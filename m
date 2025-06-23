Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71898C7115D
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 07:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B95E23CCA67
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 09:24:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 789FB3C064C
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:24:37 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C50D140054B
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:24:36 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ade5a0442dfso750417166b.1
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750663476; x=1751268276; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnSgO9Cld+q9sOUqcUD5sOdXYXrCthqgrIwLD/AZjfo=;
 b=DNQnpMZ9OPqDQaWEsV0hhVlbrXdqJ0npId3lCQq3AWeZJpV60HQ+ztMycf2jN93ToC
 yIw69WAm7KqEFGgKrOzicqEESJIkOlubg6gzNPT9NY/rH76yovoXfIWcsWADqUhUBrCc
 KO4zepudRwV4vb7zEIkC+o52bBK8fcqszbss/zICP4Xz6V+2EZpCHBehVOW39KACzdAx
 8Cguudstw12ke84nxg+OXatSbro3yEkOUowHKFRTMF+VaDPmblXiV5QiD1lSpwTVeZ45
 HRilHLELkeyckqvkSvpqM2UG7laDiyUHvM/QhHUSirHtvVu9qvZom41Ntl7pyWCUP1Ny
 Rz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750663476; x=1751268276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnSgO9Cld+q9sOUqcUD5sOdXYXrCthqgrIwLD/AZjfo=;
 b=O3Ke32wZ6waMfin2SsNs28rFA4wEySiRrJBSX/fzweF28WjU+y8xv+gMV9KfdBqR2v
 hONmOkG0O+v8S1k2jJC7ASUaTwUSJay9BbN51CmGW2G6MWrVE2sAzyUM9VmXvRG/aAqj
 ZCJo7ejJNUzTcyr5n5f7Xbj3VAWwJI19aRRcvC8TuevFIVlmrAfhHg2iMUxXF44BY4Ga
 sirKswvdYfImZ3qGHoT3YRVzFHIJSWjoZvqr+WLfcb5RCiOZbXlKtPjEgLf1HZSQ5yEl
 9efGxzzE+/jRqLBgWB16MkvaPSDlOTZfxYMJrbEpoBM6loHRrrqv5bIeV49ZkzE6Sf0A
 hqew==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1rXMpjRCAxUxSm2k5GDUAZUrgtkL42A8O2pSFqS2PzkiEMcCtoS/pk2OMgwfG6mcv/rc=@lists.linux.it
X-Gm-Message-State: AOJu0Yzc/45c0C6icjF5OMnyIFRgq1Vf/wj2dsmivV+ZuiWkDVODBi7z
 HAGEgCzJpELHbAMFRPdGY42LF60egJN/G9YMfs1TQSWfAssK2B9CR5GIgIMtqQGojTzt/aksccb
 1x/htcMl07/SA3kKOr49UO8pJr873UPA=
X-Gm-Gg: ASbGnculkv0PCCpjOdbC9nFLaMeXRhuPBbrlZX+PhN+axH8ameXGCuWJi2GRTYZoeKx
 jwDMvvH+enXWsyyX4bbKj+6KZgG4X3dcZ+YRX9cAgbTx5qRaX5kEwN/F6alrHD1MeSR9t72RmdQ
 yBpBJRY+DI3Vh07M+YQjPA5oOlSVoDmXDd54xcrECyp+s=
X-Google-Smtp-Source: AGHT+IFHySMxYGTnSvF1XOHqn7sUVXMSvr9YT6wbbBkdGFJZp/tsb5Fhr9kchbPtoG93tX8FCoD3VdeltW7atFZClFA=
X-Received: by 2002:a17:907:bacb:b0:adb:2f9c:34bb with SMTP id
 a640c23a62f3a-ae057b48d54mr1006541266b.49.1750663475632; Mon, 23 Jun 2025
 00:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250622215140.GX1880847@ZenIV>
In-Reply-To: <20250622215140.GX1880847@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 09:24:22 +0200
X-Gm-Features: AX0GCFuFHgkwQWHNwiA3nArOxrXS2Ok-B3nI6YAvj3JxGejfwZRWtPizw2Yv2TM
Message-ID: <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
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

T24gU3VuLCBKdW4gMjIsIDIwMjUgYXQgMTE6NTHigK9QTSBBbCBWaXJvIDx2aXJvQHplbml2Lmxp
bnV4Lm9yZy51az4gd3JvdGU6Cj4KPiAgICAgICAgIExUUCA2NzYzYTM2NTA3MzQgInN5c2NhbGxz
L2Zhbm90aWZ5MTA6IEFkZCB0ZXN0IGNhc2VzIGZvciBldmljdGFibGUKPiBpZ25vcmUgbWFyayIg
aGFzIGFuIGludGVyZXN0aW5nIGVmZmVjdCBvbiBib3hlbiB3aGVyZSBGQU5PVElGWSBpcyBub3QK
PiBlbmFibGVkLiAgVGhlIHRoaW5nIGlzLCB0c3RfYnJrKCkgZW5kcyB1cCBjYWxsaW5nIC0+Y2xl
YW51cCgpLiAgU2VlIHRoZQo+IHByb2JsZW0/Cj4gICAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKENB
Q0hFX1BSRVNTVVJFX0ZJTEUsICIlZCIsIG9sZF9jYWNoZV9wcmVzc3VyZSk7Cj4gaXMgZXhlY3V0
ZWQsIGV2ZW4gdGhvdWdoCj4gICAgICAgICBTQUZFX0ZJTEVfU0NBTkYoQ0FDSEVfUFJFU1NVUkVf
RklMRSwgIiVkIiwgJm9sZF9jYWNoZV9wcmVzc3VyZSk7Cj4gICAgICAgICAvKiBTZXQgaGlnaCBw
cmlvcml0eSBmb3IgZXZpY3RpbmcgaW5vZGVzICovCj4gICAgICAgICBTQUZFX0ZJTEVfUFJJTlRG
KENBQ0hFX1BSRVNTVVJFX0ZJTEUsICI1MDAiKTsKPiBoYWRuJ3QgYmVlbi4KPgo+ICAgICAgICAg
UmVzdWx0OiBmYW5vdGlmeTEwIG9uIHN1Y2gga2VybmVsIGNvbmZpZ3MgZW5kcyB1cCB6ZXJvaW5n
Cj4gL3Byb2Mvc3lzL3ZtL3Zmc19jYWNoZV9wcmVzc3VyZS4KCm9vcHMuCnN0cmFuZ2UgZW5vdWdo
LCBJIGNhbm5vdCByZXByb2R1Y2UgaXQgYXMgc29tZXRoaW5nIGlzIHByZXZlbnRpbmcKemVyb2lu
ZyB2ZnNfY2FjaGVfcHJlc3N1cmU6CgpmYW5vdGlmeTIzLmM6MjMyOiBUQ09ORjogZmFub3RpZnkg
bm90IGNvbmZpZ3VyZWQgaW4ga2VybmVsCmZhbm90aWZ5MjMuYzoyNDk6IFRXQVJOOiBGYWlsZWQg
dG8gY2xvc2UgRklMRQonL3Byb2Mvc3lzL3ZtL3Zmc19jYWNoZV9wcmVzc3VyZSc6IEVJTlZBTCAo
MjIpCgojIGNhdCAvcHJvYy9zeXMvdm0vdmZzX2NhY2hlX3ByZXNzdXJlCjEwMAoKQnV0IEknbGwg
c2VuZCBhIGZpeCBhbGwgdGhlIHNhbWUuCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
