Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C9DC02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 06:54:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95AC53C7B8C
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 07:54:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4FE3C79A1
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 07:54:32 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 716081BD0406
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 07:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737010469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpsYjtzx35oVezY1NdjhPNqsvxj64DMYP0nO0AMG86o=;
 b=Op5gaILKMYWVmGvmZfFYXXt09wrHaRhFepa9u7KQVxmXnZuCmQZrerbe4HuVOrlL9iVTnk
 2ebAWZMUB1yC9GJXrilDS2vSO4GU3nZ0vvedhLf84nWAzBe10mf4nfWvMZ78DnCH1QqAHR
 xCZgR0/TX1lHGKLX/QvKJWzE5DHG0R4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-mqnOpXCGO4Kx_O2UAyAzHw-1; Thu, 16 Jan 2025 01:54:25 -0500
X-MC-Unique: mqnOpXCGO4Kx_O2UAyAzHw-1
X-Mimecast-MFC-AGG-ID: mqnOpXCGO4Kx_O2UAyAzHw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f5538a2356so1380869a91.2
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 22:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737010464; x=1737615264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xpsYjtzx35oVezY1NdjhPNqsvxj64DMYP0nO0AMG86o=;
 b=ahgbVEjWIGEdEvULmfeBgpzaYEwJNuplu+QVniRo+LMd1loz2U3dpIGNOGxdI4HL7/
 lGKo/QQCMkou8T677ayruOk2hlVeLSrCMzcPK3ttxByNgBp93L8VzF2VThD3PD9TP/hg
 /52oeL0NnDLIEsnBHPra7DyZEv/Acd78Hdwns6KULbCMUUG6G5CiOhV5Rzfs0beYYh+e
 X00+SJ2X7VvlneUSctYttm/Vh9+enczUysaDywr/bDBDr/FCBzlA8rs4iFSlmCBHs84K
 a9GF63l2c40upQXC2BzdJSiJyF2/0KPgqdNubOQWnPqaOgryJvrGXNY8uRJ0MwUYh/gc
 VoOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvraX9Qveeg9R3lcclrQebGlCrxhwf+3PVA5XUB0la+K60toEQwOile2WRwzYMcm4A99o=@lists.linux.it
X-Gm-Message-State: AOJu0YymMjXmHL9z6MlZZTXhF/vnHbgBdH4L8N7RImrG+JvPy6ccherD
 RiOYYFkuSuwoWO05rMxNuiN0eI6JaFuGI4gTyd7ww/c4d7g0M/MDulEyjJup4DFOkXHpF2NA7ys
 bvsCjyVGP8CNtaD3YfH60GZmBi27U2XNdBmErYdtlHZbIBlXAGrUmBxUkc+zA/h1iPONdO39i/r
 kTo+dB1fJogp8M+yMqeqbCDuQ=
X-Gm-Gg: ASbGnctM78axHzLtobtI+IlSzjgRXeGVokq2Pb++pS4txFy4f7GM50TIi/39mOKNAVi
 r8i0F26vv5bPYB708H2ubk1YK9F0TtXnPzfgjub4=
X-Received: by 2002:a17:90b:270d:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f548ebf526mr49881977a91.14.1737010464594; 
 Wed, 15 Jan 2025 22:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlFKEvCwAU0sdaRfby5rD5YgonkAyknec9c0LIxwn3qVlHAofi1oGxPWCjO1b/Fa99YRanZD5zHwyjCs8mm04=
X-Received: by 2002:a17:90b:270d:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f548ebf526mr49881946a91.14.1737010464158; Wed, 15 Jan 2025
 22:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
In-Reply-To: <20250115224154.GA664782@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jan 2025 14:54:12 +0800
X-Gm-Features: AbW1kvYZjpGT8wJhugizf7PLt-6YhbKZI6BiMMoVg_RGLH5hGv7iJamQxOeBlms
Message-ID: <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qCL6ooTPqPpPz482LSi-ZB-XW2WBC7Ju-Gsis3D2B-8_1737010465
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [REGRESSION] Broken tests using tst_net.sh by 893ca0abe7
 (was: [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgNjo0MuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLCBhbGwsCj4KPiAuLi4KPiA+ICsrKyBiL2xpYi90
c3RfdGVzdC5jCj4gPiBAQCAtNTU1LDkgKzU1NSw2IEBAIHN0YXRpYyBpbnQgbXVsdGlwbHlfcnVu
dGltZShpbnQgbWF4X3J1bnRpbWUpCj4KPiA+ICAgICAgIHBhcnNlX211bCgmcnVudGltZV9tdWws
ICJMVFBfUlVOVElNRV9NVUwiLCAwLjAwOTksIDEwMCk7Cj4KPiA+IC0gICAgIGlmICh0c3RfaGFz
X3Nsb3dfa2NvbmZpZygpKQo+ID4gLSAgICAgICAgICAgICBtYXhfcnVudGltZSAqPSA0Owo+ID4g
LQo+ID4gICAgICAgcmV0dXJuIG1heF9ydW50aW1lICogcnVudGltZV9tdWw7Cj4gPiAgfQo+Cj4g
PiBAQCAtMTcwNiw2ICsxNzAzLDkgQEAgdW5zaWduZWQgaW50IHRzdF9tdWx0aXBseV90aW1lb3V0
KHVuc2lnbmVkIGludAo+IHRpbWVvdXQpCj4gPiAgICAgICBpZiAodGltZW91dCA8IDEpCj4gPiAg
ICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJ0aW1lb3V0IG11c3QgdG8gYmUgPj0gMSEgKCVk
KSIsIHRpbWVvdXQpOwo+Cj4gPiArICAgICBpZiAodHN0X2hhc19zbG93X2tjb25maWcoKSkKPiA+
ICsgICAgICAgICAgICAgdGltZW91dCAqPSA0Owo+Cj4gRllJIHRoaXMgY2hhbmdlLCBtZXJnZWQg
YXMgODkzY2EwYWJlNyAoImxpYjogbXVsdGlwbHkgdGhlIHRpbWVvdXQgaWYKPiBkZXRlY3Qgc2xv
dwo+IGtjb25maWdzIikgY2F1c2VkIGEgcmVncmVzc2lvbiBvbiAqYWxsKiB0ZXN0cyB3aGljaCB1
c2UgdHN0X25ldC5zaC4KPgo+IEZpcnN0LCBpdCBkZXRlY3RzIHNsb3cgY29uZmlnIG9uIGV2ZXJ5
dGhpbmcgd2hpY2ggdXNlcyBzdHJ1Y3QgdHN0X3Rlc3QsCj4gd2hpY2ggYXJlIHVuZm9ydHVuYXRl
bHkgc29tZSB0b29scyBhdCB0ZXN0Y2FzZXMvbGliLzoKPgo+ICQgZ2l0IGdyZXAgLWwgInN0cnVj
dCB0c3RfdGVzdCIgdGVzdGNhc2VzL2xpYi8qLmMKPiB0ZXN0Y2FzZXMvbGliL3RzdF9kZXZpY2Uu
YyAvLyBub3Qgb2J2aW91cyByZWFzb24sIG1pZ2h0IGJlIHJlbW92ZWQKPiB0ZXN0Y2FzZXMvbGli
L3RzdF9nZXRfZnJlZV9waWRzLmMgLy8gZm9yY2UgbWVzc2FnZXMgdG8gYmUgcHJpbnRlZCBmcm9t
IG5ldwo+IGxpYnJhcnkKPiB0ZXN0Y2FzZXMvbGliL3RzdF9uc19jcmVhdGUuYyAvLyAuZm9ya3Nf
Y2hpbGQgPSAxLCBOZWVkZWQgYnkgU0FGRV9DTE9ORQo+IHRlc3RjYXNlcy9saWIvdHN0X25zX2V4
ZWMuYyAgLy8gLmZvcmtzX2NoaWxkID0gMSwgTmVlZGVkIGJ5IFNBRkVfQ0xPTkUKPiB0ZXN0Y2Fz
ZXMvbGliL3RzdF9ydW5fc2hlbGwuYyAvLyBub3Qgb2J2aW91cyByZWFzb24sIG1pZ2h0IGJlIHJl
bW92ZWQKPgo+IEJlc2lkZXMgdW5pbXBvcnRhbnQgZmFjdCB0aGF0IHNsb3cgY29uZmlnIGRldGVj
dGlvbiBpcyBhbiB1bm5lY2Vzc2FyeQo+IHNsb3dkb3duCj4gb24gdGhlc2UgdG9vbHMsIHRoZSBw
cm9ibGVtIGlzIHRoYXQgaXQgcHJpbnRzIG1lc3NhZ2VzIHRvIHN0ZGVyciwgd2hpY2gKPiBjYXVz
ZXMKPiBicmVha2FnZS4KPgo+IFByZXZpb3VzbHkgdHN0X25zX2V4ZWMuYyBydW4ganVzdCBjb21t
YW5kIHBhc3NlZCBieSAtYyBwYXJhbWV0ZXI6Cj4KPiAkIC4vdHN0X25zX2V4ZWMgMTQ1MzYgbmV0
LG1udCBzaCAtYyAiIGNhdAo+IC9wcm9jL3N5cy9uZXQvaXB2Ni9jb25mL2x0cF9uc192ZXRoMS9k
aXNhYmxlX2lwdjYiCj4gMAo+Cj4gTm93IGl0IHByaW50cyBUSU5GTzoKPiAkIC4vdHN0X25zX2V4
ZWMgMTQ1MzYgbmV0LG1udCBzaCAtYyAiIGNhdAo+IC9wcm9jL3N5cy9uZXQvaXB2Ni9jb25mL2x0
cF9uc192ZXRoMS9kaXNhYmxlX2lwdjYiCj4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNp
bmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+IHRzdF9rY29uZmlnLmM6NjY3OiBU
SU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZCB3aGljaAo+IG1p
Z2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+IDAKPgo+IHRzdF9yaG9zdF9ydW4oKSBpbiB0c3RfbmV0
LnNoIHJ1bnMgYmluYXJ5IG9uIHJlbW90ZSBob3N0Ogo+Cj4gICAgICAgICBvdXRwdXQ9JCgkcmNt
ZCAiJHNoX2NtZCIgJG91dCAyPiYxIHx8IGVjaG8gJ1JURVJSJykKPgo+IFJlZGlyZWN0IHN0ZGVy
ciB0byBzdGRvdXQgKDI+JjEpIGlzIGxpa2VseSBuZWVkZWQgZm9yIHNvbWUgdGVzdHMuIEJ1dAo+
IHRzdF9yaG9zdF9ydW4oKSBvdXRwdXQgaXMgb2Z0ZW4gcGFyc2VkIGluY2x1ZGluZyB0aGVyZWZv
cmUgY2VydGFpbiB0b29scyBpbgo+IHRlc3RjYXNlcy9saWIvIGhhdmUgdG8gcHJpbnQgb25seSBl
eHBlY3RlZCBvdXRwdXQ6Cj4KPiBpbml0X2x0cF9uZXRzcGFjZSgpCj4gewo+ICAgICAgICAgLi4u
Cj4gICAgICAgICAgICAgICAgIHBpZD0iJChST0QgdHN0X25zX2NyZWF0ZSBuZXQsbW50KSIKPiAg
ICAgICAgIC4uLgo+ICAgICAgICAgZXhwb3J0IExUUF9ORVROUz0iJHtMVFBfTkVUTlM6LXRzdF9u
c19leGVjICRwaWQgbmV0LG1udH0iCj4KPiBJIHdpbGwgcHJvYmFibHkgc29sdmUgaXQgYnkgYWRk
aW5nIHlldCBhbm90aGVyIHBhcmFtZXRlciB0bwo+IHRzdF9yaG9zdF9ydW4oKSwKPiB3aGljaCBp
Z25vcmVzIHN0ZGVyciBhbmQgdXNlIGl0IGZvciB0c3RfbnNfe2NyZWF0ZSxleGVjfS4gQnV0IG1h
eWJlIHRoZXJlCj4gaXMKPiBhbm90aGVyIHNvbHV0aW9uIChvciBhbm90aGVyIHByb2JsZW0pLgo+
CgpPciwgYW5vdGhlciB3YXkgaXMganVzdCB0byBzZXQgJ3RzdF90ZXN0LT50aW1lb3V0ID09IFRT
VF9VTkxJTUlURURfVElNRU9VVCcKaW4gdGhvc2UgdGVzdGNhc2UvbGliIHRvb2xzLgoKCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
