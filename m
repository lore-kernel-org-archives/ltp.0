Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66386C54E5D
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 05:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFA1E3CE694
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 06:51:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 837C43CD420
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 06:51:30 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC8EB1000414
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 06:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710827487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twqUHZCbo5dFQpGwq5Pf4o3Nvybo0+O/KBsuNn1afYQ=;
 b=Zc/6TXVAerQEbTG/AFni6fPvEyLoLQrBc+5MvIQculfI5MOPCo9wvVa/YyrClnbW5s70Iq
 EF+ijHnbLw41IDF+64DnzayPsZWU5M/rf8RiVdG4wZKDAbO0xoJR45EiJO0CAD+IXf2UvQ
 DbvpntbQWWjC2JnGbWBTx8hWm5nzHm8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-PuyVn0JIMM2flfTjXauTGQ-1; Tue, 19 Mar 2024 01:51:25 -0400
X-MC-Unique: PuyVn0JIMM2flfTjXauTGQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29905ac5c21so4045665a91.0
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 22:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710827484; x=1711432284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twqUHZCbo5dFQpGwq5Pf4o3Nvybo0+O/KBsuNn1afYQ=;
 b=IOxJTyWH3bIYF5GtJYaaDHAG+GncEF8XgQFf4q8j/yrGWMQn7O6/uIqMqxLJlTd4ij
 dzMlVjGfdzDCvFAoydTnBjvf4l+awg4sB7Ogr7Wcpj2KWMh4ZcE3Ugc6dofA0kHWIEJI
 k8muwwYIWi4k75AChEyiNlD4g0wPpIL4gKRnppQTZDW3Xx25UoEgTPNRmwFpsUNuifnP
 e1bxJ33RWx10WhV259gZfv6IkbqXVB0SI1venr77r/PT4YmQJShBe9nv/G2twiFMXPxq
 63vulvI1ccMBWupOI+uaXSIUp3vs+RqBjYu5Ea4XJwpsB0AJkHsr+5B0Fv959C/Q5DIP
 G7Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlTY4j9G6xE8Uo+G5kuZ7UVQWt5PygHkbx/ipJZd6eudunh1LOnj6UzzARjGFGLVSttPKpig96FLgrkPTmRLga82Y=
X-Gm-Message-State: AOJu0Ywlak/TGIRCeQhS4eutJhLmllXy/9sTrOhDlu4r1yKCH2k39Pwx
 OPVO1yCABc9PwSmB3T45zIA8FCtk6TTKFX5IEHNekjatb1k5J2E7H4BlDSa8qkCrEEBNbdEa5by
 JaPwFkkX7Xy7ZAZoMC/c1VPwCqbz4dTDeBGia9Yfazg4qbY4ZGjKt7oTG8PmWh8zNpRw/lwj/TC
 iqIdBRPhHm1v0YKmVWR37qn88=
X-Received: by 2002:a17:90a:68cd:b0:29c:6ff8:fa32 with SMTP id
 q13-20020a17090a68cd00b0029c6ff8fa32mr8968688pjj.3.1710827484125; 
 Mon, 18 Mar 2024 22:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0aWmTamzxIhpw9aLRmP88LIlOcSzx45IFveqM0OAC/cYS1ewzqkqRZUd6hgeDbadhNggIHx8fyOTsNoKE7V4=
X-Received: by 2002:a17:90a:68cd:b0:29c:6ff8:fa32 with SMTP id
 q13-20020a17090a68cd00b0029c6ff8fa32mr8968679pjj.3.1710827483805; Mon, 18 Mar
 2024 22:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
 <Zfg2E59Pa1uF84di@wegao.115.61.67>
 <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
 <20240319050357.GA417761@pevik>
 <CAEemH2eoeuvZB+=9iG0qJ6_2OSAN9S_7R+hq+i1pXFXmY4j_jQ@mail.gmail.com>
In-Reply-To: <CAEemH2eoeuvZB+=9iG0qJ6_2OSAN9S_7R+hq+i1pXFXmY4j_jQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2024 13:51:10 +0800
Message-ID: <CAEemH2etj26fEXV7jk3jC=RcU=v18qDpkskhVOr8bDW5Fma4vQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

T24gVHVlLCBNYXIgMTksIDIwMjQgYXQgMTo0M+KAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIFR1ZSwgTWFyIDE5LCAyMDI0IGF0IDE6MDTigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gPiBPbiBNb24sIE1hciAxOCwgMjAy
NCBhdCA4OjQw4oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+Pgo+Pgo+Pgo+
Pgo+PiA+ID4gPiBUaGF0J3MgYmVjYXVzZSB0aGUgYXZhaWxhYmxlIHN3YXBmaWxlIG9uIHlvdXIg
U1VUIGlzIHRvbyBzbWFsbCwKPj4gPiA+ID4geW91IGNhbiBhZGp1c3QgaXQgKHRoZW4gcmV0ZXN0
IGl0KSBieSB5b3Vyc2VsZiB0byBmaW5kIGEgcHJvcGVyCj4+IHNpemUuCj4+Cj4+ID4gPiA+IFRo
aXMgaXMgZmluZSBhcyBsb25nIGFzIHRoZSBzd2FwZmlsZSBzaXplIGlzIGxlc3MgdGhhbiAzMDBN
QiwKPj4gPiA+ID4gb3RoZXJ3aXNlIHdlIG5lZWQgdG8gc2V0IC5kZXZfbWluX3NpemUgbGlrZSB3
aGF0IHdlIGRpZAo+PiA+ID4gPiBmb3Igc3dhcG9mZjAxLmMuCj4+Cj4+ID4gPiA+IEFuZCwgb24g
dGhlIG90aGVyIHNpZGUsIHdlIGNhbid0IGd1YXJhbnRlZSB0aGUgc3lzdGVtIFN3YXBDYWNoZWQK
Pj4gPiA+ID4gaGFwcGVuZWQgZXZlcnkgdGltZSwgaXQgZGVwZW5kcyBvbiB0aGUgc3lzdGVtJ3Mg
Y29uZmlndXJhdGlvbi4KPj4KPj4KPj4gPiA+IDEwME0gaXMgZ29vZCBlbm91Z2ggZm9yIGN1cnJl
bnQgc3lzdGVtLCBjb3VsZCB5b3UgaGVscCBjaGVjayBmb2xsb3dpbmcKPj4gPiA+IHBhdGNoPwo+
Pgo+Pgo+PiA+IENhbiB3ZSByZXdyaXRlIHRoZSBtYWtlX3N3YXBmaWxlKCkgQVBJIHRvIHN1cHBv
cnQgcGFzc2luZyBNQiBzaXplIGZvcgo+PiA+IG1ha2luZyB0aGUgc3dhcGZpbGU/Cj4+Cj4+IEkg
Z3Vlc3MgaXQgd291bGQgYmUgZGVzaXJhYmxlIChidXQga2VlcCBhbHNvIHBvc3NpYmxlIHRvIHBh
c3MgdGhhdCAxMAo+PiBibG9ja3MsCj4+IHRoZXJlZm9yZSBtYXliZSB1c2UgZmxhZyB0byBkaXN0
aW5ndWlzaCBiZXR3ZWVuIE1CIGFuZCBibG9ja3M/KS4KPj4KPgo+IFRoYXQncyBmaW5lIGJ1dCBh
IGJpdCBjb21wbGV4IGZvciB1c2VycyB0byBkaXN0aW5ndWlzaCBmbGFncy4KPgo+IE9yLCB3aGF0
IGFib3V0IG1ha2luZyB0aGUgZnVuY3Rpb24gdXNlIHRoZSBmbGFnIGFzIHN0YXRpYywgYW5kCj4g
ZXhwb3J0IHR3byBhZGRpdGlvbmFsIGZ1bmN0aW9ucyB3aXRoIE1CIGFuZCBibG9ja3M/Cj4KPiBl
bnVtIHN3YXBmaWxlX21ldGhvZCB7Cj4gICAgIFNXQVBGSUxFX0JZX1NJWkUsCj4gICAgIFNXQVBG
SUxFX0JZX0JMT0NLUwo+IH07Cj4KPiBzdGF0aWMgaW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hh
ciAqc3dhcGZpbGUsIHVuc2lnbmVkIGludCBwYXJhLCBpbnQKPiBzYWZlLCBlbnVtIHN3YXBmaWxl
X21ldGhvZCBtZXRob2QpIHsKPiAgICAgLy8gVGhlIG1haW4gbG9naWMgdG8gYWNoaWV2ZSB0aGUg
c3dhcGZpbGUtbWFraW5nIHByb2Nlc3MKPiAgICAgLy8gLi4uCj4gfQo+Cj4gaW50IG1ha2Vfc3dh
cGZpbGVfc2l6ZShjb25zdCBjaGFyICpzd2FwZmlsZSwgdW5zaWduZWQgaW50IHNpemUsIGludCBz
YWZlKSB7Cj4gICAgIHJldHVybiBtYWtlX3N3YXBmaWxlKHN3YXBmaWxlLCBzaXplLCBzYWZlLCBT
V0FQRklMRV9CWV9TSVpFKTsKPiB9Cj4KPiBpbnQgbWFrZV9zd2FwZmlsZV9ibGtzKGNvbnN0IGNo
YXIgKnN3YXBmaWxlLCB1bnNpZ25lZCBpbnQgYmxvY2tzLCBpbnQKPiBzYWZlKSB7Cj4gICAgIHJl
dHVybiBtYWtlX3N3YXBmaWxlKHN3YXBmaWxlLCBibG9ja3MsIHNhZmUsIFNXQVBGSUxFX0JZX0JM
T0NLUyk7Cj4gfQo+CgpFdmVuIHNpbXBsZXIgdG8gZGVmaW5lIHR3byBtYWNyb3Mgd2l0aCBvbmUg
bWFrZV9zd2FwZmlsZSgpOgoKI2RlZmluZSBNQUtFX1NXQVBGSUxFX1NJWkUoc3dhcGZpbGUsIHNp
emUsIHNhZmUpIFwKICAgIG1ha2Vfc3dhcGZpbGUoc3dhcGZpbGUsIHNpemUsIHNhZmUsIFNXQVBG
SUxFX0JZX1NJWkUpCgojZGVmaW5lIE1BS0VfU1dBUEZJTEVfQkxLUyhzd2FwZmlsZSwgYmxvY2tz
LCBzYWZlKSBcCiAgICBtYWtlX3N3YXBmaWxlKHN3YXBmaWxlLCBibG9ja3MsIHNhZmUsIFNXQVBG
SUxFX0JZX0JMT0NLUykKCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
