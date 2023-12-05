Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD30C4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 10:34:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC8143CC303
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 11:34:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 512003CBFA3
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 08:43:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 465DD600CCC
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 08:43:28 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 985516159A
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAEEC433C7
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701762206;
 bh=huchmesfybyXuM+lyDjjl6VzGgzZkYm2rIzVxxttKFE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YcrWy/Sl/r9VzJiyNShC8skvkO3Lk9FiBE+ilFWUwaJUqrj8gEssHaC9BOIRL7S8x
 kg4ckJ7Iy7JrSFV+qmMb/gZhdclG/XecH5zyzEKREc4Qt7piJbKvJQZvXsPHxaeCOZ
 bDMjCJuVqZDACJlolVdBZvwPC00XR2eBPSc59bpN23u1DsABofQAfRxOI5sPYkEoqz
 PnZrlf7Vw9G0fuDogzI49iDyKm4i2mAdMXBzAj8WQPl3Gz8cTLXHk0m4D3ftgX6Xiy
 3JsJ/TZ5O+IoSAaTnjHwM0uDWvgS3B4+xIWB6v01spOUFMRlC8L4Qk6qIjfxyzgwi5
 2rHPI7tBTUEnw==
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-a1b654faa8cso268263266b.2
 for <ltp@lists.linux.it>; Mon, 04 Dec 2023 23:43:25 -0800 (PST)
X-Gm-Message-State: AOJu0Yy4L4/X8gayUAfwJEsYBifVYhAM/5hDsXfHs06spn8M8NeOAnBY
 e8R7dYH7lb1ljqUCA+qFjtZh3Trw81hvSK6/oZM=
X-Google-Smtp-Source: AGHT+IErTFrvgaIg9WpHY8x7C27pk4WG4fV1Aw6NvOr+OKPIJPeiuiRmtC5D8IaYY+gBEQRNzuhnSgACN40VcUqxJnw=
X-Received: by 2002:a17:906:2259:b0:a19:d40a:d1ea with SMTP id
 25-20020a170906225900b00a19d40ad1eamr2276483ejr.182.1701762204390; Mon, 04
 Dec 2023 23:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20231205073721.1203427-1-zhanghongchen@loongson.cn>
In-Reply-To: <20231205073721.1203427-1-zhanghongchen@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 5 Dec 2023 15:43:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7KgcwKSBHiqd6ku8pMd9AD9PhpE=EnoAX2mJLJR=VeVw@mail.gmail.com>
Message-ID: <CAAhV-H7KgcwKSBHiqd6ku8pMd9AD9PhpE=EnoAX2mJLJR=VeVw@mail.gmail.com>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 05 Dec 2023 11:34:14 +0100
Subject: Re: [LTP] [PATCH] hugemmap13: use MMAP_GRANULARITY instead of page
 size
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBEZWMgNSwgMjAyMyBhdCAzOjM34oCvUE0gSG9uZ2NoZW4gWmhhbmcgPHpoYW5naG9u
Z2NoZW5AbG9vbmdzb24uY24+IHdyb3RlOgo+Cj4gRm9yIHNvbWUgYXJjaGl0ZWN0dXJlcyBsaWtl
IExvb25nQXJjaCwgbW1hcChNQVBfRklYRUQgfCBNQVBfU0hBUkVEKQo+IGhhcyB0byBiZSBhbGln
bmVkIHRvIFNITUxCQS4gU28gdXNlIE1NQVBfR1JBTlVMQVJJVFkgaW5zdGVhZCBvZgo+IHBhZ2Ug
c2l6ZSB3aGVuIG1tYXAsIG90aGVyd2lzZSB0aGUgdGVzdCB3aWxsIGZhaWwuCkkgdGhpbmsgYW55
IGFyY2hpdGVjdHVyZSBzaG91bGQgYWxpZ24gdG8gU0hNTEJBLCBub3Qgb25seSBMb29uZ0FyY2gu
IDopCgpIdWFjYWkKCj4KPiBTdWdnZXN0ZWQtYnk6IEh1YWNhaSBDaGVuIDxjaGVuaHVhY2FpQGtl
cm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogSG9uZ2NoZW4gWmhhbmcgPHpoYW5naG9uZ2NoZW5A
bG9vbmdzb24uY24+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1t
YXAvaHVnZW1tYXAxMy5jIHwgOSArKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMTMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAxMy5jCj4gaW5kZXggZjhjMzY2NDBkNjFkLi40MmI4
MDA2NGVmMzYgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdl
bW1hcC9odWdlbW1hcDEzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1
Z2VtbWFwL2h1Z2VtbWFwMTMuYwo+IEBAIC0yMSw2ICsyMSw3IEBACj4gICNpbmNsdWRlIDxsaW1p
dHMuaD4KPiAgI2luY2x1ZGUgPHN5cy9wYXJhbS5oPgo+ICAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+
Cj4gKyNpbmNsdWRlIDxsYXBpL21tYXAuaD4KPgo+ICAjaW5jbHVkZSAiaHVnZXRsYi5oIgo+Cj4g
QEAgLTYyLDE1ICs2MywxNSBAQCBzdGF0aWMgdm9pZCBydW5fdGVzdCh2b2lkKQo+ICAgICAgICAg
bWVtc2V0KHAsIDAsIGhwYWdlX3NpemUpOwo+Cj4gICAgICAgICAvKiBUZXN0IGp1c3QgYmVsb3cg
NEdCIHRvIGNoZWNrIGZvciBvZmYtYnktb25lIGVycm9ycyAqLwo+IC0gICAgICAgbG93YWRkciA9
IEZPVVJHQiAtIHBhZ2Vfc2l6ZTsKPiAtICAgICAgIHEgPSBtbWFwKCh2b2lkICopbG93YWRkciwg
cGFnZV9zaXplLCBQUk9UX1JFQUR8UFJPVF9XUklURSwKPiArICAgICAgIGxvd2FkZHIgPSBGT1VS
R0IgLSBNTUFQX0dSQU5VTEFSSVRZOwo+ICsgICAgICAgcSA9IG1tYXAoKHZvaWQgKilsb3dhZGRy
LCBNTUFQX0dSQU5VTEFSSVRZLCBQUk9UX1JFQUR8UFJPVF9XUklURSwKPiAgICAgICAgICAgICAg
ICAgIE1BUF9TSEFSRUR8TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVMsIDAsIDApOwo+ICAgICAgICAg
aWYgKHEgPT0gTUFQX0ZBSUxFRCkgewo+IC0gICAgICAgICAgICAgICBiZWxvd19zdGFydCA9IEZP
VVJHQiAtIHBhZ2Vfc2l6ZTsKPiArICAgICAgICAgICAgICAgYmVsb3dfc3RhcnQgPSBGT1VSR0Ig
LSBNTUFQX0dSQU5VTEFSSVRZOwo+ICAgICAgICAgICAgICAgICBhYm92ZV9lbmQgPSBGT1VSR0I7
Cj4KPiAgICAgICAgICAgICAgICAgaWYgKHJhbmdlX2lzX21hcHBlZChiZWxvd19zdGFydCwgYWJv
dmVfZW5kKSA9PSAxKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GT3xU
RVJSTk8sICJyZWdpb24gKDRHLXBhZ2UpLTRHIGlzIG5vdCBmcmVlICYgIgo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHRzdF9yZXMoVElORk98VEVSUk5PLCAicmVnaW9uICg0Ry1NTUFQX0dSQU5V
TEFSSVRZKS00RyBpcyBub3QgZnJlZSAmICIKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIm1tYXAoKSBmYWlsZWQgZXhwZWN0ZWQiKTsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICB0c3RfcmVzKFRQQVNTLCAiU3VjY2Vzc2Z1bCBidXQgaW5jb25jbHVzaXZlIik7Cj4g
ICAgICAgICAgICAgICAgIH0gZWxzZQo+IC0tCj4gMi4zMy4wCj4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
