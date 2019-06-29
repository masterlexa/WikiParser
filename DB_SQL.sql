PGDMP         +                w            test_db    11.4    11.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false                       1262    16395    test_db    DATABASE     �   CREATE DATABASE test_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE test_db;
             postgres    false            �            1259    16406    links    TABLE     _   CREATE TABLE public.links (
    from_page_id integer NOT NULL,
    link_id integer NOT NULL
);
    DROP TABLE public.links;
       public         master    false            �            1259    16421    pages    TABLE     s   CREATE TABLE public.pages (
    id integer NOT NULL,
    url text NOT NULL,
    request_depth smallint NOT NULL
);
    DROP TABLE public.pages;
       public         master    false            �            1259    16419    pages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.pages_id_seq;
       public       master    false    198                       0    0    pages_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;
            public       master    false    197            �
           2604    16424    pages id    DEFAULT     d   ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);
 7   ALTER TABLE public.pages ALTER COLUMN id DROP DEFAULT;
       public       master    false    198    197    198            �
           2606    16429    pages pages_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pages DROP CONSTRAINT pages_pkey;
       public         master    false    198            �
           2606    16438 	   pages url 
   CONSTRAINT     Q   ALTER TABLE ONLY public.pages
    ADD CONSTRAINT url UNIQUE (url) INCLUDE (url);
 3   ALTER TABLE ONLY public.pages DROP CONSTRAINT url;
       public         master    false    198    198            �
           2606    16459    links from_page_id    FK CONSTRAINT     v   ALTER TABLE ONLY public.links
    ADD CONSTRAINT from_page_id FOREIGN KEY (from_page_id) REFERENCES public.pages(id);
 <   ALTER TABLE ONLY public.links DROP CONSTRAINT from_page_id;
       public       master    false    198    2692    196            �
           2606    16454    links link_id    FK CONSTRAINT     l   ALTER TABLE ONLY public.links
    ADD CONSTRAINT link_id FOREIGN KEY (link_id) REFERENCES public.pages(id);
 7   ALTER TABLE ONLY public.links DROP CONSTRAINT link_id;
       public       master    false    198    2692    196           