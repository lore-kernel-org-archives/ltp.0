Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BEEC4167B
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 16:27:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 819473CF816
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 17:27:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 268713CF7E8
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 17:26:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6CAE600C79
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 17:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702312007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erYWctKNgD5NocoXzokYw6Cc9Ydro42N+CoY9DUdwDA=;
 b=XAEB3beERD9laCxkWOQWSaIei9aZacRdFQumPK1RmZ6vmydcjIMVmR4fZAtx6a5h3Uy/ku
 JSDUTtW90QKsi+0IInI+Ag9D1xr4M1Z4i66e4+G/sXakW/bj3rIm45zcOiSnVC8cj3+FLe
 Tu5eCUSB31VZvNB7IE9G/grkwIELtyU=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-wUMOxehLPtuWmgdXv6H3ZA-1; Mon, 11 Dec 2023 11:26:46 -0500
X-MC-Unique: wUMOxehLPtuWmgdXv6H3ZA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7cb1a0c3db6so14691241.1
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 08:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702312005; x=1702916805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erYWctKNgD5NocoXzokYw6Cc9Ydro42N+CoY9DUdwDA=;
 b=ks6NOJ2secmLYy6A1mFujm6YwlLBK8SAWe+rp9OEJxm9fkQH3dyJDRJIxv4GsySBwK
 +yUv/3YsKi06AKwOPK88mMy/0JQsN5Rc1UrVD2obf1khijnrtLvbjkwZhPWIMjOUf0oe
 67SXYGA9i1vkmi7ZKr/Y9Pwqz1Fdjfd5UkBnImNj6v7NkiRk3Lv7un/up2NNr6UqZao9
 7lSr1GksRvRo5ge/Q3dn2gr0R8WzbNecLknv/F4/Jb5sRF56qAhdFY7jgC9I8zrYDDYx
 EpI7rj63JWb5Var6IoPXGjANELc+T0/MUiRKmndBeeoOhGkx+Hp7h6mW1wghL35JU9fC
 Uegg==
X-Gm-Message-State: AOJu0YzJOnlwXaKV69EnbS1tEGK1GWVgJQXoUQh72a6At7bmYCZOOhfm
 TO9BPHQrNlkjkIzQ95Q1jOsAIoM/GJTIlqbShNCUlLoWvMCnVVdmLqL4iZE4jt+KRfP31JkBGHd
 25sJ+KwpE0+XeTy710nDv3hNmRJU=
X-Received: by 2002:a05:6122:4d12:b0:4b2:879d:1acc with SMTP id
 fi18-20020a0561224d1200b004b2879d1accmr3229956vkb.10.1702312005519; 
 Mon, 11 Dec 2023 08:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzeme1B1vz6PucYVLp1Bm80JuIa+Hr+BOZlvV4PGgbdpue+u1IN2h2kbjEd2q3MqSv2yHKbhwrbMeyGlmVRe0=
X-Received: by 2002:a05:6122:4d12:b0:4b2:879d:1acc with SMTP id
 fi18-20020a0561224d1200b004b2879d1accmr3229941vkb.10.1702312005234; Mon, 11
 Dec 2023 08:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20231211161807.526714-1-pvorel@suse.cz>
In-Reply-To: <20231211161807.526714-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Dec 2023 17:27:11 +0100
Message-ID: <CAASaF6wiMS3_u35mwnBKUy15g1LzpF6rjfXUU7TNBUcd0qG01w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/3] Add TDEBUG tst_res() flag
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBEZWMgMTEsIDIwMjMgYXQgNToxOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpLAo+Cj4gY2hhbmdlcyB2MS0+djI6Cj4gKiAlcy9UREVCVUcvVERF
QlVHL2cgKEN5cmlsKS4KPiAqIE1lcmdlZCB0aGUgbGF0ZXN0IHBhdGNoIGFuZCByZWJhc2VkIGJl
Zm9yZSBzZW5kaW5nLgoKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29t
PgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBQZXRyIFZvcmVsICgzKToKPiAgIGxpYi90
ZXN0czogQWRkIHRlc3QgZm9yIHRlc3RpbmcgdHN0X3JlcygpIGZsYWdzCj4gICBsaWI6IEFkZCBz
dXBwb3J0IGZvciBUREVCVUcgdHN0X3JlcygpIGZsYWcKPiAgIGZzeC1saW51eDogUmVkdWNlIGxv
ZyBvdXRwdXQgd2l0aCBUREVCVUcKPgo+ICBkb2MvQy1UZXN0LUFQSS5hc2NpaWRvYyAgICAgICAg
ICAgICAgICAgICB8ICA5ICsrKy0tCj4gIGluY2x1ZGUvdHN0X2Fuc2lfY29sb3IuaCAgICAgICAg
ICAgICAgICAgIHwgIDMgKysKPiAgaW5jbHVkZS90c3RfY29tbW9uLmggICAgICAgICAgICAgICAg
ICAgICAgfCAgMiArLQo+ICBpbmNsdWRlL3RzdF9yZXNfZmxhZ3MuaCAgICAgICAgICAgICAgICAg
ICB8ICAxICsKPiAgaW5jbHVkZS90c3RfdGVzdC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAg
NSArKy0KPiAgbGliL25ld2xpYl90ZXN0cy90c3RfcmVzX2ZsYWdzLmMgICAgICAgICAgfCA0NyAr
KysrKysrKysrKysrKysrKysrKysrKwo+ICBsaWIvdHN0X2Fuc2lfY29sb3IuYyAgICAgICAgICAg
ICAgICAgICAgICB8ICAzICsrCj4gIGxpYi90c3RfcmVzLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDkgKysrLS0KPiAgbGliL3RzdF90ZXN0LmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxMiArKysrKysKPiAgdGVzdGNhc2VzL2tlcm5lbC9mcy9mc3gtbGludXgvZnN4LWxp
bnV4LmMgfCAzMyArKysrKystLS0tLS0tLS0tCj4gIDEwIGZpbGVzIGNoYW5nZWQsIDkyIGluc2Vy
dGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL25ld2xp
Yl90ZXN0cy90c3RfcmVzX2ZsYWdzLmMKPgo+IC0tCj4gMi40My4wCj4KCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
