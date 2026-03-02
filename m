Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F166AEB3621
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 17:07:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BBC43D80BD
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 18:07:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1FB93C7B87
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 18:07:39 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F0A4600212
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 18:07:39 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b935a74b7c2so632504166b.3
 for <ltp@lists.linux.it>; Mon, 02 Mar 2026 09:07:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772471258; cv=none;
 d=google.com; s=arc-20240605;
 b=ejowev1F+O1TY6HxQSszazUSRQEvCJ0z45KUKiT3X4kC7aMKkU476PmWjQfLtWeMRp
 1F+XK4ucYaoswU1pb4PC/3FZai8/W5W7aOtM14K7R0xZC2lIzoJzhi2GqTWz/VCgJWg4
 6QTa+ccIbX5HKnLijhmx81WkItRTWUZv71joFzjWuWAAbwmb0eMXMd4tks1CqSEOjk6r
 wnfyj0a8V/qfrYaifkGJpUKIF+pgT1hFfj2Bo4QlFwkpMnq129Ej1bFKyzKofoPrWnZy
 RlnrB4yCuM4WLpZRhi/uIg79KozO8YWywocEBZQlJ5uGVxYDGcTcybBj+lXP5O2ZV9z/
 JTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cm2e3ZvDrdrULMngOA9L/Y6xBN4vLcQ4rvSSjQshfQk=;
 fh=llPI/3yO6j3SHqnwpMZ6RFoZYagT9Ue7yBMbjnC/SJc=;
 b=HTQLXCKcTsGrErjznLEPPVzYMJZbS76g/DdSfRnY0zCFcU9mafkqsAXzvfZQqkCjAw
 pfDYnIkBtQlui5l2PKAgmslAgH+TuzhfAoQMCwHujTzGwYJQ+bsGDgS1IM1q7556J4ft
 Q+ySqyObchCvtxxYVSlf1790xGv5++CaHDjdNIuGTjcNsuPwZBqGxputm0DiI0T2l0JO
 JzcU/jGWUp/wqY6vNNoneD4No3gAAwevx7Xw2ot9VMZKPt5+dmSfMa6QbMRd8irCPWYg
 eMMCoY9USoclQ/dy7U4lxdQo5QiTrXCcJw2D7mzIY5+u6swD5maZ9M/kuVcreUvKo4eL
 kT5Q==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772471258; x=1773076058; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cm2e3ZvDrdrULMngOA9L/Y6xBN4vLcQ4rvSSjQshfQk=;
 b=SixGeIv7yRsHsf84zR/umaOHSdsX2msdC6tg9gMF8qo2iM2AYfsQhpxquzEraIXXUZ
 7OQctAom+YoWpL5i1mukHtjjpT8HvTdWemCSju7Bg37T7RxbdPETxqWl2IIzBeZeKbbg
 Uiq/l9vyxZwJoJwNftPjP5WFobus/wvZqbMLqzDV1w5c/t5PZ4Uaz3Gevron8Oiqm7bv
 2WdkfnbIyvGIYy2iwOSo532A5XCJVi9vZE9tCCvkIH3CJT1cA3KMvxo2Ib3USwWn8HSF
 zMvyn35Hb8FuySPkigHmQlkayJjMDOG4Rb8sBuM7w1RsIGgPhQKJ3VVFIsUydUpfOZvW
 a56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471258; x=1773076058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cm2e3ZvDrdrULMngOA9L/Y6xBN4vLcQ4rvSSjQshfQk=;
 b=XfI8QMvVLdlrJe04cRNdhPQqDHu20HShtQtsbsj/fEvmaOWstVJg+UA6mY9M5v0IiL
 q3mvLdkRdcuNFlhl2mSQfdBUBiZCpWcwbwB9FYgulw1HLOQSCNZpkoSw/2ZMINoxhzwC
 ozZgN+kz6twYdcjCyxxxdXcS/g6hQNDrhjNiRBhPxCim0ACT+x/AQDmKpes3x2xFiCP2
 MOFchp4gZA3EHngmUsGm+i7V/D9NNMuGTap0ZasJJ7uI2MGZxGSCelkuDs4b21fi8cp2
 7ZrXTOKrLGJ6tnDiKITP1x+23BUwWpxkgieqxk0qDjAQQsTcyps0xr/XHDuNb375GT0I
 lpEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+UsaLbrge+RU3oqdiKt5hUkhCTdLut9nnyVbaZCXrA6HsCh4w1qOR4wiWDB6x5d6moV8=@lists.linux.it
X-Gm-Message-State: AOJu0YyCp6n4PiwrgIGBbM1En1pR3UQA2AkAobXutceJwVfmwiGzL7BV
 0Zwdt7jv1wmOAnjwMQ6eqvmS62QmEx83sPmIckA3InQ/8am9NoxUJnvGrYYESGVQC5YTjA8qzf6
 TUYlQcr3id1gjy9t/+4otUb/WFjX3i/s=
X-Gm-Gg: ATEYQzz++qMBiONklyxuakkTvank8RwuV+BsCJjWnz6z5Iz1N91P/MFFjCq5/EaKUwa
 l734uFJu/E3sfz7UfHe+/ey843rcqHif9LGC2f4jxpl5zaimxnVjGdwIWvlTqhT8r9hMRR+vlAh
 Y8NjxP1VwCDoVITi5lyn3DnGx4yIIrJk1t29u24+EzMJx1LP8BnvPGSZQ5RCdOIIRNUshXGDlET
 A09RBm5ByMPX/LVFpclvBsvjUuqeM0ufewvGSu2cxYcnO3+/BF2ZkV1NMdY3aqPYr94tNEPOtfI
 fi5b/lmxBtHUuZeRVNpeEmY7MPVQuVVN4twxbr38
X-Received: by 2002:a17:906:4fc3:b0:b7f:fedc:2711 with SMTP id
 a640c23a62f3a-b937658ccd3mr834708666b.53.1772471257944; Mon, 02 Mar 2026
 09:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20260302144446.1291724-1-amir73il@gmail.com>
 <aaWvOIlfyIDH7J8A@yuki.lan>
In-Reply-To: <aaWvOIlfyIDH7J8A@yuki.lan>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Mar 2026 18:07:26 +0100
X-Gm-Features: AaiRm50GAkoc8TCB62OWly-7T9oZajgUR5TAOiD8aWNk6EUk40JEZPeqqFsXKlU
Message-ID: <CAOQ4uxhpcC76cpj21Dv-279FnVgHLSjCXmYKxu526jV-Uo7G_w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: fix test failure on kernel with
 CONFIG_MODULES=n
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMiwgMjAyNiBhdCA0OjM54oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8
YW1pcjczaWxAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTI1LmMgfCA4ICsrKystLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTI1LmMgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjUuYwo+ID4gaW5kZXggYzk4MmYzMjI1
Li45YjAzZmQ5YWIgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zh
bm90aWZ5L2Zhbm90aWZ5MjUuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeTI1LmMKPiA+IEBAIC0yNCwxMCArMjQsMTAgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCB0cmFjZWNvbmZpZyB7Cj4gPiAgICAgICBjb25zdCBjaGFyICpmaWxlbmFtZTsKPiA+
ICAgICAgIGNvbnN0IGNoYXIgKndkYXRhOwo+ID4gIH0gdHJhY2VfY21kc1tdID0gewo+ID4gLSAg
ICAge0VWRU5UU19TWVNGSUxFLCAicDpsdHBfbG9hZF9tb2R1bGVfMCBsb2FkX21vZHVsZSJ9LAo+
ID4gLSAgICAge01OVFBPSU5UICIvZXZlbnRzL2twcm9iZXMvbHRwX2xvYWRfbW9kdWxlXzAvZW5h
YmxlIiwgIjEifSwKPiA+IC0gICAgIHtNTlRQT0lOVCAiL2V2ZW50cy9rcHJvYmVzL2x0cF9sb2Fk
X21vZHVsZV8wL2VuYWJsZSIsICIwIn0sCj4gPiAtICAgICB7RVZFTlRTX1NZU0ZJTEUsICItOmx0
cF9sb2FkX21vZHVsZV8wIn0sCj4gPiArICAgICB7RVZFTlRTX1NZU0ZJTEUsICJwOmx0cF9sb2Fk
X3NjcmlwdF8wIGxvYWRfc2NyaXB0In0sCj4gPiArICAgICB7TU5UUE9JTlQgIi9ldmVudHMva3By
b2Jlcy9sdHBfbG9hZF9zY3JpcHRfMC9lbmFibGUiLCAiMSJ9LAo+ID4gKyAgICAge01OVFBPSU5U
ICIvZXZlbnRzL2twcm9iZXMvbHRwX2xvYWRfc2NyaXB0XzAvZW5hYmxlIiwgIjAifSwKPiA+ICsg
ICAgIHtFVkVOVFNfU1lTRklMRSwgIi06bHRwX2xvYWRfc2NyaXB0XzAifSwKPgo+IERvZXNuJ3Qg
dGhpcyBkZXBlbmQgb24gQ09ORklHX0JJTkZNVF9TQ1JJUFQ/IEhvdyBsaWtlbHkgaXMgdGhhdCB0
aGlzIGlzCj4gdHVybmVkIG9mZj8KCkNPTkZJR19NT0RVTEVTPW4gaXMgYSBjb21tb24gY29uZmln
IGZvciB0ZXN0aW5nCkkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgY2FzZSBmb3IgQ09ORklHX0JJ
TkZNVF9TQ1JJUFQKCj4KPiBJZiBwb3NzaWJsZSBJIHdvdWxkIGxpa2UgdG8gYXZvaWQgd2hhY2st
YS1tb2xlIGdhbWUgdHJ5aW5nIHRvIGZpbmQKPiBzb21ldGhpbmcgdGhhdCBpcyBjb21tb25seSBl
bmFibGVkLgoKRmVlbCBmcmVlIHRvIGNob29zZSBhbnkgb3RoZXIgc3ltYm9sLgoKVGhhbmtzLApB
bWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
