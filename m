Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D7ECF9C6F
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 13:17:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 054C93C4CBA
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 15:17:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763B33C4C08
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 15:17:22 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC23E1409187
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 15:17:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oXMYUPYMt07zz0fOECTOJHvq6ALaKeolSNYhYNLakE=;
 b=I2hyVfm0i8VQMC3+qB2ntHQ2xPFNBlgfi+X0RBgA/RdI82JGHKZdNGwntGKPveg16vpxZj
 O7IF1XaW9qsqehSwitUJBdyTYLrexBj0+UT7pS0gj5W1ukwXsPVq18SwviexTfgiid8R9H
 oI4FJISR6DyvCwsDJLFEoEpVYGyORyY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-K6iCR77_OPSALWi2U366_A-1; Tue, 24 Sep 2024 09:17:12 -0400
X-MC-Unique: K6iCR77_OPSALWi2U366_A-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-277d1371d01so4159499fac.1
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 06:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727183831; x=1727788631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oXMYUPYMt07zz0fOECTOJHvq6ALaKeolSNYhYNLakE=;
 b=m2fSt1joSt57og8ur5AKm4+508SX0nq8jcZMpHNhjwqBv0gbkxos55zL/Ovc/IKr8d
 9RRiv+2gL0+kfEL8tIcIIrdOFJbUCRR694QolZBDl9qOWBINMejHj7UF2n87XZHOGcEb
 mskVeijoBilDxwQBEyp5F8htGiJXpZLcBGvqS6fBCiOigFDd5b/ViEW1roJufJd6876R
 H8tjIaBOGQ9Dqs1yYD7WPxt736H5+YNFcAA9hM66MWP60/Ke1amjSU+Off07Iz3hPWFg
 159X7NsXwrhkFnk6ltR44TlBG+01nQ9WeQX+CG2E65Ay2pd6d0XrpzP8UIGI1mhIb0ML
 lOWg==
X-Gm-Message-State: AOJu0Yy0LqulyUWnIb90rBB8jx2xqj3uTwSloYi0sRRFuuNZzkhMCoXb
 SvHoGs/vQkQzNbyDuqb9+8qNeBTy7ssTngAQA9FHUSH4bs9iHlOUZ5B/aHn63G+gJ44Bt9xVFyr
 7wZnMADFVyLv1NmmPW6gjvKOV6BQtxLgvDftZGBZ5sTRbmesB64zXh1b7/L3eUtUrpK4mEpMTpC
 ysvfsVepS+iGCy45MstsI5fcQ=
X-Received: by 2002:a05:6870:d206:b0:27c:4853:2b68 with SMTP id
 586e51a60fabf-283ab9a5164mr1604015fac.20.1727183831320; 
 Tue, 24 Sep 2024 06:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG65HUSJ3BLwBcA1uFgd30JeShx9W3meWfljUHN9feevoue9Oe1bla7s3toCNQIIX3qkS9l1JUMsMaal8u5YgY=
X-Received: by 2002:a05:6870:d206:b0:27c:4853:2b68 with SMTP id
 586e51a60fabf-283ab9a5164mr1603981fac.20.1727183830831; Tue, 24 Sep 2024
 06:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
 <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
In-Reply-To: <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 Sep 2024 15:16:51 +0200
Message-ID: <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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

T24gVHVlLCBTZXAgMjQsIDIwMjQgYXQgMTA6NDbigK9BTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBs
dHAKPGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cj4KPiBIaSEKPgo+IFBsZWFzZSBjb25zaWRl
ciB0aGlzIHBhdGNoc2V0IGFzIGEgZHJhZnQgb3BlbiBmb3IgZGlzY3Vzc2lvbi4KCkhhdmUgeW91
IGNvbXBhcmVkIG9sZCBhbmQgbmV3IGRlZmluZXM/IEFyZSB0aGVyZSBhbnkgZGlmZmVyZW5jZXMK
KG90aGVyIHRoYW4gYWRkaXRpb25zKT8KCj4KPiBBbmRyZWEKPgo+IE9uIDkvMjQvMjQgMTA6MDYs
IEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gPiBUaGUgcHJvYmxlbSB3ZSBoYXZlIGF0IHRoZSBt
b21lbnQgaXMgdGhhdCBhbGwgc3lzY2FsbHMgaW5wdXQgZmlsZXMgbXVzdAo+ID4gYmUgY2hhbmdl
ZCBieSBoYW5kIGVhY2ggdGltZSB3ZSBuZWVkIHRvIHRlc3QgYSBuZXcgc3lzY2FsbC4gVGhlIGlk
ZWEgaXMKPiA+IHRvIHNpbXBsaWZ5IHRoaXMgcHJvY2VzcywgcHJvdmlkaW5nIGEgc2NyaXB0IHRo
YXQgaXMgYWJsZSB0byByZWFkIGZyb20KPiA+IGtlcm5lbCBzb3VyY2VzIGFuZCB0byBnZW5lcmF0
ZSBhbGwgc3lzY2FsbHMgZmlsZXMgd2UgbmVlZC4KPiA+Cj4gPiBUaGlzIGlzIGRvbmUgYnkgdGhl
IGdlbmVyYXRlX3N5c2NhbGxzLnNoIHNjcmlwdCB0aGF0IGNhbiBiZSB1c2VkIGFzCj4gPiBmb2xs
b3dpbmc6Cj4gPgo+ID4gLi9nZW5lcmF0ZV9zeXNjYWxscy5zaCBwYXRoL3RvL2tlcm5lbC9zb3Vy
Y2UgcGF0aC90by9zeXNjYWxscy5oCj4gPgo+ID4gVGhpcyBhcHByb2FjaCByZXF1aXJlcyBhIGNl
cnRhaW4gdHlwZSBvZiBhdHRlbnRpb24sIGR1ZSB0byB0aGUgZmFjdCB0aGF0Cj4gPiB3ZSBuZWVk
IHRvIGdlbmVyYXRlIHN5c2NhbGxzLmggYXQgZWFjaCBrZXJuZWwgdmVyc2lvbiwgb3Igd2hlbiBu
ZXcKPiA+IHN5c2NhbGxzIGhhdmUgYmVlbiBhZGRlZCBpbiB0aGUga2VybmVsLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
Cj4gPiAtLS0KPiA+IEFuZHJlYSBDZXJ2ZXNhdG8gKDQpOgo+ID4gICAgICAgIFJlbmFtZSBzeXNj
YWxscyBvcmRlciBmaWxlIHRvIHN1cHBvcnRlZC1hcmNoLnR4dAo+ID4gICAgICAgIEFkZCBzY3Jp
cHQgdG8gZ2VuZXJhdGUgc3lzY2FsbHMuaAo+ID4gICAgICAgIERlcHJlY2F0ZSBvbGQgc3lzY2Fs
bHMgaW5wdXQgZmlsZXMKPiA+ICAgICAgICBTYXZlIHN5c2NhbGxzLmggaW5zaWRlIHJlcG8KPiA+
Cj4gPiAgIGluY2x1ZGUvbGFwaS8uZ2l0aWdub3JlICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgIDEgLQo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMuaCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDM0MjcyICsrKysrKysrKysrKysrKysrKysKPiA+ICAgaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL2FhcmNoNjQuaW4gICAgICAgICAgICAgICAgICAgfCAgIDMwNiAtCj4gPiAgIGlu
Y2x1ZGUvbGFwaS9zeXNjYWxscy9hcmMuaW4gICAgICAgICAgICAgICAgICAgICAgIHwgICAzMjUg
LQo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtLmluICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgNDA0IC0KPiA+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2JsYWNrbGlzdC1zeXNjYWxs
cy50eHQgICAgICAgfCAgICAgNiArCj4gPiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9nZW5lcmF0
ZV9zeXNjYWxscy5zaCAgICAgICAgIHwgICAyOTIgKwo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2Fs
bHMvaHBwYS5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgIDUyIC0KPiA+ICAgaW5jbHVkZS9s
YXBpL3N5c2NhbGxzL2kzODYuaW4gICAgICAgICAgICAgICAgICAgICAgfCAgIDQzOSAtCj4gPiAg
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy9pYTY0LmluICAgICAgICAgICAgICAgICAgICAgIHwgICA5
NTYgKy0KPiA+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2xvb25nYXJjaC5pbiAgICAgICAgICAg
ICAgICAgfCAgIDMxMCAtCj4gPiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9taXBzX24zMi5pbiAg
ICAgICAgICAgICAgICAgIHwgICAzNzkgLQo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvbWlw
c19uNjQuaW4gICAgICAgICAgICAgICAgICB8ICAgMzU1IC0KPiA+ICAgaW5jbHVkZS9sYXBpL3N5
c2NhbGxzL21pcHNfbzMyLmluICAgICAgICAgICAgICAgICAgfCAgIDQyNSAtCj4gPiAgIGluY2x1
ZGUvbGFwaS9zeXNjYWxscy9wb3dlcnBjLmluICAgICAgICAgICAgICAgICAgIHwgICA0MzIgLQo+
ID4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvcG93ZXJwYzY0LmluICAgICAgICAgICAgICAgICB8
ICAgNDMyIC0KPiA+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3JlZ2VuLnNoICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEyOSAtCj4gPiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zMzkwLmluICAg
ICAgICAgICAgICAgICAgICAgIHwgICA0MTkgLQo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMv
czM5MHguaW4gICAgICAgICAgICAgICAgICAgICB8ICAgMzY3IC0KPiA+ICAgaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL3NoLmluICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQxMyAtCj4gPiAgIGlu
Y2x1ZGUvbGFwaS9zeXNjYWxscy9zcGFyYy5pbiAgICAgICAgICAgICAgICAgICAgIHwgICA0MTgg
LQo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvc3BhcmM2NC5pbiAgICAgICAgICAgICAgICAg
ICB8ICAgMzgzIC0KPiA+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3N0cmlwX3N5c2NhbGwuYXdr
ICAgICAgICAgICAgfCAgICAxOSAtCj4gPiAgIC4uLi9sYXBpL3N5c2NhbGxzL3tvcmRlciA9PiBz
dXBwb3J0ZWQtYXJjaC50eHR9ICAgIHwgICAgIDEgLQo+ID4gICBpbmNsdWRlL2xhcGkvc3lzY2Fs
bHMveDg2XzY0LmluICAgICAgICAgICAgICAgICAgICB8ICAgMzk2IC0KPiA+ICAgMjUgZmlsZXMg
Y2hhbmdlZCwgMzUxNzQgaW5zZXJ0aW9ucygrKSwgNjc1NyBkZWxldGlvbnMoLSkKPiA+IC0tLQo+
ID4gYmFzZS1jb21taXQ6IDk2OGU2MjQ1ZDkzYmM5MTcyM2U3MjA4NmE3MWU2YmM1MGY0OTVkMGIK
PiA+IGNoYW5nZS1pZDogMjAyNDA5MjMtZ2VuZXJhdGVfc3lzY2FsbHMtNzgwZGMyMjI3YmRiCj4g
Pgo+ID4gQmVzdCByZWdhcmRzLAo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
