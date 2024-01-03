Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C7CC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:47:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 184FB3CE780
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 10:47:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DDCA3C081B
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 10:46:50 +0100 (CET)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5FF94600687
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 10:46:50 +0100 (CET)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-5ec7a5a4b34so63085937b3.0
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 01:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704275209; x=1704880009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihhhQFZaZR4+J27tLwPbBpD9wwAmji8BYJHqOMirIeI=;
 b=KusXusI1sLpp/YEmc82S7Bgo3BClUG9lB0roJH6QNOXGO/8Y3/zDckfMPJHAjbsrFA
 kvaywzldUYptDEHqvbXOhzLxTHhaEEsZ5Lfan25IZjZ4nf7Cge8Uzebqhh1vs/qdK7Ly
 cGSSB6AFwVti0eZaLTXaUCOscMFfbOoVodWd0NCzn5QK8RI84ifb+RUuJKJ1I9gbPVPC
 +uw3EH8qvp95pm/U+oX/BXULL2ghfbfbwrCNEbZv5BBZOKI/P9AP1+mrbm7vWCVk6IJ9
 fARkCxZsMdyGXk9DvBiG3IlCUXX1rsn7kQ5jAl9vW43PKf1zvtiLqUb+7wJB0MdB7irR
 F8gg==
X-Gm-Message-State: AOJu0Yy6JDicSQz9wYMnXHyKWKfbhnkTgOVr9E2xC5+3P41Eco0zn2vU
 FrX1XpwnOi8RgaG8q9CqFwU5B2sAUDAw9g==
X-Google-Smtp-Source: AGHT+IGSOZMwMHdTOUnssSjCCdDE810XHhMCW5u6hlLcymWMk4GIChTm93oN+uvW2wRyr1nalWEFuA==
X-Received: by 2002:a81:8784:0:b0:5d9:50cc:b901 with SMTP id
 x126-20020a818784000000b005d950ccb901mr14141628ywf.95.1704275208866; 
 Wed, 03 Jan 2024 01:46:48 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com.
 [209.85.128.178]) by smtp.gmail.com with ESMTPSA id
 ew4-20020a05690c2f8400b005e8f5b53d6bsm11832157ywb.22.2024.01.03.01.46.47
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 01:46:48 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-5f2d4aaa2fdso17867537b3.1
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 01:46:47 -0800 (PST)
X-Received: by 2002:a81:80c1:0:b0:5e8:6aba:9d18 with SMTP id
 q184-20020a8180c1000000b005e86aba9d18mr14346275ywf.35.1704275207623; Wed, 03
 Jan 2024 01:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20240103015240.1065284-1-pvorel@suse.cz>
In-Reply-To: <20240103015240.1065284-1-pvorel@suse.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2024 10:46:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
Message-ID: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
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
Cc: Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCkNDIG90aGVyIHVDbGludXggYXJjaCBsaXN0cwoKT24gV2VkLCBKYW4gMywgMjAy
NCBhdCAyOjUy4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+IFVDTElO
VVggaXMgYnJva2VuIGluIExUUCBhbmQgbm9ib2R5IHJlYWxseSBjYXJlcy4gQWN0dWFsbHkgSSBk
YXJlIHRvCj4gc2F5IFVDTElOVVggaXMgZGVhZC4gVGhlcmVmb3JlIEkgcHJlcGFyZWQgcGF0Y2hz
ZXQgdG8gcmVtb3ZlIFVDTElOVVgKPiBmcm9tIExUUC4gV2UgaGF2ZSBiZWVuIGFjdGl2ZWx5IHJl
bW92aW5nIFVDTElOVVggZnJvbSBMVFAgZHVyaW5nIHJld3JpdGUKPiB0ZXN0cyB0byBuZXcgTFRQ
IEFQSS4gVGhpcyByZW1vdmVzIHRoZSByZXN0IGZyb20gdGhlIG9sZCB0ZXN0cyAod2hpY2gKPiB3
aWxsIGJlIHNvb25lciBvciBsYXRlciByZXdyaXR0ZW4gdG8gbmV3IEFQSSkuCj4KPiBCZWNhdXNl
IHRoZSBwYXRjaHNldCBpcyBxdWl0ZSBiaWcsIEkgZGlkIG5vdCB3YW50IHRvIHNlbmQgaXQgdG8g
bWFpbGluZwo+IGxpc3RzIChidXQgSSBjYW4gZG8gaXQgaWYgeW91IHdhbnQpLgo+Cj4gQ2FuIHlv
dSBwbGVhc2UgaGF2ZSBsb29rIGF0IG15IGZvcmsgb24gZ2l0bGFiLCBicmFuY2g6IHJlbW92ZS1V
Q0xJTlVYCj4gaHR0cHM6Ly9naXRsYWIuY29tL3BldmlrL2x0cC8tL2NvbW1pdHMvcmVtb3ZlLVVD
TElOVVg/cmVmX3R5cGU9aGVhZHMKPgo+IEJ1aWxkIHRlc3Q6Cj4gaHR0cHM6Ly9naXRodWIuY29t
L3BldmlrL2x0cC9hY3Rpb25zL3J1bnMvNzM5MjQ3MDIxNQoKVGhhbmtzIGZvciB5b3VyIHNlcmll
cyEKCkkgc2VlIHlvdSBvbmx5IENDZWQgbGludXgtbTY4aywgYnV0IEFGQUlLLCB1Q2xpbnV4IGlz
IG5vdCByZXN0cmljdGVkCnRvIG02OGsvY29sZGZpcmUsIGJ1dCBhbHNvIGF2YWlsYWJsZSBvbiBh
cm0zMiwgcmlzY3YsIHNoLCBhbmQgeHRlbnNhLgoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAg
ICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdz
IGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBl
cnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxm
IGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5
ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
