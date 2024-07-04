Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF2DC30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 07:53:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEFDC3D3CD1
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 09:53:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C913D3CC6
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:53:36 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A1A921400BDE
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720079614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AJXJSxl2KTlyyA3oksZ3gRxaMbQj1MNC0YtsvSDS4U=;
 b=K+WG4ksADQlbDuRU9PbnZ0lFhcClaEog2/GSxSzFx3R766Pwrxp43mtsFIhlOY4NWuzr7i
 Vm/Wagy8HkPqnbObh2UB8Zs95Ua116Kp0jzIfIfmXXgFJ/l7KwyezJjUcP6Lx0i74UzMM5
 Yk2jaT7Q7GBM/8ko+i2Vt3ISZnMrAXA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-lWTBUC__Nsy6oAO0-P4lcw-1; Thu, 04 Jul 2024 03:53:31 -0400
X-MC-Unique: lWTBUC__Nsy6oAO0-P4lcw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a726756c8a2so30171666b.2
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 00:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079608; x=1720684408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5AJXJSxl2KTlyyA3oksZ3gRxaMbQj1MNC0YtsvSDS4U=;
 b=RdQI1bzVoel0/lazVT1OYqELXWSe9Ui5ziIt4ntmWxtH8/8lrIsUOkH9Vcs7HnCCRZ
 oQbhOmPOMMB3Q2XOMISQywGx1YPel22btC1krBVB18/Z3k2BHakHifpIEYH+vJ9Zc8wx
 JJFIUE+ltxoucnCItLbaCpkZK9DoB3p5TbOVycfBL4Xdmghcrm+jwki0RMeEBPbeXLaT
 03nPQiU8+U0+IaWk+c2RF7xsxlGZODXyiKZi4cMf9pIk9T/wwrEqE0PbP+6XC1KkwJYO
 FZNphdGo8JqATgHz76XUm2l+S2CWxewlqU19SwNETYdHjEM1NiJri6QAg+Nouulo0j3T
 fKqw==
X-Gm-Message-State: AOJu0Yxs7p1BDrGj75/4SVoQO8KqVre6mIesbNenY/Lsd1xw/9lJWELn
 c8xLvsFM/yRERR1gnUeVGirkLKwgk5OQpQk3Oey7MK2LE974CxGI1tzhDXFvKt/WUnDivxR5rqe
 MBEi9wZMRN5ObyE62qv4xXay04S5+mm2/tFL5Oc3+0uXCA7zFKS5aiWjVS1blK5yU3+afADzsWL
 G5Mnoo2FXg7XuYH2WEQXaBMSmDzUbCBpFndUB5
X-Received: by 2002:a17:906:f119:b0:a77:c080:1200 with SMTP id
 a640c23a62f3a-a77c0801299mr25034666b.31.1720079608483; 
 Thu, 04 Jul 2024 00:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEla3NjCjH1Uv2Ryy4+K0/bnqq0liMOSayEO/XHHmSm7hvqtQZ0cv1V+jsavxF88jI9bIbCQxdR29O1ffN0xT4=
X-Received: by 2002:a17:906:f119:b0:a77:c080:1200 with SMTP id
 a640c23a62f3a-a77c0801299mr25032466b.31.1720079608041; Thu, 04 Jul 2024
 00:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240626010532.2845919-1-samasth.norway.ananda@oracle.com>
In-Reply-To: <20240626010532.2845919-1-samasth.norway.ananda@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 15:53:14 +0800
Message-ID: <CAEemH2fskxgP9cFB-8zztts1qqtCJ2g01A=4+w6OxU6O_pE-9w@mail.gmail.com>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] fallocate03: FALLOC_FL_PUNCH_HOLE must be used
 with FALLOC_FL_KEEP_SIZE
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

SGkgU2FtYXN0aCwKClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSwgYmFzZSBvbiB5b3VyIHRlc3Qg
ZmFpbHVyZSwgd2hpY2gga2VybmVsIHZlcnNpb24KYW5kCkZTLXR5cGUgZGlkIHlvdSB1c2U/CgpG
cm9tIHRoZSBmYWxsb2NhdGUoKSBtYW51YWwsIEkgc2VlIHRoYXQ6CiAgIlRoZSBGQUxMT0NfRkxf
UFVOQ0hfSE9MRSBmbGFnIG11c3QgYmUgT1JlZCB3aXRoIEZBTExPQ19GTF9LRUVQX1NJWkUgaW4K
bW9kZSIKCkJ1dCBpdCBkb2Vzbid0IG1lYW4gd2Ugd291bGRuJ3QgdXNlIEZBTExPQ19GTF9LRUVQ
X1NJWkUgc2luZ2x5IGluIHRoaXMgdGVzdC4KCgoKT24gV2VkLCBKdW4gMjYsIDIwMjQgYXQgOTow
NuKAr0FNIFNhbWFzdGggTm9yd2F5IEFuYW5kYSB2aWEgbHRwIDwKbHRwQGxpc3RzLmxpbnV4Lml0
PiB3cm90ZToKCj4gVGhlIGZhbGxvY2F0ZTAzIGx0cCB0ZXN0IGZhaWxzIHdpdGggImZhaWxlZDog
RU9QTk9UU1VQUCIgaWYgd2UganVzdCB1c2UKPiBGQUxMT0NfRkxfS0VFUF9TSVpFIGZvciB0aGUg
bW9kZSBpbnN0ZWFkIG9mIE9SaW5nIGl0IHdpdGgKPiBGQUxMT0NfRkxfUFVOQ0hfSE9MRS4KPgo+
IFNpZ25lZC1vZmYtYnk6IFNhbWFzdGggTm9yd2F5IEFuYW5kYSA8c2FtYXN0aC5ub3J3YXkuYW5h
bmRhQG9yYWNsZS5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFsbG9j
YXRlL2ZhbGxvY2F0ZTAzLmMgfCAxMCArKysrKy0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDMuYwo+IGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYWxsb2NhdGUvZmFsbG9jYXRlMDMuYwo+IGluZGV4IGIzZTZiMzgxNy4uMjBj
ZTEzY2Q0IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFsbG9jYXRl
L2ZhbGxvY2F0ZTAzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZhbGxvY2F0
ZS9mYWxsb2NhdGUwMy5jCj4gQEAgLTMwLDEwICszMCwxMCBAQCBzdGF0aWMgc3RydWN0IHRlc3Rf
Y2FzZSB7Cj4gICAgICAgICB7REVGQVVMVF9NT0RFLCBCTE9DS1NfV1JJVFRFTn0sCj4gICAgICAg
ICB7REVGQVVMVF9NT0RFLCBCTE9DS1NfV1JJVFRFTiArIEhPTEVfU0laRV9JTl9CTE9DS1MgLyAy
IC0gMX0sCj4gICAgICAgICB7REVGQVVMVF9NT0RFLCBCTE9DS1NfV1JJVFRFTiArIEhPTEVfU0la
RV9JTl9CTE9DS1MgKyAxfSwKPiAtICAgICAgIHtGQUxMT0NfRkxfS0VFUF9TSVpFLCAyfSwKPiAt
ICAgICAgIHtGQUxMT0NfRkxfS0VFUF9TSVpFLCBCTE9DS1NfV1JJVFRFTn0sCj4gLSAgICAgICB7
RkFMTE9DX0ZMX0tFRVBfU0laRSwgQkxPQ0tTX1dSSVRURU4gKyBIT0xFX1NJWkVfSU5fQkxPQ0tT
IC8gMiArCj4gMX0sCj4gLSAgICAgICB7RkFMTE9DX0ZMX0tFRVBfU0laRSwgQkxPQ0tTX1dSSVRU
RU4gKyBIT0xFX1NJWkVfSU5fQkxPQ0tTICsgMn0KPiArICAgICAgIHtGQUxMT0NfRkxfS0VFUF9T
SVpFIHwgRkFMTE9DX0ZMX1BVTkNIX0hPTEUsIDJ9LAo+ICsgICAgICAge0ZBTExPQ19GTF9LRUVQ
X1NJWkUgfCBGQUxMT0NfRkxfUFVOQ0hfSE9MRSwgQkxPQ0tTX1dSSVRURU59LAo+ICsgICAgICAg
e0ZBTExPQ19GTF9LRUVQX1NJWkUgfCBGQUxMT0NfRkxfUFVOQ0hfSE9MRSwgQkxPQ0tTX1dSSVRU
RU4gKwo+IEhPTEVfU0laRV9JTl9CTE9DS1MgLyAyICsgMX0sCj4gKyAgICAgICB7RkFMTE9DX0ZM
X0tFRVBfU0laRSB8IEZBTExPQ19GTF9QVU5DSF9IT0xFLCBCTE9DS1NfV1JJVFRFTiArCj4gSE9M
RV9TSVpFX0lOX0JMT0NLUyArIDJ9Cj4gIH07Cj4KPiAgc3RhdGljIGludCBibG9ja19zaXplOwo+
IEBAIC04Miw3ICs4Miw3IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9mYWxsb2NhdGUodW5zaWduZWQg
aW50IG5yKQo+ICAgICAgICAgVFNUX0VYUF9QQVNTKAo+ICAgICAgICAgICAgICAgICBmYWxsb2Nh
dGUoZmQsIHRjLT5tb2RlLCB0Yy0+b2Zmc2V0ICogYmxvY2tfc2l6ZSwKPiBibG9ja19zaXplKSwK
PiAgICAgICAgICAgICAgICAgImZhbGxvY2F0ZShmZCwgJXMsICVsZCwgJWQpIiwKPiAtICAgICAg
ICAgICAgICAgdGMtPm1vZGUgPyAiRkFMTE9DX0ZMX0tFRVBfU0laRSIgOiAiREVGQVVMVF9NT0RF
IiwKPiArICAgICAgICAgICAgICAgdGMtPm1vZGUgPyAiRkFMTE9DX0ZMX0tFRVBfU0laRSB8IEZB
TExPQ19GTF9QVU5DSF9IT0xFIiA6Cj4gIkRFRkFVTFRfTU9ERSIsCj4gICAgICAgICAgICAgICAg
IHRjLT5vZmZzZXQgKiBibG9ja19zaXplLCBibG9ja19zaXplKTsKPiAgfQo+Cj4gLS0KPiAyLjQ1
LjIKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
