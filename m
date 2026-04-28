Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C392FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 09:30:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D35223E49E2
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:30:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FA753C61A8
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 11:30:27 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 647A81A008A0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 11:30:27 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8eea23d01f7so735895285a.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777368626; x=1777973426; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg4DIZTvb1zwWna/k9WVNOqidaeMmTJyOKJxmA5kMP8=;
 b=LCFOTADNVThKe0/EldmyJBAxJN+7EJKiSCNvl4T4ExEKTV27j3UE70R5Y3TiyW9ha1
 c8mJAIUTQIqVF0FXK+vIKjtJ6KXJ2drJj095l1zpoKQNtnoivIYghP5PoE7LT8h6XB5r
 DIll07utpgDJ2c9NhDQx+FNiIPxTzZqfiU9aworg3o7OP49wJmdeFKyplHuTcS2Waea9
 InKusm41zYcTREQufU0a8+V0K1rhWnH7ZgHvlBRxhvgvfDI1FxDvnn1zepgBSgbUmqMd
 odpzhq1IsPtbyvsh1+L+SRZjGzj6EWxMMY5NooCy+mtmHQLkvCbifVTrlSvdQG758zag
 5h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368626; x=1777973426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pg4DIZTvb1zwWna/k9WVNOqidaeMmTJyOKJxmA5kMP8=;
 b=pf9fixBQzJHWWRNxFPJhXi7cJ6eGpdi/Nyq4K3AHiSX2s2LSHwQIGOwm34rQ8sxBee
 H1l+lTH5z3FgEVX5TIe8GFLj0GORbHeumVfox+HUomoreUqA/ZbyQ/S0kAq66HW7Pz18
 NWqE4qyM2+Uha8gjjS9NJr8VhveSNhFnUty9plmFyhny0Ilo8JUOiDzVhozgXtD0XdAl
 rfZqtk6AmnmaY2FcW+5+O0ULZLzN5Oh4Pgd6tzL1XiUAKnUsREAOFIfoLw0gc9PXdPaM
 aSi47mYoBxjRM6ksE9j2urJKJkEArmCh9eIP6Dpl8oYesd5DQhLNfrDuTESGlCU4yz9p
 X2HA==
X-Gm-Message-State: AOJu0YxuoI9ypnu/i3bViXf/6muT5DOUCBUKcxhTPd1mFRYY0cqkfvxW
 jc2We8MD6rZD4ChtfYceNWhodL7gnJ1xOpHsOgoD6IfdukMRME5ZapNQovP9+9JtAd0=
X-Gm-Gg: AeBDievo+ZRdkFuvIgwvq9BVJlfCJUtWIOpdLlA9kp4aJ97vLuYw3cC4WD3KPWwNBTA
 AcrpAmptEulSHCpWDYzCtpi3WiI2ycV1cIt0HWRTaJ4ifX+boQVzckliXJlxsQSUIrUXY7lFjjW
 siOlKURhdvSXA0rSSzI77OJvbl3Ps2n2qa2X4svxk5xmo0NTdPR2iupnzEGKAoK5XuATVpU7pyR
 9xy0sUNTc8W0Gp8Fw+sXIPQ681QoEN3H4uUwhFekgM9x4vOBhAoZ6bdOBjdbh+gxPm2mwgZtPhX
 8WsU+GGpzt6lPkGLXEbz5/h+IUjICj4rlYLUPp0UzI6D/Jx3SRQAks06h06oba5A8475eAtyz88
 0m0own67oqvNRJZnU169rDbM7b8FLx+lENFRPfz77wjS2qqjYcEecQTbSkAT3xlc8z4fnpIitlO
 xF2pN3LOb276ZSgT7rrmNK8TSGEy3J/OvHyjiTaSEPOPf1W8Y0XCu37WHQ/LScmBZlGQib2vTMd
 1WSntYyfn2vghi2kIQhXSNFp40nDKkwNL1WFc2FV8xKR/8BuhM=
X-Received: by 2002:a05:620a:4453:b0:8cf:ebd2:f8e1 with SMTP id
 af79cd13be357-8f7d990420cmr286249685a.53.1777368625926; 
 Tue, 28 Apr 2026 02:30:25 -0700 (PDT)
Received: from
 runnervmhkfpo.wzbkwdbpglyu3opx21frospznb.bx.internal.cloudapp.net
 ([48.217.251.137]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c899f58fsm144472485a.44.2026.04.28.02.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:30:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: lufei <lufei@uniontech.com>
Date: Tue, 28 Apr 2026 09:30:24 +0000
Message-ID: <20260428093024.3971-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428075054.105295-1-lufei@uniontech.com>
References: <20260428075054.105295-1-lufei@uniontech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Rewrite ftrace_regression tests with new C API
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

SGkgbHVmZWksCgpPbiBUdWUsIDI4IEFwciAyMDI2LCBsdWZlaSB3cm90ZToKPiBSZXdyaXRlIGZ0
cmFjZV9yZWdyZXNzaW9uIHRlc3RzIHdpdGggbmV3IEMgQVBJCj4KPiBSZXdyaXR0ZW4gZnJvbSBv
bGQgc2hlbGwgc2NyaXB0cy4KClBsZWFzZSBleHBsYWluIHdoeSB0aGUgY29udmVyc2lvbiBpcyBi
ZWluZyBkb25lIOKAlCAiUmV3cml0dGVuIGZyb20gb2xkCnNoZWxsIHNjcmlwdHMiIG9ubHkgc3Rh
dGVzIHdoYXQsIG5vdCB3aHkuIEFsc28sIHRoaXMgYnVuZGxlcyB0d28KaW5kZXBlbmRlbnQgdGVz
dCByZXdyaXRlczsgcGxlYXNlIHNwbGl0IGludG8gb25lIGNvbW1pdCBwZXIgdGVzdC4KCj4gK3N0
YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICt7Cj4gKwlpbnQgaTsKPiArCj4gKwlmb3IgKGkgPSAwOyBp
IDwgTE9PUDsgaSsrKSB7Cj4gKwkJU0FGRV9GSUxFX1BSSU5URihTVEFDS19UUkFDRVJfUEFUSCwg
IjEiKTsKPiArCQlTQUZFX0ZJTEVfUFJJTlRGKFRSQUNFX09QVElPTlMsICJ1c2Vyc3RhY2t0cmFj
ZSIpOwoKdHJhY2Vfb3B0aW9ucyBpcyBtb2RpZmllZCBidXQgbmV2ZXIgc2F2ZWQvcmVzdG9yZWQu
IFRoZSBvcmlnaW5hbApmdHJhY2VfbGliLnNoIHNhdmVkIG9sZF90cmFjZV9vcHRpb25zIGFuZCBy
ZXN0b3JlZCBpdCBpbgpyZXN0b3JlX29sZF9zZXR0aW5nKCkuIEFkZCBUUkFDRV9PUFRJT05TIHRv
IC5zYXZlX3Jlc3RvcmUuCgo+ICsJU0FGRV9GSUxFX1BSSU5URihwYWdlX2ZhdWx0X3BhdGgsICIl
ZCIsIHBhZ2VfZmF1bHRfb3JpZ2luKTsKClRoaXMgcmVzdG9yZSBvbmx5IHJ1bnMgb24gdGhlIG5v
cm1hbCBwYXRoLiBJZiBydW4oKSBhYm9ydHMgdmlhCnRzdF9icmsoKSBpbnNpZGUgdGhlIGxvb3Ag
dGhlIGVuYWJsZSBmbGFnIGlzIGxlZnQgc2V0LiBVc2UgLnNhdmVfcmVzdG9yZQpvciBhIGRlZGlj
YXRlZCBjbGVhbnVwKCkgaW5zdGVhZC4KClsuLi5dCgo+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkK
PiArewo+ICsJaW50IGk7Cj4gKwljb25zdCBjaGFyICpjb25zdCBjbWRfbHNbXSA9IHsibHMiLCAi
LWwiLCAiL3N5cy9rZXJuZWwvdHJhY2luZy8iLCBOVUxMfTsKCi9zeXMva2VybmVsL3RyYWNpbmcv
IGlzIG5vdCBndWFyYW50ZWVkIHRvIGV4aXN0IG9uIGFsbCBjb25maWdzLiBUaGUKb3JpZ2luYWwg
dXNlZCAvcHJvYzsga2VlcCB0aGF0IG9yIGFkZCBhbiBhY2Nlc3MoKSBjaGVjayB3aXRoIFRDT05G
LgoKPiArCVNBRkVfRklMRV9QUklOVEYoU0VUX0VWRU5ULCAic2lnbmFsOnNpZ25hbF9nZW5lcmF0
ZSIpOwo+ICsJU0FGRV9GSUxFX1BSSU5URihUUkFDSU5HX09OLCAiMSIpOwoKTmVpdGhlciBTRVRf
RVZFTlQgbm9yIFRSQUNJTkdfT04gaXMgcmVzdG9yZWQuIEFkZCBib3RoIHRvIC5zYXZlX3Jlc3Rv
cmUuCgotLS0KUHJlLWV4aXN0aW5nIGlzc3VlcyBub3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBj
b2RlIChub3QgaW50cm9kdWNlZApieSB0aGlzIHBhdGNoKToKCi0gZnRyYWNlX2xpYi5zaDoxMDkg
4oCUIHR5cG8gImZ1bmN0aW9uX3BvZmlsZV9lbmFibGVkIiAoc2hvdWxkIGJlCiAgImZ1bmN0aW9u
X3Byb2ZpbGVfZW5hYmxlZCIpIHByZXZlbnRzIHJlc3RvcmluZyBwcm9maWxlIHN0YXRlCgotLS0K
Tm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBh
Z2VudCBjYW4gc29tZXRpbWVzCnByb2R1Y2UgZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVu
IGl0cyBmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYKeW91IGZpbmQgaXNzdWVzIHdpdGggdGhlIHJl
dmlldywgcGxlYXNlIGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUKdGhlIHN1Z2dlc3Rpb25z
LgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
