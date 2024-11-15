Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D22D6DDE3
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 13:58:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A735C3D7727
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 14:58:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B74AC3D76F4
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 14:58:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F423101AF2B
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 14:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731679093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUFQ/K/oJSFHD/qTxXD9iyMrZDm/Wdx1Wt2ZFylbKXM=;
 b=Mq/uNTyIvicAg+C3qloyZbElOl3HvDP3wwy5vJB71lafBBhl6IVhKrOHSfHApi5GKaS4hN
 CGSlxVYeajrR+V1kuRg9WDigqa5Exk4I3hFqvsQJPe3TjDzQHQiacETQ4CG+mb0iYAG2Cv
 xjlGuSbtQw+k9MOSqr6tMheQgJgS+dA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-zGovhrsxMUytFBvul1cOOg-1; Fri, 15 Nov 2024 08:58:12 -0500
X-MC-Unique: zGovhrsxMUytFBvul1cOOg-1
X-Mimecast-MFC-AGG-ID: zGovhrsxMUytFBvul1cOOg
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e5ff1342d0so1439780b6e.2
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 05:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731679091; x=1732283891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUFQ/K/oJSFHD/qTxXD9iyMrZDm/Wdx1Wt2ZFylbKXM=;
 b=kxidraclRZNGvQGztryctHFKg3RcFvdubcpiKGsuDULHNPobF25eygiPeMLMvKIi96
 jAF32JNxGHj26k+7gaBwxl6/OmYWeiHVEfhPQMn6OzHbI1qJlV9FPxyDgxw1KarjDQmv
 7wCS+brVXbVn+1w6UlIIJYW1VQXk/g3lH1do0vnJf/1GYBeBGSETsPb8xi14m8t47xCO
 yDocLgF9ZAwEHLTTbRhmI4zHx/Q1gENh7BMGG453eDwZDxDkaLadlUUyeSwl10XmfFTV
 ODgt/kXZrcy9xzoZbzkvoTCNooMWx7q9T2sKxahEU3ckHyexrPC8S0iQg0Ukc4BNdx2k
 EhOA==
X-Gm-Message-State: AOJu0YyZcsU6lNnN9ayxLp572B4oVJq8+z7PTeyTnQHl8PZgu8xin/RN
 0WG0mJUP4vazLanVsI8+BdlLkViBiQ9ZSx6jzeHPV/ALGfY1ObpjhAN0A1TY56IVMBXE4vBVZRE
 vAsxQhtvpKdtLovmDGO3YY0ICSk/z/v8V/5e44/A6kWu3XhV2WRmKwN2RgojqNoW6liwdM3BZfH
 3oOly+4FDBeLe3nT87IyIhG8E=
X-Received: by 2002:a05:6871:e406:b0:288:18a0:e169 with SMTP id
 586e51a60fabf-2962ddb455cmr2716843fac.19.1731679090952; 
 Fri, 15 Nov 2024 05:58:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaMN8oMXLqouQsUbfmTVtNRIZaXpvhuVEd2JsPOwzD/yFhRdkScSylkossWZWwkbCrIyE+o3qbjUr0qlapn9A=
X-Received: by 2002:a05:6871:e406:b0:288:18a0:e169 with SMTP id
 586e51a60fabf-2962ddb455cmr2716821fac.19.1731679090640; Fri, 15 Nov 2024
 05:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com>
In-Reply-To: <20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Nov 2024 14:57:53 +0100
Message-ID: <CAASaF6yu8M1kWAU-k_jEPLMNDr=naWZNC8zOXUs+AS9yJ9o=LQ@mail.gmail.com>
To: "Ricardo B. Marliere" <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XG2dqOO-a2msc6z6aBgm1WOP_lMlzz0s7KQHo9NTstk_1731679091
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: Convert to new API
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

T24gV2VkLCBOb3YgMTMsIDIwMjQgYXQgODoxNeKAr1BNIFJpY2FyZG8gQi4gTWFybGllcmUgdmlh
IGx0cAo8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPHNuaXA+Cj4gKyAgICAgICBhZGRyID0g
bW1hcChOVUxMLCBwYWdlX3N6LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAo+ICsgICAgICAgICAg
ICAgICAgICAgTUFQX0ZJTEUgfCBNQVBfU0hBUkVELCBmaWxkZXMsIDApOwo+ICsKPiArICAgICAg
IGlmIChhZGRyID09IE1BUF9GQUlMRUQpIHsKPiArICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJ
TCB8IFRFUlJOTywgIm1tYXAgb2YgJXMgZmFpbGVkIiwgVEVNUEZJTEUpOwo+ICsgICAgICAgICAg
ICAgICByZXR1cm47Cj4gKyAgICAgICB9CgpDYW4gd2UgdXNlIFNBRkVfTU1BUCBoZXJlPwoKPiAr
Cj4gKyAgICAgICAvKgo+ICsgICAgICAgICogQ2hlY2sgaWYgbWFwcGVkIG1lbW9yeSBhcmVhIGJl
eW9uZCBFT0YgYXJlCj4gKyAgICAgICAgKiB6ZXJvcyBhbmQgY2hhbmdlcyBiZXlvbmQgRU9GIGFy
ZSBub3Qgd3JpdHRlbgo+ICsgICAgICAgICogdG8gZmlsZS4KPiArICAgICAgICAqLwo+ICsgICAg
ICAgaWYgKG1lbWNtcCgmYWRkcltmaWxlX3N6XSwgZHVtbXksIHBhZ2Vfc3ogLSBmaWxlX3N6KSkK
PiArICAgICAgICAgICAgICAgdHN0X2JyayhURkFJTCwgIm1hcHBlZCBtZW1vcnkgYXJlYSBjb250
YWlucyBpbnZhbGlkIGRhdGEiKTsKPiArCj4gKyAgICAgICAvKgo+ICsgICAgICAgICogSW5pdGlh
bGl6ZSBtZW1vcnkgYmV5b25kIGZpbGUgc2l6ZQo+ICsgICAgICAgICovCj4gKyAgICAgICBhZGRy
W2ZpbGVfc3pdID0gJ1gnOwo+ICsgICAgICAgYWRkcltmaWxlX3N6ICsgMV0gPSAnWSc7Cj4gKyAg
ICAgICBhZGRyW2ZpbGVfc3ogKyAyXSA9ICdaJzsKPiArCj4gKyAgICAgICAvKgo+ICsgICAgICAg
ICogU3luY2hyb25pemUgdGhlIG1hcHBlZCBtZW1vcnkgcmVnaW9uCj4gKyAgICAgICAgKiB3aXRo
IHRoZSBmaWxlLgo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAobXN5bmMoYWRkciwgcGFnZV9z
eiwgTVNfU1lOQykgIT0gMCkgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMIHwgVEVS
Uk5PLCAiZmFpbGVkIHRvIHN5bmNocm9uaXplIG1hcHBlZCBmaWxlIik7Cj4gKyAgICAgICAgICAg
ICAgIHJldHVybjsKPiArICAgICAgIH0KPiArCj4gKyAgICAgICAvKgo+ICsgICAgICAgICogTm93
LCBzZWFyY2ggZm9yIHRoZSBwYXR0ZXJuICdYWVonIGluIHRoZSB0ZW1wb3JhcnkgZmlsZS4KPiAr
ICAgICAgICAqIFRoZSBwYXR0ZXJuIHNob3VsZCBub3QgYmUgZm91bmQgYW5kIHRoZSByZXR1cm4g
dmFsdWUgc2hvdWxkIGJlIDEuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChzeXN0ZW0oY21k
X2J1ZmZlcikgIT0gMCkgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRQQVNTLCAiRnVuY3Rp
b25hbGl0eSBvZiBtbWFwKCkgc3VjY2Vzc2Z1bCIpOwo+ICsgICAgICAgfSBlbHNlIHsKPiArICAg
ICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwgIlNwZWNpZmllZCBwYXR0ZXJuIGZvdW5kIGluIGZp
bGUiKTsKPiArICAgICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBj
bGVhbnVwKCk7Cj4gLSAgICAgICB0c3RfZXhpdCgpOwo+ICsgICAgICAgLyoKPiArICAgICAgICAq
IENsZWFuIHVwIHRoaW5ncyBpbiBjYXNlIHdlIGFyZSBsb29waW5nCj4gKyAgICAgICAgKiBVbm1h
cCB0aGUgbWFwcGVkIG1lbW9yeQo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAobXVubWFwKGFk
ZHIsIHBhZ2Vfc3opICE9IDApIHsKPiArICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRF
UlJOTywgIm11bm1hcCBmYWlsZWQiKTsKPiArICAgICAgICAgICAgICAgcmV0dXJuOwo+ICsgICAg
ICAgfQoKYW5kIFNBRkVfTVVOTUFQIGhlcmU/IE90aGVyd2lzZSB0aGlzIGxvb2tzIE9LIHRvIG1l
LgoKUmVnYXJkcywKSmFuCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
