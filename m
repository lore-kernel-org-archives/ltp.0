Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B73CC369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745604395; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=vDwV4FpXlxabvr1zgqitrWT/8NMuWp/VZjK+lqzXQhU=;
 b=ebojjW+8Jymv+FPay2VDIYzzP0j/whjqro9lmKCl4nZ1rTBbR0AIvs2nlRykkeJwPDv6L
 jk1DXO2lVYc55Cc9OXjl8j553gr9P/y2JDNfzahdNukeanlU6uClR/ThKP/65L5bN1T3ulV
 nRds07wpWDiIfDO9tXN8NDAac/uLRLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB7333CBA6A
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 20:06:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71273CB85A
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:06:12 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 27E1D1000A61
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:06:11 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso454240666b.0
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745604370; x=1746209170; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OblBp3yFTJlE7MR0YYT7RYs8XBfbsxQ9LU2aIGDm2Zs=;
 b=FRmf0qkqxS4dj5evTsnyXD9dRnpB0jzE9SFXELCqPC+V1UM7rsrHY1VdlUHbe3GoIn
 0SyV/pRV7AIIX+Fp8vL5dddAgmbqpWjr99cuKvXIdZrnoLJr19DPGxHQ9o3IV1bbuO7o
 iI1UovOYQDPwxByM5FB6EZRzrRd/e1+uSbztGFEa+6qt6cp1BpnU+E7vn2tb23wzwzsd
 op0e7qsk7DZVjYzu3B/tmBfkPjhJYryDGcnd9Nl/wwTlXfn/Wboj8m4H+05SV/Dcpyp7
 XL5wQlqm2VINWtbLoSsFn6faGXOAM76yS8rrJavQd1mhrRSdVLlyHbWtw3LyFVMbVSZX
 L+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745604370; x=1746209170;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OblBp3yFTJlE7MR0YYT7RYs8XBfbsxQ9LU2aIGDm2Zs=;
 b=u0hORLkFXXIbLPkJQvtqycZh+xXh3pSfJPtrnLWA6/V164f/S7E8vgT2wh33iufHkx
 LLLE7ctQPdEQMjC54wgk5uaoUh3tF3MB8+/myJyb1spiL0RFe9oon7H43u2nAU+bSfJh
 M/2eu5K9ENVtR44pWDtkjOOlUYYRBdHCb/4sb7/owGt/b5e/PZT6hNaIOp/CKr83BDw8
 NTg06uwb9Tad5ApumUm4JTZZg6+G9d7VZHU6DVaml1dfgoKRTWyQ+4HtNLIypdW8bLVP
 TRrEBMr6DHUy54JNU4yrbtXMeiPh9A9NQ1U85x7YWM55Mp5fxEWTsyHdIYoW714lYXc3
 nGXg==
X-Gm-Message-State: AOJu0Yw1eDA7C+Lwvzwf0ZTycSEdY+E2/EJZMm+cwx9qP3MvOw+ZRkU0
 KBekrCO1dK69C4pVjci/HermTgM32RjfhntrlCI0G8oDI7Td3X0ZpaeMl2FxxQU=
X-Gm-Gg: ASbGncs7dHw4St2ZgFWELSAPPGKFJpFtrUPYWu+EUz5O+LzFqzpUi7pQhK6v8N/bg2E
 nCdIL3f72Q8/4atzcJc4BuOItSuv9POM8hFs4w8UUmuICD30l0w45TP3lw7lIPpj470720HTuz6
 mujNnbI90aQs2X8KGPi/z+D8aqlEOPic/ioOO38UDLj6lXMRsPSUaknXEBhyDwlSH9LDOS7Hzov
 migzSFEo91hRdGAC6OWJZMGwQgVgsm84Sun6lbIMfHO8FhbwCfuJWEQI00KNm1mXZYKO8sn2IEE
 ofpd5HHo8FrYWw3cOoGeeW3FnazbhA==
X-Google-Smtp-Source: AGHT+IFdobK7+3qtZgphs0t5kXGiklOAhV/DT4eeoyOehCicnictjiOs/U3yHXAJ2K0DVQPh1xS+ow==
X-Received: by 2002:a17:906:6049:b0:ace:82a6:b938 with SMTP id
 a640c23a62f3a-ace82a6ba5emr64928366b.36.1745604370393; 
 Fri, 25 Apr 2025 11:06:10 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309f784a58dsm1960743a91.43.2025.04.25.11.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 11:06:09 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:06:00 -0300
Message-Id: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAjPC2gC/33NzWoCMRQF4FeRrHtL/pxoV30PcZGfO04ok5Tca
 VBk3t3EjVLE5YFzvnNlhCUisa/NlRWskWJOLeiPDfOTTSeEGFpmksstV2IPPqeKpdcI5p+UA/i
 w805zE6QOrO1+C47xfDcPx5adJQRXbPJTl2ZLC5ZenCItuVzu31X0+rubKkDAqAc0gwpGcv5Nf
 4SfPs+sv1T5BEjxCpAN8HsvjQu4ddz8A9QD0EK/AhRwQL5DowflRmufgHVdbzTcSSxMAQAA
X-Change-ID: 20250319-conversions-mknod-cd8cb407d24d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=rbm@suse.com;
 h=from:subject:message-id; bh=AAuoqperOzzD+dzMWeZvPBZLriDUy8j4NtxqjpIXwyI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoC88MJb5gRGgobvmGsnCrI0x1vv2/1ZLlKN5xJ
 8XhOvnw9YuJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaAvPDAAKCRDJC4p8Y4ZY
 pvOVEACVy216JoA4HGDgERkJIVMbbi3SDNySz+EG3MRNB5cSC9V1xI7750R/HPfpbADA1mlVc0J
 NN58FMIhhI+YrUz6ZdQJ2l++yRSrmuzIfzU2BBWqy6qFjTSlsXjfREx2sRiUUFHaxSGydH3XWQD
 NgMEDugZNdZxCPDcojPk8wb09hbZh7v73974Qqs4Mb2LIX5Dk+YU+NyuswaTtAvF4HaQjsK4G6C
 sMhka/cHm7UXbOJkiIheOAAww5+XVEEGBvCY5uW8paE5TO+zKXCzgV2aw9VFdUw9vRfH03FV05w
 cFL9auPumTb7ilSxzcw7at/IxsFvOciciFZhVevatiMaWUFLYGltrWtNKAFHviZ0kpRHmZ5Vchf
 UdQadbKNUy4tx9TwdghUIzRIZVnrAEs3T/MW+SCjl+mSt96W178ZRvPRV05bEbouRmFO1Xu+NKX
 BkopYwyf1V4hCHQFgbYf3kQXfN6ewTz2XApQtMXbKur8XJY2qM9cQV5OVmRcNJpDTZ1DHhOHXVM
 9NjLj8CWokBZB33OWvJkNyRIfxUWLcB2US80WbeenbTb0cROpRlwGOHsLwhDkKovavvmPeGFU75
 oIyzIRV+9ilQT9NFGNhTPWFkCtsysH0f9CaeWZMP0XGnnmEnM4rVqITYJfJvDNWcCN54je2kivp
 zHO0KlVvgb6v91w==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/8] syscalls/mknod: Refactor all tests
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SWYgbmVlZGVkLCB5b3UgY2FuIGZpbmQgdGhpcyBzZXJpZXMgYXZhaWxhYmxlIGhlcmU6CgpodHRw
czovL2dpdC5tYXJsaWVyZS5uZXQvbHRwL2x0cC8KCmBnaXQgY2xvbmUgLS1icmFuY2ggY29udmVy
c2lvbnMvbWtub2QgLS1zaW5nbGUtYnJhbmNoIGh0dHBzOi8vZ2l0Lm1hcmxpZXJlLm5ldC9sdHAv
bHRwL2AKClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+
Ci0tLQpDaGFuZ2VzIGluIHY0OgotIEZpeGVkIG1vZGVzIGJpdHMgaW4gYWxsIHRlc3RzCi0gUmVt
b3ZlZCB1bm5lY2Vzc2FyeSBTQUZFX1NUQVQgY2FsbCBpbiBta25vZDAzIChTQUZFX0NITU9EIGlz
IGVub3VnaCkKLSBGaXhlZCAlbGQgd2FybmluZyBpbiBta25vZDAxCi0gUmViYXNlZAotIExpbmsg
dG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA0MTQtY29udmVyc2lvbnMtbWtu
b2QtdjMtMC1lMDhlNzQ2M2JmYWFAc3VzZS5jb20KCkNoYW5nZXMgaW4gdjM6Ci0gbWtub2QwMzoK
CUZpeGVkIHRlc3QgZGVzY3JpcHRpb24gYWxpZ25tZW50CglSZW1vdmVkIGFuIG91dGRhdGVkIGNv
bW1lbnQgKENWRSkKCU1hZGUgZnVuY3Rpb25zIHN0YXRpYwoJTW92ZWQgc2V0Z2lkKCkgYW5kIHNl
dHJldWlkKCkgY2FsbHMgdG8gc2V0dXAoKQoJUmVuYW1lIFRTVF9ESVIgYW5kIFRTVF9OT0RFIHRv
IFRFTVBfKgotIEFsc28gcmVmYWN0b3JlZCByZW1haW5pbmcgbWtub2QgdGVzdHMKLSBMaW5rIHRv
IHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMzIxLWNvbnZlcnNpb25zLW1rbm9k
LXYyLTEtYzljMjdiZGU1YjA3QHN1c2UuY29tCgpDaGFuZ2VzIGluIHYyOgotIE1hZGUgdXNlIG9m
IFRTVF9FWFBfRVFfTEkKLSBNb3ZlZCB0ZXN0IHRtcCBkaXJlY3RvcnkgY3JlYXRpb24gaW50byBz
ZXR1cCgpCi0gUmVtb3ZlZCBub3cgdW5uZWVkZWQgb3JpZ191aWQKLSBMaW5rIHRvIHYxOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMzE5LWNvbnZlcnNpb25zLW1rbm9kLXYxLTEtZjQ2
ZTc2M2Q3MjAwQHN1c2UuY29tCgotLS0KUmljYXJkbyBCLiBNYXJsacOocmUgKDgpOgogICAgICBz
eXNjYWxscy9ta25vZDAxOiBGaXggY2hlY2twYXRjaC5wbCB3YXJuaW5ncwogICAgICBzeXNjYWxs
cy9ta25vZDAyOiBVc2UgcmVsYXRpdmUgcGF0aCB0byBhdm9pZCB1c2Ugb2YgU0FGRV9DSERJUgog
ICAgICBzeXNjYWxscy9ta25vZDAzOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHMv
bWtub2QwNDogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxzL21rbm9kMDU6IENvbnZl
cnQgdG8gbmV3IEFQSQogICAgICBzeXNjYWxscy9ta25vZDA2OiBDb252ZXJ0IHRvIG5ldyBBUEkK
ICAgICAgc3lzY2FsbHMvbWtub2QwNzogQ29udmVydCB0byBuZXcgQVBJCiAgICAgIHN5c2NhbGxz
L21rbm9kMDg6IENvbnZlcnQgdG8gbmV3IEFQSQoKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bWtub2QvbWtub2QwMS5jIHwgICA3ICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9k
L21rbm9kMDIuYyB8ICAgNCArLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25v
ZDAzLmMgfCAzMTMgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwNC5jIHwgMzE5ICsrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDA1LmMgfCAyODUg
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtu
b2QvbWtub2QwNi5jIHwgMzAxICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwNy5jIHwgMjA5ICsrKysrKy0tLS0tLS0tLS0t
LS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDguYyB8IDMxMiArKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogOCBmaWxlcyBjaGFuZ2VkLCAyNjEgaW5zZXJ0aW9u
cygrKSwgMTQ4OSBkZWxldGlvbnMoLSkKLS0tCmJhc2UtY29tbWl0OiAwMzdjYjUzZTM1M2FiYjU3
MWU1MmI1MmNiYWE2YjU2OWFjMjhjNTBjCmNoYW5nZS1pZDogMjAyNTAzMTktY29udmVyc2lvbnMt
bWtub2QtY2Q4Y2I0MDdkMjRkCgpCZXN0IHJlZ2FyZHMsCi0tIApSaWNhcmRvIEIuIE1hcmxpw6hy
ZSA8cmJtQHN1c2UuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
