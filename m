Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A17C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 07:57:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCAE53C9DF8
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 08:57:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30723C268C
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 08:57:22 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58FC9655073
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 08:57:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740729439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V24R8Sgj9LEwBA/biB+X2NoY+l3NptpHiaHj3ayP3cM=;
 b=UmyXsPzN5JVuRxCuu6QxLqee+3T/781pAOD2FDP5FFIQ0CtFXVTOGkTnmaM4nKMzDujuKi
 h0hD0C/1fYtOJgIJpIa9AfjAkNMGV4MDH9W2SsCEdxZ48OD+PBb3xDiiKaWFR94JkgFsBG
 tuPBzn/RfIssePo9mGlND33l8JVBjYY=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-L8_3SZgSNdCGcMi92m-f7w-1; Fri, 28 Feb 2025 02:57:09 -0500
X-MC-Unique: L8_3SZgSNdCGcMi92m-f7w-1
X-Mimecast-MFC-AGG-ID: L8_3SZgSNdCGcMi92m-f7w_1740729428
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-86b3fb9df93so426677241.3
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 23:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740729428; x=1741334228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V24R8Sgj9LEwBA/biB+X2NoY+l3NptpHiaHj3ayP3cM=;
 b=QCMhWoh7KjdV36DyRBOK/NrKD1XXC7UUebEAFe2XwIG5AXyuXWPa6Tuk0IBwuzg4nH
 hdRFXjxdzqeI8yXVn2hKheoO/6IRjvsUf7GM8vZ3oezmRNZ/JjSJoZVYO4N7htwb2zax
 9e37XCmAvk9bKqIJACAL9IUCSUy9ponCN4h21t6TujmJK08IGtKtdmAMW3k/OEGmrnmQ
 KqbOaZuThaOJo/vtrzNRl7VwvQrdm8Mi5Zh8XiYWATLeQDITDyg5/sdlGdnXvqi9kL3m
 BMPrjGMwTHuwUX5GsFilZEllIW//Br3HuivQmMPHg8ubDWYs7x6AmIq9wm+6OpB2fUmK
 aQ9Q==
X-Gm-Message-State: AOJu0Yz8NOE+y2Smmt7dfTFjUYa0VNZvLKY+wrdfkHaewBKKIi1nXCgC
 Ya2SCzh7gfLj7BY68ek1PmqKFqm3s2aQKywDLfgjRUwZstrOWpKNmGyKIYyjMbwsJTbwXWxhJE8
 2x67NNlgJEPKrm37mI5AzfxiZGlBzQ2GrljrAxB+sqXhuKjqG3QPYN1DliUxnZoRRnJyC37/G2X
 l6g2SzRrZFAC0lrVd1RMl9oco=
X-Gm-Gg: ASbGncuADXZGGxqAGH2xMmbUzQCbiKDRQS7zztl1VoFGgm5DAQU0i9Ov7RhGENeAsB0
 TC4k2fXFR42w4OjHan6+Ze6ix/bXpQ5BK+ssD30uB0VLFoS8cL1j1jyT4jWWYUUCOS3qtKJLT
X-Received: by 2002:a05:6102:578d:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4c044850b24mr1855635137.2.1740729428558; 
 Thu, 27 Feb 2025 23:57:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH54rmxpPiH9IhCjskaHDFaNWMUoSAwZTFy8ENI1Es5qXwXaZxj3WiV3v9ae+lLds0Emlix8XAZ0fhsCKf3GEY=
X-Received: by 2002:a05:6102:578d:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4c044850b24mr1855625137.2.1740729428074; Thu, 27 Feb 2025
 23:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20250227170524.3168535-1-pvorel@suse.cz>
In-Reply-To: <20250227170524.3168535-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 28 Feb 2025 08:56:52 +0100
X-Gm-Features: AQ5f1JpxKzaAKVR5iZypGVLVxxornkWQJPO9Jry8ym-h4SvjHfZXSbJscW9GH0k
Message-ID: <CAASaF6z-HOjvsrZX0XXdVzUVo-Krt73O=tmA+3dW32M-e03sqg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BhRCtlb78o0WkUq6M9cQvjJfw2nzyx6Si9uMhMLdslI_1740729428
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] include: Move safe_mmap into
 tst_safe_macros_inline.h
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

T24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgNjowNeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IHRzdF9zYWZlX21hY3Jvc19pbmxpbmUuaCBjb250YWlucyBmdW5jdGlv
bnMgd2hpY2ggYXJlIGZvcmNlZCB0byBiZQo+ICdpbmxpbmUnIGJlY2F1c2UgdGhlIGJlaGF2aW91
ciBtYXkgZGVwZW5kIG9uIC1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQKPiBjb21waWxlIGZsYWcgKHR5
cGUgb2ZmX3Qgb3Igc3RydWN0dXJlcyBjb250YWluaW5nIG9mZl90IGZpZWxkcykuCj4gc2FmZV9t
bWFwKCkgd2FzIGxlZnQgZnJvbSB0aGlzIGNvbnZlcnNpb24uCj4KPiBGaXhlczogM2Y1NzFkYTI4
ZCAoImluY2x1ZGU6IE1vdmUgaW5saW5lIGZ1bmN0aW9ucyB0byBzcGVjaWFsIGhlYWRlciIpCj4g
U2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpBY2tlZC1ieTogSmFu
IFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cgo+IC0tLQo+IENoYW5nZXMgdjEtPnYyOgo+
ICogRml4IGJ1aWxkIGJ5IG1vdmluZyBhbHNvIHRzdF9wcm90X3RvX3N0cigpIHNpZ25hdHVyZS4K
Pgo+IExpbmsgdG8gdjEKPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRw
L3BhdGNoLzIwMjUwMjI3MTY1ODE3LjMxNjY0MDMtMS1wdm9yZWxAc3VzZS5jei8KPgo+IFRlc3Rl
ZDoKPiBodHRwczovL2dpdGh1Yi5jb20vcGV2aWsvbHRwL2FjdGlvbnMvcnVucy8xMzU3MTg1Mzc4
OQo+Cj4gIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggICAgICAgIHwgMjkgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiAgaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3NfaW5saW5lLmggfCAy
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3Rf
c2FmZV9tYWNyb3MuaCBiL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKPiBpbmRleCA2OTg1YWE0
YmQ4Li4zYjAyZjg2Yzc2IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgK
PiArKysgYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCj4gQEAgLTI3MSwzNSArMjcxLDYgQEAg
aW50IHNhZmVfZ2V0Z3JvdXBzKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGlu
dCBzaXplLCBnaWRfdCBsaXN0W10pOwo+ICAgICAgICAgICAgICAgICAgICAgImZjbnRsKCVpLCVz
LC4uLikgZmFpbGVkIiwgZmQsICNjbWQpLCAwIFwKPiAgICAgICAgICA6IHRzdF9yZXRfO30pCj4K
PiAtdm9pZCB0c3RfcHJvdF90b19zdHIoY29uc3QgaW50IHByb3QsIGNoYXIgKmJ1Zik7Cj4gLQo+
IC1zdGF0aWMgaW5saW5lIHZvaWQgKnNhZmVfbW1hcChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLAo+IC0gICAgICAgdm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCwgaW50IHByb3Qs
IGludCBmbGFncywgaW50IGZkLCBvZmZfdCBvZmZzZXQpCj4gLXsKPiAtICAgICAgIHZvaWQgKnJ2
YWw7Cj4gLSAgICAgICBjaGFyIHByb3RfYnVmWzUxMl07Cj4gLQo+IC0gICAgICAgdHN0X3Byb3Rf
dG9fc3RyKHByb3QsIHByb3RfYnVmKTsKPiAtCj4gLSAgICAgICB0c3RfcmVzXyhmaWxlLCBsaW5l
bm8sIFRERUJVRywKPiAtICAgICAgICAgICAgICAgIm1tYXAoJXAsICV6dSwgJXMoJXgpLCAlZCwg
JWQsICVsbGQpIiwKPiAtICAgICAgICAgICAgICAgYWRkciwgbGVuZ3RoLCBwcm90X2J1ZiwgcHJv
dCwgZmxhZ3MsIGZkLCAobG9uZyBsb25nIGludClvZmZzZXQpOwo+IC0KPiAtICAgICAgIHJ2YWwg
PSBtbWFwKGFkZHIsIGxlbmd0aCwgcHJvdCwgZmxhZ3MsIGZkLCBvZmZzZXQpOwo+IC0gICAgICAg
aWYgKHJ2YWwgPT0gTUFQX0ZBSUxFRCkgewo+IC0gICAgICAgICAgICAgICB0c3RfYnJrXyhmaWxl
LCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICJtbWFw
KCVwLCV6dSwlcygleCksJWQsJWQsJWxkKSBmYWlsZWQiLAo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGFkZHIsIGxlbmd0aCwgcHJvdF9idWYsIHByb3QsIGZsYWdzLCBmZCwgKGxvbmcpIG9mZnNl
dCk7Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgcmV0dXJuIHJ2YWw7Cj4gLX0KPiAtCj4gLQo+
IC0jZGVmaW5lIFNBRkVfTU1BUChhZGRyLCBsZW5ndGgsIHByb3QsIGZsYWdzLCBmZCwgb2Zmc2V0
KSBcCj4gLSAgICAgICBzYWZlX21tYXAoX19GSUxFX18sIF9fTElORV9fLCAoYWRkciksIChsZW5n
dGgpLCAocHJvdCksIFwKPiAtICAgICAgIChmbGFncyksIChmZCksIChvZmZzZXQpKQo+IC0KPiAg
aW50IHNhZmVfbXByb3RlY3QoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiAg
ICAgICAgIGNoYXIgKmFkZHIsIHNpemVfdCBsZW4sIGludCBwcm90KTsKPgo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvc19pbmxpbmUuaCBiL2luY2x1ZGUvdHN0X3NhZmVfbWFj
cm9zX2lubGluZS5oCj4gaW5kZXggNWVlZDNhMThkMC4uMTViNzU2ODYwZSAxMDA2NDQKPiAtLS0g
YS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvc19pbmxpbmUuaAo+ICsrKyBiL2luY2x1ZGUvdHN0X3Nh
ZmVfbWFjcm9zX2lubGluZS5oCj4gQEAgLTIyNyw0ICsyMjcsMzIgQEAgc3RhdGljIGlubGluZSBp
bnQgc2FmZV9zZXRybGltaXQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiAg
I2RlZmluZSBTQUZFX1NFVFJMSU1JVChyZXNvdXJjZSwgcmxpbSkgXAo+ICAgICAgICAgc2FmZV9z
ZXRybGltaXQoX19GSUxFX18sIF9fTElORV9fLCAocmVzb3VyY2UpLCAocmxpbSkpCj4KPiArdm9p
ZCB0c3RfcHJvdF90b19zdHIoY29uc3QgaW50IHByb3QsIGNoYXIgKmJ1Zik7Cj4gKwo+ICtzdGF0
aWMgaW5saW5lIHZvaWQgKnNhZmVfbW1hcChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGlu
ZW5vLAo+ICsgICAgICAgdm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCwgaW50IHByb3QsIGludCBm
bGFncywgaW50IGZkLCBvZmZfdCBvZmZzZXQpCj4gK3sKPiArICAgICAgIHZvaWQgKnJ2YWw7Cj4g
KyAgICAgICBjaGFyIHByb3RfYnVmWzUxMl07Cj4gKwo+ICsgICAgICAgdHN0X3Byb3RfdG9fc3Ry
KHByb3QsIHByb3RfYnVmKTsKPiArCj4gKyAgICAgICB0c3RfcmVzXyhmaWxlLCBsaW5lbm8sIFRE
RUJVRywKPiArICAgICAgICAgICAgICAgIm1tYXAoJXAsICV6dSwgJXMoJXgpLCAlZCwgJWQsICVs
bGQpIiwKPiArICAgICAgICAgICAgICAgYWRkciwgbGVuZ3RoLCBwcm90X2J1ZiwgcHJvdCwgZmxh
Z3MsIGZkLCAobG9uZyBsb25nIGludClvZmZzZXQpOwo+ICsKPiArICAgICAgIHJ2YWwgPSBtbWFw
KGFkZHIsIGxlbmd0aCwgcHJvdCwgZmxhZ3MsIGZkLCBvZmZzZXQpOwo+ICsgICAgICAgaWYgKHJ2
YWwgPT0gTUFQX0ZBSUxFRCkgewo+ICsgICAgICAgICAgICAgICB0c3RfYnJrXyhmaWxlLCBsaW5l
bm8sIFRCUk9LIHwgVEVSUk5PLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICJtbWFwKCVwLCV6
dSwlcygleCksJWQsJWQsJWxkKSBmYWlsZWQiLAo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFk
ZHIsIGxlbmd0aCwgcHJvdF9idWYsIHByb3QsIGZsYWdzLCBmZCwgKGxvbmcpIG9mZnNldCk7Cj4g
KyAgICAgICB9Cj4gKwo+ICsgICAgICAgcmV0dXJuIHJ2YWw7Cj4gK30KPiArCj4gKyNkZWZpbmUg
U0FGRV9NTUFQKGFkZHIsIGxlbmd0aCwgcHJvdCwgZmxhZ3MsIGZkLCBvZmZzZXQpIFwKPiArICAg
ICAgIHNhZmVfbW1hcChfX0ZJTEVfXywgX19MSU5FX18sIChhZGRyKSwgKGxlbmd0aCksIChwcm90
KSwgXAo+ICsgICAgICAgKGZsYWdzKSwgKGZkKSwgKG9mZnNldCkpCj4gKwo+ICAjZW5kaWYgLyog
VFNUX1NBRkVfTUFDUk9TX0lOTElORV9IX18gKi8KPiAtLQo+IDIuNDcuMgo+CgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
