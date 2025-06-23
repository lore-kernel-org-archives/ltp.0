Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D78C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 15:19:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA66A3CCA83
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 17:19:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CB183CAB29
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 17:19:39 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 973CB10006C6
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 17:19:39 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad89ee255easo784379766b.3
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750691979; x=1751296779; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCpZRaNYcrlJ7g7L1zxin2BdglQIDQ3Fa5bAy+E1/kg=;
 b=nBmzsjUPWLLL7wyRsTXM0hIGw+kcTtXeubXm9mHKMQ02hVdx5VfgV2GQI3OnbZk/qX
 I1m8u6vUg/5V0Tb6bb6xCQD0dai1fzLnP7410ViUyZTuq0/ioriNj6FZ4zHo2iYhckLh
 jo1r+1YtXwI6VIgJM6UjDIeYopmZId0pr/7x7E0NayYmiBoDwRr5Z5hqORaeSEClLcS5
 vK81/tuLeKxCdFgi9urevVAn9or+BBa8kzTzXHTwaHF0iIc6UDu0Dy5HhsHWxP75GN8K
 X/gobPgpeEfpuHRetE1xfQyTwW2rstXcTIqXRX466bW3p1tejZWLRX0BMbtvG8vidyWw
 rTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691979; x=1751296779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCpZRaNYcrlJ7g7L1zxin2BdglQIDQ3Fa5bAy+E1/kg=;
 b=c765HkN2OuVu2nqpran7MmVA/OopLtXAG3g5Cqm6Woh0EYj+kVleTXBsXtPDVEpIxH
 XIx5x+IyrO8PhMOebsXu1Cn8LMwdsGTrKI2Lsv6KptpD1FaJkz8da/5rudCqjLdm5uAP
 wJ+UrZ/V0gYsJ+3QAi7k/yiynZIjfhXRjlKcDJZlffotoS1iokHHRUaQ535waHXiY7Ym
 Q27QYq2b2xycdE0EvBQz+bxzQKJ3z7LFIe0FR3F+gdad4gxB3ZvRpXyka7mEmhSXN4CF
 hvgAFxe7c706Ot9ypO2nz/CcwkzEe4jTK7d5q/otK8eCjOJVaXRFRD5NLNGuXbvPQEDG
 efuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3pCM0s2mE64908oFrmbC2zlrRy3e0gEI4nily79dBRlC60EN0zBQgf8AnhEztMqNUmK0=@lists.linux.it
X-Gm-Message-State: AOJu0YzQq3YNFXmMhznmDo3ar3QqlfPaRhB3PztcS/lhCv+taycc6xIX
 8IGP3zoUAHWEENH9/roCp+Q+fw8WmswExWlAZpYhIWNp9ltNemLpGOQdDXAk9IsAJ1kV2e90Oi3
 CZkJsg1f0VD+4fJVSlgFFCDZN+7aF0Ro=
X-Gm-Gg: ASbGncsO+J0Ty+e6ftCYQkYggEN/qYZejPwfZaxzEcG2QKwLn1IWHA+ohuvvmfZFaqw
 VC/Mngg2VFZyXWJ4764elP5Lupfw+m3dglPOs91IZLciNXUm0OrXp+c8TXZLf2/qnyYvKZHD/Qa
 P486fRnzSpIukrI3kCSrMBBbGO8UrD/ioQgYi0PTTfsLmc1G68bYE4/Q==
X-Google-Smtp-Source: AGHT+IG2nEpSKguYvq4MT0QxB0uZkhC0q9k5UaApzvYIBw2WImr6QSPQ8WHQwfIIGy4TVpQhO/XQ26yuezEx15TWaZU=
X-Received: by 2002:a17:907:2d86:b0:ad8:9257:5728 with SMTP id
 a640c23a62f3a-ae057d8cca2mr1299182366b.27.1750691978472; Mon, 23 Jun 2025
 08:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250622215140.GX1880847@ZenIV>
 <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
 <20250623144515.GB1880847@ZenIV>
In-Reply-To: <20250623144515.GB1880847@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 17:19:26 +0200
X-Gm-Features: Ac12FXyyihH5TYAhYyJoqyhCl2n3PwsvmkwMKcy2wI_t4F_ZZCDNn659Q0mwsUw
Message-ID: <CAOQ4uxhTXgTt62cX-F00e4vAyhDn=fCTxDqONcGT9+tBH-DkCQ@mail.gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] interesting breakage in ltp fanotify10
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
Cc: linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMjMsIDIwMjUgYXQgNDo0NeKAr1BNIEFsIFZpcm8gPHZpcm9AemVuaXYubGlu
dXgub3JnLnVrPiB3cm90ZToKPgo+IE9uIE1vbiwgSnVuIDIzLCAyMDI1IGF0IDA5OjI0OjIyQU0g
KzAyMDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gT24gU3VuLCBKdW4gMjIsIDIwMjUgYXQg
MTE6NTHigK9QTSBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4gd3JvdGU6Cj4gPiA+
Cj4gPiA+ICAgICAgICAgTFRQIDY3NjNhMzY1MDczNCAic3lzY2FsbHMvZmFub3RpZnkxMDogQWRk
IHRlc3QgY2FzZXMgZm9yIGV2aWN0YWJsZQo+ID4gPiBpZ25vcmUgbWFyayIgaGFzIGFuIGludGVy
ZXN0aW5nIGVmZmVjdCBvbiBib3hlbiB3aGVyZSBGQU5PVElGWSBpcyBub3QKPiA+ID4gZW5hYmxl
ZC4gIFRoZSB0aGluZyBpcywgdHN0X2JyaygpIGVuZHMgdXAgY2FsbGluZyAtPmNsZWFudXAoKS4g
IFNlZSB0aGUKPiA+ID4gcHJvYmxlbT8KPiA+ID4gICAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKENB
Q0hFX1BSRVNTVVJFX0ZJTEUsICIlZCIsIG9sZF9jYWNoZV9wcmVzc3VyZSk7Cj4gPiA+IGlzIGV4
ZWN1dGVkLCBldmVuIHRob3VnaAo+ID4gPiAgICAgICAgIFNBRkVfRklMRV9TQ0FORihDQUNIRV9Q
UkVTU1VSRV9GSUxFLCAiJWQiLCAmb2xkX2NhY2hlX3ByZXNzdXJlKTsKPiA+ID4gICAgICAgICAv
KiBTZXQgaGlnaCBwcmlvcml0eSBmb3IgZXZpY3RpbmcgaW5vZGVzICovCj4gPiA+ICAgICAgICAg
U0FGRV9GSUxFX1BSSU5URihDQUNIRV9QUkVTU1VSRV9GSUxFLCAiNTAwIik7Cj4gPiA+IGhhZG4n
dCBiZWVuLgo+ID4gPgo+ID4gPiAgICAgICAgIFJlc3VsdDogZmFub3RpZnkxMCBvbiBzdWNoIGtl
cm5lbCBjb25maWdzIGVuZHMgdXAgemVyb2luZwo+ID4gPiAvcHJvYy9zeXMvdm0vdmZzX2NhY2hl
X3ByZXNzdXJlLgo+ID4KPiA+IG9vcHMuCj4gPiBzdHJhbmdlIGVub3VnaCwgSSBjYW5ub3QgcmVw
cm9kdWNlIGl0IGFzIHNvbWV0aGluZyBpcyBwcmV2ZW50aW5nCj4gPiB6ZXJvaW5nIHZmc19jYWNo
ZV9wcmVzc3VyZToKPiA+Cj4gPiBmYW5vdGlmeTIzLmM6MjMyOiBUQ09ORjogZmFub3RpZnkgbm90
IGNvbmZpZ3VyZWQgaW4ga2VybmVsCj4gPiBmYW5vdGlmeTIzLmM6MjQ5OiBUV0FSTjogRmFpbGVk
IHRvIGNsb3NlIEZJTEUKPiA+ICcvcHJvYy9zeXMvdm0vdmZzX2NhY2hlX3ByZXNzdXJlJzogRUlO
VkFMICgyMikKPgo+IEhvdyBvbGQgaXMgeW91ciBsdHAgdHJlZT8gIE1pbmUgd2FzIGZyb20gbGF0
ZSBNYXkgKDgxZDQ2MGJhNjczNyAib3ZlcmNvbW1pdF9tZW1vcnk6Cj4gRGlzYWJsZSBvcHRpbWl6
YXRpb24gZm9yIG1hbGxvYyB0byBwcmV2ZW50IGZhbHNlIHBvc2l0aXZlcyIpCgpNeSBMVFAgdHJl
ZSBpcyBmcm9tIGVuZCBvZiBNYXkgdGFnIDIwMjUwNTMwCgo+IGFuZCBJJ20gZGVmaW5pdGVseQo+
IHNlZWluZyB0aGF0IGJlaGF2aW91ciB3aXRoIGZhbm90aWZ5MjMgYXMgd2VsbC4gIE5vIFRXQVJO
LCB0aG91Z2ggLQoKSSBoYXZlIG5vIGlkZWEgd2hlcmUgdGhpcyBzdHJhbmdlIFRXQVJOIGlzIGNv
bWluZyBmcm9tCkkgZGlkIG5vdCBpbnZlc3RpZ2F0ZSBpdCwgYnV0IHRoZSBidWcgaXMgdGhlcmUg
YW55d2F5LCBzbyBJIHNlbnQgYSBmaXguCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
