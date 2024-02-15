Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044A8C4829E
	for <ltp@archiver.kernel.org>; Thu, 15 Feb 2024 19:13:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D74AE3D0B4A
	for <ltp@archiver.kernel.org>; Thu, 15 Feb 2024 20:13:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 275163CE335
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 20:12:45 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FA291401122
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 20:12:45 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso646580a12.3
 for <ltp@lists.linux.it>; Thu, 15 Feb 2024 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mbobrowski-org.20230601.gappssmtp.com; s=20230601; t=1708024365; x=1708629165;
 darn=lists.linux.it; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJxP1qagcKhQEraW62B0QYZg/w9OczVS9P6+qllQcBk=;
 b=xMoqJB5RB+ujUrUA+XI06xYfeh3jcyWUpd7+EX0TG/Ktb43ymEuuBqZCAHZ5C7+q/m
 RXXXEEnRoo8SL/AU9Dl/1kt+8vrb4BaK6NhyIaCI4y6b8eWBCrv31hMfUUzYaqUkdy5a
 FxMCMqF8Bnz4Mm9EAo7y7rYd0XFGBn5bUeUwWP2UuM2qs1F4+aQPgSrdOXTFRvC8Fdr0
 O92RueSRgiQHh8UlPaygep9MyAB3U7ZZsY8PWWX+BsHt/ptYh3aIz8W4jA+8OC8pNkBD
 shRfTRmgt4Ai1T5VL1VwYqjVC1Y2SaPuroJattsKaUmZ6oXA13Ozq+Tnvp6Dxarjitvy
 jdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708024365; x=1708629165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJxP1qagcKhQEraW62B0QYZg/w9OczVS9P6+qllQcBk=;
 b=btTFZa/rM2mLLabeV0nIr8shDaolrhYH/YuKhPJhgNUx1ThIoI2OMx3jJp+BrF0Se7
 otnEvs2YYjGX0fKvjgpWLy9vDZ/DlCRMTV/pkK/LDvhQF+JsfHKeN6U6X0/CAvM7ncpm
 hnUPAu2gbceCo4yDtoC/aHovbA0SutQumuDWmv2c20OZa3QsAsTsKzFbih/1WxYvASo0
 TjfgjwbXo2g9DYdKZMWV+7ZAZhi7LxGta+ipg9eS5wEG1Snxra2pTOQWDb8nnbQdgPRc
 akZfYDwvNda0alrNpDbZ/gZ+rAFVKMPgnA/+GG0VgsFxGaJQrI27bTJx/qxt1nI4Rih/
 hJRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcAvIU49NuZpCcLZjnRIw5fSj78cRPjlY2NBwJpKRlVWWQSm7YXAWAVXFDT6quv1e/EFWbMlmsQiA9T4Me2bylga8=
X-Gm-Message-State: AOJu0Yyh/YME5lBqJoN0CCK/jfysX2ZKD1uPpOIAy+92at5f7a+c+uxx
 Onutq5cTgP4VCe5uvLQr8VCrb8/W0vGMuj1hPKqA/1dOTNJU3WEHvGjh2HYDUq87rvLtasyrnNr
 aygn0yj1mdcR5t2lOa7hkTMv+Yt3s+Ibuq1FT
X-Google-Smtp-Source: AGHT+IF036WZQ7BqIiNEd8PwkE1jFF4cIIXasRMvity2YtRMq4P8hGifZRlshCf4STEbdygtKhnV3xddhEHvY8kJDg8=
X-Received: by 2002:a05:6402:120c:b0:560:e4d8:ccca with SMTP id
 c12-20020a056402120c00b00560e4d8cccamr2450616edw.28.1708024364690; Thu, 15
 Feb 2024 11:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
 <20240215092350.c6ujpr52f7yb7nw2@quack3>
In-Reply-To: <20240215092350.c6ujpr52f7yb7nw2@quack3>
From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Thu, 15 Feb 2024 20:12:20 +0100
Message-ID: <CAC0goKeFnzQntaZtHuMK3ieBUoW+9_gWQxHE5d7szYeBc1UqOg@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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

T24gVGh1LCBGZWIgMTUsIDIwMjQgYXQgMTA6MjPigK9BTSBKYW4gS2FyYSA8amFja0BzdXNlLmN6
PiB3cm90ZToKPgo+IE9uIFdlZCAxNC0wMi0yNCAxODowOTo0OSwgUGV0ciBWb3JlbCB3cm90ZToK
PiA+IENjOiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiA+IENjOiBKYW4gS2FyYSA8
amFja0BzdXNlLmN6Pgo+ID4gQ2M6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
Cj4gPiBDYzogTWF0dGhldyBCb2Jyb3dza2kgPG1ib2Jyb3dza2lAbWJvYnJvd3NraS5vcmc+Cj4g
PiBDYzogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiBDYzogTWFydGluIERv
dWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+ID4gQ2M6IFJpY2hhcmQgUGFsZXRob3JwZSA8aW9Acmlj
aGllanAuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
Cj4gPiAtLS0KPiA+IEhpIGFsbCwKPiA+Cj4gPiBJJ20gc29ycnkgdG8gc3RlYWwgeW91ciB0aW1l
IHdpdGggbGljZW5zZSBjbGVhbnVwLgo+ID4KPiA+IExUUCBzdGFydGVkIGFzIEdQTCB2MiBvbmx5
IGFyb3VuZCAyMDAxLiBMYXRlciBuZXcgdGVzdHMgd2VyZSBjaGFuZ2VkIHRvCj4gPiBHUEwgdjIr
LiBXaGVuIHdlIGxhdGVyIHN0YXJ0ZWQgdXNpbmcgU1BEWCwgd2UgdXNlIEdQTC0yLjAgd2hpY2gg
YWN0dWFsbHkKPiA+IG1lYW5zIEdQTC0yLjAtb25seS4gUGxlYXNlIGlmIHlvdSBhZ3JlZSB3aXRo
IGNoYW5naW5nIEdQTC0yLjAtb3ItbGF0ZXIKPiA+IGZvciB0ZXN0cyB5b3Ugd3JvdGUgYWNrIHRo
aXMgKG9yIHNlbmQgYSBwYXRjaCB3aGVyZSB5b3UgY2hhbmdlIGl0IGlmIHlvdQo+ID4gcHJlZmVy
KS4gSWYgeW91IGRvbid0IGFncmVlIG9yIHlvdSBkb24ndCByZXBseSB5b3VyIGZpbGVzIHdpbGwg
c3RheQo+ID4gR1BMIHYyIG9ubHkgKGp1c3QgU1BEWCB3aWxsIGJlIGNoYW5nZWQgdG8gR1BMLTIu
MC1vbmx5IHRvIGJlIG9idmlvdXMuKQo+IC4uLgo+ID4gSmFuIEthcmEKPiA+IHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkwMS5jCj4gPiB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDIuYwo+ID4gdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTAzLmMKPiA+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkwNC5jCj4gPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90
aWZ5L2Zhbm90aWZ5MDUuYwo+ID4gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTA2LmMKPiA+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkxMC5jCgpBY2tlZC1ieTogTWF0dCBCb2Jyb3dza2kgPG1hdHRib2Jyb3dza2lAZ29vZ2xlLmNv
bT4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
