import asyncio
import aiohttp
import asyncpg
from asyncpg.exceptions import UniqueViolationError
import re
from time import time

PAGE = "https://ru.wikipedia.org/wiki/%D0%92%D0%B8%D0%BA%D0%B8"
MAX_DEPTH = 1
DB_USER = "master"
DB_PASS = "master"
DB_NAME = "test_db"
DB_HOST = "db"

conn = None
reg_exp = r'<a[^<>]*href="(\/wiki\/.*?)"[^<>]*>'


def get_links(html):
    """Функция возвращает все ссылки в коде по регулярному выражению"""
    return re.findall(reg_exp, html)


async def get_page(session, url):
    """Функция для получения кода страницы по заданному URL"""
    async with session.get(url) as response:
        return await response.text()


async def add_to_db(url, depth, parent):
    """Функция для добавления записей в таблицу страниц и связей"""
    try:
        id_n = await conn.fetchval('''
            INSERT INTO pages(URL, request_depth) VALUES($1, $2) RETURNING id;
            ''', url, depth)
        if depth == 0:
            return id_n
        res = await conn.execute('''
            INSERT INTO links(from_page_id, link_id) VALUES($1, $2)
            ''', parent, id_n)
    except UniqueViolationError:
        id_n = await conn.fetch('''SELECT id FROM pages WHERE url=$1''', url)
    finally:
        return id_n


async def parse_wiki(url, depth=0, parent=0):
    """Асинхронная рекурсивная функция парсинга Википедии"""
    if "ru.wikipedia.org" not in url:
        url = "https://ru.wikipedia.org"+url
    parent = await add_to_db(url, depth, parent)
    async with aiohttp.ClientSession() as session:
        if depth+1 <= MAX_DEPTH:
            html = await get_page(session, url)
            links = await loop.run_in_executor(None, get_links, html)
            for link in links:
                await parse_wiki(link, depth+1, parent)


async def main():
    """Основная функция"""
    global conn
    print("Подключение к БД")
    conn = await asyncpg.connect(user=DB_USER, password=DB_PASS,
                                 database=DB_NAME, host=DB_HOST)
    print("Старт парсинга")
    await parse_wiki(PAGE)
    print("Закрытие подключения к БД")
    await conn.close()


if __name__ == "__main__":
    start = time()
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
    loop.close()
    print(time()-start)
