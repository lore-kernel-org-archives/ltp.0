Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EB9C369A1
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 03:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744254267; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RdECxGQD1POvzUhDR3Km1Bbm8FWALIPUoXqwgXiIh3w=;
 b=btpHjLIY93Jrog2VuUoiPiCHs8aO5ZVoMxw/4aFCWV5RrVJ4S+HRfuUzFoaoS/05Dc04F
 tg7/zgObePmdl0jcmhRGY9c6hT6GPg3EI6Z/p7G7j5Ql/CRMtUa7nU8pZRsrmUwUNya8kIf
 avG+eTh8CXQhsiGiwxMh49gDxkOg25k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB0233CB45A
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 05:04:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5546A3CB41F
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 05:04:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5719420010F
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 05:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744254243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kMTNFvuN1CsZT68SpLOrWCUmVc0APEWuktEV1StsH7w=;
 b=Ea76RUgFqsZjlr9l9cGOtGzHY54vJeFwFkyNFjuCv2vtLBdXNw5oO+GWlMJns2ZstIZDFU
 023oHR1qUeqZ53yaJCSh85lt6yYffl/fhgOJEd3MsBQ8lAvRUmaqeBfvqRzlDZ/TaSwctn
 ld3sepzFc9vZzaqgTMDaPwm5Kl/04zU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-MezTGgrrMRKP6ML3pKJTOA-1; Wed, 09 Apr 2025 23:04:01 -0400
X-MC-Unique: MezTGgrrMRKP6ML3pKJTOA-1
X-Mimecast-MFC-AGG-ID: MezTGgrrMRKP6ML3pKJTOA_1744254240
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff7f9a0b9bso346993a91.0
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 20:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744254240; x=1744859040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kMTNFvuN1CsZT68SpLOrWCUmVc0APEWuktEV1StsH7w=;
 b=mYri3BqLw/4zvewxxEJ6iVt9vc+IeV33pUsJVPeAdjHHXZotATe1v4wPJNDJewFawz
 1RoK0eO0E9HaGI3vL5KsxLY5tl1O07uR+5pAB2HPUVNClQOV/ydyfAjHCfxd7kmgpn/B
 YD0oxfdhejzwvpb8iflUzeH6Ohszl9NHJH8fpOvSGIVb8/nUQ5ZeKvwWxxKPHQCfY+yQ
 mPxy6fdO61fvvs08tRzFAL++PLmXnVUnD12g5mzwOM0k95HWK6FxMv44kDGqcc3nNt6v
 SPGWf7sNiCIQwPJLM0wB7wuNTJ+jeC0w6xHevrAk6L6s5lad/QVncwrp3K9YcznC6Txq
 2QMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzBvW3hU8zDhWKQaPMfNGaTMeI/1idoefmCVzwLeEM6mRHspzK5ZnIBGRUv7nzuNFurKQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yx1fL/GvgsvZKr7PtOT5NB6CTalSDl4LYSaDKWT5Jrf4WMYyBpS
 6Ug5bphBgeu1TTrMrogRC2SaGSTBGPNp5V3jUHIl5XfZk8rDWBVrzWSggEerK7nC3rhlYtJVcsZ
 aia5TMmkw99WbyJ9IXe3/6M+FE67+mO/9stM+7ZOAkmw9I3cJiRZc7TFeBKMBvsVtp4ASyu+h/4
 F+9cwMapOL596afnoSg46LoeE=
X-Gm-Gg: ASbGncuqSSz5RzV/NTZ7A/xkIpOftZhEA0OMAgY4vGzcA+GeP4LodWMusZsq+ImMzqp
 gRKyf5YYPbENS7KA0/aueQyHp5j0qXuhwKEKbC5CQm4W9Rsk6/T11Tr39Bcy1Ic1NrNLsBA==
X-Received: by 2002:a17:90b:4d0d:b0:305:2d27:7ba5 with SMTP id
 98e67ed59e1d1-30718b62c3fmr1617586a91.6.1744254240431; 
 Wed, 09 Apr 2025 20:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhWdecf2qyI5B6UPGXIoFtn9z0Tm1t9oNEf6Hw7+u790bRa7N5M6fPqJjU20Mawq6oU0Gt0JjDyF/s906k3/0=
X-Received: by 2002:a17:90b:4d0d:b0:305:2d27:7ba5 with SMTP id
 98e67ed59e1d1-30718b62c3fmr1617561a91.6.1744254239963; Wed, 09 Apr 2025
 20:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250407102448.2605506-1-siddhesh@gotplt.org>
 <20250407102448.2605506-3-siddhesh@gotplt.org> <20250407111343.GA83774@pevik>
 <ea5bf29e-cfe8-411c-bccc-0a586231e4f7@gotplt.org>
In-Reply-To: <ea5bf29e-cfe8-411c-bccc-0a586231e4f7@gotplt.org>
Date: Thu, 10 Apr 2025 11:03:47 +0800
X-Gm-Features: ATxdqUFeHBQgDg5tCM0W7HwARmLbnFi8D1EInj30Ew2pwzdapx9I4hOQKdM-FFg
Message-ID: <CAEemH2e_vqHjCmwCDhK444=RGMvcG69Bv2GYgGXP7d=OqYrG1A@mail.gmail.com>
To: Siddhesh Poyarekar <siddhesh@gotplt.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2mPtEtO3B44ECqULwTJ78k6yGInfohWLqYxECjN5JoM_1744254240
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] Add centos10 to test matrix
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

SGkgUGV0ciwgU2lkZGhlc2gsCgpTaWRkaGVzaCdzIHdvcmRzIG1ha2Ugc2Vuc2UsIGJ1dCBjb25z
aWRlcmluZyB3ZSAoUmVkSGF0KSBhbHJlYWR5IHRlc3QKRmVkb3JhLUVMTiBbMV0gaW50ZXJuYWxs
eSB3aXRoIHRoZSBMVFAgbGF0ZXN0IGJyYW5jaCwgc28gaXQncyBub3QgbmVjZXNzYXJ5CnRvIGVu
YWJsZSBDZW50T1MtMTAgc3RyZWFtIGluIEdpdEh1YiBDSSBhZ2Fpbi4KClsxXSBBY3RzIGFzIGEg
dGVzdGluZyBncm91bmQgZm9yIFJIRUwncyBuZXh0IG1ham9yIHZlcnNpb24gKGUuZy4sIFJIRUwg
MTApLgoKQFNpZGRoZXNoLCB5b3UgY2FuIGZpbmQgdGhlIEZlZG9yYS1FTE4gdGVzdCBpbiBDS0kg
c3lzdGVtLCB3aGljaCBwbGF5cwphbiBpbXBvcnRhbnQgcm9sZSBpbiB0ZXN0aW5nIExUUCBtYXN0
ZXIgYnJhbmNoLgoKCk9uIE1vbiwgQXByIDcsIDIwMjUgYXQgMTA6MDDigK9QTSBTaWRkaGVzaCBQ
b3lhcmVrYXIgPHNpZGRoZXNoQGdvdHBsdC5vcmc+Cndyb3RlOgoKPiBPbiAyMDI1LTA0LTA3IDA3
OjEzLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4+IGdjYyBvbiBDZW50T1MgMTAgaXMgY29uZmlndXJl
ZCB0byBidWlsZCB3aXRoIEFWWCBvbiBieSBkZWZhdWx0Cj4gPj4gKHNwZWNpZmljYWxseSwgLW1h
cmNoPXg4Ni02NC12MyksIHVubGlrZSBvdGhlciBjb21waWxlcnMsIHNvIGl0IHNob3VsZAo+ID4+
IGJlIGEgdXNlZnVsIGFkZGl0aW9uIHRvIHRoZSB0ZXN0IG1hdHJpeC4KPiA+Cj4gPj4gY3ZlLTIw
MTUtMzI5MCBmb3IgZXhhbXBsZSBmYWlscyB0byBidWlsZCBvbiB0aGlzIHdpdGhvdXQgYC1tbm8t
YXZ4YCBpbgo+ID4+IHRoZSBidWlsZCBmbGFncy4KPiA+Cj4gPiBJIGRvbid0IHdhbnQgdG8gYWRk
IHlldCBhbm90aGVyIENJIGpvYiBqdXN0IHRvIHRlc3QgcHJldmlvdXMgY29tbWl0Lgo+ID4gV2Ug
YWxyZWFkeSBoYXZlIHF1aXRlIGEgbG90IG9mIGRpc3Ryb3MgKHJ1bm5pbmcgaXMgcXVpdGUgbG9u
ZykuCj4KPiBTbyB0aGUgcmVhc29uIEkgc3VnZ2VzdGVkIGFkZGluZyBjZW50b3MxMCBpcyB0aGF0
IGl0IGhhcyBhIGRpc3RpbmN0bHkKPiBkaWZmZXJlbnQgdG9vbGNoYWluIGZyb20gdGhlIG90aGVy
IGNvbnRhaW5lcnMgaW4gdGhlIG1hdHJpeC4gIFRoZSBnY2Mgb24KPiBjZW50b3MxMCBkZWZhdWx0
cyB0byBnZW5lcmF0aW5nIGNvZGUgZm9yIHRoZSB4ODYtNjQtdjMgYmFzZWxpbmUgKHdoaWNoCj4g
ZW5hYmxlcyBBVlggYnkgZGVmYXVsdCkgb24geDg2XzY0IHdoaWNoIGlzIGRpZmZlcmVudCBmcm9t
IGFsbCBvZiB0aGUKPiBvdGhlciB0ZXN0IGVudmlyb25tZW50cyBpbiB0aGUgbWF0cml4Lgo+Cj4g
PiBATGkgSSBzdXBwb3NlIHlvdSB3YW50IHRvIGtlZXAgY2VudG9zIDkgdGhhbiB0byBoYXZlIGNl
bnRvcyAxMC4KPiA+IEkgZ3Vlc3MgZm9yIG5ldyBkaXN0cm9zIHdlIGhhdmUgRmVkb3JhLgo+Cj4g
Y2VudG9zOSBkZWZhdWx0cyB0byB4ODYtNjQtdjIgRldJVywgc28gaXQncyBraW5kYSB1bmlxdWUg
aW4gdGhhdCBzZW5zZQo+IHRvby4gIEZlZG9yYSBkb2VzIG5vdCBjaGFuZ2UgSVNBIGJhc2VsaW5l
cyB0aGUgd2F5IGNlbnRvcy9SSEVMIGRvZXMKPiBzaW5jZSB0aGUgRmVkb3JhIGNvbW11bml0eSB3
b3VsZCBsaWtlIHRvIGNvbnRpbnVlIHN1cHBvcnRpbmcgdGhlIGxvd2VzdAo+IGNvbW1vbiBkZW5v
bWluYXRvciBpbiB0ZXJtcyBvZiBhcmNoaXRlY3R1cmUgc3VwcG9ydC4KCgo+IEFsdGhvdWdoIEkg
dW5kZXJzdGFuZCB0aGUgbmVlZCB0byBrZWVwIHRoZSBwcmUtY29tbWl0IENJIHJ1biBzbGltLCBq
dXN0Cj4gdGhvdWdodCBJJ2QgYWRkIG15ICQwLjAyIDopCj4KPiBUaGFua3MsCj4gU2lkCj4KPgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
