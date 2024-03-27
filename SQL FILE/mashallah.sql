PGDMP      4                |           postgres    16.1    16.1 6    T           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            U           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            V           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            W           1262    5    postgres    DATABASE     |   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Canada.1252';
    DROP DATABASE postgres;
                postgres    false            X           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4951            	            2615    16530    DATABASEPROJECT    SCHEMA     !   CREATE SCHEMA "DATABASEPROJECT";
    DROP SCHEMA "DATABASEPROJECT";
                postgres    false            �            1259    16592 	   amenities    TABLE     �   CREATE TABLE "DATABASEPROJECT".amenities (
    name character varying(20) NOT NULL,
    room_id integer,
    tv character varying(20),
    airconditioner character varying(20),
    fridge character varying(20)
);
 (   DROP TABLE "DATABASEPROJECT".amenities;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16657    archive    TABLE     �   CREATE TABLE "DATABASEPROJECT".archive (
    archive_id integer NOT NULL,
    end_date date,
    start_date date,
    room_id integer,
    type character varying(20),
    customer_id integer,
    booking_id integer,
    renting_id integer
);
 &   DROP TABLE "DATABASEPROJECT".archive;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16627    bookings    TABLE     �   CREATE TABLE "DATABASEPROJECT".bookings (
    booking_id integer NOT NULL,
    customer_id integer,
    room_id integer,
    start_date date,
    end_date date
);
 '   DROP TABLE "DATABASEPROJECT".bookings;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16602 	   customers    TABLE     �   CREATE TABLE "DATABASEPROJECT".customers (
    customer_id integer NOT NULL,
    f_name character varying(20),
    l_name character varying(20),
    register_date date,
    id_type character varying(20),
    id_number integer
);
 (   DROP TABLE "DATABASEPROJECT".customers;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16552    employee    TABLE     �   CREATE TABLE "DATABASEPROJECT".employee (
    employee_id integer NOT NULL,
    f_name character varying(20),
    l_name character varying(20),
    role_name character varying(20),
    address character varying(200),
    hotel_id integer
);
 '   DROP TABLE "DATABASEPROJECT".employee;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16536    hotel    TABLE     P  CREATE TABLE "DATABASEPROJECT".hotel (
    hotel_id integer NOT NULL,
    chain_id integer,
    address character varying(200),
    number_of_rooms integer,
    hotel_rating integer,
    contact_email character varying(200),
    contact_number character varying(200),
    manager_id integer,
    city_location character varying(200)
);
 $   DROP TABLE "DATABASEPROJECT".hotel;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16531 
   hotelchain    TABLE     �   CREATE TABLE "DATABASEPROJECT".hotelchain (
    address character varying(200),
    email_contact character varying(200),
    num_of_hotels integer,
    phone_contact character varying(200),
    chain_id integer NOT NULL
);
 )   DROP TABLE "DATABASEPROJECT".hotelchain;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16577    manages    TABLE     g   CREATE TABLE "DATABASEPROJECT".manages (
    supervisee_id integer NOT NULL,
    manager_id integer
);
 &   DROP TABLE "DATABASEPROJECT".manages;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16642    manages_renting    TABLE     �   CREATE TABLE "DATABASEPROJECT".manages_renting (
    renting_id integer NOT NULL,
    employee_id integer,
    booking_id integer
);
 .   DROP TABLE "DATABASEPROJECT".manages_renting;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16612    rentings    TABLE     �   CREATE TABLE "DATABASEPROJECT".rentings (
    renting_id integer NOT NULL,
    customer_id integer,
    room_id integer,
    end_date date,
    start_date date,
    payment integer
);
 '   DROP TABLE "DATABASEPROJECT".rentings;
       DATABASEPROJECT         heap    postgres    false    9            �            1259    16567    rooms    TABLE     �   CREATE TABLE "DATABASEPROJECT".rooms (
    room_id integer NOT NULL,
    hotel_id integer,
    capacity integer,
    extendible boolean,
    price numeric(10,2),
    problem character varying(200),
    hotel_view character varying(200)
);
 $   DROP TABLE "DATABASEPROJECT".rooms;
       DATABASEPROJECT         heap    postgres    false    9            L          0    16592 	   amenities 
   TABLE DATA           Y   COPY "DATABASEPROJECT".amenities (name, room_id, tv, airconditioner, fridge) FROM stdin;
    DATABASEPROJECT          postgres    false    234   �G       Q          0    16657    archive 
   TABLE DATA           �   COPY "DATABASEPROJECT".archive (archive_id, end_date, start_date, room_id, type, customer_id, booking_id, renting_id) FROM stdin;
    DATABASEPROJECT          postgres    false    239   �G       O          0    16627    bookings 
   TABLE DATA           e   COPY "DATABASEPROJECT".bookings (booking_id, customer_id, room_id, start_date, end_date) FROM stdin;
    DATABASEPROJECT          postgres    false    237   H       M          0    16602 	   customers 
   TABLE DATA           n   COPY "DATABASEPROJECT".customers (customer_id, f_name, l_name, register_date, id_type, id_number) FROM stdin;
    DATABASEPROJECT          postgres    false    235   .H       I          0    16552    employee 
   TABLE DATA           h   COPY "DATABASEPROJECT".employee (employee_id, f_name, l_name, role_name, address, hotel_id) FROM stdin;
    DATABASEPROJECT          postgres    false    231   KH       H          0    16536    hotel 
   TABLE DATA           �   COPY "DATABASEPROJECT".hotel (hotel_id, chain_id, address, number_of_rooms, hotel_rating, contact_email, contact_number, manager_id, city_location) FROM stdin;
    DATABASEPROJECT          postgres    false    230   �K       G          0    16531 
   hotelchain 
   TABLE DATA           o   COPY "DATABASEPROJECT".hotelchain (address, email_contact, num_of_hotels, phone_contact, chain_id) FROM stdin;
    DATABASEPROJECT          postgres    false    229   }N       K          0    16577    manages 
   TABLE DATA           G   COPY "DATABASEPROJECT".manages (supervisee_id, manager_id) FROM stdin;
    DATABASEPROJECT          postgres    false    233   ?O       P          0    16642    manages_renting 
   TABLE DATA           Y   COPY "DATABASEPROJECT".manages_renting (renting_id, employee_id, booking_id) FROM stdin;
    DATABASEPROJECT          postgres    false    238   \O       N          0    16612    rentings 
   TABLE DATA           n   COPY "DATABASEPROJECT".rentings (renting_id, customer_id, room_id, end_date, start_date, payment) FROM stdin;
    DATABASEPROJECT          postgres    false    236   yO       J          0    16567    rooms 
   TABLE DATA           o   COPY "DATABASEPROJECT".rooms (room_id, hotel_id, capacity, extendible, price, problem, hotel_view) FROM stdin;
    DATABASEPROJECT          postgres    false    232   �O       �           2606    16596    amenities amenities_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY "DATABASEPROJECT".amenities
    ADD CONSTRAINT amenities_pkey PRIMARY KEY (name);
 M   ALTER TABLE ONLY "DATABASEPROJECT".amenities DROP CONSTRAINT amenities_pkey;
       DATABASEPROJECT            postgres    false    234            �           2606    16661    archive archive_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY "DATABASEPROJECT".archive
    ADD CONSTRAINT archive_pkey PRIMARY KEY (archive_id);
 I   ALTER TABLE ONLY "DATABASEPROJECT".archive DROP CONSTRAINT archive_pkey;
       DATABASEPROJECT            postgres    false    239            �           2606    16631    bookings bookings_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY "DATABASEPROJECT".bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);
 K   ALTER TABLE ONLY "DATABASEPROJECT".bookings DROP CONSTRAINT bookings_pkey;
       DATABASEPROJECT            postgres    false    237            �           2606    16606    customers customers_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY "DATABASEPROJECT".customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);
 M   ALTER TABLE ONLY "DATABASEPROJECT".customers DROP CONSTRAINT customers_pkey;
       DATABASEPROJECT            postgres    false    235            �           2606    16556    employee employee_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY "DATABASEPROJECT".employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);
 K   ALTER TABLE ONLY "DATABASEPROJECT".employee DROP CONSTRAINT employee_pkey;
       DATABASEPROJECT            postgres    false    231            �           2606    16541    hotel hotel_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY "DATABASEPROJECT".hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (hotel_id);
 E   ALTER TABLE ONLY "DATABASEPROJECT".hotel DROP CONSTRAINT hotel_pkey;
       DATABASEPROJECT            postgres    false    230            �           2606    16535    hotelchain hotelchain_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY "DATABASEPROJECT".hotelchain
    ADD CONSTRAINT hotelchain_pkey PRIMARY KEY (chain_id);
 O   ALTER TABLE ONLY "DATABASEPROJECT".hotelchain DROP CONSTRAINT hotelchain_pkey;
       DATABASEPROJECT            postgres    false    229            �           2606    16581    manages manages_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY "DATABASEPROJECT".manages
    ADD CONSTRAINT manages_pkey PRIMARY KEY (supervisee_id);
 I   ALTER TABLE ONLY "DATABASEPROJECT".manages DROP CONSTRAINT manages_pkey;
       DATABASEPROJECT            postgres    false    233            �           2606    16646 $   manages_renting manages_renting_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY "DATABASEPROJECT".manages_renting
    ADD CONSTRAINT manages_renting_pkey PRIMARY KEY (renting_id);
 Y   ALTER TABLE ONLY "DATABASEPROJECT".manages_renting DROP CONSTRAINT manages_renting_pkey;
       DATABASEPROJECT            postgres    false    238            �           2606    16616    rentings rentings_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY "DATABASEPROJECT".rentings
    ADD CONSTRAINT rentings_pkey PRIMARY KEY (renting_id);
 K   ALTER TABLE ONLY "DATABASEPROJECT".rentings DROP CONSTRAINT rentings_pkey;
       DATABASEPROJECT            postgres    false    236            �           2606    16571    rooms rooms_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY "DATABASEPROJECT".rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_id);
 E   ALTER TABLE ONLY "DATABASEPROJECT".rooms DROP CONSTRAINT rooms_pkey;
       DATABASEPROJECT            postgres    false    232            �           2606    16652    manages_renting fk_booking_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".manages_renting
    ADD CONSTRAINT fk_booking_id FOREIGN KEY (booking_id) REFERENCES "DATABASEPROJECT".bookings(booking_id);
 R   ALTER TABLE ONLY "DATABASEPROJECT".manages_renting DROP CONSTRAINT fk_booking_id;
       DATABASEPROJECT          postgres    false    238    237    4772            �           2606    16667    archive fk_booking_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".archive
    ADD CONSTRAINT fk_booking_id FOREIGN KEY (booking_id) REFERENCES "DATABASEPROJECT".bookings(booking_id);
 J   ALTER TABLE ONLY "DATABASEPROJECT".archive DROP CONSTRAINT fk_booking_id;
       DATABASEPROJECT          postgres    false    4772    239    237            �           2606    16542    hotel fk_chain_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".hotel
    ADD CONSTRAINT fk_chain_id FOREIGN KEY (chain_id) REFERENCES "DATABASEPROJECT".hotelchain(chain_id);
 F   ALTER TABLE ONLY "DATABASEPROJECT".hotel DROP CONSTRAINT fk_chain_id;
       DATABASEPROJECT          postgres    false    4756    230    229            �           2606    16617    rentings fk_customer_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".rentings
    ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES "DATABASEPROJECT".customers(customer_id);
 L   ALTER TABLE ONLY "DATABASEPROJECT".rentings DROP CONSTRAINT fk_customer_id;
       DATABASEPROJECT          postgres    false    4768    236    235            �           2606    16632    bookings fk_customer_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".bookings
    ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES "DATABASEPROJECT".customers(customer_id);
 L   ALTER TABLE ONLY "DATABASEPROJECT".bookings DROP CONSTRAINT fk_customer_id;
       DATABASEPROJECT          postgres    false    237    235    4768            �           2606    16662    archive fk_customer_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".archive
    ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES "DATABASEPROJECT".customers(customer_id);
 K   ALTER TABLE ONLY "DATABASEPROJECT".archive DROP CONSTRAINT fk_customer_id;
       DATABASEPROJECT          postgres    false    235    4768    239            �           2606    16647    manages_renting fk_employee_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".manages_renting
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES "DATABASEPROJECT".employee(employee_id);
 S   ALTER TABLE ONLY "DATABASEPROJECT".manages_renting DROP CONSTRAINT fk_employee_id;
       DATABASEPROJECT          postgres    false    238    4760    231            �           2606    16557    employee fk_hotel_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".employee
    ADD CONSTRAINT fk_hotel_id FOREIGN KEY (hotel_id) REFERENCES "DATABASEPROJECT".hotel(hotel_id);
 I   ALTER TABLE ONLY "DATABASEPROJECT".employee DROP CONSTRAINT fk_hotel_id;
       DATABASEPROJECT          postgres    false    230    4758    231            �           2606    16572    rooms fk_hotel_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".rooms
    ADD CONSTRAINT fk_hotel_id FOREIGN KEY (hotel_id) REFERENCES "DATABASEPROJECT".hotel(hotel_id);
 F   ALTER TABLE ONLY "DATABASEPROJECT".rooms DROP CONSTRAINT fk_hotel_id;
       DATABASEPROJECT          postgres    false    4758    230    232            �           2606    16562    hotel fk_manager_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".hotel
    ADD CONSTRAINT fk_manager_id FOREIGN KEY (manager_id) REFERENCES "DATABASEPROJECT".employee(employee_id);
 H   ALTER TABLE ONLY "DATABASEPROJECT".hotel DROP CONSTRAINT fk_manager_id;
       DATABASEPROJECT          postgres    false    230    4760    231            �           2606    16582    manages fk_manager_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".manages
    ADD CONSTRAINT fk_manager_id FOREIGN KEY (manager_id) REFERENCES "DATABASEPROJECT".employee(employee_id);
 J   ALTER TABLE ONLY "DATABASEPROJECT".manages DROP CONSTRAINT fk_manager_id;
       DATABASEPROJECT          postgres    false    233    231    4760            �           2606    16672    archive fk_renting_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".archive
    ADD CONSTRAINT fk_renting_id FOREIGN KEY (renting_id) REFERENCES "DATABASEPROJECT".rentings(renting_id);
 J   ALTER TABLE ONLY "DATABASEPROJECT".archive DROP CONSTRAINT fk_renting_id;
       DATABASEPROJECT          postgres    false    236    239    4770            �           2606    16597    amenities fk_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".amenities
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES "DATABASEPROJECT".rooms(room_id);
 I   ALTER TABLE ONLY "DATABASEPROJECT".amenities DROP CONSTRAINT fk_room_id;
       DATABASEPROJECT          postgres    false    234    4762    232            �           2606    16622    rentings fk_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".rentings
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES "DATABASEPROJECT".rooms(room_id);
 H   ALTER TABLE ONLY "DATABASEPROJECT".rentings DROP CONSTRAINT fk_room_id;
       DATABASEPROJECT          postgres    false    232    4762    236            �           2606    16637    bookings fk_room_id    FK CONSTRAINT     �   ALTER TABLE ONLY "DATABASEPROJECT".bookings
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_id) REFERENCES "DATABASEPROJECT".rooms(room_id);
 H   ALTER TABLE ONLY "DATABASEPROJECT".bookings DROP CONSTRAINT fk_room_id;
       DATABASEPROJECT          postgres    false    232    4762    237            L      x������ � �      Q      x������ � �      O      x������ � �      M      x������ � �      I   �  x����n�F���S��";H^�@�@۸@�º�HD&�r�>}����ĥ�A�fI}���!��f�?�q��c34�� ����|m����ӱ�8�v��l��v�u����������l��氇��M����mN���ݷG;�k��}��&�z{��'y���RC3�[6��1Pm�[3�a����ޞ���~Ѐ���o���O]��5ŏ������ˀ��=��۫-�ۻ�"�7o����1���������ܟ���i9u�`���'�=-<t�×��Ʃyl.�^���q-�~v��Z4��D�O��d,�9�?��[]���ߵ`��9�>��Z4��D�~�MkѹO�Ș�c�C&�d3g�4/��[& B�쌙�f��L��bC�"h�M �js���M�u�JX�LTMQ+�\��-Q�M�amy�M����&�i^ǲ�?��}/�q_B�"��_�Y�^x��A��_�9�^p�b�v_�y��/s�ί��#��Y;�_�������nf�q���˛A��.�s��fP��F�t޾�JƊ�I޺�*����3�8C��|g����O�9辀4����'�,u/<�{�I8��KN�Y��q��s��E"w��%�] �͜��,C�� A��^"x�/��bC.^�x�&/ �js��%w��`i3ѼDɒC/P
V�D�d�T���]��z��^��y�<�d�kH�9���4�e��'�,{/=��{�I8��kN�Y�^r�γ��U#{��5�^!(�͜��lCW��Qd���5��-�
�(6��5��m�j�F��K����:{U,m&��hYs�J�J����{�J����Wg���+�:�×�g�������ͽ���E�a��~v\A���O����ٱ�$m�W��e�aï����$>��u���@��k�J      H   �  x����O�0���W� �����6�mHۤ]v�Y#J3�����ޫ�j`9�8X��9��U��E�o�^��ݮ{3W�a�A�����7�=����i�fs��_T���
�ه
aE����}�h�&Z����	������3f����f�w}�${����(U	K(���$���B�(a�?�gÿ��1�����|K8i�)�i�X�[}t����e����[g�u(��r�G����{X��?�1���(��.K���u 6$.q��������(�<��P�x�&�Z��qěa��C��7��K��ib
|�u��l��y�!�)�i 7Q����-,��"c��0J�JR�(��n�1��6�$8js��}&��D�F�
�ƍZ��N/Y�*���T��R�R�\'`*VP��;�j'Xn����$��71�{IS���o@WǙ�Fe�G�+WJW�%g�Q��X�f�'ɛ�H#�Zk%r�&M'.S�q3Wi�5n���%p�.�q\��9s�� E)��@l�w��N/�T�>�J����S�\�βO�*IͷO%8�>�*��i���r%6�>���L�4`[�B�}�=��_ ׯ����UIj�~�%8S�^R3������o 7g�7`[�B�~��uQ� )��L      G   �   x�u��
�0���S�:��-�M��E/v�R�B�m��ޢV�)$!����Z�{w��]�����CV!N�o�;�E��"+2�J�	PX�r���z����GX�Ii&e� 5V��p��~��.��DE��F��"�rc�;����O&��-�X6�σ�����2	5J2q*�c�\�      K      x������ � �      P      x������ � �      N      x������ � �      J   �  x��X͎�(<'O�ؑ�`�q4�<�j���t♱:�[�Q��~�3�	���UŇ+b'Į��w�,�����:��}q��q�Oݽ�������$�Td�������-{����{��:�}���~�=���c��z''�n�s{x�*~��>n�@ `_wbs+����+j�-JU��+�(��5�9=��ݾ���~�y��Q��Z��u��P��&

҅
�u��k������ꝚV�F����T�z\�����n�p$O����p�m8�	�*��#K��hR�qG83��gן�Ow3$A�!�>dE1Gd�	[���MX�zM�׻z�ۥ=����0\�lC�9"�ߝfK���KĬ�	<�j�[��Y�g��"[fu��q*��(8�Qn%	�8��� bqŖ���Ra%�
�$#k9��ήv~�n���].-@]�.le6�W�o	� |��;h�J`�m�ү*R��^�6�UZ��g�o�����S� ��3��S�LC��*��3z�t`�CK�v�?.��J(��������a��pC�����B�%�|����d��p�	lb��۟�sz!u��S�' (�N1]핖��A��Z���D��	}~ݴ
t��d'G��K�����HϺ<7��9�[�|7�,b�{�������F�\��Ԓ �IL](e��ճ�N��K��՘�Y�GA�@1��K?��uz�@�7�1e z�x��Ѥ\��W��xTd*B�L����l�ף�Bq���=L��N�!T�f����)�g�M��X=��e�z5���Q%?@G�$�b?mE��TN%Ѫ��<��h��ɏ�1�#�|L����������ö	<i��2����j0�W�b�M#	�����T��D6*�EN�+�~��G��D6��U~:5� 9�K��	\i���@��Z���L�E)	�v��"؆L�R�D�E�g4բĈ��Z��~Ϲ-JK�nQ6�*�7e���Ri�l|m�l���ٖn�Ni�x4J�ɷ@��L�z�e<G��[<Gy���荖���TPL��S��A�6e�ѓ�2���9�Gi�Q!��R��Fk�j��荞*�7��'��M�(6������y�=�Y>��G�k�`<㨐J1GT���j��荊��Q�1j.��P�2�WCo�8ti&㨎:�q��:�qƚ�����7:c����X�~�;>�h&�q<rfc���3�irG��\�Q-�9ʣ��9*��=G�������f2N�K��w_o�8%K�3�Z�9�G��Q!�h�R��F��z�ߨ��*�7�'��M��i6�T�t6��]�=�Y>E7}�A���3�b�4�q�J�x�j��x�n�x�Q.�9��2���7d_Fz[�q�4�q�L��8jf��8zf����Yo�M���Fլy��5�q�M��8ڦ٘q�M�g}��2��i���qZ�sTN��stN�z%�0��������S�     