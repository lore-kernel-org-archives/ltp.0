Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BBAC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 05:57:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9A460EE9
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 05:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D9A460EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC3B53C4DD4
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 07:57:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE3BF3C4D41
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 07:57:03 +0200 (CEST)
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id E9E1A60076B
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 07:57:00 +0200 (CEST)
HMM_SOURCE_IP: 172.18.0.48:34644.578139612
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-10.133.11.243 (unknown [172.18.0.48])
 by chinatelecom.cn (HERMES) with SMTP id 402A928008B;
 Wed, 20 Oct 2021 13:56:45 +0800 (CST)
X-189-SAVE-TO-SEND: liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
 by app0024 with ESMTP id 0657492927bc4f29a1bdc13280513ae4 for
 krzysztof.kozlowski@canonical.com; Wed, 20 Oct 2021 13:56:49 CST
X-Transaction-ID: 0657492927bc4f29a1bdc13280513ae4
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
Date: Wed, 20 Oct 2021 13:56:48 +0800
From: "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>, 
 ltp <ltp@lists.linux.it>
References: <20211019150206.90335-1-krzysztof.kozlowski@canonical.com>
X-Priority: 3
X-GUID: 8EF5B085-1C73-45CA-997D-A2FAB0BF2992
X-Has-Attach: no
X-Mailer: Foxmail 7.2.20.258[cn]
Mime-Version: 1.0
Message-ID: <202110201356480826324@chinatelecom.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: respect minimum memory watermark
 when polluting memory
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
Content-Type: multipart/mixed; boundary="===============1548487058=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a multi-part message in MIME format.

--===============1548487058==
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart176036538777_=----"

This is a multi-part message in MIME format.

------=_001_NextPart176036538777_=----
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

U2VydmVyYWwgbW9udGhzIGFnbyxpIHJlcG9ydCB0aGlzIGlzc3VlLkkgc3VnZ2VzdCB0byB1c2Ug
YXZhaWxhYmxlIG1lbW9yeS4NCllvdSBjYW4gdGVzdCB3aXRoIGF2YWlsYWJsZSBtZW1vcnkgaW5z
dGVhZCBvZiBmcmVlcmFtLEl0IHdpbGwgYmUgT0suDQoNClJlcG9ydC1ieTogTGl1IFhpbnBlbmcg
PGxpdXhwMTFAY2hpbmF0ZWxlY29tLmNuPg0KUmV2aWV3ZWQtYnk6IExpdSBYaW5wZW5nIDxsaXV4
cDExQGNoaW5hdGVsZWNvbS5jbj4NCg0KDQoNClRoYW5rc++8gQ0KDQogDQpGcm9tOiBLcnp5c3p0
b2YgS296bG93c2tpDQpEYXRlOiAyMDIxLTEwLTE5IDIzOjAyDQpUbzogbHRwDQpTdWJqZWN0OiBb
TFRQXSBbUEFUQ0hdIGxpYjogbWVtdXRpbHM6IHJlc3BlY3QgbWluaW11bSBtZW1vcnkgd2F0ZXJt
YXJrIHdoZW4gcG9sbHV0aW5nIG1lbW9yeQ0KUHJldmlvdXMgZml4IGZvciBhbiBvdXQtb2YtbWVt
b3J5IGtpbGxlciBraWxsaW5nIGlvY3RsX3NnMDEgcHJvY2Vzcw0KaW4gY29tbWl0IDRkMmUzZDQ0
ZmFkNSAoImxpYjogbWVtdXRpbHM6IGRvbid0IHBvbGx1dGUNCmVudGlyZSBzeXN0ZW0gbWVtb3J5
IHRvIGF2b2lkIE9vTSIpIHdhcyBub3QgZnVsbHkgZWZmZWN0aXZlLiAgV2hpbGUgaXQNCmNvdmVy
cyBtb3N0IG9mIHRoZSBjYXNlcywgYW4gQVJNNjQgbWFjaGluZSB3aXRoIDEyOCBHQiBvZiBtZW1v
cnksIDY0IGtCDQpwYWdlIHNpemUgYW5kIHY1LjExIGtlcm5lbCBoaXQgaXQgYWdhaW4uICBQb2xs
dXRpbmcgdGhlIG1lbW9yeSBmYWlscw0Kd2l0aCBPb006DQogDQogIExUUDogc3RhcnRpbmcgaW9j
dGxfc2cwMQ0KICBpb2N0bF9zZzAxIGludm9rZWQgb29tLWtpbGxlcjogZ2ZwX21hc2s9MHgxMDBk
Y2EoR0ZQX0hJR0hVU0VSX01PVkFCTEV8X19HRlBfWkVSTyksIG9yZGVyPTAsIG9vbV9zY29yZV9h
ZGo9MA0KICAuLi4NCiAgTWVtLUluZm86DQogIGFjdGl2ZV9hbm9uOjMwOSBpbmFjdGl2ZV9hbm9u
OjE5NjQ3ODEgaXNvbGF0ZWRfYW5vbjowDQogICAgICAgICAgICAgICAgICBhY3RpdmVfZmlsZTo5
NCBpbmFjdGl2ZV9maWxlOjAgaXNvbGF0ZWRfZmlsZTowDQogICAgICAgICAgICAgICAgICB1bmV2
aWN0YWJsZTozMDUgZGlydHk6MCB3cml0ZWJhY2s6MA0KICAgICAgICAgICAgICAgICAgc2xhYl9y
ZWNsYWltYWJsZToxNTEwIHNsYWJfdW5yZWNsYWltYWJsZTo1MDEyDQogICAgICAgICAgICAgICAg
ICBtYXBwZWQ6MTE1IHNobWVtOjMzOSBwYWdldGFibGVzOjQ2MyBib3VuY2U6MA0KICAgICAgICAg
ICAgICAgICAgZnJlZToxMTIwNDMgZnJlZV9wY3A6MSBmcmVlX2NtYTozMTU5DQogIE5vZGUgMCBh
Y3RpdmVfYW5vbjoxOTc3NmtCIGluYWN0aXZlX2Fub246MTI1NzQ1OTg0a0IgYWN0aXZlX2ZpbGU6
NjAxNmtCIGluYWN0aXZlX2ZpbGU6MGtCIHVuZXZpY3RhYmxlOjE5NTIwa0IgLi4uDQogIE5vZGUg
MCBETUEgZnJlZTo3MTA2NTZrQiBtaW46MjA1MTIwa0IgbG93OjI1NjM4NGtCIGhpZ2g6MzA3NjQ4
a0IgcmVzZXJ2ZWRfaGlnaGF0b21pYzowS0IgYWN0aXZlX2Fub246MGtCIGluYWN0aXZlX2Fub246
MzMzMjAzMmtCIC4uLg0KICBsb3dtZW1fcmVzZXJ2ZVtdOiAwIDAgNzkwOCA3OTA4IDc5MDgNCiAg
Tm9kZSAwIE5vcm1hbCBmcmVlOjY0NjAwOTZrQiBtaW46NjQ2MzE2OGtCIGxvdzo4MDc4OTEya0Ig
aGlnaDo5Njk0NjU2a0IgcmVzZXJ2ZWRfaGlnaGF0b21pYzowS0IgYWN0aXZlX2Fub246MTk3NzZr
QiBpbmFjdGl2ZV9hbm9uOjEyMjQxMzk1MmtCIC4uLg0KICBsb3dtZW1fcmVzZXJ2ZVtdOiAwIDAg
MCAwIDANCiANClRoZSBpbXBvcnRhbnQgcGFydCBhcmUgZGV0YWlscyBvZiBtZW1vcnkgb24gTm9k
ZSAwIGluIE5vcm1hbCB6b25lOg0KMS4gZnJlZSBtZW1vcnk6IDY0NjAwOTYga0INCjIuIG1pbiAo
bWluaW11bSB3YXRlcm1hcmspOiA2NDYzMTY4IGtCDQogDQpQYXJzZSB0aGUgL3Byb2Mvem9uZWlu
Zm8gYW5kIGluY2x1ZGUgdGhlICJtaW4iIGRhdGEgd2hlbiBjb3VudGluZyBzYWZldHkNCihmcmVl
IG1lbW9yeSB3aGljaCBzaG91bGQgbm90IGJlIHBvbGx1dGVkKS4gIFRoaXMgd2F5IHdlIGFsc28g
aW5jbHVkZQ0KbWluaW11bSBtZW1vcnkgZm9yIERNQSB6b25lcyBhbmQgYWxsIG5vZGVzLg0KIA0K
U2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBj
YW5vbmljYWwuY29tPg0KLS0tDQpsaWIvdHN0X21lbXV0aWxzLmMgfCAzMSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tDQoxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCiANCmRpZmYgLS1naXQgYS9saWIvdHN0X21lbXV0aWxzLmMgYi9saWIvdHN0
X21lbXV0aWxzLmMNCmluZGV4IGFmMTMyYmNjNmMyNC4uZjM0YmE1ODJlYzkzIDEwMDY0NA0KLS0t
IGEvbGliL3RzdF9tZW11dGlscy5jDQorKysgYi9saWIvdHN0X21lbXV0aWxzLmMNCkBAIC02LDIy
ICs2LDQ5IEBADQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5jbHVkZSA8bGltaXRzLmg+DQojaW5j
bHVkZSA8c3lzL3N5c2luZm8uaD4NCisjaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzdGRs
aWIuaD4NCiNkZWZpbmUgVFNUX05PX0RFRkFVTFRfTUFJTg0KI2luY2x1ZGUgInRzdF90ZXN0Lmgi
DQorI2luY2x1ZGUgInRzdF9zYWZlX3N0ZGlvLmgiDQojZGVmaW5lIEJMT0NLU0laRSAoMTYgKiAx
MDI0ICogMTAyNCkNCit1bnNpZ25lZCBsb25nIHRzdF9taW5fbWVtb3J5KHZvaWQpDQorew0KKyBG
SUxFICpmcDsNCisgaW50IHJldDsNCisgdW5zaWduZWQgbG9uZyB0b3RhbF9wYWdlcyA9IDA7DQor
IHVuc2lnbmVkIGxvbmcgcGFnZXM7DQorIGNoYXIgbGluZVtCVUZTSVpdOw0KKw0KKyBmcCA9IFNB
RkVfRk9QRU4oIi9wcm9jL3pvbmVpbmZvIiwgInIiKTsNCisNCisgd2hpbGUgKGZnZXRzKGxpbmUs
IEJVRlNJWiwgZnApICE9IE5VTEwpIHsNCisgcmV0ID0gc3NjYW5mKGxpbmUsICIgbWluICVsdSIs
ICZwYWdlcyk7DQorIGlmIChyZXQgPT0gMSkNCisgdG90YWxfcGFnZXMgKz0gcGFnZXM7DQorIH0N
CisNCisgU0FGRV9GQ0xPU0UoZnApOw0KKw0KKyAvKiBBcHBseSBhIG1hcmdpbiBiZWNhdXNlIHdl
IGNhbm5vdCBnZXQgYmVsb3cgIm1pbiIgd2F0ZXJtYXJrICovDQorIHRvdGFsX3BhZ2VzICs9ICh0
b3RhbF9wYWdlcyAvIDEwKTsNCisNCisgcmV0dXJuIHRvdGFsX3BhZ2VzOw0KK30NCisNCnZvaWQg
dHN0X3BvbGx1dGVfbWVtb3J5KHNpemVfdCBtYXhzaXplLCBpbnQgZmlsbGNoYXIpDQp7DQpzaXpl
X3QgaSwgbWFwX2NvdW50ID0gMCwgc2FmZXR5ID0gMCwgYmxvY2tzaXplID0gQkxPQ0tTSVpFOw0K
KyBsb25nIHBhZ2VzaXplID0gU0FGRV9TWVNDT05GKF9TQ19QQUdFU0laRSk7DQp2b2lkICoqbWFw
X2Jsb2NrczsNCnN0cnVjdCBzeXNpbmZvIGluZm87DQpTQUZFX1NZU0lORk8oJmluZm8pOw0KLSBz
YWZldHkgPSBNQVgoNDA5NiAqIFNBRkVfU1lTQ09ORihfU0NfUEFHRVNJWkUpLCAxMjggKiAxMDI0
ICogMTAyNCk7DQotIHNhZmV0eSA9IE1BWChzYWZldHksIChpbmZvLmZyZWVyYW0gLyA2NCkpOw0K
KyBzYWZldHkgPSBNQVgoNDA5NiAqIHBhZ2VzaXplLCAxMjggKiAxMDI0ICogMTAyNCk7DQorIHNh
ZmV0eSA9IE1BWChzYWZldHksIHRzdF9taW5fbWVtb3J5KCkgKiBwYWdlc2l6ZSk7DQpzYWZldHkg
Lz0gaW5mby5tZW1fdW5pdDsNCmlmIChpbmZvLmZyZWVzd2FwID4gc2FmZXR5KQ0KLS0gDQoyLjMw
LjINCiANCiANCi0tIA0KTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwDQo=

------=_001_NextPart176036538777_=----
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3Dutf-8"><style>body { line-height: 1.5; }blockquote { margin-top: 0px; =
margin-bottom: 0px; margin-left: 0.5em; }p { margin-top: 0px; margin-botto=
m: 0px; }body { font-size: 14px; font-family: "Microsoft YaHei UI"; color:=
 rgb(0, 0, 0); line-height: 1.5; }</style></head><body>=0A<div><span></spa=
n>Serveral months ago,i report this issue.I suggest to use&nbsp;<span styl=
e=3D"background-color: transparent;">available memory.</span></div>=0A<div=
>You can test with available memory instead of&nbsp;<span style=3D"backgro=
und-color: transparent;">freeram,It will be OK.</span></div><div><span sty=
le=3D"background-color: transparent;"><br></span></div><div><span style=3D=
"background-color: transparent;">Report-by:&nbsp;</span><span style=3D"bac=
kground-color: transparent; font-family: &quot;Microsoft YaHei UI&quot;, T=
ahoma; font-size: small;">Liu Xinpeng &lt;</span><a href=3D"mailto:liwang@=
redhat.com" target=3D"_blank" class=3D"" style=3D"background-color: transp=
arent; font-family: &quot;Microsoft YaHei UI&quot;, Tahoma; font-size: sma=
ll; text-decoration-line: none !important;">liuxp11@chinatelecom.cn</a><sp=
an style=3D"background-color: transparent; font-family: &quot;Microsoft Ya=
Hei UI&quot;, Tahoma; font-size: small;">&gt;</span></div><div><span style=
=3D"font-family: &quot;Microsoft YaHei UI&quot;, Tahoma; font-size: small;=
">Reviewed-by: Liu Xinpeng &lt;</span><a href=3D"mailto:liwang@redhat.com"=
 target=3D"_blank" style=3D"font-family: &quot;Microsoft YaHei UI&quot;, T=
ahoma; font-size: small; text-decoration-line: none !important;" class=3D"=
">liuxp11@chinatelecom.cn</a><span style=3D"font-family: &quot;Microsoft Y=
aHei UI&quot;, Tahoma; font-size: small;">&gt;</span></div><div><br></div>=
<hr style=3D"width: 210px; height: 1px;" color=3D"#b5c4df" size=3D"1" alig=
n=3D"left">=0A<div><span><div style=3D"MARGIN: 10px; FONT-FAMILY: verdana;=
 FONT-SIZE: 10pt"><p class=3D"MsoNormal" style=3D"margin: 0cm; font-size: =
10.5pt; font-family: =E7=AD=89=E7=BA=BF; line-height: normal; text-align: =
justify;"><span lang=3D"EN-US" style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=
=9B=85=E9=BB=91, sans-serif;">Thanks=EF=BC=81</span></p><p class=3D"MsoNor=
mal" style=3D"margin: 0cm; font-size: 10.5pt; font-family: =E7=AD=89=E7=BA=
=BF; line-height: normal; text-align: justify;"><br></p></div></span></div=
>=0A<blockquote style=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left:=
 0.5em; margin-Right: inherit"><div>&nbsp;</div><div style=3D"border:none;=
border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div style=3D"PA=
DDING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:tahoma;CO=
LOR:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TOP: 8px"><=
div><b>From:</b>&nbsp;<a href=3D"mailto:krzysztof.kozlowski@canonical.com"=
>Krzysztof Kozlowski</a></div><div><b>Date:</b>&nbsp;2021-10-19&nbsp;23:02=
</div><div><b>To:</b>&nbsp;<a href=3D"mailto:ltp@lists.linux.it">ltp</a></=
div><div><b>Subject:</b>&nbsp;[LTP] [PATCH] lib: memutils: respect minimum=
 memory watermark when polluting memory</div></div></div><div><div>Previou=
s fix for an out-of-memory killer killing ioctl_sg01 process</div>=0A<div>=
in commit 4d2e3d44fad5 ("lib: memutils: don't pollute</div>=0A<div>entire =
system memory to avoid OoM") was not fully effective.&nbsp; While it</div>=
=0A<div>covers most of the cases, an ARM64 machine with 128 GB of memory, =
64 kB</div>=0A<div>page size and v5.11 kernel hit it again.&nbsp; Pollutin=
g the memory fails</div>=0A<div>with OoM:</div>=0A<div>&nbsp;</div>=0A<div=
>&nbsp; LTP: starting ioctl_sg01</div>=0A<div>&nbsp; ioctl_sg01 invoked oo=
m-killer: gfp_mask=3D0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=3D0,=
 oom_score_adj=3D0</div>=0A<div>&nbsp; ...</div>=0A<div>&nbsp; Mem-Info:</=
div>=0A<div>&nbsp; active_anon:309 inactive_anon:1964781 isolated_anon:0</=
div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_file:94 inactive_file:0 is=
olated_file:0</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unevictable:305 di=
rty:0 writeback:0</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; slab_reclaimab=
le:1510 slab_unreclaimable:5012</div>=0A<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
mapped:115 shmem:339 pagetables:463 bounce:0</div>=0A<div>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; free:112043 free_pcp:1 free_cma:3159</div>=0A<div>&nbsp; Node=
 0 active_anon:19776kB inactive_anon:125745984kB active_file:6016kB inacti=
ve_file:0kB unevictable:19520kB ...</div>=0A<div>&nbsp; Node 0 DMA free:71=
0656kB min:205120kB low:256384kB high:307648kB reserved_highatomic:0KB act=
ive_anon:0kB inactive_anon:3332032kB ...</div>=0A<div>&nbsp; lowmem_reserv=
e[]: 0 0 7908 7908 7908</div>=0A<div>&nbsp; Node 0 Normal free:6460096kB m=
in:6463168kB low:8078912kB high:9694656kB reserved_highatomic:0KB active_a=
non:19776kB inactive_anon:122413952kB ...</div>=0A<div>&nbsp; lowmem_reser=
ve[]: 0 0 0 0 0</div>=0A<div>&nbsp;</div>=0A<div>The important part are de=
tails of memory on Node 0 in Normal zone:</div>=0A<div>1. free memory: 646=
0096 kB</div>=0A<div>2. min (minimum watermark): 6463168 kB</div>=0A<div>&=
nbsp;</div>=0A<div>Parse the /proc/zoneinfo and include the "min" data whe=
n counting safety</div>=0A<div>(free memory which should not be polluted).=
&nbsp; This way we also include</div>=0A<div>minimum memory for DMA zones =
and all nodes.</div>=0A<div>&nbsp;</div>=0A<div>Signed-off-by: Krzysztof K=
ozlowski &lt;krzysztof.kozlowski@canonical.com&gt;</div>=0A<div>---</div>=
=0A<div> lib/tst_memutils.c | 31 +++++++++++++++++++++++++++++--</div>=0A<=
div> 1 file changed, 29 insertions(+), 2 deletions(-)</div>=0A<div>&nbsp;<=
/div>=0A<div>diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c</div>=0A=
<div>index af132bcc6c24..f34ba582ec93 100644</div>=0A<div>--- a/lib/tst_me=
mutils.c</div>=0A<div>+++ b/lib/tst_memutils.c</div>=0A<div>@@ -6,22 +6,49=
 @@</div>=0A<div> #include &lt;unistd.h&gt;</div>=0A<div> #include &lt;lim=
its.h&gt;</div>=0A<div> #include &lt;sys/sysinfo.h&gt;</div>=0A<div>+#incl=
ude &lt;stdio.h&gt;</div>=0A<div> #include &lt;stdlib.h&gt;</div>=0A<div> =
</div>=0A<div> #define TST_NO_DEFAULT_MAIN</div>=0A<div> #include "tst_tes=
t.h"</div>=0A<div>+#include "tst_safe_stdio.h"</div>=0A<div> </div>=0A<div=
> #define BLOCKSIZE (16 * 1024 * 1024)</div>=0A<div> </div>=0A<div>+unsign=
ed long tst_min_memory(void)</div>=0A<div>+{</div>=0A<div>+	FILE *fp;</div=
>=0A<div>+	int ret;</div>=0A<div>+	unsigned long total_pages =3D 0;</div>=
=0A<div>+	unsigned long pages;</div>=0A<div>+	char line[BUFSIZ];</div>=0A<=
div>+</div>=0A<div>+	fp =3D SAFE_FOPEN("/proc/zoneinfo", "r");</div>=0A<di=
v>+</div>=0A<div>+	while (fgets(line, BUFSIZ, fp) !=3D NULL) {</div>=0A<di=
v>+		ret =3D sscanf(line, " min %lu", &amp;pages);</div>=0A<div>+		if (ret=
 =3D=3D 1)</div>=0A<div>+			total_pages +=3D pages;</div>=0A<div>+	}</div>=
=0A<div>+</div>=0A<div>+	SAFE_FCLOSE(fp);</div>=0A<div>+</div>=0A<div>+	/*=
 Apply a margin because we cannot get below "min" watermark */</div>=0A<di=
v>+	total_pages +=3D (total_pages / 10);</div>=0A<div>+</div>=0A<div>+	ret=
urn total_pages;</div>=0A<div>+}</div>=0A<div>+</div>=0A<div> void tst_pol=
lute_memory(size_t maxsize, int fillchar)</div>=0A<div> {</div>=0A<div> 	s=
ize_t i, map_count =3D 0, safety =3D 0, blocksize =3D BLOCKSIZE;</div>=0A<=
div>+	long pagesize =3D SAFE_SYSCONF(_SC_PAGESIZE);</div>=0A<div> 	void **=
map_blocks;</div>=0A<div> 	struct sysinfo info;</div>=0A<div> </div>=0A<di=
v> 	SAFE_SYSINFO(&amp;info);</div>=0A<div>-	safety =3D MAX(4096 * SAFE_SYS=
CONF(_SC_PAGESIZE), 128 * 1024 * 1024);</div>=0A<div>-	safety =3D MAX(safe=
ty, (info.freeram / 64));</div>=0A<div>+	safety =3D MAX(4096 * pagesize, 1=
28 * 1024 * 1024);</div>=0A<div>+	safety =3D MAX(safety, tst_min_memory() =
* pagesize);</div>=0A<div> 	safety /=3D info.mem_unit;</div>=0A<div> </div=
>=0A<div> 	if (info.freeswap &gt; safety)</div>=0A<div>-- </div>=0A<div>2.=
30.2</div>=0A<div>&nbsp;</div>=0A<div>&nbsp;</div>=0A<div>-- </div>=0A<div=
>Mailing list info: https://lists.linux.it/listinfo/ltp</div>=0A</div></bl=
ockquote>=0A</body></html>
------=_001_NextPart176036538777_=------


--===============1548487058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1548487058==--

