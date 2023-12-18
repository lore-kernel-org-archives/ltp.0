Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020DFC46CA2
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 03:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A42DB3CF391
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 04:41:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC5E3CBADF
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 04:41:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A0A956010E9
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 04:41:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702870889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2fyyeOrUmzZ7nS7x9clG32i84v5PQXlFrOzVkcM8yo8=;
 b=cXxcyja8m0vIswlJsiqa38Ss1nUcVrbeAGaNVhkNInKcCwru50jWKQzazob5SpwkCH6Zpe
 IHo+M7Huqw9vcyf/TxHPE6jr7l9/m2LS3Zphf8MrefvGmBGwvQyWiLRIJS/tV8N7cMOlkK
 iHAlwkoUIFiQmK/icczk71W4GrAf9k8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-MQxgOJ7hOvyXP8NboQje6Q-1; Sun, 17 Dec 2023 22:41:26 -0500
X-MC-Unique: MQxgOJ7hOvyXP8NboQje6Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50bfda09704so2144214e87.1
 for <ltp@lists.linux.it>; Sun, 17 Dec 2023 19:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702870885; x=1703475685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2fyyeOrUmzZ7nS7x9clG32i84v5PQXlFrOzVkcM8yo8=;
 b=wLqBpz+NYuceD1PsfG2/7NPgP6lUUn/G4homkTylOW4z7Mh9FnogROyP5IzNfcDE4K
 LG7dBM9Z6ifJzd6hsU7TEuyySgxt+pdTL5a8AqGSM0UanOoLzAjF7uotvxafSsRjDrN1
 uAcCC6H1AeV8TAxa/hs5lFdw2gJORF5s8CWX2qYX8Jc51vr+qk74ssNjlAanXOMABQiU
 nnD+8RwHWWDlYm7/z4toi2/wxQRjNGwwlR7Fgd5KQwlcnhVNbUo6xjgGIGwq8wDtqI6N
 puyiqtRyX+vz0WuOErx9Yz0X9T4P0XmzHr1cnvi9dmGGFu4L2SkNyQ+J/oiLw1ZThyR3
 1bLg==
X-Gm-Message-State: AOJu0YzxahIwc5ybI2HrrlBbNEsgyjA8pbNFT6by0vDIpa4Lc9tu0HyZ
 htYXgpf9+2VeQ3hBPq8AgW1i/bwcxvpjrqIMKkTXrK8AvqIgvJf0aBfKzG8ZBSEIw3q1sGlevqd
 q+X+P+pBf0lTjaViTDNPl9h7l7Lg=
X-Received: by 2002:a05:6512:ba8:b0:50c:d30:3a05 with SMTP id
 b40-20020a0565120ba800b0050c0d303a05mr9666539lfv.25.1702870885378; 
 Sun, 17 Dec 2023 19:41:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhI4reFTEoD5oDvJDyQqjpOZMpN+zPz66TTQM4eUigtocsB6FIDmsqLUU0zjqzSQjp5RzRX8a9qlt+YrTjRBk=
X-Received: by 2002:a05:6512:ba8:b0:50c:d30:3a05 with SMTP id
 b40-20020a0565120ba800b0050c0d303a05mr9666533lfv.25.1702870884963; Sun, 17
 Dec 2023 19:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-2-wegao@suse.com> <20231215185749.GA58273@pevik>
In-Reply-To: <20231215185749.GA58273@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 11:41:12 +0800
Message-ID: <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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

SGkgUGV0ciwgQWxsLAoKT24gU2F0LCBEZWMgMTYsIDIwMjMgYXQgMjo1OOKAr0FNIFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgV2VpLAo+Cj4gLi4uCj4gPiArKysgYi9p
bmNsdWRlL3RzdF9tZW11dGlscy5oCj4gPiBAQCAtNTgsNCArNTgsMTAgQEAgdm9pZCB0c3RfZW5h
YmxlX29vbV9wcm90ZWN0aW9uKHBpZF90IHBpZCk7Cj4gPiAgICovCj4gPiAgdm9pZCB0c3RfZGlz
YWJsZV9vb21fcHJvdGVjdGlvbihwaWRfdCBwaWQpOwo+Cj4gPiArdm9pZCB0c3RfcHJpbnRfbWVt
aW5mbyh2b2lkKTsKPiA+ICsKPiA+ICt2b2lkIHRzdF9wcmludF9tZW1pbmZvXyhjb25zdCBjaGFy
ICpmaWxlLCBjb25zdCBpbnQgbGluZW5vKTsKPiA+ICsKPiA+ICsjZGVmaW5lIHRzdF9wcmludF9t
ZW1pbmZvKCkgdHN0X3ByaW50X21lbWluZm9fKF9fRklMRV9fLCBfX0xJTkVfXykKPiBNb3N0IG9m
IHRoZSBtYWNyb3Mgd2UgaGF2ZSB1cHBlciBjYXNlLCBjYW4gaXQgYmUgcGxlYXNlCj4gVFNUX1BS
SU5UX01FTUlORk8oKSA/Cj4gSSBndWVzcyBpdCBkb2VzIG5vdCBoYXZlIHRvIGJlIFNBRkVfUFJJ
TlRfTUVNSU5GTygpLgo+Cj4gQW5kIGJlY2F1c2UgaXQncyBqdXN0IG9uZSBsaW5lciwgY291bGQg
aXQgYmU6Cj4KPiAjZGVmaW5lIFRTVF9QUklOVF9NRU1JTkZPKCkgc2FmZV9wcmludF9maWxlKF9f
RklMRV9fLCBfX0xJTkVfXywKPiAiL3Byb2MvbWVtaW5mbyIpCj4KPiAuLi4KPgo+ID4gKysrIGIv
bGliL3NhZmVfbWFjcm9zLmMKPgo+IFdlIGRvbid0IHdhbnQgdG8gYWRkIGFueXRoaW5nIHRvIHRo
ZSBsZWdhY3kgQVBJIChvdGhlcndpc2UgaXQgd291bGQgZ28gdG8KPiBsaWIvc2FmZV9maWxlX29w
cy5jKSwgcGxlYXNlIGFkZCB0aGlzIHRvIGxpYi90c3Rfc2FmZV9tYWNyb3MuYy4KPgo+IEJUVyBJ
J20gc2xpZ2h0bHkgY29uZnVzZWQsIHdoYXQgd291bGQgYmUgdGhlIGJlc3QgcGxhY2UgZm9yIHRo
aXMsCj4gbGliL3RzdF9zYWZlX21hY3Jvcy5jIGlzIGJlaW5nIHVzZWQgbm93YWRheXMgZm9yIGV2
ZXJ5dGhpbmcuIEJ1dCB0aGVyZSBpcwo+IGFsc28KPgoKCj4gaW5jbHVkZS90c3Rfc2FmZV9maWxl
X29wcy5oLCB3aGljaCBkb2VzIG5vdCBoYXZlIEMgZmlsZQo+IChsaWIvdHN0X3NhZmVfZmlsZV9v
cHMuYykgYmVjYXVzZSBpdCBpbnRlcm5hbGx5IHVzZSBsaWIvdHN0X3NhZmVfbWFjcm9zLmMuCj4K
Ck5vLCBiYXNpY2FsbHkgaXQgZG9lcyBub3QgdXNlIHRoZSBsaWIvdHN0X3NhZmVfbWFjcm9zLmMu
CgpGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCAndHN0X3NhZmVfZmlsZV9vcHMuaCcgaXMganVzdCBh
IGhlYWRlciBmb3IKY29sbGVjdGluZwphbGwgdGhlIGZpbGUgb3BlcmF0aW9ucyBmb3IgTGludXgs
IGl0IGRvZXNuJ3QgdG91Y2ggb3RoZXIgc3ViY29tcG9uZW50IG9wcy4KCid0c3Rfc2FmZV9maWxl
X29wcy5oJyBkZWZpbmVzIG1hY3JvcyBmb3IgYWxsIGZ1bmN0aW9ucyBpbgonc2FmZV9maWxlX29w
c19mbi5oJwphbmQgYXJjaGl2ZWQgdGhlbSBpbiAnc2FmZV9maWxlX29wcy5jJyBsaWIuCgpTb21l
dGhpbmcgbGlrZSB0aGlzIGNvbWJpbmF0aW9uOgoKdHN0X3NhZmVfZmlsZV9vcHMuaDoKICAgIHNh
ZmVfZmlsZV9vcHNfZm4uaAogICAgc2FmZV9maWxlX29wcy5jCgp0c3Rfc2FmZV9tYWNyb3MuaAp0
c3Rfc2FmZV9tYWNyb3MuYwoKCgo+IEkgZ3Vlc3MgY3JlYXRpbmcgbGliL3RzdF9zYWZlX21hY3Jv
cy5jIHdhcyBwb3N0cG9uZWQgdW50aWwgd2UgcmV3cml0ZSBhbGwKPiB0ZXN0cywKPiBtYXliZSBp
dCdzIGEgdGltZSB0byBjcmVhdGUgaXQuCj4KCgoKPiBATGkgQEN5cmlsOiBBbHNvIGluY2x1ZGUv
dHN0X3NhZmVfZmlsZV9vcHMuaCBoYXMgU0FGRV9SRUFEX01FTUlORk8oKSBhbmQKPiBTQUZFX1JF
QURfUFJPQ19TVEFUVVMoKSwgSU1ITyB0aGVzZSBzaG91bGQgYmUgaW4gaW5jbHVkZS90c3RfbWVt
dXRpbHMuaC4KPiBPciwgd2Ugc2hvdWxkbid0IGhhdmUgMiBoZWFkZXJzIGZvciBzaW1pbGFyIHRo
aW5nLCBpdCB3b3VsZCBiZSBnb29kIHRvCj4gbWVyZ2UKPiB0aGVzZSB0d28uCj4KCkFncmVlZCwg
YW55dGhpbmcgcmVsYXRlZCB0byB0aGUgZGVkaWNhdGVkIG9wcyBzaG91bGQgYmUgcHV0IGludG8g
dGhlCmNvcnJlc3BvbmRpbmcgaGVhZGVyIGZpbGVzLiB0c3Rfc2FmZV9maWxlX29wcy5oIGlzIGEg
Z2VuZXJpYyBvcGVyYXRpb24KZm9yIExpbnV4IChidXQgbm90IGZvciBzcGVjaWZpYykgZmlsZXMu
IFNvIEkgdm90ZSBmb3IgYWRkaW5nICpfTUVNSU5GTygpCnRvIHRzdF9tZW11dGlsLmguCgoKCj4K
PiA+IEBAIC0xMzUyLDMgKzEzNTIsMTkgQEAgaW50IHNhZmVfc3lzaW5mbyhjb25zdCBjaGFyICpm
aWxlLCBjb25zdCBpbnQKPiBsaW5lbm8sIHN0cnVjdCBzeXNpbmZvICppbmZvKQo+Cj4gPiAgICAg
ICByZXR1cm4gcmV0Owo+ID4gIH0KPiA+ICsKPiA+ICtpbnQgc2FmZV9wcmludF9maWxlKGNvbnN0
IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGNoYXIgKnBhdGgpCj4gPiArewo+ID4gKyAg
ICAgaW50IHJldDsKPiA+ICsgICAgIEZJTEUgKnBmaWxlOwo+ID4gKyAgICAgY2hhciBsaW5lW1BB
VEhfTUFYXTsKPiA+ICsKPiA+ICsgICAgIHBmaWxlID0gc2FmZV9mb3BlbihmaWxlLCBsaW5lbm8s
IE5VTEwsIHBhdGgsICJyIik7Cj4gPiArCj4gPiArICAgICB3aGlsZSAoZmdldHMobGluZSwgc2l6
ZW9mKGxpbmUpLCBwZmlsZSkpCj4gPiArICAgICAgICAgICAgIHRzdF9yZXNtXyhmaWxlLCBsaW5l
bm8sIFRJTkZPLCAiJXMiLCBsaW5lKTsKPiA+ICsKPiA+ICsgICAgIHJldCA9IHNhZmVfZmNsb3Nl
KGZpbGUsIGxpbmVubywgTlVMTCwgcGZpbGUpOwo+ID4gKwo+ID4gKyAgICAgcmV0dXJuIHJldDsK
PiA+ICt9Cj4gPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9tZW11dGlscy5jIGIvbGliL3RzdF9tZW11
dGlscy5jCj4gPiBpbmRleCBjNTM4MmZmMTAuLjZjMWU3YzI5ZSAxMDA2NDQKPiA+IC0tLSBhL2xp
Yi90c3RfbWVtdXRpbHMuYwo+ID4gKysrIGIvbGliL3RzdF9tZW11dGlscy5jCj4gPiBAQCAtMTgy
LDMgKzE4Miw4IEBAIHZvaWQgdHN0X2Rpc2FibGVfb29tX3Byb3RlY3Rpb24ocGlkX3QgcGlkKQo+
ID4gIHsKPiA+ICAgICAgIHNldF9vb21fc2NvcmVfYWRqKHBpZCwgMCk7Cj4gPiAgfQo+ID4gKwo+
ID4gK3ZvaWQgdHN0X3ByaW50X21lbWluZm9fKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8pCj4gPiArewo+ID4gKyAgICAgc2FmZV9wcmludF9maWxlKGZpbGUsIGxpbmVubywgIi9w
cm9jL21lbWluZm8iKTsKPiBBcyBJIG1lbnRpb25lZCBhYm92ZSwgd2UgdHJ5IHRvIGF2b2lkIGZ1
bmN0aW9uIHdyYXBwZXJzLgo+ID4gK30KPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
