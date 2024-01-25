Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64DAC48260
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 13:45:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E0863CFB01
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 14:45:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A877F3CE1EF
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 14:45:38 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B6898201DC5
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 14:45:37 +0100 (CET)
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-68195c0c8d1so27428816d6.3
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706190336; x=1706795136; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6h3Bto91tsGryiQD4l0dRypWcLX2s4+9LxrRy+H+9VA=;
 b=hrnRumQK4xqeTBA/VvEQIkXlKqPSSGVr0tPbbIQqnjPAOuoA3tEhPLpjlP9jSOgBwq
 PrL2IfVDwGtl9KQZdUe3WrxDEkryeQWt4IUsfhQ9jVfFEN0St/7e/koHoJlekYoao1Pl
 RW4Z1ZwhC803E3Cv0WpQaPmDkpR16dIzK/v59UC9Wz9aWbDfWfeHbnFh4V4Cjg5d34g9
 0WZwBKJ47aLYEY8cUnJ7dzrH5ezlqsx0AQksLRjKFuhsyoa56dklK7+BVsSosB+WfvRO
 b+7FfNKWSD8ZDs/GST6YUJqTzOWBTdUqllPcQ0pl9flWTVA8M6QauVIr6b2LrF9K3qhp
 C1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706190336; x=1706795136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6h3Bto91tsGryiQD4l0dRypWcLX2s4+9LxrRy+H+9VA=;
 b=TTrSvxMDReZeO0UvAxAGIYmjZABrcwOcIdSoEAkfDEB3nRquxo7coYe7dQ7oFuVD1g
 YMRulygP1L9LcAwpHLEpGJXoMPFFl7btmgUeLdkieP0Av+zJH+ERAjO3aTrAAxDG+g/Z
 aJogcGr3cEg/w6noH5EpQ3SOuAqXrnRba+qCQfNamDLC79WpXJifam/cIX2ReH++9veV
 g767Z0oYRx3ozMlO0XEZUXSWdEH4JiWODhT3JDyysxJiDnSUTzNz8fJTZZnmgLma8o1N
 kN9sKr0h2YeuakYwu+mc/M0oceVY5rcClg3VKzM0G0Oc1WSmnwc4YSF53lAs5cIypRgD
 xyig==
X-Gm-Message-State: AOJu0YyBDEyGB1L3k9Twvx0m9kLNi40GKXtQQDmkqBOCcR2XT85Xqg5m
 C4fGgfb6ta5US58kuOZzPU/eob16782w85oxHdcbElbziC8Bk3MeIz92yGGkiqNEUoa68T7bxMl
 vt8HZdwoBU3npPEjoU7+4+xlGhZs=
X-Google-Smtp-Source: AGHT+IHTkcQYJPMksHee7uGKUVoRqK+zNUmaHAEO4GkvKL3jmMxcJ7S6BHvX6NLuy8cZtjc87w/wv4QVsmKBtrz6NHc=
X-Received: by 2002:a05:6214:d47:b0:680:fee7:7781 with SMTP id
 7-20020a0562140d4700b00680fee77781mr982863qvr.52.1706190336456; Thu, 25 Jan
 2024 05:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240125122337.GA398849@pevik>
In-Reply-To: <20240125122337.GA398849@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Jan 2024 15:45:24 +0200
Message-ID: <CAOQ4uxjMiPG5E5=jirxT_D=NDxdUfA2Vp8u1yNZ=YH_SxC0S8Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

T24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMjoyM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+ID4gV2hlbiB0ZXN0ZWQgZnMgaGFzIHplcm8gZnNpZCAoZS5nLiBmdXNl
KSBhbmQgZXZlbnRzIGFyZSByZXBvcnRlZAo+ID4gd2l0aCBmc2lkK2ZpZCwgd2F0Y2hpbmcgZGlm
ZmVyZW50IGZpbGVzeXN0ZW1zIHdpdGggdGhlIHNhbWUgZ3JvdXAgaXMKPiA+IG5vdCBzdXBwb3J0
ZWQuCj4KPiA+IFRyeSB0byBzZXR1cCBhIGJvZ3VzIG1hcmsgb24gdGVzdCB0bXAgZGlyLCBpbiBh
ZGRpdGlvbiB0byB0aGUgbWFyawo+ID4gb24gdGhlIHRlc3RlZCBmaWxlc3lzdGVtLCB0byBjaGVj
ayBpZiBtYXJrcyBvbiBkaWZmZXJlbnQgZmlsZXN5c3RlbXMKPiA+IGFyZSBzdXBwb3J0ZWQuCj4K
PiA+IFJ1biBvbiBhbGwgZmlsZXN5c3RlbSB0byB0ZXN0IGJvdGggZnMgd2l0aCB6ZXJvIGZzaWQg
KGUuZy4gZnVzZSkgYW5kCj4gPiBmcyB3aXRoIHZhbGlkIGZzaWQuCj4KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiAtLS0KPgo+IEhpIEFt
aXIsCj4KPiA+IFBldHIsCj4KPiA+IFRoZSBmYW5vdGlmeSB0ZXN0cyBjaGFuZ2VzIHRoYXQgeW91
IGFscmVhZHkgcGlja2VkIGZyb20gbXkgZ2l0aHViIFsxXQo+ID4gaGF2ZSB0byBkbyB3aXRoIGZp
eGluZyBuZXcgdGVzdCBmYWlsdXJlcyBpbiB2Ni43IGFuZCB2Ni44LXJjMSwgZHVlcyB0bwo+ID4g
dGhlIGZhY3QgdGhhdCBlYWNoIG9mIHRob3NlIGtlcm5lbCB2ZXJzaW9ucyBhZGRlZCBuZXcgZmls
ZXN5c3RlbXMgdGhhdAo+ID4gc3VwcG9ydCBmYW5vdGlmeSBldmVudHMgd2l0aCBmaWQrZnNpZC4K
Pgo+ID4gVGhpcyBpcyB0aGUgb25seSBjaGFuZ2UgdG8gdGVzdCBuZXcgZnVuY3Rpb25hbGl0eSBp
biB2Ni44LXJjMSwgbmFtZWx5LAo+ID4gdGhhdCBmb3IgZnMgd2l0aCB6ZXJvIGZzaWQgKGUuZy4g
ZnVzZSksIGFuIGZhbm90aWZ5IGdyb3VwIGNhbiB3YXRjaCBhCj4gPiBzaW5nbGUgZnMgaW5zdGFu
Y2UuCj4KPiBUaGlzIHBhdGNoIHdvdWxkIGhhdmUgdG8gYmUgcmViYXNlZCwgdG8gYmUgYXBwbGlj
YWJsZSBvZiB0aGUgcHJldmlvdXMgb25lICh3aGljaAo+IHRvdWNoZXMgbW9yZSB0ZXN0cykgaW4g
eW91ciBicmFuY2guCgpJIGRvbid0IHVuZGVyc3RhbmQgLSB0aGlzIHBhdGNoIGlzIGFscmVhZHkg
cmViYXNlZC4KSSBoYXZlIGl0IGluIG15IGJyYW5jaCBhZnRlciB0aGUgZml4IHBhdGNoZXM6Cgo3
ZGIyZGFjOWYgKEhFQUQgLT4gZmFub3RpZnlfZnNpZCkgZmFub3RpZnkwMTogVGVzdCBzZXR0aW5n
IHR3byBtYXJrcwpvbiBkaWZmZXJlbnQgZmlsZXN5c3RlbXMKZjgwZGM1MTJlIGZhbm90aWZ5ezAx
LDA5LDEwfTogQ2hlY2sgZm9yIHJlcG9ydCBmaWQgc3VwcG9ydCB3aXRoIG1vdW50IG1hcmsKOTA2
MjgyNGE3IChtYXN0ZXIpIGZhbm90aWZ5MTY6IEZpeCB0ZXN0IGZhaWx1cmUgb24gRlVTRQplYTA4
NTcxM2YgZmFub3RpZnl7MTQsMTUsMTZ9OiBDaGVjayBmb3IgZmlsZXN5c3RlbSBtYXJrIHN1cHBv
cnQgb24gZmlsZXN5c3RlbQo5MjFmMGNlODYgZmFub3RpZnkxMzogVXNlIGdlbmVyaWMgY2hlY2sg
Zm9yIG1hcmsgdHlwZSBzdXBwb3J0IG9uIGZpbGVzeXN0ZW0KCj4KPiBJIGFsc28gd29uZGVyIHdo
YXQgSSBkaWQgd3JvbmcsIHRoZSBicmFuY2ggd29ya3MgYWZ0ZXIgcmVib290LCB0ZXN0ZWQgb246
Cj4gMSkgbWFpbmxpbmUga2VybmVsIDYuOC4wLXJjMSBpbiByYXBpZG8tbGludXgKPiAyKSBvcGVu
U1VTRSBrZXJuZWwgNi44LjAtcmMxLTIuZ2Y0YmE1ZGItZGVmYXVsdAo+IDMpIDYuNy4wLTkuZ2Fl
ZGRhODAtZGVmYXVsdAo+CgpXaGljaCBicmFuY2ggd29ya3M/IExUUCBtYXN0ZXIgYnJhbmNoPwoK
TXkgY2xhaW0gaXMgdGhhdCB3aXRoIHRoZSBjdXJyZW50IExUUCBtYXN0ZXIgYnJhbmNoLCBmYW5v
dGlmeTAxLDA5LDEwCndvdWxkIGZhaWwgb24ga2VybmVsIDYuOC4wLXJjMSB3aGVuIHJ1bm5pbmcg
d2l0aApMVFBfREVWX0ZTX1RZUEU9ZXhmYXQgKG5vdCBMVFBfU0lOR0xFX0ZTX1RZUEU9ZXhmYXQp
CgpTbyBhdCBsZWFzdCB5b3Ugc2hvdWxkIGNvbnNpZGVyIGFwcGx5aW5nIHRoaXMgZml4IGZvciB0
aGUgcmVsZWFzZToKZjgwZGM1MTJlIGZhbm90aWZ5ezAxLDA5LDEwfTogQ2hlY2sgZm9yIHJlcG9y
dCBmaWQgc3VwcG9ydCB3aXRoIG1vdW50IG1hcmsKClRoYW5rcywKQW1pci4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
