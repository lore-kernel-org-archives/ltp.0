Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A73C61D92
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 11:56:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48BF53CA0F0
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 12:56:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0463C8213
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 12:56:08 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 47E4F2010ED
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 12:56:08 +0100 (CET)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-58ceabd7cdeso254394eaf.3
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 03:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700567767; x=1701172567; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlQyyadGlQXidxwm7+0H7xB3kCB7D3DB3h2GqpBixJc=;
 b=hzWwTf1xfky+qmANJRu16vNRQdDOkEzjGjouqGsdKD9hYK9g1Poscr2LS+bZ/PB/0a
 XzwzcS6SReT1o+97eqbKoO05ScDdn8sPr6iZZEsXJ7vQwGth0GpQrjCkgxyiJkRZbeYW
 ZIFnH2Hgr9l+/jRaJ3ChvoLimyk2UJNS5XVjnbibdxoJAFakSownTH1HY2lzsFuICev8
 TUrga1s4O5HgpaMVPRbGkDuXc0UhyNXBwsJM8e41eLiJM4sRkWO9XI1wjT5GyZGBomqE
 Fv5GoYOzRyj2BKwHrDzhL4rUFn14XVJkW1/xg7orgMyiDdxRrgSRuXNK2rPI2P5KR3dX
 JAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700567767; x=1701172567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlQyyadGlQXidxwm7+0H7xB3kCB7D3DB3h2GqpBixJc=;
 b=cKvLLrDFOth3cefW8r54VvgDtsJCxAH4cEHX6nyozKfUBQyDS1W4d0FUbFybV65l0G
 uO/HBGyVYhE+Lu0YC5Z2oL96NdwMss3/gS+JWfUHx8sSYzyLEs8vOsdRQb9HXXZKuUS+
 rmP9Q5Gwmy8+ccz8iMv9h6sqSgT9EbmCODgrKOJXIjhqpurQFqYlGY/+KvZErk73ht/W
 Qa5LdZ7oyuVMyUHnAo+R/eKesP7nSPvPOeHCLGvv+ufAp7Lpja6beYEVkiGtWxkuLGfR
 Ac6ASXXZsq+gEtTt/1R8wWeucsth2bXvCVFe8GPl5EokgUJ4vBNIyRMNgsHbGYzglJNn
 RZrw==
X-Gm-Message-State: AOJu0YxrLE5E13Spaouz8T6Szf7tO6gnvxj3AXVkEgXxTMoGuIDTScmk
 3L1SanSiRX3GMVVCz/AQgxI0Vf/H2TN/8LNlXKk=
X-Google-Smtp-Source: AGHT+IFItPk9JlCV5mMsDV5lRDnEWdbVv7k5IRorPu5jG9g6KzTLLoLGA/iVAksZvo9ooewqGObdgARs5uJYzUYelbM=
X-Received: by 2002:a05:6358:720d:b0:16b:f8f5:e20 with SMTP id
 h13-20020a056358720d00b0016bf8f50e20mr11310429rwa.30.1700567766709; Tue, 21
 Nov 2023 03:56:06 -0800 (PST)
MIME-Version: 1.0
References: <20231115104148.8287-1-mdoucha@suse.cz>
In-Reply-To: <20231115104148.8287-1-mdoucha@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Nov 2023 13:55:55 +0200
Message-ID: <CAOQ4uxjoXt4wL-9jNXKseKs6=5wXZ-0ks=71VePvx3bbUa3ybQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify14: Revert broken flag support check
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

W2NjIFBldHJdCgpPbiBXZWQsIE5vdiAxNSwgMjAyMyBhdCAxMjo0MeKAr1BNIE1hcnRpbiBEb3Vj
aGEgPG1kb3VjaGFAc3VzZS5jej4gd3JvdGU6Cj4KPiBSZXZlcnRzIHBhcnQgb2YgMzVmNzdlNzUg
d2hpY2ggb2J2aW91c2x5IGRvZXNuJ3QgYmVsb25nIGluIGEgbWVtY29udHJvbAo+IHRlc3QgcGF0
Y2guCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4g
LS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jIHwg
MyArLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkxNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMK
PiBpbmRleCA5MDhhNjYzOGEuLjBiYjc4OTE4OCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gQEAgLTI0Niw4ICsyNDYsNyBAQCBz
dGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBudW1iZXIpCj4gICAgICAgICB0c3RfcmVz
KFRJTkZPLCAiVGVzdCBjYXNlICVkOiBmYW5vdGlmeV9pbml0KCVzLCBPX1JET05MWSkiLCBudW1i
ZXIsCj4gICAgICAgICAgICAgICAgIHRjLT5pbml0LmRlc2MpOwo+Cj4gLSAgICAgICAvL2lmICh0
Yy0+aW5pdC5mbGFncyAmIH5zdXBwb3J0ZWRfaW5pdF9mbGFncykgewo+IC0gICAgICAgaWYgKHRj
LT5pbml0LmZsYWdzID09IHN1cHBvcnRlZF9pbml0X2ZsYWdzKSB7Cj4gKyAgICAgICBpZiAodGMt
PmluaXQuZmxhZ3MgJiB+c3VwcG9ydGVkX2luaXRfZmxhZ3MpIHsKPiAgICAgICAgICAgICAgICAg
dHN0X3JlcyhUQ09ORiwgIlVuc3VwcG9ydGVkIGluaXQgZmxhZ3MiKTsKPiAgICAgICAgICAgICAg
ICAgcmV0dXJuOwo+ICAgICAgICAgfQo+IC0tCj4gMi40Mi4xCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
