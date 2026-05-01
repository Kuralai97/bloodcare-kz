--
-- PostgreSQL database dump
--

\restrict z1gWU8ITLUb6JQP4JImPaob80vghamHyq5LJvZc3bJ5Zpf5KzJBkczwoAWvKOLQ

-- Dumped from database version 15.17 (Debian 15.17-1.pgdg13+1)
-- Dumped by pg_dump version 15.17 (Debian 15.17-1.pgdg13+1)

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

SET default_table_access_method = heap;

--
-- Name: blood_requests; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.blood_requests (
    id integer NOT NULL,
    hospital character varying(200) NOT NULL,
    blood_type character varying(10) NOT NULL,
    amount_liters numeric(5,2),
    urgency character varying(50) DEFAULT 'Орташа'::character varying,
    status character varying(50) DEFAULT 'Күтуде'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.blood_requests OWNER TO admin;

--
-- Name: blood_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.blood_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blood_requests_id_seq OWNER TO admin;

--
-- Name: blood_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.blood_requests_id_seq OWNED BY public.blood_requests.id;


--
-- Name: blood_stock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.blood_stock (
    id integer NOT NULL,
    blood_type character varying(10) NOT NULL,
    amount_liters numeric(6,2) DEFAULT 0
);


ALTER TABLE public.blood_stock OWNER TO admin;

--
-- Name: blood_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.blood_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blood_stock_id_seq OWNER TO admin;

--
-- Name: blood_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.blood_stock_id_seq OWNED BY public.blood_stock.id;


--
-- Name: donors; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.donors (
    id integer NOT NULL,
    full_name character varying(200) NOT NULL,
    blood_type character varying(10) NOT NULL,
    city character varying(100),
    phone character varying(20),
    donations_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.donors OWNER TO admin;

--
-- Name: donors_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.donors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donors_id_seq OWNER TO admin;

--
-- Name: donors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.donors_id_seq OWNED BY public.donors.id;


--
-- Name: blood_requests id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.blood_requests ALTER COLUMN id SET DEFAULT nextval('public.blood_requests_id_seq'::regclass);


--
-- Name: blood_stock id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.blood_stock ALTER COLUMN id SET DEFAULT nextval('public.blood_stock_id_seq'::regclass);


--
-- Name: donors id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.donors ALTER COLUMN id SET DEFAULT nextval('public.donors_id_seq'::regclass);


--
-- Data for Name: blood_requests; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.blood_requests (id, hospital, blood_type, amount_liters, urgency, status, created_at) FROM stdin;
1	Алматы қалалық ауруханасы	О(-)	3.00	Шұғыл	Күтуде	2026-05-01 19:08:39.033899
2	Астана медицина орталығы	А(+)	2.00	Шұғыл	Күтуде	2026-05-01 19:08:39.033899
3	Шымкент облыстық ауруханасы	В(-)	1.50	Орташа	Өңделуде	2026-05-01 19:08:39.033899
4	Қарағанды облыстық ауруханасы	АВ(+)	1.00	Жоспарлы	Орындалды	2026-05-01 19:08:39.033899
\.


--
-- Data for Name: blood_stock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.blood_stock (id, blood_type, amount_liters) FROM stdin;
1	А(+)	42.00
2	А(-)	18.00
3	В(+)	35.00
4	В(-)	8.00
5	О(+)	55.00
6	О(-)	3.00
7	АВ(+)	22.00
8	АВ(-)	11.00
\.


--
-- Data for Name: donors; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.donors (id, full_name, blood_type, city, phone, donations_count, created_at) FROM stdin;
1	Асқар Бейсенов	А(+)	Алматы	+7 701 111 1111	8	2026-05-01 19:08:39.03267
2	Айгүл Сейткали	О(-)	Астана	+7 702 222 2222	5	2026-05-01 19:08:39.03267
3	Мұрат Жақсыбеков	В(+)	Шымкент	+7 703 333 3333	3	2026-05-01 19:08:39.03267
4	Зарина Оспанова	АВ(+)	Алматы	+7 704 444 4444	12	2026-05-01 19:08:39.03267
5	Дәурен Нұрланов	А(-)	Астана	+7 705 555 5555	1	2026-05-01 19:08:39.03267
6	Камила Әбенова	О(+)	Қарағанды	+7 706 666 6666	7	2026-05-01 19:08:39.03267
7	Серік Қасымов	В(-)	Атырау	+7 707 777 7777	4	2026-05-01 19:08:39.03267
8	Назгүл Ибрагимова	АВ(-)	Алматы	+7 708 888 8888	2	2026-05-01 19:08:39.03267
\.


--
-- Name: blood_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.blood_requests_id_seq', 4, true);


--
-- Name: blood_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.blood_stock_id_seq', 8, true);


--
-- Name: donors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.donors_id_seq', 8, true);


--
-- Name: blood_requests blood_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.blood_requests
    ADD CONSTRAINT blood_requests_pkey PRIMARY KEY (id);


--
-- Name: blood_stock blood_stock_blood_type_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.blood_stock
    ADD CONSTRAINT blood_stock_blood_type_key UNIQUE (blood_type);


--
-- Name: blood_stock blood_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.blood_stock
    ADD CONSTRAINT blood_stock_pkey PRIMARY KEY (id);


--
-- Name: donors donors_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.donors
    ADD CONSTRAINT donors_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict z1gWU8ITLUb6JQP4JImPaob80vghamHyq5LJvZc3bJ5Zpf5KzJBkczwoAWvKOLQ

