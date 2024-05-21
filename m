Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80EBC25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:30:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48BCD3CFF43
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:30:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82B7B3C006F
 for <ltp@lists.linux.it>; Tue, 21 May 2024 10:30:29 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A95A5100098F
 for <ltp@lists.linux.it>; Tue, 21 May 2024 10:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716280227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgcReRYX5yqwp0ujFYZ9SCJj8CcRG/bF652AWMkPrK4=;
 b=BAD/KiTsaM77jh1OVXT5RLdfh+w0StqG56Bkl7CeRg1wjNPqP7Sqoo/gVU2KpiHFSSdsjY
 sUBBAA+0dwYe1QFR9F06k0eN4D7WD4ONYaEbgpu27c0HNbt648xoEb3lp5tFO0xR8UkcZR
 J0O02fbXZUNPTlq7mx/POnQwZyzGyZE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-4VVTpRQbNLiORoJeXznMYQ-1; Tue, 21 May 2024 04:30:24 -0400
X-MC-Unique: 4VVTpRQbNLiORoJeXznMYQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b432dfdcf6so11038494a91.3
 for <ltp@lists.linux.it>; Tue, 21 May 2024 01:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716280223; x=1716885023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgcReRYX5yqwp0ujFYZ9SCJj8CcRG/bF652AWMkPrK4=;
 b=D0qXhdGxR70OPf4qwodOwfmwS5VGbl6IKAMSveIBr3D7xhkUIw/wX4qnEgp8OAq6Ym
 pVdqDAdFgtRlYyO1II9ZvifRQDoJNflcc/jQuzix6Ww+vGcgFdio7xSssDNDkq9E2A03
 IgYw/U71kjGPbVbzXifeplT/cwOZLFIFBiRtCKE0RwIOiZTKK5OR/3CbUgoPcqZGeK+q
 4aiI3VWqNtLxJF3rZMZT2RKE/GdaW0j2b8deAH8vw7gRRsrvUWhPhRXAHjeyNI8aVvV/
 htJVtriDtajun+MPH5gdTBBSnXQ9DsRpcrsGx7sn32qrFFYoKiD7Nu+DricsF4Zz8p6/
 GmUA==
X-Gm-Message-State: AOJu0YwXfkvV0MsZCusdekV1LKoVHSXuVeN9x/Mv6h3k74oGUe23htA5
 DlzIwGcNHQj5ITQgWNjAbLCsnYmd/D0oRgEO9UErJT4DrTN12Yw4VTEwVHto85dyQQycuebKjA2
 L8cMf5f1atK4h1WMW5BOTQJ22+wDMd1OtDljYa70wtUsA6B07NouYfITzyyCGqtZWZQhZdL7udc
 3c7m0NC+jxc+FUofGumz/gB1E=
X-Received: by 2002:a17:90a:17a2:b0:2ad:e004:76e6 with SMTP id
 98e67ed59e1d1-2b6cc342854mr25201953a91.7.1716280223557; 
 Tue, 21 May 2024 01:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF22bIMfZ+oeM4p601GvqyLETGQfXJyS9rHfe0YhPd0QcZFnrtpl0K6FxBe8Al/qsXahotAmN1jz0cURlstvzE=
X-Received: by 2002:a17:90a:17a2:b0:2ad:e004:76e6 with SMTP id
 98e67ed59e1d1-2b6cc342854mr25201942a91.7.1716280223044; Tue, 21 May 2024
 01:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240521074955.78675-1-pvorel@suse.cz>
 <20240521074955.78675-2-pvorel@suse.cz>
In-Reply-To: <20240521074955.78675-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 May 2024 16:30:11 +0800
Message-ID: <CAEemH2cgQ=Fc32QPsYg_zYwYjtYLw6-NaytACthMsf2d8Wr+ag@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/3] libswap: Split long lines (readability)
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCkZvciBzZXJpZXM6ClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4KCk9uIFR1ZSwgTWF5IDIxLCAyMDI0IGF0IDM6NTDigK9QTSBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+IC0tLQo+IENoYW5nZXMgdjEtPnYyOgo+ICogU2VwYXJhdGVkIGZyb20gdGhlIG5l
eHQgY29tbWl0Cj4KPiAgbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYyB8IDEwICsrKysrKystLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIGIvbGlicy9saWJsdHBzd2FwL2xp
YnN3YXAuYwo+IGluZGV4IGViMDY2ZGY3MS4uMDA2NmNhNzM0IDEwMDY0NAo+IC0tLSBhL2xpYnMv
bGlibHRwc3dhcC9saWJzd2FwLmMKPiArKysgYi9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4g
QEAgLTkzLDcgKzkzLDkgQEAgc3RhdGljIGludCBmaWxlX2lzX2NvbnRpZ3VvdXMoY29uc3QgY2hh
ciAqZmlsZW5hbWUpCj4KPiAgICAgICAgIGZkID0gU0FGRV9PUEVOKGZpbGVuYW1lLCBPX1JET05M
WSk7Cj4KPiAtICAgICAgIGZpZW1hcCA9IChzdHJ1Y3QgZmllbWFwICopU0FGRV9NQUxMT0Moc2l6
ZW9mKHN0cnVjdCBmaWVtYXApICsKPiBzaXplb2Yoc3RydWN0IGZpZW1hcF9leHRlbnQpKTsKPiAr
ICAgICAgIGZpZW1hcCA9IChzdHJ1Y3QgZmllbWFwICopU0FGRV9NQUxMT0Moc2l6ZW9mKHN0cnVj
dCBmaWVtYXApCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICsgc2l6ZW9mKHN0cnVjdAo+IGZpZW1hcF9leHRlbnQpKTsKPiArCj4gICAgICAgICBtZW1zZXQo
ZmllbWFwLCAwLCBzaXplb2Yoc3RydWN0IGZpZW1hcCkgKyBzaXplb2Yoc3RydWN0Cj4gZmllbWFw
X2V4dGVudCkpOwo+Cj4gICAgICAgICBmaWVtYXAtPmZtX3N0YXJ0ID0gMDsKPiBAQCAtMjQzLDcg
KzI0NSw4IEBAIGJvb2wgaXNfc3dhcF9zdXBwb3J0ZWQoY29uc3QgY2hhciAqZmlsZW5hbWUpCj4g
ICAqLwo+ICBpbnQgdHN0X21heF9zd2FwZmlsZXModm9pZCkKPiAgewo+IC0gICAgICAgdW5zaWdu
ZWQgaW50IHN3cF9taWdyYXRpb25fbnVtID0gMCwgc3dwX2h3cG9pc29uX251bSA9IDAsCj4gc3dw
X2RldmljZV9udW0gPSAwLCBzd3BfcHRlX21hcmtlcl9udW0gPSAwOwo+ICsgICAgICAgdW5zaWdu
ZWQgaW50IHN3cF9taWdyYXRpb25fbnVtID0gMCwgc3dwX2h3cG9pc29uX251bSA9IDAsCj4gKyAg
ICAgICAgICAgICAgICAgICAgc3dwX2RldmljZV9udW0gPSAwLCBzd3BfcHRlX21hcmtlcl9udW0g
PSAwOwo+ICAgICAgICAgc3RydWN0IHRzdF9rY29uZmlnX3ZhciBtaWdyYXRpb24gPQo+IFRTVF9L
Q09ORklHX0lOSVQoIkNPTkZJR19NSUdSQVRJT04iKTsKPiAgICAgICAgIHN0cnVjdCB0c3Rfa2Nv
bmZpZ192YXIgbWVtb3J5ID0KPiBUU1RfS0NPTkZJR19JTklUKCJDT05GSUdfTUVNT1JZX0ZBSUxV
UkUiKTsKPiAgICAgICAgIHN0cnVjdCB0c3Rfa2NvbmZpZ192YXIgZGV2aWNlID0KPiBUU1RfS0NP
TkZJR19JTklUKCJDT05GSUdfREVWSUNFX1BSSVZBVEUiKTsKPiBAQCAtMjgxLDcgKzI4NCw4IEBA
IGludCB0c3RfbWF4X3N3YXBmaWxlcyh2b2lkKQo+ICAgICAgICAgICAgICAgICBzd3BfcHRlX21h
cmtlcl9udW0gPSAxOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICByZXR1cm4gREVGQVVMVF9NQVhf
U1dBUEZJTEUgLSBzd3BfbWlncmF0aW9uX251bSAtIHN3cF9od3BvaXNvbl9udW0KPiAtIHN3cF9k
ZXZpY2VfbnVtIC0gc3dwX3B0ZV9tYXJrZXJfbnVtOwo+ICsgICAgICAgcmV0dXJuIERFRkFVTFRf
TUFYX1NXQVBGSUxFIC0gc3dwX21pZ3JhdGlvbl9udW0gLSBzd3BfaHdwb2lzb25fbnVtCj4gKyAg
ICAgICAgICAgICAgIC0gc3dwX2RldmljZV9udW0gLSBzd3BfcHRlX21hcmtlcl9udW07Cj4gIH0K
Pgo+ICAvKgo+IC0tCj4gMi40My4wCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
