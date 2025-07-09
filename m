Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6541C83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752066722; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=BrId7RWqVFLS/v6zfcm8TrSgATqMV5SBveNkbjSDzsU=;
 b=ow8eLRjoOWRbO2XHakS4A5FwlkgY1wl723gDjPo3h3wUsc2FYc8qYym+aW3oN8qaCoXAB
 vtv2Jv4w/RSOPl+SYkMJMgVfU4mmPuBGnkN+xDDv4her44F4x5ZCb2LqMPZ2dpBs3Dp0UlZ
 pyyeAJkLDQTQubujYbyijpDXlj/iaH4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14A4B3CABF5
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 15:12:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 606803C8C3D
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:11:40 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4CA89208DE6
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:11:39 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so4508818f8f.2
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752066699; x=1752671499; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LmBABBuzsX0xQSdfnqN9aAkigjHvudrKXZY+IMkuySE=;
 b=PEzqZxy5RkPDyrh4KhGsQDKROVw0/GhJehgMK+hR9sXke/42Nkj9F17QH36uzDil4V
 p/OqsFhuVCIlERZg/jSvC2uQQG/qkZJJWPb2UvhrUcDDrmloZt+TaC/9pniCoDpd8u1F
 BhDFFIib4qLiGXMbD1G1zxd4DIn8W0gi9BzISSoLZoFhkDx4n6ty5TPOfR172qfqKFuQ
 gcNZRI+aWMrYesyOXeWz+k8H0b4L4yoFwZQxJhC2/P/Vi53DYeCVvFqH6XhBfYNLW5PP
 qLEb07rYz+JxXQZNYuHqzC9KhDCOT1sdSSoGKYqq3LvrR8vfbJY12Zdbs/9XfKX0DHtK
 p9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752066699; x=1752671499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LmBABBuzsX0xQSdfnqN9aAkigjHvudrKXZY+IMkuySE=;
 b=RP4eZJZIrUBYXGQctHzvVl7Q3pyiO6ibusbI0abyZfymn0Szw3sq9Ds5ynhxfGrOKf
 1VLoLJoFhXaJ2TH+wp9GXtXCwfGtu4RZ80fAyU0rDTWtDSF8YSlVpCImO/tnsj5hhqY3
 GunbNCm4Iqp7i5AaG2UCLEjEBRLTU1BG/dYS+RKn/X6CCe35edNiN9t2pFnPgdg5zffg
 6Bnojyiq2l6dT119qXxPVEut1A/x+XUMUdJtaRTtrrprLMxQ9HoU6Rn+qBKulFYq/pTt
 7vWn9x+tJaIYIbJJLMte+PePM40zn4Xx/YQX0Mq79f0DI6gxqSn0rcnWOJfulu0MkQY4
 Hr3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSe5wOxPhi0zO7AU4BeZwQOLZUouqLbapCSB6nB/MxAmp5ZNpJiq7RrIIkUiMliLodwdI=@lists.linux.it
X-Gm-Message-State: AOJu0YztICXxe5HDVeMC3a2InBkfjm1CxvG/lLMhpY1FBSjW7JzdpQbi
 iqT+58HIy8TOisf2GBCgeXjH0v5XAByGsKN889FY3UOCfRIg8SL63yBvNHhxCFkQFbQ=
X-Gm-Gg: ASbGnctR4RXFfZ9CDRGky4ailoRNbjNSYB9FzqnPwavgeSbJsRXD2U29I68J3Fleqta
 AQl3/86IrhqBnWlVXWmJ36gCRDmJFn6bMyD+4YF4P9YvsnxfyNAAvNCyNAWslnnP1QfxAcvZlPM
 14f1x5dy5OIaAa0qLHEyO6mvKKMXkagl6Q+NGkOmT2HmDT4lB3MhTGu85EEfK407ZKK9onUC+tQ
 gjXr3AOipmOoLB/tBDcb82ByF/krrXXoqwOr3QWCui6o4R9z6o1F+EQFII6dcWDUVVEnFgkquTH
 pUVFr9TZO+1ocvbo5D6twy8hHcVLjN3q+R9dyFZ9hpNMhtEUtCtxMVGL/xhdoi2A/Cn6nB8C0gl
 x5SnsMvU566SVJQDz0YCNse1LutKCyL6dGOaoS8jSLDUIp8PlmxIDmDYrCA5p2sETuqGdDVKXFT
 CV2L4n6PHnMeoh2nKBC3vgAKzzZTBDzAnrEEqX
X-Google-Smtp-Source: AGHT+IHnyCGjh1mUsAOJ9uCYzM/9jH9HD9m0YyLfxTAMbwMOD1JHmGmMfyROdAoVZ2NVDjKdWCk7cA==
X-Received: by 2002:a05:6000:43d4:10b0:3b5:e5c9:93c5 with SMTP id
 ffacd0b85a97d-3b5e5c9940bmr900880f8f.49.1752066698609; 
 Wed, 09 Jul 2025 06:11:38 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eaaa70416sm1759035b3a.98.2025.07.09.06.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:11:38 -0700 (PDT)
Message-ID: <69aa84ad-9720-4f66-9a4d-d994ff23c28f@suse.com>
Date: Wed, 9 Jul 2025 15:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-1-aa043b0182fc@suse.com>
Content-Language: en-US
In-Reply-To: <20250708-conversions-mremap-v1-1-aa043b0182fc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] lib: safe_macros: Fix memalign() failure
 error format
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbT4KCk9uIDcvOC8yNSAxMDoxMSBQTSwgUmljYXJkbyBCLiBNYXJsacOocmUgdmlhIGx0cCB3
cm90ZToKPiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+Cj4gU2ln
bmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiAtLS0KPiAg
IGxpYi9zYWZlX21hY3Jvcy5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbGliL3NhZmVfbWFjcm9zLmMgYi9s
aWIvc2FmZV9tYWNyb3MuYwo+IGluZGV4IDY5NDZjYzViY2I5NDIwMmE2N2ZjYjk4NmE1MDRlNzdh
YjBhMjc3MzguLjU3YmMwYmM3NDk3MTJmMWI4OTA1OTQxMjNiNmI5ZjNjYWJjZTgyMWEgMTAwNjQ0
Cj4gLS0tIGEvbGliL3NhZmVfbWFjcm9zLmMKPiArKysgYi9saWIvc2FmZV9tYWNyb3MuYwo+IEBA
IC04MjEsNyArODIxLDcgQEAgdm9pZCAqc2FmZV9tZW1hbGlnbihjb25zdCBjaGFyICpmaWxlLCBj
b25zdCBpbnQgbGluZW5vLAo+ICAgCj4gICAJaWYgKHJ2YWwgPT0gTlVMTCkgewo+ICAgCQl0c3Rf
YnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgY2xlYW51cF9mbiwKPiAtCQkJIm1l
bWFsaWduKCkgZmFpbGVkIik7Cj4gKwkJCSJtZW1hbGlnbiglenUsJXp1KSBmYWlsZWQiLCBhbGln
bm1lbnQsIHNpemUpOwo+ICAgCX0KPiAgIAo+ICAgCXJldHVybiBydmFsOwo+CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
