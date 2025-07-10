Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84BBC83F03
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752071780; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GCJUKz2ZhRjgJarU5BusTJU9rEGGLhZaOGmcrg2lYyY=;
 b=j2dPddvBnEiZJFTs+qBTB5IpuqnQk8XgIF4BeMBDMkIX3Ob0VxBxPXOLeNO4zsol+PQUr
 NKA+djgHkp1wpaf/CB1FNTAIAec2g1G4Mss++cLdfBFVGVPfV2ER2ADIUuXPH4xVh4LgifK
 bTyt79pyXCXfudfsezOuJYxvsBHUjTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 712983CAC65
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 16:36:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62FBF3C8C3D
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 16:35:58 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 98DF5609247
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 16:35:57 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so13074f8f.0
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752071757; x=1752676557; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z6Vc8YuJV5E5dK+UuErYRwh+Xngxbs+BHDg9LI1oXK0=;
 b=E8/9dGFQaHmD0QkUSosPEUqGEdTTuid8wBT8VVGb6NZN/hPwRpHkBo99xjRI4VGeLk
 0+CxGT8gdzxype3voLGxes90TT9l3yS4Z2aPAOwPSPiuhig8/tKklGpCS99cT5L1E+t0
 AEYPvLwtKebwQSSDjvntzfQsJp9P/CkuUG0X1pQbKOqndN+aiHz0YpEozTU9SpeZ8lEJ
 /FTpREB5jTUjsq+zAmYSyyFgxTd8LuNVdkZyGRq0/SuKq2a/KCauNq3VLaO54/+wJWDD
 fG6J+zqCkKlXVRNy1gRxZ73+6b1AOOVlw30VLnbsKuZuV51mL0vJ0XuZ0q4IJ4pAKvUF
 PLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752071757; x=1752676557;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6Vc8YuJV5E5dK+UuErYRwh+Xngxbs+BHDg9LI1oXK0=;
 b=dyHexxqaORqVcmigtrSu1E8mYFLxrQc0bbLcC9w5wXgyvU0RqAYt1N62E8/Lc0y7UH
 Xco2UCr5SKNIzH3sM5B+BkOTLWPa7DugRrTJo9bbPWaXL24eB97OOejCYkpbkbNnFEdc
 GiarR9H3tg9toih0/HHRY9unFrKEdIy5dp9bUk/F3JItyUTPWqZSwYoJFuQmLSvTgIOx
 dzyYUdYeCDFBge8TAwsJ1jB8CnnNHbvdWb3eKypnI0oO1HGNjPzn9hLnVyt4SDP8tPNI
 fqGKPiMhyw/gD6q6ahHrPQ0/JCgy1svJM1T6PalofCID5LqTMSDsxHoCMLhgWOHAxZna
 Ebjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL3HcFGEzupMD3XuMtXKapxuJZP/rMK1A95belWvtVLo6H0ioMrYGvqUYioEdWP4IuddE=@lists.linux.it
X-Gm-Message-State: AOJu0YwXiqB4D09JJjRjeyidKsmOXJKNVisPsDSaHvrhWgEdPgW0KaMk
 GH2Y9140McWBOm9xJ/2aRzSD00nBag/f7OV6SaiGz8mxZ9NCv9EUD7Q6jcDFYYioIw==
X-Gm-Gg: ASbGnct5i8qXORuvEGxnq9s6PBUYbQtyVAxNIBqniQl0Xvr5wMkXkFjLLin0ylCv5R6
 C6Voo4+qDzZZTj3sY4qFIjHo2ZOP9OIDlfqv7ON4sEBfCqKN2U3iXoXt8PUH50eo09aXvIClqNA
 fBnOnliQ2f64MBGK4Hn0Y7eS2fkW90eDsgEm6KTC5eE0HyRw2ZFjmJAhVLgnj7mo+6nY6/9wBR2
 9Q5x/BXaTQ/PGrBRH5pDkKmvXZPk0mOyLW/SAMQkR1P1t1saD4wvUZTVyE8K1Br00mjQMpIqcpS
 n0mDRNwL/I5NNe/7CIAOZMI9Y7knkZ/rcMHse9fKh2MmfXdQShC7pODxqJMIwg==
X-Google-Smtp-Source: AGHT+IFDNuOplHvChiEdcKKqFJEu6LoUoKePvqNCVknYzEb52ul+/f3iVPXUQ7TkFGvvbuUMMTh8aA==
X-Received: by 2002:a05:6000:26c2:b0:3a4:f918:9db9 with SMTP id
 ffacd0b85a97d-3b5e78d7cc7mr154429f8f.32.1752071756902; 
 Wed, 09 Jul 2025 07:35:56 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce43d67fbsm16006756b3a.178.2025.07.09.07.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:35:56 -0700 (PDT)
Date: Wed, 9 Jul 2025 22:35:16 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aG8m5AiKWMNFxXyQ@MiWiFi-CR6608-srv>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
 <456d5d63-737f-441e-bc3f-4fa012983264@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <456d5d63-737f-441e-bc3f-4fa012983264@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] lib: safe_macros: Add SAFE_MREMAP
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>,
 Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdWwgMDksIDIwMjUgYXQgMDM6MTY6MDJQTSArMDIwMCwgQW5kcmVhIENlcnZlc2F0
byB2aWEgbHRwIHdyb3RlOgo+IEhpIQo+IAo+IE9uIDcvOC8yNSAxMDoxMSBQTSwgUmljYXJkbyBC
LiBNYXJsacOocmUgdmlhIGx0cCB3cm90ZToKPiA+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJl
IDxyYm1Ac3VzZS5jb20+Cj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnD
qHJlIDxyYm1Ac3VzZS5jb20+Cj4gPiAtLS0KPiA+ICAgaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5o
ICB8ICAyICsrCj4gPiAgIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggfCAgNCArKysrCj4gPiAg
IGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrCj4gPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9zYWZlX21hY3Jvc19mbi5oIGIvaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oCj4gPiBpbmRl
eCBkMjU2MDkxYjc2YWQxMGIwNmIyOWUzZmQ1ZmFkODg1M2ZhYTE0YzA4Li40ODkyNzA2ZmEzMTFh
ZTIzMTMxY2QxYmEzZDM2ZThlYjMyNTdkOWM0IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9zYWZl
X21hY3Jvc19mbi5oCj4gPiArKysgYi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKPiA+IEBAIC02
OSw2ICs2OSw4IEBAIGludCBzYWZlX21rZGlyKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sCj4gPiAgIGludCBzYWZlX3JtZGlyKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sCj4gPiAgICAgICAgICAgICAgICAgIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwgY29u
c3QgY2hhciAqcGF0aG5hbWUpOwo+ID4gK3ZvaWQqIHNhZmVfbXJlbWFwKGNvbnN0IGNoYXIgKmZp
bGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPiA+ICsJCXZv
aWQgKm9sZF9hZGRyZXNzLCBzaXplX3Qgb2xkX3NpemUsIHNpemVfdCBuZXdfc2l6ZSwgaW50IGZs
YWdzKTsKPiA+ICAgaW50IHNhZmVfbXVubWFwKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBs
aW5lbm8sCj4gPiAgICAgICAgICAgICAgICAgICB2b2lkICgqY2xlYW51cF9mbikodm9pZCksIHZv
aWQgKmFkZHIsIHNpemVfdCBsZW5ndGgpOwo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3Nh
ZmVfbWFjcm9zLmggYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCj4gPiBpbmRleCAxOTUwNGJl
YjU3YWQzNzljODM1YTEzZWQ1ZDM1ZmUwNmU0MmE2ZWQ2Li45Y2E3MDMxOWYwODZkZWE0Mzc0Njdj
Nzc1ZGQ5Y2I0OGI5NTY1ODNlIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS90c3Rfc2FmZV9tYWNy
b3MuaAo+ID4gKysrIGIvaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaAo+ID4gQEAgLTkzLDYgKzkz
LDEwIEBAIHZvaWQgKnNhZmVfcmVhbGxvYyhjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGlu
ZW5vLCB2b2lkICpwdHIsIHNpemVfdCBzaXplKTsKPiA+ICAgI2RlZmluZSBTQUZFX1JNRElSKHBh
dGhuYW1lKSBcCj4gPiAgIAlzYWZlX3JtZGlyKF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBh
dGhuYW1lKSkKPiA+ICsjZGVmaW5lIFNBRkVfTVJFTUFQKG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwg
bmV3X3NpemUsIGZsYWdzKSAgICAgICAgICAgICAgXAo+ID4gKwlzYWZlX21yZW1hcChfX0ZJTEVf
XywgX19MSU5FX18sIE5VTEwsIChvbGRfYWRkcmVzcyksIChvbGRfc2l6ZSksIFwKPiA+ICsJCSAg
ICAobmV3X3NpemUpLCAoZmxhZ3MpKQo+ID4gKwo+ID4gICAjZGVmaW5lIFNBRkVfTVVOTUFQKGFk
ZHIsIGxlbmd0aCkgXAo+ID4gICAJc2FmZV9tdW5tYXAoX19GSUxFX18sIF9fTElORV9fLCBOVUxM
LCAoYWRkciksIChsZW5ndGgpKQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIv
bGliL3NhZmVfbWFjcm9zLmMKPiA+IGluZGV4IDU3YmMwYmM3NDk3MTJmMWI4OTA1OTQxMjNiNmI5
ZjNjYWJjZTgyMWEuLjRiYjRjNzAwZjFkMjVlOTUyMGUzZDVhMmY5OTY5YmZlY2FmZDI1Y2MgMTAw
NjQ0Cj4gPiAtLS0gYS9saWIvc2FmZV9tYWNyb3MuYwo+ID4gKysrIGIvbGliL3NhZmVfbWFjcm9z
LmMKPiA+IEBAIC0yMTUsNiArMjE1LDIyIEBAIGludCBzYWZlX3JtZGlyKGNvbnN0IGNoYXIgKmZp
bGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSAodm9pZCksCj4gPiAgIAly
ZXR1cm4gKHJ2YWwpOwo+ID4gICB9Cj4gPiArdm9pZCAqc2FmZV9tcmVtYXAoY29uc3QgY2hhciAq
ZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoKmNsZWFudXBfZm4pKHZvaWQpLAo+ID4gKwkJ
dm9pZCAqb2xkX2FkZHJlc3MsIHNpemVfdCBvbGRfc2l6ZSwgc2l6ZV90IG5ld19zaXplLCBpbnQg
ZmxhZ3MpCj4gPiArewo+ID4gKwl2b2lkICpydmFsOwo+ID4gKwo+ID4gKwlydmFsID0gbXJlbWFw
KG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwgbmV3X3NpemUsIGZsYWdzKTsKPiA+ICsKPiA+ICsJaWYg
KHJ2YWwgPT0gTUFQX0ZBSUxFRCkgewo+ID4gKwkJdHN0X2Jya21fKGZpbGUsIGxpbmVubywgVEJS
T0sgfCBURVJSTk8sIGNsZWFudXBfZm4sCj4gPiArCQkJICAibXJlbWFwKCVwLCV6dSwlenUsJWQp
IGZhaWxlZCIsIG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwKPiA+ICsJCQkgIG5ld19zaXplLCBmbGFn
cyk7Cj4gPiArCX0KPiBIZXJlIHdlIGNhbiBoYW5kbGUgYWxzbyB1bmV4cGVjdGVkIHJldHVybiB2
YWx1ZXMuIFBsZWFzZSBjaGVjayBzYWZlX211bm1hcCgpCgpCYXNlIGJlbG93IG1hbiBwYWdlIG9m
IG1yZW1hcCAsIGl0IHdpbGwgcmV0dXJuIGEgcG9pbnRlciBvciBNQVBfRkFJTEVELiBTbyBpIGd1
ZXNzIGFib3ZlIGxvZ2ljIGNvdmVyZWQgYWxsIHNpdHVhdGlvbi4KClJFVFVSTiBWQUxVRQogICAg
ICAgT24gc3VjY2VzcyBtcmVtYXAoKSByZXR1cm5zIGEgcG9pbnRlciB0byB0aGUgbmV3IHZpcnR1
YWwgbWVtb3J5IGFyZWEuICBPbiBlcnJvciwgdGhlIHZhbHVlIE1BUF9GQUlMRUQgKHRoYXQgaXMs
ICh2b2lkICopIC0xKSBpcyByZXR1cm5lZCwgYW5kIGVy4oCQCiAgICAgICBybm8gaXMgc2V0IHRv
IGluZGljYXRlIHRoZSBlcnJvci4KCj4gPiArCj4gPiArCXJldHVybiBydmFsOwo+ID4gK30KPiA+
ICsKPiA+ICAgaW50IHNhZmVfbXVubWFwKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5l
bm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSAodm9pZCksCj4gPiAgICAgICAgICAgICAgICAgICB2b2lk
ICphZGRyLCBzaXplX3QgbGVuZ3RoKQo+ID4gICB7Cj4gPiAKPiAtIEFuZHJlYQo+IAo+IC0tIAo+
IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
