Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AADAEE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 07:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B8F3CE848
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 09:13:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E9353CB386
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 09:13:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4187601413
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 09:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694416422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lYVIzw94PQ2s1VkJS/asgTvZNF8VsZNq8TBL5TC0R80=;
 b=P981fnuOg4E3PjKBXUV71cvH7jwvurfgejSu4+qGhxJhQVc6kVT3p4clZn32rhhMtci47K
 oahxyAPsWmOFbm6AdNi+ge5Ymh8sriOdho2ia+Q4bEdAEWwaYgCJDbKPAcefFrpyxWsDMu
 fRvm8wELDnF47/ydP3KrP6qBoUKKm/0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-trkIjWnVP8-Lv92jSWR3Ig-1; Mon, 11 Sep 2023 03:13:41 -0400
X-MC-Unique: trkIjWnVP8-Lv92jSWR3Ig-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-501c70f247cso4349366e87.1
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 00:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694416418; x=1695021218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYVIzw94PQ2s1VkJS/asgTvZNF8VsZNq8TBL5TC0R80=;
 b=bsRE3Vk/4x5tahEUSWDdD/yvQTSYvzx1TSK6fdhrf5b/of7vumG0VbMrYev/5fVnJV
 fIT+DyXNT8Jy4afRuJEbd8jf7uLSYYs8ElwpYyogTh5wMV4x78Ce8bzJ1e8FOSh13kij
 mgbHGmnKcrtl3plTFILu0/AYPLsSXgfq7vxMjV/HYC+WgzMMGWtgboegaa+64uemlg/C
 zaPJLMYgVvjhFhLT6WXUJSEYCI4G0eNDbm0Z+THgdcFNgAPvmVnJV8eIqgwWJeGgaClJ
 3EfdSkannHcT1iE8rJ0rpJ33MXj0+qRCNs8xddye7/ug8tVCJWJ/pmhfXftTMuWsGq8A
 k2/A==
X-Gm-Message-State: AOJu0YwpnrkfhC0+/lcJ64qoMvun1saz8BEqhTL0DgV3316foxIBsodX
 Hcbnomco8NPO5XlDRf/QcRgq9w3TLOquZJ40FjvDpxETw+WSfzRz11gKX6bBtSYvppzCcOlpXb6
 krm3Gm6G7XP/rbT4ajlDrASNGUvXeGRpttvaaI98f
X-Received: by 2002:ac2:57c5:0:b0:500:b74b:e53 with SMTP id
 k5-20020ac257c5000000b00500b74b0e53mr5878642lfo.46.1694416418611; 
 Mon, 11 Sep 2023 00:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr5Go2bcxJhc4UEWI8bIHkQ5vvKiHvjzZHA51nXkDRhF0ZSJYkvC5zs6iJh4+MbLjHlyUM9Niwhe87OT4gyBg=
X-Received: by 2002:ac2:57c5:0:b0:500:b74b:e53 with SMTP id
 k5-20020ac257c5000000b00500b74b0e53mr5878625lfo.46.1694416418176; Mon, 11 Sep
 2023 00:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230909113004.21766-1-pastalian46@gmail.com>
In-Reply-To: <20230909113004.21766-1-pastalian46@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Sep 2023 15:13:25 +0800
Message-ID: <CAEemH2f3-LqJ0M5yLoBPQErfkrWgELgiRZjzxGLJ0QrKMoof9Q@mail.gmail.com>
To: Takuya Wakazono <pastalian46@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] recvmsg01: Skip unsupported test
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

T24gU2F0LCBTZXAgOSwgMjAyMyBhdCA3OjMw4oCvUE0gVGFrdXlhIFdha2F6b25vIDxwYXN0YWxp
YW40NkBnbWFpbC5jb20+Cndyb3RlOgoKPiBTaW5jZSBpdCdzIGFscmVhZHkgc3RhdGVkIHRoYXQg
TVNRX0VSUlFVRVVFICsgU09DS19TVFJFQU0gaXMgbm90Cj4gc3VwcG9ydGVkIG9uIGtlcm5lbHMg
PCAzLjE3LCBsZXQncyBhY3R1YWxseSBza2lwIHRoaXMgdGVzdC4KPgo+IEZpeGVzOiA3ZDM2NWQ3
MmJhNzEgKCJyZWN2bXNnMDE6IFJlZmFjdG9yIHVzaW5nIG5ldyBMVFAgQVBJIikKPiBTaWduZWQt
b2ZmLWJ5OiBUYWt1eWEgV2FrYXpvbm8gPHBhc3RhbGlhbjQ2QGdtYWlsLmNvbT4KPiAtLS0KPiAg
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWN2bXNnL3JlY3Ztc2cwMS5jIHwgNCArKy0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWN2bXNnL3JlY3Ztc2cwMS5jCj4g
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlY3Ztc2cvcmVjdm1zZzAxLmMKPiBpbmRleCAy
NTc2ZTE1NzIuLjgwYzFiM2FhOSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3JlY3Ztc2cvcmVjdm1zZzAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3JlY3Ztc2cvcmVjdm1zZzAxLmMKPiBAQCAtMjIwLDE0ICsyMjAsMTQgQEAgc3RhdGljIHZvaWQg
cnVuKHVuc2lnbmVkIGludCBuKQo+ICAgICAgICAgc3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNb
bl07Cj4gICAgICAgICBpbnQgcmV0ID0gdGMtPmV4cF9lcnJubyA/IC0xIDogMDsKPgo+IC0gICAg
ICAgc2V0dXBfYWxsKCk7Cj4gLQo+ICAgICAgICAgaWYgKCh0c3Rfa3ZlcmNtcCgzLCAxNywgMCkg
PCAwKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICYmICh0Yy0+ZmxhZ3MgJiBNU0dfRVJSUVVF
VUUpCj4gICAgICAgICAgICAgICAgICAgICAgICAgJiYgKHRjLT50eXBlICYgU09DS19TVFJFQU0p
KSB7Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJNU0dfRVJSUVVFVUUgcmVxdWly
ZXMga2VybmVsID49IDMuMTciKTsKPiArICAgICAgICAgICAgICAgcmV0dXJuOwo+CgpJdCdkIGJl
IGJldHRlciB0byB1c2UgdHN0X2JyayBUQ09ORiByYXRoZXIgdGhhbiB0c3RfcmVzICsgcmV0dXJu
LgoKVGhlIHJlc3QgbG9va3MgZ29vZC4KUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPgoKCgo+ICAgICAgICAgfQo+Cj4gKyAgICAgICBzZXR1cF9hbGwoKTsKPiAgICAgICAg
IHRjLT5zZXR1cChuKTsKPgo+ICAgICAgICAgaW92WzBdLmlvdl9iYXNlID0gdGMtPnJlY3ZfYnVm
Owo+IC0tCj4gMi40Mi4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
