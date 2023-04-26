Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA99C77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:01:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 733B73CBB73
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 12:01:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50253CA1D6
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 12:01:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB8556008F9
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 12:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682503304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIgNbd1ao98hi0n0oaxQ8/PkHD+BdqbYMwVtWGfRlbQ=;
 b=ZKnbodQ7t51GI9s0WKW7VNyxf4WPyjkyVPUC+6vALoQVmBR10gMB2sCdv3/jVy8+UGAxZy
 rhM+KsiRuJddiEZaAZh8f3vNgrJ5yI1AtjxCxMiuZd1sktogV8xHc+m4hB5XpfVQpNwYNb
 qnqvZJwCFWUp/xHO6ydIyOl8qvvLG0c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-mC8IqJ9LONaq_lv4Aye8lA-1; Wed, 26 Apr 2023 06:01:42 -0400
X-MC-Unique: mC8IqJ9LONaq_lv4Aye8lA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2a8d01c704cso29457341fa.0
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 03:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682503301; x=1685095301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIgNbd1ao98hi0n0oaxQ8/PkHD+BdqbYMwVtWGfRlbQ=;
 b=SBiEXQNY0HIMaxYjoEHiY/ug28Zp3V+z+yQFjhGtXaONKj6OV8gtnM6HR+nXmrzG4j
 AVZvthP051Vpv7OeRSFKbWgiR8ATNzyTktWDDEfn51AO3ME9JcqWxDIYnFjSaEs0JgsI
 ExBN2oIKzjVvYT8627+fhSYoFTTIIBIh4FFe+CHmiBDyBQeOt0zEJkvOTo/RH3yEgnxX
 hSKtweIWDTQHVJp6sIP6UBl2k+czXtBPlFZ9I8AV8nEhHc5nO5O/Ph5POcP3gJxAQo3D
 AqVPih3ZIh9MEVZcey7A5YIqY2sxouFNWFQoDjmfucf12G9j7DCDvB591jrGKRGU2o3r
 EaFg==
X-Gm-Message-State: AAQBX9e46imrTkIBnlpyjXO4/yV+VWtRb7Uf2pIK/1jY1aavpTyOEcZc
 BavBmR71Pw8cBlwjkZZGnXMTOAEfyxIE4kPsYR65Vvf0EoxUTW4TG14uY7/p7eWqVh1nMCwpr5x
 p/dIDIGCwwa4Mj0X0AtA3pIwcD4Y=
X-Received: by 2002:a2e:7003:0:b0:2a8:d3bb:2d83 with SMTP id
 l3-20020a2e7003000000b002a8d3bb2d83mr3871331ljc.42.1682503300856; 
 Wed, 26 Apr 2023 03:01:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZOzXi4CAOfjII3ewaLwTTcRuxbUuIAypD5H1rGpkwBZ+p8xDvSo2LRgDl6BmbvsULo6XhPs/X/T89cYmg+jpM=
X-Received: by 2002:a2e:7003:0:b0:2a8:d3bb:2d83 with SMTP id
 l3-20020a2e7003000000b002a8d3bb2d83mr3871325ljc.42.1682503300464; Wed, 26 Apr
 2023 03:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <ZEjsKC6ESB1+mM0H@rei>
In-Reply-To: <ZEjsKC6ESB1+mM0H@rei>
From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Apr 2023 18:01:28 +0800
Message-ID: <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preparations
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

T24gV2VkLCBBcHIgMjYsIDIwMjMgYXQgNToxOeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gSSB3b3VsZCBsaWtlIHRvIHN0YXJ0IHdpdGggTFRQIHBy
ZS1yZWxlYXNlIHByZXBhcmF0aW9ucyBhIGJpdCBzb29uZXIKPiB0aGFuIHVzdWFsbCwgc2luY2Ug
cXVpdGUgYSBsb3Qgb2YgdGhpbmdzIGhhdmUgYWNjdW11bGF0ZWQgaW4gTWF5LCBlLmcuCj4gdGhl
cmUgaXMgYSBTVVNFIExhYnMgY29uZmVyZW5jZSByaWdodCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBt
b250aC4KPgo+IEkgd291bGQgbGlrZSB0byBzdGFydCB3aXRoIHJldmlld2Ugb2YgcGF0Y2hlcyB0
aGF0IHNob3VsZCBnbyBpbiBub3csCj4gZnJlZXplIHRoZSBnaXQgc29tZXdoZXJlIGF0IHRoZSBl
bmQgb2YgdGhlIGZpcnN0IHdlZWsgb2YgTWF5IGFuZCBhaW0gZm9yCj4gYSByZWxlYXNlIHNvbWV3
aGVyZSBpbiB0aGUgbWlkZGxlIG9mIHRoZSBtb250aC4gRG9lcyB0aGF0IHNvdW5kIE9rIHRvCj4g
ZXZlcnlvbmU/Cj4KCkJhc2ljYWxseSBhZ3JlZSwgYnV0IGl0J2QgYmUgYmV0dGVyIGlmIHdlIGV4
dGVuZCBvbmUgbW9yZSB3ZWVrIGluIE1heS4KU2luY2UgdGhlIGZpcnN0IHdlZWsgaXMgQ2hpbmEn
cyBwdWJsaWMgaG9saWRheSwgSSBkb24ndCB3YW5uYSBtaXNzIHRoZQpyZWxlYXNlIHRoaXMgdGlt
ZSBhZ2Fpbi4KCgoKPgo+IEVpdGhlciB3YXkgaWYgeW91IGhhdmUgcGF0Y2hlcyB0aGF0IHNob3Vs
ZCBsYW5kIGluIHRoZSB1cGNvbW1pbmcKPiByZWxlYXNlLCBwbGVhc2UgcG9pbnQgdGhlbSBvdXQg
bm93LCBzbyB0aGF0IHdlIGhhdmUgYSBjaGFuY2UgdG8gcmV2aWV3Cj4gdGhlbS4KPgoKSSdsbCBi
ZSB3b3JraW5nIG9uIHRoZSBodWdlbW1hcDI0IGZhaWx1cmUgeW91IHBvaW50ZWQgb3V0IGJlZm9y
ZSwKdG8gc2VuZCBhbiBlZmZlY3RpdmUgZml4aW5nIHBhdGNoLgpodHRwczovL2xpc3RzLmxpbnV4
Lml0L3BpcGVybWFpbC9sdHAvMjAyMy1NYXJjaC8wMzMxMTcuaHRtbAoKQWxzbywgSSdkIHZvdGUg
Zm9yIHRoZSBjZ3JvdXBfY29yZTAzLmMgdGVzdCwgd2hpY2ggYmFzaWNhbGx5IGdldHMgcGFzc2Vk
Cm9uIG15IHJldmlldyBhbmQgdGVzdGluZy4KSSB3aWxsIGFkZGl0aW9uYWxseSBzdGFydCBhIHNl
cGFyYXRlIHBhdGNoIG9uIG5ldyBpbXByb3ZlbWVudHMgYmFzZWQgb24KV2VpJ3MgcGF0Y2hzZXQg
dG8gbGV0IExUUCBDZ3JvdXAgdGVzdCBhdm9pZCBWMW5WMiBtaXhpbmcgdGVzdC4KaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjMtQXByaWwvMDMzNjA0Lmh0bWwKaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjMtQXByaWwvMDMzNjA1Lmh0bWwKCk1v
cmUgd2lkZWx5IExUUCBMVFAgcHJlLXJlbGVhc2Ugd2lsbCBiZSBkZXBsb3llZCBiYXNlIG9uIFJI
RUwgcHJvZHVjdHMgYXMKd2VsbC4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
