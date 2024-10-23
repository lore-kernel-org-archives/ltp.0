Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501E7CF5367
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729686876; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=BuEETKu3/WLhPUDOnmnBBVz0O3ferSQXNrFbA6HPN70=;
 b=Mzt1rbiEXocFjle+QZrcWiD/qYcWWivEERJvpRkB8iqaohNRXvZjTpzHAr+EocIp6NYib
 D+tTXO938Q2r17FjcDtjQrEk9PbFxzNgbP7MqWKIA6I+6kJw5ZdJSsR1GBjOZv0Bs363tjE
 l4XTvp9NLxBnAHcemGhCkz0eClbgOss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863F93C7080
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 14:34:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 533353C6C2E
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 14:34:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0028E14139EB
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 14:34:14 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso52498675e9.0
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729686854; x=1730291654; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vfuG+zWZZa31oTIjNJatqnpqahc47bdCau2HcIGK+0s=;
 b=UfJK1VdXP68Yc3unJ8OaCVdWlz5Xb2R8UJ/MPUPUFqDXB/TNqCIpD2UNb3I1+ybA+U
 hfIfTosBWO3msMbrUmfnYTGAj1FPA5qcQkPV4yY2w0U9c54rSQON9lOmssSNP5TqJsM3
 T64c4pgOwYwlBqOMts5N2fb+EeXdCtmeicA061mW4rMe4u4V8CrDuSct2pnuVC4Pmeio
 upBrdN0CHqj5r0rUqxWjt4nSfIQNEaSGnCUS35B0aK7SEJ4/XEUk3q1zgS3fkfT68ECR
 tJZROExeesmqpVMdeHuBaPQumkdIEn0+g81G1UD3DkIdC4WXvSTMkZK3AP+fNEYyoQNa
 ykOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729686854; x=1730291654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vfuG+zWZZa31oTIjNJatqnpqahc47bdCau2HcIGK+0s=;
 b=uVsGJ33mN3rfJIxeRKhm26/Assnd0iQFPbeGI17dro4csi9uABlkTX6ilhmVHb/35X
 DJTcd6BCdaz7Xw3zY2zUimcCVgz2VB1i0055kTtMi8VU+AlOYqpNFMPmBRppZ5zwYyEM
 8EpleHU0SNAbw7pCwJwKQ8zIbYDGsLr2Od60VIt7xOcB3H0iQLXXf49zq6pMSVN9/UDS
 enV7WYg+pRMsv81r8NWmXGNw3OBNoFNwS1GA8PLaVZOeS3iSu3SIC1uPckqG9FzqIpWw
 FUehZAe11/kq8Uz2hkGR82t0W9gihqRrAyHmrMAhcQ+npUxH4wseE/626auBJNGCuIcK
 C2Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnmJyBFd0HjogkeBYLag6TeXtRmB2XjdjFi/TlCqkzFLzk9Yj23MrRhfIopJBoa/g/h/E=@lists.linux.it
X-Gm-Message-State: AOJu0YzG6hhTetq0zteggVxxxMnUwvB3Syjz9fYKoFw/Koe7vdQ1t7A3
 cYq1bqnFGMO5M3X6huQ87YgtZ/MhoPD3zMAQDZAfKnsOOdnadVRbO9SbbgJNKK0=
X-Google-Smtp-Source: AGHT+IH8uTsVKGqhFnue21V1OwCt+cbRjL7k5437q9pktNmWviFBZfQMhKvns6vPM2VgpCZGVyXkKQ==
X-Received: by 2002:a05:6000:4581:b0:37d:41c5:a527 with SMTP id
 ffacd0b85a97d-37efcf05d52mr1411325f8f.13.1729686854261; 
 Wed, 23 Oct 2024 05:34:14 -0700 (PDT)
Received: from [10.15.23.93] ([213.61.187.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0ba7480sm8781176f8f.113.2024.10.23.05.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 05:34:14 -0700 (PDT)
Message-ID: <69c655f5-3635-48c7-a925-544ad2af05ca@suse.com>
Date: Wed, 23 Oct 2024 14:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
 <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
 <20241015171717.GA36237@pevik>
Content-Language: en-US
In-Reply-To: <20241015171717.GA36237@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIDEwLzE1LzI0IDE5OjE3LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIEFuZHJl
YSwgTGksIGFsbCwKPgo+PiBIaSBBbGwsCj4+IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDI6NDni
gK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4+IEFuZHJlYSBDZXJ2
ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4gd3JvdGU6Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Pj4+IC0tLQo+
Pj4+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2FyYy5pbiAgICAgICAgIHwgIDQxICstCj4+Pj4g
ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtLmluICAgICAgICAgfCA4MTkKPj4+PiArKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQo+Pj4+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxz
L2FybTY0LmluICAgICAgIHwgIDE4ICstCj4+Pj4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvaTM4
Ni5pbiAgICAgICAgfCAgMTggKy0KPj4+PiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9pYTY0Lmlu
ICAgICAgICB8ICAxMCArLQo+Cj4KPj4+IFRoZSBtYWlubGluZSBrZXJuZWwgaGFzIGRyb3BwZWQg
c3VwcG9ydCBmb3IgSXRhbml1bSBJQS02NCBmcm9tIGtlcm5lbC12Ni43Cj4+PiAuCj4+PiBodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvY29tbWl0Lz9pZD1jZjhlODY1ODEwMGQ0ZWFlODBjZTliMjFmN2E4MWNiMDI0ZGQ1MDU3
Cj4+PiBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZCByZW1vdmUgSUE2NCBzdXBwb3J0IGZvciBM
VFAgYXMgd2VsbC4KPj4+IEJ1dCB3aGF0ZXZlciBMVFAga2VlcHMgdGhlIGNvZGUgZm9yIElBNjQg
b3Igbm90LCBtYXliZSB3ZSBkb24ndAo+Pj4gbmVlZCB0aGVzZSB1cGRhdGUgZm9yIGlhNjQsIHJp
Z2h0Pwo+Cj4+IEJUVywgVGhlIGJlbG93IGxpbmsgaGVyZSBtYXkgbm90IGJlIGRpcmVjdGx5IHJl
bGV2YW50IHRvIHlvdXIgcGF0Y2gsCj4+IGJ1dCBJIHRoaW5rIG9mIHdlIGhhdmUgZGlzY3Vzc2Vk
IGNsZWFuaW5nIHVwIHRoZSBJQTY0IGNvZGUgaW4gTFRQIGJlZm9yZS4KPj4gaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjQtSmFudWFyeS8wMzY2MTEuaHRtbAo+IFllcywg
aXQncyB0aW1lIHRvIGRyb3AgSUE2NCBjb2RlIChhcyBhIHNlcGFyYXRlIGVmZm9ydCwgdGhlcmUg
YXJlICNpZmRlZikuCj4KPiBJdCB3b3VsZCBiZSBjbGVhbmVyIGlmIHlvdSBpbnN0ZWFkIG9mIG1v
ZGlmeWluZyBpYTY0LmluIGp1c3QgcmVtb3ZlIHRoZSBmaWxlIGluCj4gYSBzZXBhcmF0ZSBjb21t
aXQgYmVmb3JlICh1bnJlbGF0ZWQgY2hhbmdlKS4gQnV0IEknbSBvayBhbHNvIHdpdGggc2luZ2xl
IGNvbW1pdAo+IGlmIHlvdSdyZSBub3QgZ29pbmcgdG8gc2VuZCBhbm90aGVyIHZlcnNpb24uCk9r
LCBub3cgSSBzZWUgdGhlIHBvaW50LiBXZWxsLCB3ZSBjYW4gbWFrZSBhIGRlY2lzaW9uIGFyb3Vu
ZCBpdCB0aGVuLCAKYnV0IGl0IHdpbGwgcHJvYmFibHkgbmVlZCBtb3JlIHBlb3BsZSBpbnZvbHZl
ZC4KPiBJIGFsc28gd29uZGVyIGlmIHdlIHNob3VsZCBhZGQgUEEtUklTQywgSFAgc3RvcCBzdXBw
b3J0aW5nIHNlcnZlcnMgaW4gMjAxMyBbMV0uCj4gU3VyZSwga2VybmVsIGlzIHN0aWxsIGNvbnRh
aW5zIHRoaXMgYXJjaCwgYnV0IEkgZG91YnQgYW55Ym9keSB1c2VzIExUUCBmb3IKPiB0ZXN0aW5n
LiBUaGUgYXJjaCBpcyBJTUhPIG5vdCBzdXBwb3J0ZWQgZGlyZWN0bHkgYnkgYW55IGRpc3RybyAo
aXQgd2FzIGRyb3BwZWQKPiBmcm9tIERlYmlhbiA2IHNxdWVlemUgWzJdLCB3aGljaCB3YXMgcmVs
ZWFzZWQgMjAxMSBhbmQgRU9MIDIwMTYpLCBtb3ZlZCB0bwo+IERlYmlhbiBwb3J0cyBbM10uIFRo
ZSBjb21tdW5pdHkgaXMgc3RpbGwgc29tZWhvdyBhY3RpdmUsIGJ1dCBmZXcgcGVvcGxlIGp1c3QK
PiBmaWdodCB0byBmaXggY29tcGlsYXRpb24gaXNzdWVzIFs0XS4KPgo+IFN1cmUsIGl0J3MganV0
IGEgc2luZ2xlIGZpbGUgKHBhcmlzYy5pbikgYW5kIHdlIGhhdmUgb3RoZXIgbGVnYWN5IGFyY2hp
dGVjdHVyZXMKPiB3aGljaCBhcmUgcGFzc2luZyBhd2F5IGJ1dCBub3QgeWV0IHJlbW92ZWQgZnJv
bSBrZXJuZWwgdHJlZSBkdWUgZmV3IHBlb3BsZSB1c2luZwo+IHRoZW0gKGF0IGxlYXN0IHNoLCBz
MzkwLCBzcGFyYykuIEhhdmluZyB0aGVzZSBmaWxlcyB3ZSBzdWdnZXN0IHNvbWVib2R5IGlzCj4g
YWN0dWFsbHkgdGFraW5nIGNhcmUgYWJvdXQgdGhlc2UgYXJjaHMuIEJ1dCBhcyBJIHNhaWQsIHBy
b2JhYmx5IG5vYm9keSBpcyB1c2luZwo+IExUUCB0byB0ZXN0IHRoZW0sIHRodXMgbWFueSB0ZXN0
cyB3aWxsIGJlIGJyb2tlbi4KPgo+IFsxXSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Q
QS1SSVNDCj4gWzJdIGh0dHBzOi8vd3d3LmRlYmlhbi5vcmcvcG9ydHMvaHBwYS8KPiBbM10gaHR0
cHM6Ly9saXN0cy5kZWJpYW4ub3JnL2RlYmlhbi1ocHBhLwo+IFs0XSBodHRwczovL2xpc3RzLmRl
Ymlhbi5vcmcvZGViaWFuLWhwcGEvMjAyNC8wOS90aHJlYWRzLmh0bWwKPgo+IEFsc28sIHRoaXMg
NHRoIHBhdGNoIGFsc28gZG9lcyBub3QgYXBwbHkuIFVubGlrZSBmaXJzdCBjb21taXQgdGhlcmUg
YXJlIG1vcmUKPiBjb25mbGljdHMgKGFwcGx5aW5nIG9mIGNvdXJzZSBvbiB0aGUgdG9wIG9mIHRo
ZSAzIHByZXZpb3VzIHBhdGNoZXMpOgo+Cj4gRGVzY3JpcHRpb246IFt2NCw0LzRdIFVwZGF0ZSBz
eXNjYWxscyBmaWxlcwo+IEFwcGx5aW5nOiBVcGRhdGUgc3lzY2FsbHMgZmlsZXMKPiBlcnJvcjog
cGF0Y2ggZmFpbGVkOiBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtLmluOjEKPiBlcnJvcjogaW5j
bHVkZS9sYXBpL3N5c2NhbGxzL2FybS5pbjogcGF0Y2ggZG9lcyBub3QgYXBwbHkKPiBlcnJvcjog
cGF0Y2ggZmFpbGVkOiBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtNjQuaW46Mjk0Cj4gZXJyb3I6
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hcm02NC5pbjogcGF0Y2ggZG9lcyBub3QgYXBwbHkKPiBl
cnJvcjogcGF0Y2ggZmFpbGVkOiBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvaWE2NC5pbjozNDEKPiBl
cnJvcjogaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2lhNjQuaW46IHBhdGNoIGRvZXMgbm90IGFwcGx5
Cj4gZXJyb3I6IHBhdGNoIGZhaWxlZDogaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3g4Nl82NC5pbjoz
NDkKPiBlcnJvcjogaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3g4Nl82NC5pbjogcGF0Y2ggZG9lcyBu
b3QgYXBwbHkKPiBQYXRjaCBmYWlsZWQgYXQgMDAwMSBVcGRhdGUgc3lzY2FsbHMgZmlsZXMKVGhp
cyBpcyByZWFsbHkgc3RyYW5nZS4gSXQncyBub3QgaGFwcGVuaW5nIGZvciBtZSBldmVuIHdpdGgg
dGhlIGxhdGVzdCAKSEVBRC4gRGlkIHlvdSByZWJhc2UgZmlyc3Q/Cj4gS2luZCByZWdhcmRzLAo+
IFBldHIKQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
