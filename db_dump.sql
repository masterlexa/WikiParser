--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4
-- Dumped by pg_dump version 11.4

-- Started on 2019-06-30 20:38:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 32790)
-- Name: links; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.links (
    from_page_id integer NOT NULL,
    link_id integer NOT NULL
);


ALTER TABLE public.links OWNER TO master;

--
-- TOC entry 197 (class 1259 OID 32793)
-- Name: pages; Type: TABLE; Schema: public; Owner: master
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    url text NOT NULL,
    request_depth smallint NOT NULL
);


ALTER TABLE public.pages OWNER TO master;

--
-- TOC entry 198 (class 1259 OID 32799)
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: master
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO master;

--
-- TOC entry 2823 (class 0 OID 0)
-- Dependencies: 198
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: master
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- TOC entry 2690 (class 2604 OID 32801)
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- TOC entry 2692 (class 2606 OID 32803)
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- TOC entry 2694 (class 2606 OID 32805)
-- Name: pages url; Type: CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT url UNIQUE (url) INCLUDE (url);


--
-- TOC entry 2695 (class 2606 OID 32806)
-- Name: links from_page_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT from_page_id FOREIGN KEY (from_page_id) REFERENCES public.pages(id);


--
-- TOC entry 2696 (class 2606 OID 32811)
-- Name: links link_id; Type: FK CONSTRAINT; Schema: public; Owner: master
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT link_id FOREIGN KEY (link_id) REFERENCES public.pages(id);


-- Completed on 2019-06-30 20:38:08

--
-- PostgreSQL database dump complete
--

