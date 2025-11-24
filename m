Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B335CFA466
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763989163; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=V+MvYcZ2i3Eh3GvRGDV6D/SuP0roWI5u11fXNx/4M7c=;
 b=qBAxr9o3vOW3fg1+MIQO5Czv9KLHpFp53kHieA9LWX61vVFVF/OoK/rBRVCX2PVVsfKtO
 xQkyDVm2TeYBOdVk8pLj0/svnDsyi3lFdGmAX5D/XDRTTXBMtSz8HFZmc30t3uStOL4TbhU
 9tzzNskflNf0BOVdMpI1wE6MUQ/0uH4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89A503C83AA
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 13:59:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B54E3C7947
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 13:59:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59AA3100036D
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 13:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763989140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=piJaPPnnOqMCf5k9NlhPIbz53Q4XDOdsAXvCQFYDrfE=;
 b=dXXkdvTfKJ39vvGl68qm9q3rnXivIIB/f+yDQwDLsCTG9Uptgc8+G3Fj5zwviGEqkHEqNk
 3cnbyQLa76l5xsmpzcZh+7Y4hDJQ0i5uqZHMPEHRRn/ZvKGr+bLi4hRjUvJO/QkEe+l1Om
 xdjxcFpherkrsVeB1l49bTESeuF+p4E=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-lH-yypoVPLCooP9dS8RvPg-1; Mon, 24 Nov 2025 07:58:59 -0500
X-MC-Unique: lH-yypoVPLCooP9dS8RvPg-1
X-Mimecast-MFC-AGG-ID: lH-yypoVPLCooP9dS8RvPg_1763989138
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso7990238a12.3
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 04:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763989137; x=1764593937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piJaPPnnOqMCf5k9NlhPIbz53Q4XDOdsAXvCQFYDrfE=;
 b=ELQYwlnT1yCFTc+tTii0au1aXONAo0xIwNGdJbztFuradhpTBqbf3EriIeDGK+63k/
 EXwc03kLjIpCnhnIW/FLDYutTo57MqYMCWOIcbvIq+sxOc6b3s0soTl8ffLfFlWpacMz
 VfKb9mk69ClkS7unwQ1twn/2vrSLJx1yRRl/vTW3fSdXZmNeUqEIJ8iET0SmEpvluySf
 KKJw9oNy0TAZHIaTflIPy5cCaQ6OZn5BSDQq4+RuNSPvJ1kT4w4SU7pE1fePN8B8tf41
 5RlJRi3QkMNeOg4cf67smWmPk6P/tH2Sl2Pz+b4YrY36vOKW+1wh5Hs5xuSNJIe+VNAf
 8HHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHpy4iuExTQxuWfEzr09FIYtPkK6pJKHcqHBw/3cX43/XBS5CML+fZprWYoiKS+KTCPUU=@lists.linux.it
X-Gm-Message-State: AOJu0YwPKev5itwUWfun57IJtjydolKumsfPBYgi1pR3FEcoQu8bmtSo
 XqiH99BbSBA2AMQ5MVXxgnclO1Zw7beStIkCZAuv6qLKWetxNZlaptP0zuvblegjF9XD8wpzSij
 wn/V9ThA+02EtcHq30AS5VxRqq10OK7urb/AjAhEFPQesFeAASEvLBABloSDgg32jwojgdzwRej
 5+4tqMUGr27s7HhloVnWz97lM1UCn3EwNcbHOuDQ==
X-Gm-Gg: ASbGncsOihWvKTRjP/ECmpce1LlhI6f5VGYuVhzItQbJsGz8ZHUoTiU/hl/eniQFPVC
 o9g0uJKVbWPNtPcP9DBW2LJ2McrSD0dpUhMeDDCD19KQlnIovxo8XDz8s4tQ06Fc+UVcMAyFi4n
 Wre7xU7ZH3ntHk83rVCaKvm8JZkeZOzN8z3M/peCyqxhg3IQliYDhWbP3MR+oIQtHrqmQ=
X-Received: by 2002:a05:7301:29af:b0:2a4:3594:72e4 with SMTP id
 5a478bee46e88-2a719277102mr4529744eec.19.1763989136907; 
 Mon, 24 Nov 2025 04:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2Gxj8WasQ79uagkGXrwrFmeQUSisknL/TdmCA3ILllJWD7nVUMul8ndgoWbrcPwWp0f+g30A1nvwztf65WHo=
X-Received: by 2002:a05:7301:29af:b0:2a4:3594:72e4 with SMTP id
 5a478bee46e88-2a719277102mr4529729eec.19.1763989136419; Mon, 24 Nov 2025
 04:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan>
 <20251121104506.GA25561@pevik> <aSBQDg8PRXFK8GxB@yuki.lan>
In-Reply-To: <aSBQDg8PRXFK8GxB@yuki.lan>
Date: Mon, 24 Nov 2025 20:58:44 +0800
X-Gm-Features: AWmQ_bntuQxmv97vX3uzIHKk4LRIvHw1MZplTB50dkJnkwct22C3w8X2M7Az5nY
Message-ID: <CAEemH2fN=byf4dKvCk82KKuA9fRk0M6uh1GmMfiY2EPOk=X_Zg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bHw-gWGB0lFwB5r1S9L-5PkdfPPjowwRkmNEnayHFww_1763989138
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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

T24gRnJpLCBOb3YgMjEsIDIwMjUgYXQgNzo0MeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+IEFkZGluZyBhIHNob3J0IHNsZWVwIGlzIGEgZ29v
ZCBzdGFydC4gSG93ZXZlciBJJ20gYWZyYWlkIHRoYXQgd2Ugd2lsbAo+ID4gPiBuZWVkIGEgYml0
IG1vcmUgY29tcGxleCBzb2x1dGlvbiB0byB0aGlzIHByb2JsZW0uIE1heWJlIGRvIGEgc2hvcnQK
PiA+ID4gc2xlZXAsIGNoZWNrIHRoZSBjYWNoZSBzaXplIGFuZCBpZiBpdCBpbmNyZWFzZWQgbW9y
ZSB0aGFuIHNvbWUKPiA+ID4gdGhyZXNob2xkLCBzbGVlcCBhZ2Fpbi4KPiA+Cj4gPiA+IFNvbWV0
aGluZyBhczoKPiA+Cj4gPiA+ICAgICBpbnQgcmV0cmllcyA9IE1BWF9SRVRSSUVTOwo+ID4gPiAg
ICAgdW5zaWduZWQgbG9uZyBjYWNoZWRfcHJldiwgY2FjaGVkX2N1ciA9IGdldF9jYWNoZWRfc2l6
ZSgpOwo+ID4KPiA+ID4gICAgIGRvIHsKPiA+ID4gICAgICAgICAgICAgdXNsZWVwKFNIT1JUX1NM
RUVQKTsKPiA+Cj4gPiA+ICAgICAgICAgICAgIGNhY2hlZF9wcmV2ID0gY2FjaGVkX2N1cjsKPiA+
ID4gICAgICAgICAgICAgY2FjaGVkX2N1ciA9IGdldF9jYWNoZWRfc2l6ZSgpOwo+ID4KPiA+ID4g
ICAgICAgICAgICAgaWYgKGNhY2hlZF9jdXIgPCBjYWNoZWRfcHJldikKPiA+ID4gICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiA+Cj4gPiA+ICAgICAgICAgICAgIGlmIChjYWNoZWRfY3VyLWNh
Y2hlZF9wcmV2IDwgQ0FDSEVfSU5DX1RIUkVTSE9MRCkKPiA+ID4gICAgICAgICAgICAgICAgICAg
ICBicmVhazsKPiA+Cj4gPiA+ICAgICB9IHdoaWxlIChyZXRyaWVzLS0gPiAwKTsKPiA+Cj4gPiBZ
ZWFoLCBmZXcgbG9vcHMgd2l0aCBzaG9ydGVyIHVzbGVlcCgpIGFuZCBwcm9hY3RpdmUgY2hlY2tp
bmcgaXMgZm9yIHN1cmUKPiB3YXkKPiA+IGJldHRlciB0aGFuIHNpbmdsZSB1c2xlZXAoKS4gV2ls
bCB5b3UgcGxlYXNlIGhhdmUgdGltZSB0byBzZW5kIHRoZSBhYm92ZQo+IGFzIGEKPiA+IHBhdGNo
PyBJJ2xsIHRlc3QgaXQgZm9yIHlvdS4KPgo+IFRoZSBoYXJkIHBhcnQgaXMgdHVuaW5nIHRoZSBj
b25zdGFudHMgcmlnaHQuCj4KPiBJZiB3ZSBhc3N1bWUgdGhhdCBvbiB0aGUgc2xvd2VzdCBsb3cg
ZW5kIGRldmljZSB3ZSB3b3VsZCBnZXQgYXJvdW5kCj4gNU1CL3MgKHRoYXQncyBob3cgc2xvdyBT
RCBjYXJkIGluIFJQaSBjYW4gYXBwYXJlbnRseSBiZQo+IGh0dHBzOi8vZWxpbnV4Lm9yZy9SUGlf
U0RfY2FyZHMjU0RfY2FyZF9wZXJmb3JtYW5jZSkKPiBJZiB3ZSBhbGxvdyB0aGlzIHRvIGJlIGEg
Yml0IGxlc3MgcHJlY2lzZSB3ZSBjYW4gYXNzdW1lIHRoYXQgdGhlIHNwZWVkIGlzCj4gNSBieXRl
cyBwZXIgMSB1cyAoc2luY2UgVVNFQ19QRVJfU0VDIC8gQllURVNfSU5fTUIgaXMgcm91Z2h0bHkg
MSkuCj4KPiBGcm9tIHRoYXQgdGhlIG51bWJlciBvZiByZXRyaWVzIHNob3VsZCBiZSB0aGUgcmVh
ZGFoZWFkX3NpemUgLwo+ICg1KlNIT1JUX1NMRUVQKQo+IGFuZCBJIHdvdWxkIHB1dCB0aGUgc2hv
cnQgc2xlZXAgc29tZXdoZXJlIGFyb3VuZCB0aGUKPiBhIGZldyBtaWxpc2Vjb25kcyByYW5nZSwg
dGhhdCB3b3VsZCBtZWFuIHRoYXQgdGhlIG51bWJlciBvZiByZXRyaWVzCj4gd291bGQgZW5kIHVw
IGJldHdlZW4gdGhvdXNhbmQgYW5kIGh1bmRyZWQgd2hlbiByZWFkYWhlYWRfc2l6ZSBpcyBpbgo+
IG1lZ2FieXRlcy4gVGhpcyBhbHNvIG1lYW5zIHRoYXQgd2UgY2FuIGFzc3VtZSB0aGF0IHRoZSBt
aW5pbWFsIHNpemUgdG8KPiBiZSByZWFkIGluIG9uZSBsb29wIGlzIDUgKiBTTEVFUF9TSVpFIGJ5
dGVzLiBIb3dldmVyIHdpdGggU0xFRVBfVElNRSBpbgo+IGEgZmV3IG1pbGlzZWNvbmQgcmFuZ2Ug
dGhlIG1pbmltYWwgbnVtYmVyIG9mIGJ5dGVzIGlzIGluIHRoZSByYW5nZSBvZiBhCj4gZmV3IHBh
Z2VzIHNvIEkgZ3Vlc3MgdGhhdCB3ZSBjYW4gc2V0dGxlIGZvciBydW5uaW5nIHRoZSBsb29wIGZv
ciBhcyBsb25nCj4gYXMgdGhlIGNhY2hlIGluY3JlYXNlcy4KPgo+IFNvIEkgc3VwcG9zZSB0aGF0
IHdlIHdhbnQgc29tZXRoaW5nIGFzOgo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAyLmMKPiBpbmRleCBmMDA3ZGIxODcuLmEyMTE4YzVh
YiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFk
YWhlYWQwMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVh
ZGFoZWFkMDIuYwo+IEBAIC0zOSw2ICszOSw3IEBAIHN0YXRpYyBjaGFyIHRlc3RmaWxlW1BBVEhf
TUFYXSA9ICJ0ZXN0ZmlsZSI7Cj4gICNkZWZpbmUgTUVNSU5GT19GTkFNRSAiL3Byb2MvbWVtaW5m
byIKPiAgI2RlZmluZSBQUk9DX0lPX0ZOQU1FICIvcHJvYy9zZWxmL2lvIgo+ICAjZGVmaW5lIERF
RkFVTFRfRklMRVNJWkUgKDY0ICogMTAyNCAqIDEwMjQpCj4gKyNkZWZpbmUgU0hPUlRfU0xFRVBf
VVMgNTAwMAo+Cj4gIHN0YXRpYyBzaXplX3QgdGVzdGZpbGVfc2l6ZSA9IERFRkFVTFRfRklMRVNJ
WkU7Cj4gIHN0YXRpYyBjaGFyICpvcHRfZnNpemVzdHI7Cj4gQEAgLTE3Myw2ICsxNzQsMzggQEAg
c3RhdGljIGludCByZWFkX3Rlc3RmaWxlKHN0cnVjdCB0Y2FzZSAqdGMsIGludAo+IGRvX3JlYWRh
aGVhZCwKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGkrKzsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBvZmZzZXQgKz0gcmVhZGFoZWFkX2xlbmd0aDsKPiArCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgLyoKPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBXZSBhc3N1bWUgdGhhdCB0
aGUgd29yc3QgY2FzZSBJL08gc3BlZWQgaXMKPiBhcm91bmQKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgKiA1TUIvcyB3aGljaCBpcyByb3VnaGx5IDUgYnl0ZXMgcGVyIDEgdXMsIHdoaWNoCj4g
Z2l2ZXMKPiArICAgICAgICAgICAgICAgICAgICAgICAgKiB1cyB1cHBlciBib3VuZCBmb3IgcmV0
cmllcyB0aGF0IGlzCj4gcmVhZGFoZWFkX3NpemUvKDUKPiArICAgICAgICAgICAgICAgICAgICAg
ICAgKiBTSE9SVF9TTEVFUF9VUykuCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICoKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgKiBXZSBhbHNvIG1vbml0b3IgdGhlIGNhY2hlIHNpemUgaW5j
cmVhc2VzIGJlZm9yZQo+IGFuZAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGFmdGVyIHRo
ZSBzbGVlcC4gV2l0aCB0aGUgc2FtZSBhc3N1bXB0aW9uIGFib3V0Cj4gdGhlCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICogc3BlZWQgd2UgYXJlIHN1cHBvc2VkIHRvIHJlYWQgYXQgbGVhc3Qg
NSAqCj4gU0hPUlRfU0xFRVBfVVMKPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBkdXJpbmcg
dGhhdCB0aW1lLiBUaGF0IGFtb3VuZCBpcyBnZW5yZWFsbHkKPiBxdWl0ZSBjbG9zZQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAqIGEgcGFnZSBzaXplIHNvIHRoYXQgd2UganVzdCBhc3N1bWUK
PiArICAgICAgICAgICAgICAgICAgICAgICAgKgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAq
IE9mIGNvdXJzZSBhbGwgb2YgdGhpcyBpcyBpbnByZWNpc2Ugb24KPiBtdWx0aXRhc2tpbmcKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgKiBPUyBob3dldmVyIGV2ZW4gb24gYSBzeXN0ZW0gd2hl
cmUgdGhlcmUgYXJlCj4gc2V2ZXJhbAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHByb2Nl
c3NlcyBmaWd0aGluZyBmb3IgSS9PIHRoaXMgbG9vcCB3aWxsIHdhaXQKPiBhcwo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAqIGxvbmcgYSBjYWNoZSBpcyBpbmNyZWFzaW5nIHdoaWNoIHdpbGwg
Z2l2ZXMgdXMKPiBoaWdoCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogY2hhbmNlIG9mIHdh
aXRpbmcgZm9yIHRoZSByZWFkYWhlYWQgdG8gaGFwcGVuLgo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAqLwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGludCByZXRyaWVzID0gcmVhZGFoZWFk
X3NpemUgLyAoNSAqCj4gU0hPUlRfU0xFRVBfVVMpOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgY2FjaGVkX3ByZXYsIGNhY2hlZF9jdXIgPQo+IGdldF9jYWNoZWRfc2l6
ZSgpOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBkbyB7Cj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1c2xlZXAoU0hPUlRfU0xFRVBfVVMpOwo+ICsKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNhY2hlZF9wcmV2ID0gY2FjaGVkX2N1cjsKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNhY2hlZF9jdXIgPSBnZXRfY2FjaGVkX3NpemUoKTsK
PiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoY2FjaGVkX2N1ciA8PSBj
YWNoZWRfcHJldikKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfSB3aGlsZSAocmV0cmllcy0tID4gMCk7Cj4g
Kwo+ICAgICAgICAgICAgICAgICB9IHdoaWxlICgoc2l6ZV90KW9mZnNldCA8IGZzaXplKTsKPiAg
ICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgInJlYWRhaGVhZCBjYWxscyBtYWRlOiAlenUi
LCBpKTsKPiAgICAgICAgICAgICAgICAgKmNhY2hlZCA9IGdldF9jYWNoZWRfc2l6ZSgpOwo+Cj4K
PiBMaSwgSmFuIHdoYXQgZG8geW91IHRoaW5rPwo+CgoKVGhpcyBpcyBhIG5pY2UgaW1wcm92ZW1l
bnQsIGJ1dCBvbmUgdGhpbmcgY29tZXMgdG8gbXkgbWluZCB0aGF0CmdldF9jYWNoZWRfc2l6ZSgp
IHJlYWRzIHRoZSBzeXN0ZW0gd2lkZSDigJxDYWNoZWTigJ0gc2l6ZSBmcm9tCicvcHJvYy9tZW1p
bmZvJyBtaWdodCBub3QgYmUgcmVsaWFibGUgaW4gdGhlIHRlc3QgKHByb2JiYWx5IGltcGFjdApm
cm9tIG90aGVyIHByb2dyZXNzKS4KClNvLCBob3cgYWJvdXQgdXNpbmcgbWluY29yZSgpIHdvcmtz
IG9uIHRoZSBjdXJyZW50bHkgbWFwcGVkIHBhZ2VzCnRvIGNvdW50IHRoZSByZXNpZGVudCBieXRl
cyBpbiBtZW1vcnk/CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
