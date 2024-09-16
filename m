Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5C0C3ABA2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 10:33:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3AC23C2C02
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 12:33:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CEFC3C1BE2
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 12:33:07 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F60D600683
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 12:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726482785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNhVSVu+hzl7VkU5QuyxweCQETr2EGkMjyKT9g8rULo=;
 b=W75akKFz8oMrSpcAxjkzZ+G03GIw5SRXX7qrXPuYkOAC0kP8iL+z8ZJjIEo3mCm5e6HKtS
 i/+I2m6NnimstC8IvjLLRNtF204vGX7IDqw/qHDqUo7Cxhmblwpxqbo1EoxsAks3YGAShx
 Dn3yZyMh3FEymyHdIaI5xPOEzPev0Ac=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-inDmr-1tMYSlEGQHGEQUmA-1; Mon, 16 Sep 2024 06:33:03 -0400
X-MC-Unique: inDmr-1tMYSlEGQHGEQUmA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-27ba6712e9bso2242592fac.2
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 03:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726482783; x=1727087583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNhVSVu+hzl7VkU5QuyxweCQETr2EGkMjyKT9g8rULo=;
 b=g1Q53FFv5qQcLTUfiTWcqSzH3ThD4Y72+R0GOItXPlnF2JRpNOav9qXITsuU3v7QAD
 xpvqPXmsnpvxAii2/CS6hPJQ1Tgpk5MCE9jKwfJfP5q4avk7r4EvIPGAVuqtqk36F+Kw
 GOIep/l9WqMSpnYRGSKYhwGRsvSGWGKR0MrDsI4ZY0conWzBBjvdoIp8PCx7c+st62QI
 utj1uuD7HWsi/vU7msJhUyFkKL7SakfjWyhDlKKBOjUWitj1kMRbZ2XOXGhnRaU50GCn
 cN1CYccgmux+MtzqjUlUODwU3gTRFwkY69rbQV4wVbXQZbJDj037D7aCeNGTfQ/bPicZ
 O3FA==
X-Gm-Message-State: AOJu0YxevVAGRZkRsPxsfi/nzqOnsdliRaKRaHSZU6rlBYSfflN4VE+E
 0G1DOg/wRYVcpFGG9h9eiimRl+KMSRvFVrsIw+r53q7mOuR0lx+0uCXE59p6FX45ykmEuoVGT38
 VXCavj0FhvpYd+4K+//2OREg+dLv/Z+5KybFm6rtkMqjwf5JgH/37ftFlrENgOHTBqRsHC6flU3
 PnYndLD/B54B2hrTfwhRz7p5r6k7y5lsVLbQ==
X-Received: by 2002:a05:6871:331f:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-27c3f2b23a9mr8752749fac.22.1726482783183; 
 Mon, 16 Sep 2024 03:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEonECqnPrhAuhPfOKMRrRtkNz+FoM4SNnFy9EdihScIhIIORTwA9kZyMa8KyjkD+gRMWwO3Nmn+VTTQj35SaU=
X-Received: by 2002:a05:6871:331f:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-27c3f2b23a9mr8752740fac.22.1726482782885; Mon, 16 Sep 2024
 03:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <mvmtteg0wvn.fsf@suse.de>
In-Reply-To: <mvmtteg0wvn.fsf@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Sep 2024 12:32:39 +0200
Message-ID: <CAASaF6wOW=i3kxokuNENCj_Ghv_UOVDsq8JkqdqavPACJN1EkA@mail.gmail.com>
To: Andreas Schwab <schwab@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getdents: account for d_name size in tst_dirp_size
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

T24gTW9uLCBTZXAgMTYsIDIwMjQgYXQgMTE6MzDigK9BTSBBbmRyZWFzIFNjaHdhYiA8c2Nod2Fi
QHN1c2UuZGU+IHdyb3RlOgo+Cj4gVGhlIGxpbnV4X2RpcmVudCBhbmQgbGludXhfZGlyZW50NjQg
c3RydWN0cyBkbyBub3QgY29udGFpbiBzcGFjZSBmb3IgdGhlCj4gZF9uYW1lIG1lbWJlci4gIEFk
ZCBOQU1FX01BWCB0byB0aGUgc2l6ZSBpbiB0c3RfZGlycF9zaXplIHNvIHRoYXQgdGhlCj4gZ2V0
ZGVudHMgc3lzY2FsbHMgZG8gbm90IHNwdXJpb3VzbHkgZmFpbCB3aXRoIEVJTlZBTCBpbnN0ZWFk
IG9mIEVGQVVMVC4KClNpZ25lZC1vZmYtYnkgc2VlbXMgbWlzc2luZy4KCkFja2VkLWJ5OiBKYW4g
U3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaCB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaCBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMuaAo+IGluZGV4IDU2MGRmNDEyNi4uMDJjM2JjNTA5
IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVu
dHMuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMu
aAo+IEBAIC02NCw5ICs2NCw5IEBAIHRzdF9kaXJwX3NpemUodm9pZCkKPiAgewo+ICAgICAgICAg
c3dpdGNoICh0c3RfdmFyaWFudCkgewo+ICAgICAgICAgY2FzZSAwOgo+IC0gICAgICAgICAgICAg
ICByZXR1cm4gc2l6ZW9mKHN0cnVjdCBsaW51eF9kaXJlbnQpOwo+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gc2l6ZW9mKHN0cnVjdCBsaW51eF9kaXJlbnQpICsgTkFNRV9NQVg7Cj4gICAgICAgICBj
YXNlIDE6Cj4gLSAgICAgICAgICAgICAgIHJldHVybiBzaXplb2Yoc3RydWN0IGxpbnV4X2RpcmVu
dDY0KTsKPiArICAgICAgICAgICAgICAgcmV0dXJuIHNpemVvZihzdHJ1Y3QgbGludXhfZGlyZW50
NjQpICsgTkFNRV9NQVg7Cj4gICNpZiBIQVZFX0dFVERFTlRTCj4gICAgICAgICBjYXNlIDI6Cj4g
ICAgICAgICAgICAgICAgIHJldHVybiBzaXplb2Yoc3RydWN0IGRpcmVudCk7Cj4gLS0KPiAyLjQ2
LjEKPgo+Cj4gLS0KPiBBbmRyZWFzIFNjaHdhYiwgU1VTRSBMYWJzLCBzY2h3YWJAc3VzZS5kZQo+
IEdQRyBLZXkgZmluZ2VycHJpbnQgPSAwMTk2IEJBRDggMUNFOSAxOTcwIEY0QkUgIDE3NDggRTRE
NCA4OEUzIDBFRUEgQjlENwo+ICJBbmQgbm93IGZvciBzb21ldGhpbmcgY29tcGxldGVseSBkaWZm
ZXJlbnQuIgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
