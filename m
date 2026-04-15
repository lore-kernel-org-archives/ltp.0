Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C6CF428E0
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776284502; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aOzN8O3IDj/djIvu58rZpuzhcRjP9QKMSsmpJvwPky0=;
 b=ExMrA4lyQ+b6CV0UBSIkvKMgkkCNf++u1SYhpa9PIVhRSht/DmFUVjQyvsWVI3wDSnC+F
 TSuZrR1Bd6wX3WlJ6uS2BymcmKS/gEqlfAdrBVqyBgyTEuMna/zdN1YXRNXM9uGhGmPrMhA
 4Bmv/wmv/fwh5bnpw+qjN1K6FwEUuSk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DA133E2255
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 22:21:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 890893CB6BF
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 22:21:17 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 17E571A00264
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 22:21:17 +0200 (CEST)
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-95699e8e26aso893540241.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776284476; cv=none;
 d=google.com; s=arc-20240605;
 b=bMC7tJ637NhO3YQ8ncdKvVOSPU8k3OoLVTguHnA8gp1SHNPggt9OX+SsYssvKcLh+P
 wUcunzIAvXWyrBh9AcJr/lBJciY1zZbYFHfjhkqYYjhxQDGvkY6PfLyR/lv3WyknBP+i
 O74d/CjdqApVKUembu3ZgUrQNJmr60VFf/7huCROJad5PRKjypC+8hXuHDnyTPbiYcvv
 rwiBRbfCX/FiDtnJL8cs4lPin/myuKGjMwROdx8yRvQlkjv9tCnqqRU01wYnjV5OGevl
 JmHSzsFjV4b/RCycZMR9t7ZfgMyRxgSEWpJXmAjt/ZJrs30t+nNwq9beZxvbKyVboRsH
 PehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lMeaEhX6NCDliM3JhdR1douUBFEeUzEBllgQHTNp2YI=;
 fh=DUtt9KdDPrd81V+i/AjmN59os3iUSXX3UNjUPI6ZE6w=;
 b=Bg29GWaRejIvtPq+w5+BM1r3omXOcKT+tbtNwHmByAaQMHH5Xxw8OgGbE13J8YGJ83
 HreSoEnAvjmTK3LoMQiNByuWRQSooCXsEy/oTDVQ9OUDBA7uuFuftPRnOSpB3QZrHUvj
 w2md9UxY05f6eKXXf7FFVxK5l3Xe7pY1KdzSQiC2Qr0plSoHb6HwIVaObwRzT4QN9JEQ
 GfDxkDgzALE60E44VwFiYyu5UFBOJQ49tERnlHWAigETGea1BK/njLQpWgH8RzoKe/9H
 wCK8OMcAT4Ptrx8gGgTkLX3mqjIdgv40Nme7/+d11imOuwLTSdEb0WKsWU7dYNw0WOHN
 k8cg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776284476; x=1776889276; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMeaEhX6NCDliM3JhdR1douUBFEeUzEBllgQHTNp2YI=;
 b=ELo0BABYWS4wYRlyV5Fm5J3hcTHEDz0s1y9lKXTEeQqwiWq1V9HQzBh7BOw4e3R0IT
 JPGOVSiCNnlet6q+rUJYL1t0Pw6IakjM4RvfhYszPpBv5eKSLXqgQFdcEbKBGD4ehOjY
 bWO6MHaNziwE7nCfT1aeMjha0kn8ySfhU21qZRldg7UYIq2HogzxXfVDIwPY82BmHboH
 yuWTj1T8su+DZNgTd0XzMmOzb1QYvMgDt49n0aBAL67tXw6YEl7UQWYZzJOQLGgiCyDT
 blNd7Es07DhjiBIe+FGQWNJDGGWJKEW93ErhGIsxp8CQdy8F23/uGy62JGcWAcXrXusO
 dawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284476; x=1776889276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lMeaEhX6NCDliM3JhdR1douUBFEeUzEBllgQHTNp2YI=;
 b=Coaq8K+DzMK+/ud+1KVB9rj9lRhqU+AeCI7WFLqf9FDUNRuwok4zR2NAqQpwPkIVM/
 dvsElMKOLRvsF93EMgVpNZzsD1xu9s9VMBT0/yowNlYfzIKAM9DpBKXRHZHvyMyzvxBJ
 k8mRDzaVImJbirWzMY9TjMeDJ4y+zWTqMXsozM8t8+57vp1LIWtAJQjdWQT3LLm4XlnB
 wR/T2NrY04TSf3UhaFw0dW4JkRUjib8+VXXfUCw+6mNMMmaI51tT9fflGm5xCtMB/46N
 a9g+WZGXf5/z2tNQ/v+jWixoboWk++NQqu6Kw1VGTE4uTbfObwUsTz7X4lZQ3GgRbDf7
 UXdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X3iDIJe0SreDSSjVk6w0XnkQ6WZTDUpK1/5EuEftt5fmgBTRqlsnQ3X+3gJokcy0y3AQ=@lists.linux.it
X-Gm-Message-State: AOJu0YxNjjCaX4fREMiIMgFNrDTdfE2SaA2+GkvgaVelBQy3PvFqa06R
 CkkqpHbayWXq+ktsfZnjm451o6AQ3ZO609PM8ECoLlDopP9q7kIPhVUqxDKEybvWUnQxk5KA7p+
 XSS71HHYwKu6c3n5GHKsWwW2U+6u9J5RNKIvRzik=
X-Gm-Gg: AeBDievvfGALZbIhOpBZue7sRPo85NcFb2N98Cno0yTgjEmrGmgSl2yCNMcuq0ya1y9
 XC6xGTyytFEUj/1uTP2fbWk3AfqI5+yVxpU/GvRuB7K19V3rqUPMY4G1mvmK22EqRB6PRjxZdPg
 oAu8YPF1yJi1ZAPt9WKbkIgnFkCkLPFHjVb2wSBMGPW4K5HFzsJBO3O1k62PkTnuM/9zxxLVQSw
 MfMKsGA0qWo/Q/lUCL9MxAO1PRRhS233F66VL9gxDCMc0mdVONDkFwsYF8HTa/aCIeXACujMtmr
 3gQXyEiqpqd8heLTMIk7VGY0XPz/JiZwi7748pTWAKUlMC1oqCTUuUtqauspuGsOYUp7
X-Received: by 2002:a05:6102:1483:b0:605:558d:c7c2 with SMTP id
 ada2fe7eead31-609ff0c1b4emr11105567137.12.1776284475113; Wed, 15 Apr 2026
 13:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
 <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Wed, 15 Apr 2026 13:21:02 -0700
X-Gm-Features: AQROBzA8r9HH-Nf9i8y70cOjchP4rEIK2wmze41ac88q_PE9gJcAOnWgjlxHtvw
Message-ID: <CANDhNCoAc4ktPUzqgam_oO7aAc4yp3nCqkcwQDvWs0zV15ZCaw@mail.gmail.com>
To: Jan Polensky <japo@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: Soma Das <somadas1@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBcHIgMTUsIDIwMjYgYXQgODoyMOKAr0FNIEphbiBQb2xlbnNreSA8amFwb0BsaW51
eC5pYm0uY29tPiB3cm90ZToKPiBPbiBXZWQsIEFwciAxNSwgMjAyNiBhdCAwNTo1MjoxMVBNICsw
ODAwLCBMaSBXYW5nIHdyb3RlOgo+ID4gSGkgU29tYSBhbmQgSmFuLAo+ID4KPiA+ID4gPiAxLiBS
VCB0aHJvdHRsaW5nIGZyZWV6ZXMgYWxsIFNDSEVEX0ZJRk8gdGhyZWFkcyBzaW11bHRhbmVvdXNs
eS4gT24KPiA+ID4gPiByZWxlYXNlLCB0aGUga2VybmVsIGRvZXMgbm90IGFsd2F5cyByZXNjaGVk
dWxlIHRoZSBoaWdoZXN0LXByaW9yaXR5Cj4gPiA+ID4gdGhyZWFkIGZpcnN0IG9uIGV2ZXJ5IENQ
VSwgc28gb2ZmZW5zZSBicmllZmx5IHJ1bnMgYW5kIGluY3JlbWVudHMKPiA+ID4gPiB0aGVfYmFs
bCBiZWZvcmUgZGVmZW5zZSBpcyByZXNjaGVkdWxlZC4gRml4IGJ5IHNhdmluZyBhbmQgZGlzYWJs
aW5nCj4gPiA+ID4gc2NoZWRfcnRfcnVudGltZV91cyBpbiBzZXR1cCBhbmQgcmVzdG9yaW5nIGl0
IGluIGEgbmV3IGNsZWFudXAKPiA+ID4gPiBjYWxsYmFjay4KPiA+Cj4gPiBNYWtlIHNlbnNlLCBh
bmQgbGlrZSB0aGUgQUktcmV2aWV3ZXIgcG9pbnRzIG91dCBMVFAgcHJvdmlkZXMgYW4gb3B0aW9u
Cj4gPiB0byBzYXZlX3Jlc3RvcmUgaXQgYXV0b21hdGljYWxseS4KClRocm90dGxpbmcgc2hvdWxk
bid0IGJyZWFrIHRoZSB0ZXN0LiBUaGUgZmFjdCB0aGF0IFNDSEVEX05PUk1BTCB0YXNrcwpyYW4g
c2hvdWxkbid0IGNoYW5nZSB0aGUgb3JkZXJpbmcgd2hlbiB3ZSBnbyBiYWNrIHRvIHJ1bm5pbmcg
UlQgdGFza3MuClRoaXMgaXMgbGlrZWx5IGEga2VybmVsIGJ1Zy4KCj4gPiA+ID4gMi4gT2ZmZW5z
ZSBhbmQgZGVmZW5zZSB0aHJlYWRzIHdlcmUgdW5waW5uZWQsIGFsbG93aW5nIHRoZSBzY2hlZHVs
ZXIKPiA+ID4gPiB0byBtaWdyYXRlIHRoZW0gZnJlZWx5LiBBbiBvZmZlbnNlIHRocmVhZCBjb3Vs
ZCBsYW5kIG9uIGEgQ1BVIHdpdGgKPiA+ID4gPiBubyBkZWZlbnNlIHRocmVhZCBwcmVzZW50IGFu
ZCBydW4gdW5jaGVja2VkLiBGaXggYnkgcGFzc2luZyBhIENQVQo+ID4gPiA+IGluZGV4IGFzIHRo
ZSB0aHJlYWQgYXJnIGFuZCBjYWxsaW5nIHNjaGVkX3NldGFmZmluaXR5KCkgYXQgdGhyZWFkCj4g
PiA+ID4gc3RhcnQuIFBhaXJzIGFyZSBkaXN0cmlidXRlZCByb3VuZC1yb2JpbiAoaSAlIG5jcHVz
KSBzbyBlYWNoCj4gPiA+ID4gb2ZmZW5zZSB0aHJlYWQgc2hhcmVzIGl0cyBDUFUgd2l0aCBhIGRl
ZmVuc2UgdGhyZWFkLgo+ID4KPiA+IFRoaXMgaXMgYSBnb29kIHRob3VnaHQsIGFzIGZvciBTQ0hF
RF9GSUZPIGl0IG1hbmFnZXMgdGhlIGNvcnJlc3BvbmRpbmcKPiA+IHJ1bnF1ZXVlIGZvciBlYWNo
IENQVSBhbmQgc2ltcGx5IHBpY2tzIHRoZSBoaWdoZXIgcHJpb3JpdHkgdGFzayB0byBydW4uCj4g
PiBTbyBwaW5uaW5nIHRoZSB0aHJlYWRzIHRvIGVhY2ggQ1BVIG1ha2VzIHNlbnNlLCBidXQgbWF5
YmUgd2UgY291bGQKPiA+IG9ubHkgcGluIHRoZSBkZWZlbnNlIGJlY2F1c2U6Cj4gPgo+ID4gV2l0
aCBOIGRlZmVuc2UgdGhyZWFkcyBwaW5uZWQgb25lIHBlciBDUFUsIGV2ZXJ5IENQVSBoYXMgYSBk
ZWZlbnNlCj4gPiB0aHJlYWQgYXQgcHJpb3JpdHkgMzAgcGVybWFuZW50bHkgcnVubmFibGUuIFRo
ZSBvZmZlbnNlIHRocmVhZHMgYXQgcHJpb3JpdHkKPiA+IDE1LCByZWdhcmRsZXNzIG9mIHdoaWNo
IENQVSB0aGUgc2NoZWR1bGVyIHBsYWNlcyB0aGVtIG9uLCB3aWxsIGFsd2F5cyBmaW5kCj4gPiBh
IGhpZ2hlci1wcmlvcml0eSBkZWZlbnNlIHRocmVhZCBvbiB0aGUgc2FtZSBDUFUncyBydW5xdWV1
ZS4gU2luY2UKPiA+IFNDSEVEX0ZJRk8gc3RyaWN0bHkgZmF2b3JzIHRoZSBoaWdoZXItcHJpb3Jp
dHkgcnVubmFibGUgdGFzaywgb2ZmZW5zZSBjYW4KPiA+IG5ldmVyIGJlIHBpY2tlZC4KPiA+Cj4g
PiBQaW5uaW5nIG9mZmVuc2UgYXMgd2VsbCB3b3VsZCBiZSByZWR1bmRhbnQsIGl0IGRvZXNuJ3Qg
bWF0dGVyIHdoZXJlIG9mZmVuc2UKPiA+IGxhbmRzLCBiZWNhdXNlIGRlZmVuc2UgYWxyZWFkeSBj
b3ZlcnMgZXZlcnkgQ1BVLiBUaGlzIGFsc28gaGFzIHRoZSBhZHZhbnRhZ2UKPiA+IG9mIGxldHRp
bmcgdGhlIHNjaGVkdWxlciBmcmVlbHkgbWlncmF0ZSBvZmZlbnNlIHRocmVhZHMgd2l0aG91dAo+
ID4gYWZmZWN0aW5nIHRoZSB0ZXN0Cj4gPiBvdXRjb21lLCB3aGljaCBhdm9pZHMgaW50ZXJmZXJp
bmcgd2l0aCB0aGUga2VybmVsJ3MgbG9hZCBiYWxhbmNpbmcgbG9naWMgZHVyaW5nCj4gPiB0aGUg
dGVzdC4KPiA+Cj4gPiBBbmQsIEknZCBzdWdnZXN0IHVzaW5nIHRzdF9uY3B1c19hdmFpbGFibGUo
KSBpbnN0ZWFkIG9mIGdldF9udW1jcHVzKCkKPiA+IHdoZW4gZGlzdHJpYnV0aW5nIGRlZmVuc2Ug
dGhyZWFkcyBhY3Jvc3MgQ1BVcywgaW4gY2FzZSBzb21lIENQVXMgYXJlCj4gPiBvZmZsaW5lLiBQ
aW5uaW5nIGEgZGVmZW5zZSB0aHJlYWQgdG8gYW4gb2ZmbGluZSBDUFUgd291bGQgbGVhdmUgdGhh
dAo+ID4gQ1BVIHVuY292ZXJlZCBhbmQgYWxsb3cgb2ZmZW5zZSB0byBydW4gdW5jaGVja2VkLiBT
ZWU6CgpJIGRpZG4ndCBzZWUgdGhlIG9yaWduYWwgcGF0Y2ggaGVyZSwgYnV0IHRoZSB3aG9sZSBw
b2ludCBvZgpzY2hlZF9mb290YmFsbCBpcyB0byBlbnN1cmUgdGhlIHRvcCA8bnVtIGNwdT4gKHVu
YWZmaW5lZCkgcHJpb3JpdHkKdGFza3MgYXJlIGFsd2F5cyBydW4gYW5kIG5vIGxvd2VyIHByaW9y
aXR5IHJ0IHRhc2tzIGFyZSBydW4gaW5zdGVhZC4KClNvIG5vbmUgb2YgdGhlIHRhc2tzIHNob3Vs
ZCBiZSBwaW5uZWQgdG8gYW55IGNwdXMuIFRoZSBzY2hlZHVsZXIgaXMKc3VwcG9zZWQgdG8gZW5z
dXJlIHRoZSBSVCBpbnZhcmlhbnQgaG9sZHMuClRoZXJlIGFyZSBzb21lIGtub3duIGJ1Z3MgYXQg
dGhlIG1vbWVudCB0aGF0IHdpbGwgY2F1c2Ugc2NoZWRfZm9vdGJhbGwKdG8gZmFpbCAodGhlIFJU
X1BVU0hfSVBJIGZlYXR1cmUsIGZvciBpbnN0YW5jZSkuIFRoYXQncyBhIHByb2JsZW0gd2l0aAp0
aGUga2VybmVsLCBub3QgdGhlIHRlc3QuCgp0aGFua3MKLWpvaG4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
