Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C2AC25B48
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 00:47:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 759533CF96C
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 02:46:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99383CB7F4
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 02:46:46 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B54C820092C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 02:46:45 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53f98cbcd76so3063a12.1
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 17:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698194805; x=1698799605; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KFI56T3kpW8SzMnKPcKMxdJ54m4855lItS03wNXlfI8=;
 b=X11qrwbzACvGXaTXgcf6GlUSL8VnWO5dcfo9tBqo+pu8KnWz2f2HcgO+WYqntPIU9y
 Rzu6q1mA0xk5KkFFyFdLswfr1NUAMClU7pudwS4XSu/jXaIHP+BVD9eSHA+zrOCPIztZ
 jy0rWuqd/obUUrLFlLS+fAXLAcmigNYtik8bDbA2iEmbkxFz5LcVW3j7Upz6evQazz/6
 rjnkxtnRPNvGWX/7NoKcHR7pvLEdqVHTC50srw181khTfz+IPdSIHZG34bLxua246lrd
 4amhNm9Jwv3FRsOEAGH4RFeY+7HQyEFg8N70XHjM+1ob6bF2S2MU4Kb/heduxuwFJF+C
 NDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698194805; x=1698799605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFI56T3kpW8SzMnKPcKMxdJ54m4855lItS03wNXlfI8=;
 b=dbyMImO6yFGF9vihotkSBfx7fSZHmODWg1rwAYuM1vc9mC7IYw43vxAWP7M/iqDMxA
 DudyIDg9pXJDViIp7lDH7U0R+uEgFvFjIGUy1vA++cHPtkU9pMhHdWNwNyxLQLb7Kkiu
 r3iFkypv0YCBcmQPEuL7fglLwezSNqq16UIE7ReZhqFLxp0x2nsZ/Xw7VeReNpw+3djj
 p+IHsRsWA5ku+zKOLs4yR1yhiigjioTmASTzgiIGwSbE06/2zIiAAhChhDlEalKAv74n
 FDgVxwnbyqXO1FQevC+0vbc2CEWsd/0+g6L/17iCFrMNJBDj0PLNPElgJPeSsJt2V0eO
 9Vtg==
X-Gm-Message-State: AOJu0YwRm8h/KWUIuHSJSM2K9oS6M/cvzedChmMG5Hz0/cycTDeZDjYo
 V3T98YMkUyAkN34Fz0I26YC5dc9oxJOkAALRusMJPw==
X-Google-Smtp-Source: AGHT+IFHZzJ94e/FmzoNyGguM95BAIiTD4k/oF/BGI+GbIGppXLEAymxwiMlp4BG3qwW8GzW3gdnGZr1adH7IIQmqI4=
X-Received: by 2002:a05:6402:154:b0:540:e46c:5c7e with SMTP id
 s20-20020a056402015400b00540e46c5c7emr15069edu.0.1698194804789; Tue, 24 Oct
 2023 17:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231018015016.1897021-1-edliaw@google.com>
 <20231024231429.GA282313@pevik>
In-Reply-To: <20231024231429.GA282313@pevik>
Date: Tue, 24 Oct 2023 17:46:30 -0700
Message-ID: <CAG4es9XP8UWtR6Z4jx+Oe1H4FoL=Rb1PFkShctBsC2Jkp7kg0g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_kvercmp: Handle larger kernel version numbers
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBPY3QgMjQsIDIwMjMsIDQ6MTTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4gd3JvdGU6Cgo+IEhpIEVkd2FyZCwKPgo+ID4gQ3VycmVudCBpbXBsZW1lbnRhdGlvbiBjYW4g
b25seSBoYW5kbGUgcmV2aXNpb24gbnVtYmVycyB1cCB0byAyNTYuICBCdW1wCj4gPiB0aGlzIHVw
IHRvIDEwMjQgYXMgc29tZSByZXZpc2lvbiBudW1iZXJzIGFyZSBpbiB0aGUgMzAwcy4KPgo+ID4g
U2lnbmVkLW9mZi1ieTogRWR3YXJkIExpYXcgPGVkbGlhd0Bnb29nbGUuY29tPgo+ID4gLS0tCj4g
PiAgbGliL3RzdF9rdmVyY21wLmMgfCA0ICsrLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9rdmVy
Y21wLmMgYi9saWIvdHN0X2t2ZXJjbXAuYwo+ID4gaW5kZXggNTUyOTIwZmFjLi45ZTFhNTExYWYg
MTAwNjQ0Cj4gPiAtLS0gYS9saWIvdHN0X2t2ZXJjbXAuYwo+ID4gKysrIGIvbGliL3RzdF9rdmVy
Y21wLmMKPiA+IEBAIC05Miw4ICs5Miw4IEBAIGludCB0c3Rfa3ZjbXAoY29uc3QgY2hhciAqY3Vy
X2t2ZXIsIGludCByMSwgaW50IHIyLAo+IGludCByMykKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgY3VyX2t2ZXIpOwo+ID4gICAgICAgfQo+Cj4gPiAtICAgICB0ZXN0dmVyID0gKHIxIDw8IDE2
KSArIChyMiA8PCA4KSArIHIzOwo+ID4gLSAgICAgY3VycnZlciA9IChhMSA8PCAxNikgKyAoYTIg
PDwgOCkgKyBhMzsKPiA+ICsgICAgIHRlc3R2ZXIgPSAocjEgPDwgMjApICsgKHIyIDw8IDEwKSAr
IHIzOwo+ID4gKyAgICAgY3VycnZlciA9IChhMSA8PCAyMCkgKyAoYTIgPDwgMTApICsgYTM7Cj4K
PiBJIHdvbmRlciB3aHkgeW91IG5lZWQgdGhpcyBjaGFuZ2UuIE51bWJlciA+IDI1NiBpcyBhY3R1
YWxseSBvbmx5IHRoZSB0aGlyZAo+IG51bWJlciwgYnV0IHdlIGhhdmVuJ3QgY2hlY2tlZCB0aGF0
IHNvIGZhci4gRG8geW91IHBsYW4gdG8gdXNlIGl0IGFjdHVhbGx5Pwo+CgpJdCB3YXMgY2F1c2lu
ZyB0aGUgbWlub3IgcmV2IG9mIHRoZSBrZXJuZWwgSSB3YXMgcnVubmluZyB0byBvdmVyZmxvdyBp
bnRvCnRoZSBtYWpvciByZXYsIHNvIGEgdGVzdCB0aGF0IGhhZCBhIG1pbiBrdmVyIG9mIDQuMTkg
d2FzIHJ1bm5pbmcgYW5kCmZhaWxpbmcgb24gYSA0LjE0LjMyNyBrZXJuZWwuCgpXZSB0cnkgdG8g
ZGV0ZWN0IGZ1bmN0aW9uYWwgY2hhbmdlcyB0byBhdm9pZCBwcm9ibGVtcyB0byBjb21wYXJlIGFi
b3V0Cj4gbWFpbmxpbmUKPiBhbmQgKmFsc28qIHdpdGggc3RhYmxlL0xUUyBrZXJuZWxzLgo+Cj4g
Tk9URTogY2hlY2tpbmcgZm9yIDNyZCBudW1iZXIgYWN0dWFsbHkgZG9lcyBub3Qgd29yayBmb3Ig
RGViaWFuLCB3aGljaAo+IHJlcG9ydHMKPiBgdW5hbWUgLXJgIGFzOiA1LjEwLjAtOC1hbWQ2NCAo
dGhlIHJlYWwgdmVyc2lvbiBpcyBvbmx5IGFzIGFuIGNvbW1lbnQgaW4KPiAvYm9vdC9jb25maWct
KikuIElmIHNvbWV0aGluZyBzcGVjaWZpYyBpbiBzdGFibGUgd291bGQgYmUgbmVlZGVkLCBpdCB3
b3VsZAo+IGhhdmUKPiB0byB1c2UgdHN0X2t2ZXJjbXAyKCkgKGUuZy4gdXRpbWVuc2F0MDEuYyBm
b3IgVWJ1bnR1KS4gTWF5YmUgeW91IGhhdmUgYQo+IHNpbWlsYXIKPiBwcm9ibGVtIGluIEFPU1Ag
a2VybmVsLgoKCj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gICAgICAgcmV0dXJuIGN1cnJ2
ZXIgLSB0ZXN0dmVyOwo+ID4gIH0KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
