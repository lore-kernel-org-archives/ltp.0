Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885AAC38150
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 07:18:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97C243D3832
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 09:18:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 533BC3CBA12
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 09:18:22 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3284C6011C5
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 09:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720595899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=evrIik9pMGr2bB+Awj43EEXkIWLWUN/MmUGrrNyfvNc=;
 b=hq72uDH5vt/ol+n+R88ZXHIkDp6yrUX5Fk5MJYlShXLlC25qfFwzW9S6l6Sot5iIEtZ9d0
 94boLMU7uzluUcs1LCAsei6kFQBFoAuHH+T0wamI4rGR+rrvzmgRgMSc3JXNVXcfRfaz20
 ytz7uHhvqO9Ep6H1ADe2QiE4GGhTrFE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-QIlQZ3ADMcS53TrZLDfcvA-1; Wed, 10 Jul 2024 03:18:17 -0400
X-MC-Unique: QIlQZ3ADMcS53TrZLDfcvA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c95c80c6f7so4741212a91.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 00:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720595895; x=1721200695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=evrIik9pMGr2bB+Awj43EEXkIWLWUN/MmUGrrNyfvNc=;
 b=PZzOfoQqjrkxaD+5uVPmQl3m+gcw/hYik168r4TrtFWalgsZywlj3GFU+45EDdnbUj
 RuiI73a9euAErQngSSyFU9cb5yYqwubZQURkvt4kiaZKYVC7Au/L65hovfJMFxM2ngE8
 fkdRH5gR3L4M0vOjbaEvC22N24iQUf6uCLRf9k6UzSI9DpJUIvIgPAUH70zVie/wQn3d
 EQtFxYtRnwqcmyMSH0LvUzbIWBp/hlP4mv6W5o1r19ATx2wB/9X6KGYWRaGa3fEiA4Xl
 B0qxJsESFi54HbSJdjSA1adAMg9FNBiK1bIzzXSHqMAPXM9CHlMEMpH2kmjYc9LPOKxU
 DeVQ==
X-Gm-Message-State: AOJu0YzdU5geuqoIAvI6x5zoXzYYVqiUy6/HQf5ptH2LaxRf6rJNQ6kd
 tOWkCnRtTo8wyoy9t7ZOUpD70pke6xg4yiTJbfJgmO3YgDY/WliFVkRRFWeyApSyyN0VclfBihB
 X6ATsT8xiUf/rHYEAOFG4vUEMIO0/H7Qs2pD1bUmJF/dNds3fGVY+TweigYT4YoOY05Hyu2eYFy
 NTva7DmmBuqs2pYv+mxmMMcVOOJRT73DapKU4C
X-Received: by 2002:a17:90a:4b88:b0:2c9:3526:630b with SMTP id
 98e67ed59e1d1-2ca35c32dccmr3659996a91.13.1720595895143; 
 Wed, 10 Jul 2024 00:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWxh2dW/RoOqTWMvRs0TWncCzs3KUTjTEca0quugngXVnEJTUsvfQY4P3DbnFGu35suX8EXlWPf7AV489u9/Y=
X-Received: by 2002:a17:90a:4b88:b0:2c9:3526:630b with SMTP id
 98e67ed59e1d1-2ca35c32dccmr3659984a91.13.1720595894743; Wed, 10 Jul 2024
 00:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <09c8813ad86c4a8034e3e35a183355c4f887f1b4.1720527432.git.jstancek@redhat.com>
 <CAEemH2e88FUiY7GbPgtxc+7NfP_xDFamMnACV7H6H_N39=SMrQ@mail.gmail.com>
 <CAASaF6yidJu66ScuKOLyftZ81ejt0SnZvOO46+Nj8yuvvOFemw@mail.gmail.com>
In-Reply-To: <CAASaF6yidJu66ScuKOLyftZ81ejt0SnZvOO46+Nj8yuvvOFemw@mail.gmail.com>
From: Li Wang <liwan@redhat.com>
Date: Wed, 10 Jul 2024 15:18:02 +0800
Message-ID: <CAEemH2cXi7=-X0dKd3rSW8WohnneZrkWdG-P-pA4==xP9P7NnA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] kallsyms: skip user-space mapped addresses
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

T24gVHVlLCBKdWwgOSwgMjAyNCBhdCA4OjQx4oCvUE0gSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJl
ZGhhdC5jb20+IHdyb3RlOgoKPiBPbiBUdWUsIEp1bCA5LCAyMDI0IGF0IDI6MzXigK9QTSBMaSBX
YW5nIDxsaXdhbkByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4KPiA+IE9uIFR1ZSwgSnVs
IDksIDIwMjQgYXQgODoxOOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPiB3
cm90ZToKPiA+Pgo+ID4+IFJIRUw5IHMzOTB4IHdpdGggS1BUSSBlbmFibGVkIGhhcyBiZWVuIG9i
c2VydmVkIHRvIHNwb3JhZGljYWxseQo+ID4+IHVzZSBzYW1lIGFkZHJlc3MgcmFuZ2VzIGZvciB1
c2VyLXNwYWNlIGxpYnJhcmllcyBhcyB0aGUgb25lcwo+ID4+IG9jY3VwaWVkIGJ5IGthbGxzeW1z
IHdoaWxlIGluIGtlcm5lbC1zcGFjZS4KPiA+Cj4gPgo+ID4gVGhhbmtzIGZvciB0aGUgcHJvcG9z
YWwgZml4LCBkbyB5b3UgdGhpbmsgd2UgbmVlZCB0byBhZGQKPiA+IGEgY2hlY2sgdG8gc2VlIGlm
IEtQVEkgaXMgZXhwbGljaXRseSBlbmFibGVkIGJlZm9yZSBkb2luZyB0aGF0Cj4gPiBpc19hZGRy
ZXNzX21hcHBlZD8KPiA+IChvciwgY2hlY2sgdGhlIGNvbmZpZ3VyYXRpb24gZm9yIENPTkZJR19Q
QUdFX1RBQkxFX0lTT0xBVElPTikKPgo+IEl0IHNob3VsZG4ndCBiZSBuZWVkZWQuIEl0J3MgYSBz
bWFsbCBvcHRpbWl6YXRpb24sIGJ1dCB0aGUgdGVzdCBydW4gbG9va3MKPiBmYXN0IGVub3VnaCAo
YXQgbGVhc3Qgb24gczM5MHggSSB0cmllZCkuCj4KCk1ha2Ugc2Vuc2UuCgpSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
