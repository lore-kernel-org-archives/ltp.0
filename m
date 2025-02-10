Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D29C0219B
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:56:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22D0F3C98AA
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 17:56:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43B583C02C9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 17:56:04 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7125865C6AB
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 17:56:02 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5dcdb56c9d3so7408833a12.0
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739206562; x=1739811362; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bm79MfoZqK/fJFJJhjb/ewOHERJjPXcVJ4H9Nkc77so=;
 b=OsMpKwSETkcdN9VHbzpAPxh71wEgoohi2cyXrxBHQyVCjbpIVmKf7au16KWRY/i0GZ
 d4Spc5IXigVErD7AuHyvQO33BzfXppld9zVmtRiXc6cu+OyZJj8Pdxgw9TBbYTS2+cPp
 NdBqk3p2aCVdfBuPTwvFlbT4WPLT305VIGzvTYB1bhm7s2zmEESmwxykglLO7bmLHmpr
 /BN2BKUf5bygjzzI2IlMoAlGCO75KEmVEarx1lXj54sPbBxpgnInvDB+F3lhIhJgdz49
 4wlKGMlIcwemhhbAqnCR8agJp2SrJWWSK4YKyHgt4PrBbggktLq8coao7jKHCXFMO8/y
 qlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206562; x=1739811362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bm79MfoZqK/fJFJJhjb/ewOHERJjPXcVJ4H9Nkc77so=;
 b=kky3IxTfIDR6YzlMDNxujCLVfJB4MCWQmKUwMeGzKXpxATr0ppGqkfrCBmcwOELerc
 4ghDpjfH030qionTIFHgHoeuegDllQ7bY5VMa+7UtQ1A5RTcdDnhiPwv8eO0ljJPaT0L
 RUNU9zp7iojgVriGf2cwQOdzOWl+0zG7t5BTy6962GIX2Kp0jgZc+GYhSI+mhOhTom6V
 zAEC+Jt7mFz7vEVmoWkK5eik0oPXYG57B8WFclHJ0yKaJ17lkMsVcFNDci2u7cDFjUBf
 N4esJ1qI7SGt31nyAE9ZJ6GifkwZtLUO8VtaP7K7mv4JW7c6vW2F1paJpCox7sQ/YQSJ
 YWEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSlT/VNYS1aHBqp4aDTW2kK1nDJBUAUtc0KlPyTrADzMfHzBB/dbsGTNG/B0x7ExNyAMc=@lists.linux.it
X-Gm-Message-State: AOJu0YyIdYoKp/lt3c7pnBdHomh9wMcVvXR+h8JIKoE7FkMBtJOX/YZr
 r9d5GPJctUnFFX/CjeL5F23Yrze3Mowsy8xJWftf3D6s3NRBa1OBlvr83bci1A8a4+UTIMHKtFo
 xpodZjC82fhuEDUrj0VL/48fX3uY=
X-Gm-Gg: ASbGncsBkWuGqkbyBQG4nQxo1LbU+su5OYz1mheRUo7v2OFbr9zXYqU8rG64vEvhp2e
 um/267VRrXHLIacFYcdrJZr/dTBjXRYrsPFyDSlie4Cf/5kjE0wgTlMPzTH3aZ9J/i+eR3AUh
X-Google-Smtp-Source: AGHT+IHYoPp/paJZc5q7jbPe3HZYICE8VUMpMrDWAY1XOGNtV0qnOS+tTVYVxcp6KVX43TuRXlSOcdLO21A4vjriJT8=
X-Received: by 2002:a05:6402:194b:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5de44fe95c1mr38506789a12.2.1739206561388; Mon, 10 Feb 2025
 08:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-3-amir73il@gmail.com>
 <betolcydydpyyd45jncnozi6g7phk32anhn4kx3jvgrk4kvwzx@5covq3yufbp3>
In-Reply-To: <betolcydydpyyd45jncnozi6g7phk32anhn4kx3jvgrk4kvwzx@5covq3yufbp3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 10 Feb 2025 17:55:50 +0100
X-Gm-Features: AWEUYZkKzy2hVWYiBPx53rn9irTMFXVbOETcxSn_A_vJXnF-CjGb8otUNA_XVXM
Message-ID: <CAOQ4uxgu16dOsU4uuq66CGqXw6wY8c8jK7sL1QheB8kTPU=X+g@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] fanotify03: Add test cases for permission
 events on children
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

T24gTW9uLCBGZWIgMTAsIDIwMjUgYXQgNDoyNeKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gT24gTW9uIDEwLTAyLTI1IDE2OjEzOjE0LCBBbWlyIEdvbGRzdGVpbiB3cm90
ZToKPiA+IFZlcmlmeSB0aGF0IHBlcm1pc3Npb24gZXZlbnRzIGFyZSBkZWxpdmVyZWQgaWZmIHBh
cmVudCBpcyB3YXRjaGluZwo+ID4gY2hpbGRyZW4uCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogQW1p
ciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KPgo+IE92ZXJhbGwgbG9va3Mgb2sgYnV0
Ogo+Cj4gPiAtICAgICBpZiAocmVhZChmZCwgYnVmLCBCVUZfU0laRSkgIT0gLTEpCj4gPiArICAg
ICBleHBfcmV0ID0gZXhwX2Vycm5vID8gLTEgOiAxOwo+ID4gKyAgICAgZXJybm8gPSAwOwo+ID4g
KyAgICAgaWYgKHJlYWQoZmQsIGJ1ZiwgQlVGX1NJWkUpICE9IGV4cF9yZXQgfHwgZXJybm8gIT0g
ZXhwX2Vycm5vKSB7Cj4gPiArICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJyZWFkKCkgZ290
IGVycm5vICVkIChleHBlY3RlZCAlZCkiLCBlcnJubywgZXhwX2Vycm5vKTsKPiA+ICAgICAgICAg
ICAgICAgZXhpdCgzKTsKPiA+ICsgICAgIH0gZWxzZSBpZiAoZXJybm8gPT0gZXhwX2Vycm5vKSB7
Cj4gICAgICAgICAgICAgICAgIF5eIFdoeSBpcyB0aGlzIGNvbmRpdGlvbiBuZWVkZWQ/IEl0IGlz
IGFsd2F5cyB0cnVlIEFGQUlDVC4KPgo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAi
cmVhZCgpIGdvdCBlcnJubyAlZCBhcyBleHBlY3RlZCIsIGVycm5vKTsKPiA+ICsgICAgIH0KPiA+
Cj4gPiAgICAgICBTQUZFX0NMT1NFKGZkKTsKPiA+Cj4gPiAtICAgICBpZiAoZXhlY3ZlKEZJTEVf
RVhFQ19QQVRILCBhcmd2LCBlbnZpcm9uKSAhPSAtMSkKPiA+ICsgICAgIGV4cF9yZXQgPSBleHBf
ZXJybm8gPyAtMSA6IDA7Cj4gPiArICAgICBlcnJubyA9IDA7Cj4gPiArICAgICBpZiAoZXhlY3Zl
KEZJTEVfRVhFQ19QQVRILCBhcmd2LCBlbnZpcm9uKSAhPSBleHBfcmV0IHx8IGVycm5vICE9IGV4
cF9lcnJubykgewo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMLCAiZXhlY3ZlKCkgZ290
IGVycm5vICVkIChleHBlY3RlZCAlZCkiLCBlcnJubywgZXhwX2Vycm5vKTsKPiA+ICAgICAgICAg
ICAgICAgZXhpdCg1KTsKPiA+ICsgICAgIH0gZWxzZSBpZiAoZXJybm8gPT0gZXhwX2Vycm5vKSB7
Cj4gICAgICAgICAgICAgICAgIF5eXiBhbmQgaGVyZSBhcyB3ZWxsLi4uCj4KPiA+ICsgICAgICAg
ICAgICAgdHN0X3JlcyhUSU5GTywgImV4ZWN2ZSgpIGdvdCBlcnJubyAlZCBhcyBleHBlY3RlZCIs
IGVycm5vKTsKCllvdSBhcmUgcmlnaHQuCkkgd2FzICJiYWNrcG9ydGVkIiBmcm9tIHRoZSBwcmUt
Y29udGVudCB0ZXN0LgpUaGUgdHdvIGVsc2Ugc3RhdGVtZW50cyBjYW4gYmUgcmVtb3ZlZCBpbiB0
aGlzIHBhdGNoLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
