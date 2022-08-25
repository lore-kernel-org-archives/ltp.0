Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8103CC04AA5
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 07:48:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6104B3CA475
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 09:48:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FAC93C0895
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:48:37 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82445600071
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 09:48:36 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id h1so9849560wmd.3
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc;
 bh=wFHKNvRv5PBwAwuMo1YPzYcvo3soaxcTbTqwj/BjF6Q=;
 b=eNjRiFq4Xilg9VUGwqlaKUu2Gpqet0HoEaDzseTRKUMidMt19pUlMtFV+OjzZWRx3k
 h5295WZUln5RYUMpPhIFhLu/eqgCM25de6u/4XR4KtEVjABkT3DiCurxseYtvXOAXTZ7
 CCDoZP/Ecb/hV0xjVx1CYK5cxa33ntzI4qjHgiM/m/lf/XhyweLIyGisgXTCfc+7b6mh
 QRZg8vazwDBxbbj/t6O1ecEkW/1+qhSCP7s/+hJOrh/WodYaixnxPfpD1wA1OoshUeeP
 YDfv2VH6jsjWmL36LfhUX//0KhBcQCqCsLIwQfu/nkXKeP9v8yMz3Ad4XLXoqVIv4fpK
 JYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc; bh=wFHKNvRv5PBwAwuMo1YPzYcvo3soaxcTbTqwj/BjF6Q=;
 b=jnhAmf2M2Crs/zzz6g3Ip0AAmUaj2PSo+tz2P6k9sc/tmt2LgAGYCxyUMpl70+C1LL
 XIgWS0uznis6Qw0jzv33RVCWX9xUdDTht53lCY1UXb6iSq6iTXX6NHK7UCgFgcyYBRlf
 kHUawg1d+WGciopYXTVXHzlAt4ERa3NFm8tBA4gE+a5R+Mo/PByB1lBl1HwIlijlumNH
 Cxt0pZT3oEo2PTpw+1IxT/5lEJdQ2AMLXqOQXxIHvV89Dy+r06J31rVg0e9RZMUTk8Tr
 +P1m1h1DOB7qprPiJwO1a0RPnPxB4gEy2jpMtkddIjFjqCKAV1wNCdgKWxdRmmV3rWZf
 fBzQ==
X-Gm-Message-State: ACgBeo3ofEi9uzQYIs0SV3RFjn5oHxkY5qSU0AIrj+69R+aWHbxdgXwp
 MTjZqIAUuxwUkqAT57oIcrM=
X-Google-Smtp-Source: AA6agR6qz2wI4mvAT5RNQTo1r7ZQO1aq29t/HGAgCl55GcT+/3w5SW33w0b82w8zm/niEqs1mtbQAA==
X-Received: by 2002:a05:600c:4f92:b0:3a5:f545:a6ce with SMTP id
 n18-20020a05600c4f9200b003a5f545a6cemr7079190wmq.149.1661413716082; 
 Thu, 25 Aug 2022 00:48:36 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b003a5537bb2besm4666408wms.25.2022.08.25.00.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:48:35 -0700 (PDT)
Message-ID: <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
Date: Thu, 25 Aug 2022 09:48:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To: Xi Ruoyao <xry111@xry111.site>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
From: Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Many pages: Document fixed-width types with
 ISO C naming
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 GCC <gcc-patches@gcc.gnu.org>, LTP List <ltp@lists.linux.it>,
 glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============1134192854=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1134192854==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2tq1iQrZNr8SAH4XDeC6pnO1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2tq1iQrZNr8SAH4XDeC6pnO1
Content-Type: multipart/mixed; boundary="------------OsCfbhS1YqB1OqxDNlsqMg2N";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Xi Ruoyao <xry111@xry111.site>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-man <linux-man@vger.kernel.org>, Rich Felker <dalias@libc.org>,
 Alexei Starovoitov <ast@kernel.org>, David Howells <dhowells@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Joseph Myers <joseph@codesourcery.com>,
 linux-arch <linux-arch@vger.kernel.org>, Zack Weinberg <zackw@panix.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alex Colomar <alx@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
 Arnd Bergmann <arnd@arndb.de>, GCC <gcc-patches@gcc.gnu.org>,
 LTP List <ltp@lists.linux.it>, Florian Weimer <fweimer@redhat.com>,
 glibc <libc-alpha@sourceware.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Linux API <linux-api@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Message-ID: <017d77b8-8be3-a0a8-ce2e-17c7b6a16758@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com>
 <CAHk-=whfft=qpCiQ=mkaCz+X1MEfGK5hpUWYoM5zWK=2EQMwyw@mail.gmail.com>
 <20d93962-538c-d2c9-1696-a1bdbffa87f8@gmail.com>
 <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>
In-Reply-To: <5a3ce36a284fe988694d2e75117aca5f9af66194.camel@xry111.site>

--------------OsCfbhS1YqB1OqxDNlsqMg2N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgWGksDQoNCk9uIDgvMjUvMjIgMDk6MjgsIFhpIFJ1b3lhbyB3cm90ZToNCj4gT24gVGh1
LCAyMDIyLTA4LTI1IGF0IDA5OjIwICswMjAwLCBBbGVqYW5kcm8gQ29sb21hciB2aWEgR2Nj
LXBhdGNoZXMNCj4gd3JvdGU6DQo+PiBJIGRvbid0IGtub3cgZm9yIHN1cmUsIGFuZCBJIG5l
dmVyIHByZXRlbmRlZCB0byBzYXkgb3RoZXJ3aXNlLsKgIEJ1dCB3aGF0DQo+PiBJTUhPIHRo
ZSBrZXJuZWwgY291bGQgZG8gaXMgdG8gbWFrZSB0aGUgdHlwZXMgY29tcGF0aWJsZSwgYnkg
dHlwZWRlZmluZw0KPj4gdG8gdGhlIHNhbWUgZnVuZGFtZW50YWwgdHlwZXMgKGkuZS4sIGxv
bmcgb3IgbG9uZyBsb25nKSB0aGF0IHVzZXItc3BhY2UNCj4+IHR5cGVzIGRvLg0KPiANCj4g
SW4gdXNlci1zcGFjZSB0aGluZ3MgYXJlIGFscmVhZHkgaW5jb25zaXN0ZW50IGFzIHdlIGhh
dmUgbXVsdGlwbGUgbGliYw0KPiBpbXBsZW1lbnRhdGlvbnMuICBUZWxsaW5nIGV2ZXJ5IGxp
YmMgaW1wbGVtZW50YXRpb24gdG8gc3luYyB0aGVpcg0KPiB0eXBlZGVmIHcvbyBhIFdHMTQg
ZGVjaXNpb24gd2lsbCBvbmx5IGNhdXNlICJhZ2dyZXNzaXZlIGRpc2N1c3Npb24iIChmYXIN
Cj4gbW9yZSBhZ2dyZXNzaXZlIHRoYW4gdGhpcyB0aHJlYWQsIEknZCBzYXkpLg0KPiANCj4g
SWYgaW50NjRfdCBldGMuIHdlcmUgZGVmaW5lZCBhcyBidWlsdGluIHR5cGVzIHNpbmNlIGVw
b2NoLCB0aGluZ3Mgd291bGQNCj4gYmUgYSBsb3QgZWFzaWVyLiAgQnV0IHdlIGNhbid0IGNo
YW5nZSBoaXN0b3J5Lg0KDQpUaGlzIHdvdWxkIGJlIGdyZWF0LiAgSSBtZWFuLCB0aGUgZnVu
ZGFtZW50YWwgdHlwZXMgc2hvdWxkIGJlIHU4LCB1MTYsIA0KLi4uIGFuZCBpbnQsIGxvbmcs
IC4uLiB0eXBlZGVmcyBmb3IgdGhlc2UsIGFuZCBub3QgdGhlIG90aGVyIHdheSBhcm91bmQs
IA0KaWYgdGhlIGxhbmd1YWdlIHdhcyBkZXNpZ25lZCB0b2RheS4NCg0KTWF5YmUgR0NDIGNv
dWxkIGNvbnNpZGVyIHNvbWV0aGluZyBsaWtlIHRoYXQuDQoNCkNoZWVycywNCg0KQWxleA0K
DQotLSANCkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21h
ci5lcy8+DQo=

--------------OsCfbhS1YqB1OqxDNlsqMg2N--

--------------2tq1iQrZNr8SAH4XDeC6pnO1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHKVEACgkQnowa+77/
2zLf/w//TGoaIMTn8K9jSsuXnyT12yLhySkI4g9lpuxSg5In1va2aYdE+FxmYy7j
aLYURQ69jURkCL4XLTvvVj3Adfter1t3/G7+EeiuJ6yF/J8nb8nzLVvvh2S5L5RK
79TESSnqgAqtZwFJqxeHfGBOLR7FSFjvVagRH+hALtUdowp5fQ+BsPGjvtBnyX5+
Jd36n7cN+tPCc6tfzVWWO8d4XTv9jOVqxhz9aiJjwULHqGFwea67x302daCMirQE
MxAauUo83+jCTwF0Sf7II4PWdfYukfsj2tUQLf7KSa3/3lWJptg2DEkaPzbLkvWA
4YlSNtr4mb87Q30UDCoK4W9QPK3bkROirz2hJC3snIMHanoBNWKqFkXhx3huM8HF
/UNidcqnYEd2SH7vWMIJNWQNQe1d8FSAJDEP7f7/0zamusLt2V66CTLgSwnfVOJM
l6gNR2Q6QBEnLqmXLuZ2UQrwVn9NUHqqYeL3CXs90GLVCXIRZ8qWkNFG+ZXKnwhO
lCPIxlQw+CrJo9As8kmkT/j8XKKNZ+0FmGtPsqlvby4Hj8+helZAGwLY3fFBj5iP
hwGLmg2pMSxt4zolCc0AoMO54yctNxJjxdoSrzlTf828lOHYlnVZxtai68yZkxK1
xXrF9toPzGkMRaTvDDrIO2kijs9gS2DV2q81CgOss1fPhAt5xe8=
=AeSD
-----END PGP SIGNATURE-----

--------------2tq1iQrZNr8SAH4XDeC6pnO1--

--===============1134192854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1134192854==--
