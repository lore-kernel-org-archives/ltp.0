Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45334C04AA5
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 08:04:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 028933CA45D
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 10:04:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5EB23C8CA7
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 10:04:05 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F06461400196
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 10:04:04 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id d5so9866151wms.5
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:references:cc:to:from:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc;
 bh=1QLLv2yv2C5Rwl3FU5SB/pJ7Nwwb3OC8gXKx+2uAV5g=;
 b=ZUqEuqYLWqO373UnT9Li1Ip8LxeRW4o/paM0vO0PbJAa18TU/AfLI201w7AOS7lGCe
 Htdnbz0qNA+n4waQDvPNfoGfpGQzZpQp6fxmSDCRdR2QDerzCiwpnigr4JhIaSU2CiV3
 kls3wDmVOkRx1toO5y9fHuG4HsN3OsT+8GHZaYXOz2iCwF+uYaq9ukM5u+jI9io3hWry
 D8zXTjz4c6nEVxqJzNR9b4LkdiOAGPjdZlyaNSpwEt/avBY5JN8eEAUDoXgVnis6kcjW
 A/dGsboqkeAT0n+lau0R2elqbXBGsGnwAy6jERhZ9Szyfd7qh7UeocEbx/29brm4X3Pr
 7ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:references:cc:to:from:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc; bh=1QLLv2yv2C5Rwl3FU5SB/pJ7Nwwb3OC8gXKx+2uAV5g=;
 b=W1QgN6atICq/bAnBgVzT5bp3OvJ8D0SLFG3yFWRYN6IBTdBJHfquOylGvlPSWgeFeY
 J+10VSdAsicxY9G3aFR6UJc5s6VC/qDvhaBvTIzVWJgXZE4S0Lw6ZkWriCFV8V0rzPJo
 zzfONNCnoUxJjlUov4+gVinJbqW8nGlmUG3rZqO3mVTA9fWgBkc58cXgEPy1TZQ1bHHH
 1MW9b/F7T5IJLBCT7aiDUE1+WkEejReaeNdXi7NllE1HqV/jnAuTeCBoi4ZrWtdINOo/
 iODJCFxKDOC20HLwbmqc2C8Y3tn2WyyLOSy4sIKEU+Vq9W5/lZR58UxM4PrmduuyCnCW
 jKOw==
X-Gm-Message-State: ACgBeo3n7ZKUa/aM7pTejvg90mxQPdbZsi3xapcKeJ6n72P5oZnhiB7H
 scchWaPB3piIO6ikwfjadpM=
X-Google-Smtp-Source: AA6agR4gl9HaSapnqSYTiv7W1V6zMnM0euJI5+6mxpeJIpUGC7nKo9QKyQcmEBq/YUYHyx0gPxWAQw==
X-Received: by 2002:a05:600c:3514:b0:3a5:dc71:d9c4 with SMTP id
 h20-20020a05600c351400b003a5dc71d9c4mr1491302wmq.42.1661414644521; 
 Thu, 25 Aug 2022 01:04:04 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id
 c10-20020adfa70a000000b0022529d3e911sm19402113wrd.109.2022.08.25.01.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 01:04:03 -0700 (PDT)
Message-ID: <e8b48d52-07ef-5023-7195-173345fd6540@gmail.com>
Date: Thu, 25 Aug 2022 10:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <609e1161-87ee-bb48-d14c-dc444ddff754@gmail.com>
In-Reply-To: <609e1161-87ee-bb48-d14c-dc444ddff754@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
 glibc <libc-alpha@sourceware.org>, Linux API <linux-api@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, David Laight <David.Laight@aculab.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, bpf <bpf@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/mixed; boundary="===============1851349000=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1851349000==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Jcs2SV4wGLtedSe0Cg0u0fct"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Jcs2SV4wGLtedSe0Cg0u0fct
Content-Type: multipart/mixed; boundary="------------3Cr5MBcyk9uZm0r3hhGNJWm1";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alex Colomar <alx@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-man <linux-man@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Zack Weinberg <zackw@panix.com>,
 LKML <linux-kernel@vger.kernel.org>, glibc <libc-alpha@sourceware.org>,
 GCC <gcc-patches@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>, Linux API <linux-api@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Joseph Myers <joseph@codesourcery.com>, Florian Weimer <fweimer@redhat.com>,
 Cyril Hrubis <chrubis@suse.cz>, David Howells <dhowells@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <e8b48d52-07ef-5023-7195-173345fd6540@gmail.com>
Subject: Re: [PATCH v3] Many pages: Document fixed-width types with ISO C
 naming
References: <20210423230609.13519-1-alx.manpages@gmail.com>
 <20220824185505.56382-1-alx.manpages@gmail.com>
 <CAADnVQKiEVL9zRtN4WY2+cTD2b3b3buV8BQb83yQw13pWq4OGQ@mail.gmail.com>
 <c06008bc-0c13-12f1-df85-3814b74e47f9@gmail.com> <YwcPQ987poRYjfoL@kroah.com>
 <609e1161-87ee-bb48-d14c-dc444ddff754@gmail.com>
In-Reply-To: <609e1161-87ee-bb48-d14c-dc444ddff754@gmail.com>

--------------3Cr5MBcyk9uZm0r3hhGNJWm1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOC8yNS8yMiAwOTo0NCwgQWxlamFuZHJvIENvbG9tYXIgd3JvdGU6DQo+IEhpIEdyZWcs
DQo+IA0KPiBPbiA4LzI1LzIyIDA3OjU3LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+
PiBPbiBUaHUsIEF1ZyAyNSwgMjAyMiBhdCAwMTozNjoxMEFNICswMjAwLCBBbGVqYW5kcm8g
Q29sb21hciB3cm90ZToNCj4+PiBCdXQgZnJvbSB5b3VyIHNpZGUgd2hhdCBkbyB3ZSBoYXZl
P8KgIEp1c3QgZGlyZWN0IE5BS3Mgd2l0aG91dCBtdWNoDQo+Pj4gZXhwbGFuYXRpb24uwqAg
VGhlIG9ubHkgb25lIHdobyBnYXZlIHNvbWUgZXhwbGFuYXRpb24gd2FzIEdyZWcsIGFuZCBo
ZQ0KPj4+IHZhZ3VlbHkgcG9pbnRlZCB0byBMaW51cydzIGNvbW1lbnRzIGFib3V0IGl0IGlu
IHRoZSBwYXN0LCB3aXRoIG5vIA0KPj4+IHByZWNpc2UNCj4+PiBwb2ludGVyIHRvIGl0LsKg
IEkgaW52ZXN0aWdhdGVkIGEgbG90IGJlZm9yZSB2MiwgYW5kIGNvdWxkIG5vdCBmaW5kIA0K
Pj4+IGFueXRoaW5nDQo+Pj4gc3Ryb25nIGVub3VnaCB0byByZWNvbW1lbmQgdXNpbmcga2Vy
bmVsIHR5cGVzIGluIHVzZXIgc3BhY2UsIHNvIEkgDQo+Pj4gcHVzaGVkIHYyLA0KPj4+IGFu
ZCB0aGUgZGlzY3Vzc2lvbiB3YXMga2VwdC4NCj4+DQo+PiBTbyBkZXNwaXRlIG1lIHNheWlu
ZyB0aGF0ICJ0aGlzIGlzIG5vdCBvayIsIGFuZCBtYW55IG90aGVyIG1haW50YWluZXJzDQo+
PiBzYXlpbmcgInRoaXMgaXMgbm90IG9rIiwgeW91IGFwcGxpZWQgYSBwYXRjaCB3aXRoIG91
ciBvYmplY3Rpb25zIG9uIGl0Pw0KPj4gVGhhdCBpcyB2ZXJ5IG9kZCBhbmQgYSBiaXQgcnVk
ZS4NCj4+DQo+Pj4gSSB3b3VsZCBsaWtlIHRoYXQgaWYgeW91IHN0aWxsIG9wcG9zZSB0byB0
aGUgcGF0Y2gsIGF0IGxlYXN0IHdlcmUgDQo+Pj4gYWJsZSB0bw0KPj4+IHByb3ZpZGUgc29t
ZSBmYWN0cyB0byB0aGlzIGRpc2N1c3Npb24uDQo+Pg0KPj4gVGhlIGZhY3QgaXMgdGhhdCB0
aGUga2VybmVsIGNhbiBub3QgdXNlIHRoZSBuYW1lc3BhY2UgdGhhdCB1c2Vyc3BhY2UgaGFz
DQo+PiB3aXRoIElTTyBDIG5hbWVzLsKgIEl0J3MgdGhhdCBzaW1wbGUgYXMgdGhlIElTTyBz
dGFuZGFyZCBkb2VzIE5PVA0KPj4gZGVzY3JpYmUgdGhlIHZhcmlhYmxlIHR5cGVzIGZvciBh
biBBQkkgdGhhdCBjYW4gY3Jvc3MgdGhlIHVzZXIva2VybmVsDQo+PiBib3VuZHJ5Lg0KPiAN
Cj4gSSB1bmRlcnN0YW5kIHRoYXQuwqAgQnV0IHVzZXItc3BhY2UgcHJvZ3JhbXMgYXJlIGFs
bG93ZWQgdG8gdXNlIHRoZSANCj4gc3RhbmRhcmQgdHlwZXMgd2hlbiBjYWxsaW5nIGEgc3lz
Y2FsbCB0aGF0IHJlYWxseSB1c2VzIGtlcm5lbCB0eXBlcy4NCj4gDQo+IElNSE8sIGl0IHNo
b3VsZCBiZSBpcnJlbGV2YW50IGZvciB0aGUgdXNlciBob3cgdGhlIGtlcm5lbCBkZWNpZGVz
IHRvIA0KPiBjYWxsIGEgNjQtYml0IHVuc2lnbmVkIGludGVnZXIsIHJpZ2h0Pw0KPiANCj4g
T3IgZG8geW91IG1lYW4gdGhhdCBzb21lIG9mIHRoZSBwYWdlcyBJIG1vZGlmaWVkDQoNCi4u
LiBhcmUgaW50ZW5kZWQgbW9zdGx5IGZvciBrZXJuZWwtc3BhY2UgcHJvZ3JhbW1lcnM/DQoN
Cj4gDQo+Pg0KPj4gV29yayB3aXRoIHRoZSBJU08gQyBzdGFuZGFyZCBpZiB5b3Ugd2lzaCB0
byBkb2N1bWVudCBzdWNoIHR5cGUgdXNhZ2UsDQo+PiBhbmQgZ2V0IGl0IGFwcHJvdmVkIGFu
ZCB0aGVuIHdlIHdvdWxkIGJlIHdpbGxpbmcgdG8gY29uc2lkZXIgc3VjaCBhDQo+PiBjaGFu
Z2UuwqAgQnV0IHVudGlsIHRoZW4sIHdlIGhhdmUgdG8gc3RpY2sgdG8gb3VyIHZhcmlhYmxl
IG5hbWUgdHlwZXMsDQo+PiBqdXN0IGxpa2UgYWxsIG90aGVyIG9wZXJhdGluZyBzeXN0ZW1z
IGhhdmUgdG8gKHdlIGFyZSBub3QgYWxvbmUgaGVyZS4pDQo+Pg0KPj4gUGxlYXNlIHJldmVy
dCB5b3VyIGNoYW5nZS4NCj4gDQo+IFRoYW5rcyBmb3IgYXNraW5nIG5pY2VseS4NCj4gDQo+
IFNpbmNlIHRoZXJlJ3Mgb25nb2luZyBkaXNjdXNzaW9uLCBhbmQgSSBkb24ndCB3YW50IHRv
IG1ha2UgaXQgbG9vayBsaWtlIA0KPiBpZ25vcmluZyBpdCwgSSd2ZSByZXZlcnRlZCB0aGUg
cGF0Y2ggZm9yIG5vdy7CoCBJZiBJIGFwcGx5IGl0IGFnYWluLCBJIA0KPiBob3BlIHRoYXQg
aXQgd2lsbCBiZSB3aXRoIHNvbWUgbW9yZSBjb25zZW5zdXMsIGFzIEkndmUgYWx3YXlzIHRy
aWVkIHRvIA0KPiBkby7CoCBTb3JyeSBpZiBJIHdhcyBhIGJpdCBpcmFzY2libGUgeWVzdGVy
ZGF5LsKgIFNoaXQgaGFwcGVucy4NCj4gDQo+IFRMO0RSOsKgIFBhdGNoIHJldmVydGVkOyBh
c2tpbmcgbmljZWx5IHdvcmtzLiA9KQ0KPiANCj4+DQo+PiBncmVnIGstaA0KPiANCj4gQ2hl
ZXJzLA0KPiANCj4gQWxleA0KPiANCg0KLS0gDQpBbGVqYW5kcm8gQ29sb21hcg0KPGh0dHA6
Ly93d3cuYWxlamFuZHJvLWNvbG9tYXIuZXMvPg0K

--------------3Cr5MBcyk9uZm0r3hhGNJWm1--

--------------Jcs2SV4wGLtedSe0Cg0u0fct
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmMHLPEACgkQnowa+77/
2zIJ/g/8DaBt3UpLTZvVKMjW6ELL0lD7x3FambKSQF9D4C2o51juKOgQg58Rwfs6
4/PO5BA5itoFav3k9yMr1Ou6W7pFwovX2GCc8sFPX1NDGIpVdxxZWqo+DiCOrNNx
zDpxZUK1FJdSZ8ofRZTWW+qyBds+eV7rrh3lzE6c4CC8vF99TtG/dR3YCJKiVjdC
HFsySWorAhP/bGY7KRoHPomLCt2QZvEhkWZTZMRGzKMhjX+lCleQfSDdMDhQNgTx
xayVyh2VgdoRPLtK4Cd0BxG0l2mqnCumCCjQ9yTsPdDqD0xucbeuocheV7wQsciW
xWVMBKs10E6BDiqac5W1PlVQ1ANlCHfuUFEoLhvuJTftXSa0kfFXrCseluQnhynt
FM1NGIsVcjXP/kmG3aRhXqHEMreBPYSYk2n1/BSCSOhqGDWPA7b/RQLXHQ2NrS7o
Kshl/3tmdxXxIM04Bbzyv1yEh6rahvMabXyHxNitGjRCiw2EUlDJGnz6cOmQHiHa
RDW+A5+ZDzZhwvP8LZPEv5Oa0GJUFx7Od3bYtWS74ebc9btf1+BlDhjyFT3/4zFi
SWUu+ly1I0/AvFWSEyD0B/nXFzEVCLON8oWPEyeuC4CIZLEJP2s1g7fHy/aZPBH5
yPAd9H1sprC06/Qmgik3YvozwZGUMaT/dG4zZaUA73T3ROGgIkI=
=pDPZ
-----END PGP SIGNATURE-----

--------------Jcs2SV4wGLtedSe0Cg0u0fct--

--===============1851349000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1851349000==--
