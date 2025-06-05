Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B78C5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 03:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749094378; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=V2giLCbqy4vDnDXb3YOZx6XdecF6osryeMwo8C5pqTY=;
 b=HgoJZmFyeB4lGQy2xkxVtW1US6qKJdQODQo2M7kQKy4HkGe2YrDvPTccNSY2x0iBFhzkl
 z1YUTwHbLxeboUoDfY1SJqrmjbJzt1Qo1BJ9c+eqaT2YHh744vqqyS/PqRU4Nz/mUez81nh
 EinQ8/PDNiZHT5PkgidYT7+WT9rQL8A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA8B3CA1ED
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 05:32:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB1D3C6B03
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 05:32:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8CE641000DE5
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 05:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749094355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKBkqjfpefVM7DyeDuL4C1jwMNf36wGbjrs4mcYoc1M=;
 b=i74Lf4mqevrkNxedfA39Zv0eiPg2o5BmggfKPrvMwKJOpvgPoVQMujMT12jAz3cpw0XQFa
 BKhEIlE6ItbvfGY+ldODe3P2f+O/0tsplCvrol49gVQSFZo17yhmJUrXJunqJrMSgpHBXe
 zp877xIbAH6SVcapCPGssstN8Hyv2yc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-sW-VKgoBOYGjWmlWrogaQg-1; Wed, 04 Jun 2025 23:32:33 -0400
X-MC-Unique: sW-VKgoBOYGjWmlWrogaQg-1
X-Mimecast-MFC-AGG-ID: sW-VKgoBOYGjWmlWrogaQg_1749094353
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-312436c2224so781329a91.0
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 20:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749094353; x=1749699153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKBkqjfpefVM7DyeDuL4C1jwMNf36wGbjrs4mcYoc1M=;
 b=qNm33wkyuFdFnoEhR3TRDqiFmKYMscl9qKd/niIdMXoz+0ChLIpJ/5QpHMZzHxQThJ
 Rr+fuCCbAFAFePqRvamkz4iDAKO79VaJR+sccOV1yft6MjiY4GjF+UQUtP4C1GUXr23s
 +qxnTQFb7HXek3vYxio7kc+WvDcB7ZizSmYnu5HqvSWksfg35e1CzJYaeoJjRkpVPRF0
 fal6yh2dsODXF3H4IWxnR6mZFfHMT0cb5Yyqgw59AhlK8FGwiLak8711qfEcl/Gt2hVl
 t1mRTTLfHYlrwtGVGovWhekwAtMlV1Df+uUmKR0lnOKyJ8WwZhkrzYT6uwleLfUghlcW
 MImw==
X-Gm-Message-State: AOJu0Yxe9MScb7U2VamDLm+q+U7GmLEV5jhdrk+92xJ+vkWce7zaNVAS
 gWIX3QkunKSnBFCsvIicfN6GBOGBkFPZ+K/YzWv+nxGRBbYJDeUgLx0iwgqEfUWh8V3xuzd3kYN
 K/z5CrCwllgybPxU2Bb71W/utvY8JwBPeD7CGojnuDoL/QqKDfSXRqq4nPJC/WjhVtxekaVzQ1D
 3R1hUBF+c1oj6lU2MK1Jj7Ercb370=
X-Gm-Gg: ASbGnctGtMmCFVj7iZn+mRKzxxIkVxm4tvblCpMvo9lyjU49IcrVVnYXtoPuasiwveE
 Zw3XjvTB4uWbh/Q/+dWunQ1JCOr2eQF0hi6QhAN2LoCeww04MRsWZRVi/K7GYCYMrH6e9RQ==
X-Received: by 2002:a17:90b:53c6:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-31323ed09bbmr4500215a91.4.1749094352806; 
 Wed, 04 Jun 2025 20:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsHDBeMeEphFO69e27lQfRQwkwd4dfty8Ms+P9Dqv2STXXRaqRzKup0LG2iywNZxnabtitkgShlY5Ptk1b74g=
X-Received: by 2002:a17:90b:53c6:b0:313:23ed:701 with SMTP id
 98e67ed59e1d1-31323ed09bbmr4500198a91.4.1749094352469; Wed, 04 Jun 2025
 20:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-3-liwang@redhat.com>
 <aEA0LYNKcPPeS0Uw@yuki.lan>
In-Reply-To: <aEA0LYNKcPPeS0Uw@yuki.lan>
Date: Thu, 5 Jun 2025 11:32:19 +0800
X-Gm-Features: AX0GCFt2IPF6i7Olgx7cNKtUYuiJtnLZVn2Swu6mpdZ8ZuTsdAiM-4Gek5iub-c
Message-ID: <CAEemH2erR_5qOk-ixhMMd2L0=RLH=RvDdSBdeiWWPXNtE60_QQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ixVpKd4brX43eXT0gKcI030X6_QA0HP0i79RO6bIrac_1749094353
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 2/2] lib: moves test infrastructure states into
 a shared context structure
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gNCwgMjAyNSBhdCA3OjU14oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ICAgICAgIGlmICh0c3RfdGVzdC0+bmVlZHNfY2hlY2tw
b2ludHMpIHsKPiA+IC0gICAgICAgICAgICAgdHN0X2Z1dGV4ZXMgPSAoY2hhciAqKXJlc3VsdHMg
KyBzaXplb2Yoc3RydWN0IHJlc3VsdHMpOwo+ID4gLSAgICAgICAgICAgICB0c3RfbWF4X2Z1dGV4
ZXMgPSAoc2l6ZSAtIHNpemVvZihzdHJ1Y3QKPiByZXN1bHRzKSkvc2l6ZW9mKGZ1dGV4X3QpOwo+
ID4gKyAgICAgICAgICAgICB0c3RfZnV0ZXhlcyA9IGlwYy0+ZnV0ZXhlczsKPiA+ICsKPiA+ICsg
ICAgICAgICAgICAgc2l6ZV90IGZ1dGV4ZXNfb2Zmc2V0ID0gKGNoYXIgKilpcGMtPmZ1dGV4ZXMg
LSAoY2hhciAqKWlwYzsKPiA+ICsgICAgICAgICAgICAgdHN0X21heF9mdXRleGVzID0gKHNpemUg
LSBmdXRleGVzX29mZnNldCkgLwo+IHNpemVvZihmdXRleF90KTsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBUaGlzIHdvdWxkIGJlIGJldHRlciBhczoKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IGlwYywgZnV0ZXhl
cykKPgoKb2Zmc2V0b2Yoc3RydWN0IGlwYywgZnV0ZXhlcykgcmV0dXJucyB0aGUgb2Zmc2V0IG9m
IHRoZSBmaWVsZCBmdXRleGVzIHdpdGhpbgp0aGUgc3RydWN0IGlwY19yZWdpb24gbGF5b3V0IGlu
IG1lbW9yeS4gSXQgZG9lcyBub3QgcmVmbGVjdCBob3cgbWFueQpmdXRleGVzIGNhbiBiZSBzdG9y
ZWQuCgpJIGd1ZXNzIHlvdSB3ZXJlIGhvcGluZzoKCi0tLSBhL2xpYi90c3RfdGVzdC5jCisrKyBi
L2xpYi90c3RfdGVzdC5jCkBAIC0xNTIsNyArMTUyLDcgQEAgc3RhdGljIHZvaWQgc2V0dXBfaXBj
KHZvaWQpCiAgICAgICAgaWYgKHRzdF90ZXN0LT5uZWVkc19jaGVja3BvaW50cykgewogICAgICAg
ICAgICAgICAgdHN0X2Z1dGV4ZXMgPSBpcGMtPmZ1dGV4ZXM7CgotICAgICAgICAgICAgICAgc2l6
ZV90IGZ1dGV4ZXNfb2Zmc2V0ID0gKGNoYXIgKilpcGMtPmZ1dGV4ZXMgLSAoY2hhciAqKWlwYzsK
KyAgICAgICAgICAgICAgIHNpemVfdCBmdXRleGVzX29mZnNldCA9IG9mZnNldG9mKHN0cnVjdCBp
cGNfcmVnaW9uLApmdXRleGVzKTsKICAgICAgICAgICAgICAgIHRzdF9tYXhfZnV0ZXhlcyA9IChz
aXplIC0gZnV0ZXhlc19vZmZzZXQpIC8gc2l6ZW9mKGZ1dGV4X3QpOwogICAgICAgIH0KCkBAIC0y
MDgsNyArMjA4LDcgQEAgdm9pZCB0c3RfcmVpbml0KHZvaWQpCiAgICAgICAgcmVzdWx0cyA9ICZp
cGMtPnJlc3VsdHM7CgogICAgICAgIHRzdF9mdXRleGVzID0gaXBjLT5mdXRleGVzOwotICAgICAg
IHNpemVfdCBmdXRleGVzX29mZnNldCA9IChjaGFyICopaXBjLT5mdXRleGVzIC0gKGNoYXIgKilp
cGM7CisgICAgICAgc2l6ZV90IGZ1dGV4ZXNfb2Zmc2V0ID0gb2Zmc2V0b2Yoc3RydWN0IGlwY19y
ZWdpb24sIGZ1dGV4ZXMpOwogICAgICAgIHRzdF9tYXhfZnV0ZXhlcyA9IChzaXplIC0gZnV0ZXhl
c19vZmZzZXQpIC8gc2l6ZW9mKGZ1dGV4X3QpOwoKICAgICAgICBpZiAoY29udGV4dC0+dGRlYnVn
KQoKCgo+ID4gICAgICAgc3dpdGNoICh0dHlwZSkgewo+ID4gICAgICAgY2FzZSBUQ09ORjoKPiA+
IC0gICAgICAgICAgICAgdHN0X2F0b21pY19pbmMoJnJlc3VsdHMtPnNraXBwZWQpOwo+ID4gKyAg
ICAgICAgICAgICB0c3RfYXRvbWljX2luYygoaW50ICopJnJlc3VsdHMtPnNraXBwZWQpOwo+ID4g
ICAgICAgYnJlYWs7Cj4gPiAgICAgICBjYXNlIFRQQVNTOgo+ID4gLSAgICAgICAgICAgICB0c3Rf
YXRvbWljX2luYygmcmVzdWx0cy0+cGFzc2VkKTsKPiA+ICsgICAgICAgICAgICAgdHN0X2F0b21p
Y19pbmMoKGludCAqKSZyZXN1bHRzLT5wYXNzZWQpOwo+ID4gICAgICAgYnJlYWs7Cj4gPiAgICAg
ICBjYXNlIFRXQVJOOgo+ID4gLSAgICAgICAgICAgICB0c3RfYXRvbWljX2luYygmcmVzdWx0cy0+
d2FybmluZ3MpOwo+ID4gKyAgICAgICAgICAgICB0c3RfYXRvbWljX2luYygoaW50ICopJnJlc3Vs
dHMtPndhcm5pbmdzKTsKPiA+ICAgICAgIGJyZWFrOwo+ID4gICAgICAgY2FzZSBURkFJTDoKPiA+
IC0gICAgICAgICAgICAgdHN0X2F0b21pY19pbmMoJnJlc3VsdHMtPmZhaWxlZCk7Cj4gPiArICAg
ICAgICAgICAgIHRzdF9hdG9taWNfaW5jKChpbnQgKikmcmVzdWx0cy0+ZmFpbGVkKTsKPiA+ICAg
ICAgIGJyZWFrOwo+ID4gICAgICAgY2FzZSBUQlJPSzoKPiA+IC0gICAgICAgICAgICAgdHN0X2F0
b21pY19pbmMoJnJlc3VsdHMtPmJyb2tlbik7Cj4gPiArICAgICAgICAgICAgIHRzdF9hdG9taWNf
aW5jKChpbnQgKikmcmVzdWx0cy0+YnJva2VuKTsKPiA+ICAgICAgIGJyZWFrOwo+Cj4gVGhpcyBn
ZXRzIHVnbHkuIEkgZ3Vlc3MgdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8ga2VlcCB0aGUgcmVz
dWx0cyBhcwo+IGludCB1bmxlc3Mgd2UgY2hhbmdlIHRoZSB0c3RfYXRvbWljLmggdG8gd29yayB3
aXRoIGludDMyX3QuCj4KPiBNYXliZSB3ZSBjYW4gYWN0dWFsbHkgZHJvcCB0aGUgYXNzZW1ibHkg
ZmFsbGJhY2tzIGZyb20gdHN0X2F0b21pYy5oCj4gc2luY2UgYXMgZmFyIGFzIEkgY2FuIHRlbGwg
dGhlIF9fYXRvbWljXyooKSBmdW5jdGlvbnMgd2VyZSBhZGRlZCB0bwo+IGdjYy00LjcgYW5kIHRo
ZSBfX3N5bmNfKigpIGZ1bmN0aW9uIHdlcmUgYWRkZWQgaW50byBnY2MtNC4xIHNvIHVubGVzcyB3
ZQo+IG5lZWQgdG8gc3VwcG9ydCBjb21waWxlciBvbGRlciB0aGFuIDQuMSB3ZSBjYW4gZHJvcCB0
aGUgYXNzZW1ibHkgYW5kCj4gZWFzaWx5IGFkZCBzdXBwb3J0IGZvciBhdG9taWMgb3BlcmF0aW9u
cyBmb3IgaW50MzJfdC4KPgoKVGhhdCBzb3VuZHMgZ29vZCwgSSB3aWxsIGxvb2sgdG8gc2VlIGlm
IHdlIGNhbiByZWZpbmUgdGhlIHRzdF9hdG9taWMuaC4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
