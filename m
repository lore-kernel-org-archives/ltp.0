Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AE1C71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750083536; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VP4uZqwvQ4YmaZ+4rczjHEk951xJnLVpYNjtH5efzJY=;
 b=Rl/2wpky/yTyGZ38tOxm9K3o7tqou+RAXDYAdFXT7JyudTy6R7gnvmPbC7s4FxGv17EU0
 P9KaC1JBwmBucI27ZYbtRH0uT9J7swcsmOUTABmBuyP9Qeaya8oThrgvZaVxAGd9bv9yf2K
 GhHVscIDrR3Ub+H3tT8lTI+F8JRr3ps=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FF0C3CC097
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:18:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 806523CBF43
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:18:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8897E100099A
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750083510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wPBbUOgJ7cuHKdFpkjkO7tsXj7YzTFq0wqLMencyRT4=;
 b=ZMNaawHW7eNbOhcT7LkyHXxEaRsigXy1mRm+dGrR7Xd7wBQWKRdXC3IfW+b1XLd6mEjDT4
 cH0diRMyBNYWDokm8i0xNQS9QHpqydL1R192/AEfmkixt0rAnBNSEq+zt0kX83Y9L4oWx6
 Unyx0ePCPvJNMLRrQeN39XAvCk/g9DU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-CAloyx4wPcOxeVaSUf-gRA-1; Mon, 16 Jun 2025 10:18:28 -0400
X-MC-Unique: CAloyx4wPcOxeVaSUf-gRA-1
X-Mimecast-MFC-AGG-ID: CAloyx4wPcOxeVaSUf-gRA_1750083508
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2356ce66d7cso76992225ad.1
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 07:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750083507; x=1750688307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wPBbUOgJ7cuHKdFpkjkO7tsXj7YzTFq0wqLMencyRT4=;
 b=AGWyvxn4Hd2ipayzyo/T2npqaM1wEdnLQFtUSiWUpb9zeshTxVrn/B9GtPx7GJY/1B
 h80dfzS5Lb+audgVDu/enaACohmWplxwc8rGWgtKjR6V2xE5mq71KrW77LGtZ4jnvjyJ
 qA9UG9KsZa1+UvDrEkRxq+hvsr8Y7Q3B6E0eCjWH9DoazXT4sRwwjMTFP04JlizG1Fnq
 tNx85FLM/QEBfDs39MnyxE1w33pTaR6in4RjoD/QZ21yvT+bYT0tj2sYJRD/2dNt/tI8
 +hOb8Ahh7uHjjaO/P2AikIUBY5tvu3N43xUeAC0zRXbRwOkg0mZa9q3FYxpzOWbE+Vdk
 hTaA==
X-Gm-Message-State: AOJu0YwFoNJxa/eVLFjCl14GJR92X8CZqfN19E5HGzg2wvDSFMyQgvVr
 8LQD8Pdxah3eizxnAWad5Gty9fHasW7fNxDh64X8zHHqEzkdwZLr27QGzSAtkwCx+djiapL+Ocf
 kfnkSpcmvxMNLYijoQpnk3SsSPFh/5fu+fsKQJPRzlJT1vZ29tuM68SDMPuNk5tf8PxJL6nlYYv
 liClX5fVNutRnQiBc/yYIYqa1gCB5dbBGxAfhIOA==
X-Gm-Gg: ASbGnctdXYydGfhiJUlbx/M5t+CXT+/TFmcLCjMJmXKVin7IG9q+tBRxsPBcvSL+tTz
 jwI1uCH7pwXNckgC5bXTsraymIMzfADGQ420FLc2h4jFuRwOkKiOIOlUMDR1pxoxNj1N01hy8IQ
 f0emui
X-Received: by 2002:a17:90b:586b:b0:312:1b53:5e9f with SMTP id
 98e67ed59e1d1-313f1dfa2ffmr15697432a91.24.1750083506760; 
 Mon, 16 Jun 2025 07:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIMMlYAmP4Q1JMoCDZ1EkyRNcdx5Po4UacAJkZqNvkbkJmk0u6OmPjjBmnPyNE9RdaBtKvAN26Fb7rCUimP9g=
X-Received: by 2002:a17:90b:586b:b0:312:1b53:5e9f with SMTP id
 98e67ed59e1d1-313f1dfa2ffmr15697396a91.24.1750083506366; Mon, 16 Jun 2025
 07:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
 <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
 <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
 <CAEemH2fM82gZitSh5wjcp34N6GoTd=EtSh-AVtxSm_+qAh1suA@mail.gmail.com>
 <DAO0MWF8LETA.1PY8DUWS4A6W7@suse.com>
In-Reply-To: <DAO0MWF8LETA.1PY8DUWS4A6W7@suse.com>
Date: Mon, 16 Jun 2025 22:18:13 +0800
X-Gm-Features: AX0GCFstz2CBuCvEbbA1Qv1hAHbu7AYiKHZ2mJFd3f6VlNbZYeHQ1BEZ4_4SD8U
Message-ID: <CAEemH2dKfFdCv3C7pEjjivs2Z=6cyC=WvifyEF9mrse0FCiYSg@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJJ3FsOf5dwW0S6w2CkKcNYPgb4oGAdXSTLqtXPA_rM_1750083508
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgMTA6MDnigK9QTSBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8
cmJtQHN1c2UuY29tPiB3cm90ZToKCj4gT24gTW9uIEp1biAxNiwgMjAyNSBhdCAxMTowOCBBTSAt
MDMsIExpIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIEp1biAxNiwgMjAyNSBhdCA3OjAy4oCvUE0g
UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiB3cm90ZToKPiA+Cj4gPj4gT24g
V2VkIEp1biAxMSwgMjAyNSBhdCAxMDo1MiBQTSAtMDMsIExpIFdhbmcgd3JvdGU6Cj4gPj4gPiBS
aWNhcmRvIEIuIE1hcmxpw6hyZSB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+IHdyb3RlOgo+
ID4+ID4KPiA+PiA+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4g
Pj4gPj4KPiA+PiA+PiBUaGUgdGVzdCBjYXNlIGRlc2NyaXB0aW9uIHJlYWRzOgo+ID4+ID4+Cj4g
Pj4gPj4gIlRlc3QgY2FzZSB0byBjaGVjayB0aGF0IFNJR0tJTEwgY2FuIG5vdCBiZSBjYXVnaHQu
Igo+ID4+ID4+Cj4gPj4gPj4gSXQgbWFrZXMgdXNlIG9mIHNpZ2FjdGlvbigpIHRvIHNldCB1cCBh
IGhhbmRsZXIgZm9yIFNJR0tJTEwsIGJ1dAo+ID4+ID4+IGFjY29yZGluZyB0byBpdHMgbWFudWFs
IHBhZ2U6Cj4gPj4gPj4KPiA+PiA+PiAiRUlOVkFMIEFuIGludmFsaWQgc2lnbmFsIHdhcyBzcGVj
aWZpZWQuICBUaGlzIHdpbGwgYWxzbyBiZSBnZW5lcmF0ZWQKPiA+PiBpZiBhbgo+ID4+ID4+IGF0
dGVtcHQgaXMgbWFkZSB0byBjaGFuZ2UgdGhlIGFjdGlvbiBmb3IgU0lHS0lMTCBvciBTSUdTVE9Q
LCB3aGljaAo+ID4+IGNhbm5vdAo+ID4+ID4+IGJlIGNhdWdodCBvciBpZ25vcmVkLiIKPiA+PiA+
Pgo+ID4+ID4KPiA+PiA+IE9yIGNvdWxkIHdlIHJlZmFjdG9yIGtpbGwwNyB0byB2YWxpZGF0ZSB0
aGUgRUlOVkFMIHdoZW4gY2hhbmdpbmcKPiBhY3Rpb24KPiA+PiBvbgo+ID4+ID4gU0lHS0lMTC9T
SUdTVE9QPwo+ID4+Cj4gPj4gQnV0IHRoZW4gd2Ugd291bGQgYmUgdGVzdGluZyBzaWdhY3Rpb24o
KS4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/Cj4gPj4KPiA+Cj4gPiBZb3UncmUgcmlnaHQs
IGlmIHdlIHRlc3Qgc2lnYWN0aW9uKCksIHRoZW4gdGhlIGNvZGUgc2hvdWxkIGJlIHB1dCBpbnRv
Cj4gPiBrZXJuZWwvc3lzY2FsbHMvc2lnYWN0aW9uL3NpZ2FjdGlvbjAzLmMuCj4gPgo+ID4gTWF5
YmUgd2UgY2FuIHRyeToKPgo+IFN1cmUhIEJ1dCBpbiBhbnkgY2FzZSBraWxsMDcgc2hvdWxkIHN0
aWxsIGJlIHJlbW92ZWQgSU1ITy4KPgoKQWdyZWVkLiBJZiB5b3UgcGxhbiB0byBhZGQgc2lnYWN0
aW9uMDMuYyBzZXBhcmF0ZWx5LCB0aGlzIG9uZSBzaG91bGQgYmUKZ29vZC4KClJldmlld2VkLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
