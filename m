Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416AF8A140
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:03:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C2FA3E262F
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:03:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E46233E2DE6
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:03:09 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8043D600860
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:03:09 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1279eced0b9so11209318c88.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776326588; x=1776931388; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2jVbToG2xbbGnax4nzP6dZtd/pIuuuxQYlz7iTJ6L8=;
 b=eeUuFbmYNp/Bm1yNLvmNFd7OggWKiPKoKCkaKdSas95M/IHb8GBDKKkS6Dcd4NsxcR
 pvs1VJObZ7QDoEP63Aurb1v6XMpOfdMMkXre7T5bQJp89NOQnCqSFiuZtkE9LWwTkP/I
 x99LAPEf3/MfVIlYJ+abdVCvQmx0yxbRYyGAc4zVApXtNlxvpn3YkMBiwpxg0F+Qj2Ry
 BqcZjkCDLpbTXuyVy6MF1v+cGruEaCwhsuo+N3m9L1c9KI4yhSLUgYstJfNY2nRlbRG3
 3W6bPlwUdjt1A2gnGfba5DI4Otbhl/YhTdif0aDbnCF7o9/6hxllgP1bpy3lww023WQe
 1Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776326588; x=1776931388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2jVbToG2xbbGnax4nzP6dZtd/pIuuuxQYlz7iTJ6L8=;
 b=VGxCOoaxNp/GUvfZwSXB5UjWjESHY2KWpMwe4v952ZakUR4DQy8mrab5CAyq1KGZWE
 XH+rZN7rPd7KGmF+Foq+B+5v70CwxibOU3hsOtZWeknxrGlmFamoiZ1U4JuFLIJriwD4
 BlCdjcadI5bw/kX2EIdAItZAdCPjS0RF+LwoppcniA6QgFb+dM7iH/it9OR3T5DJ+AgC
 fhIPucTvCC/TGnk64Qa/4jhabvlluGJr9tMgAPVxilP2j0NExGMQzFgfpaumifABsBTf
 IBFJgrFWDwhN5sPghSUQ75LMhEOJ63NvmInvHxIuOkjKUKW985LrUgodzHsaYdy9NNLc
 peSA==
X-Gm-Message-State: AOJu0YxPrBzgJU/rzXzMy5syJrwfKCoZbQfcfXt0I1LcrMd8/WNZZRJh
 RAh2Dy2T+GUn2otuKo2b6wdYulDYP4ey4J/i6dAEQ4k15/z98BWRYElv
X-Gm-Gg: AeBDietpzI4EZJ9Cv3rrCILbAthsJOjXibnJXA4F0uVMlxzjBoAX8WTO1MUV38wYNzp
 ZGVjMhMFkvgJ5mvm9AkmZXC/Uh4WGK1F1WNm6cdHjYkD51rRxzTCIV+fXYxRZJmsnbLG88mJ2iN
 PFEzUuwSTVvKE5S6Y3qVuyHCcR1T5H40FMaioyMHM+YV4fG2dV5RxJ9kE1WlFJEsnTkkHQvOGpW
 4KKlysE8ncEr0biJJRUmokna5B2xWfCECjYBhqjzEcmXAbzPSHO0CKUE0vVUyNDjZUhwykVzN+Y
 cXaOUC/aAtjTCdYaJ9pWCdc+CckNVaGLQuTNlpW4Vp+HWTdFE89n8w7D0zw6tvsA3eKRD5SHzm6
 rXLW7L8FOAY5sWmaBzSbwNYW6iKdRkajctWvO+T+HO/78XFiuEJPrf8vtO8KZ+9zkMXeWFNXofw
 WRYQlE32YZTs+ssSH5uDnCIZIRQZoOjQqA1oxXaEB4VD8f3f6l9TNyAyl3sYC0FChb2MpqB332b
 Z+oooXxuBxjNOk2DYYxBgTBkJ0quWBC8J0/Tlc=
X-Received: by 2002:a05:7022:4a6:b0:128:d5f1:d595 with SMTP id
 a92af1059eb24-12c34e8f6e5mr14048578c88.10.1776326587665; 
 Thu, 16 Apr 2026 01:03:07 -0700 (PDT)
Received: from
 runnervm35a4x.naa1fqp52ykedpe5ofrqdcouyd.dx.internal.cloudapp.net
 ([104.209.12.71]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c5e6a8496sm5056274c88.10.2026.04.16.01.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:03:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 08:03:06 +0000
Message-ID: <20260416080306.4018-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416-fix_nanosleep_include-v1-1-f584b5556141@suse.com>
References: <20260416-fix_nanosleep_include-v1-1-f584b5556141@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nanosleep: use POSIX runtime detection for CLOCK_MONOTONIC
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

SGkgQW5kcmVhLAoKT24gVGh1LCAxNiBBcHIgMjAyNiAwODo1OTo1OSArMDIwMCwgQW5kcmVhIENl
cnZlc2F0byB3cm90ZToKPiBuYW5vc2xlZXA6IHVzZSBQT1NJWCBydW50aW1lIGRldGVjdGlvbiBm
b3IgQ0xPQ0tfTU9OT1RPTklDCgo+IC0jaW5jbHVkZSA8dW5pc3RkLmg+Cj4gICNpbmNsdWRlIDxz
eXMvd2FpdC5oPgo+ICAjaW5jbHVkZSAicG9zaXh0ZXN0LmgiCj4gLQo+IC0jaWZkZWYgX1BPU0lY
X01PTk9UT05JQ19DTE9DSwo+IC0jZGVmaW5lIFRFU1RfQ0xPQ0sgQ0xPQ0tfTU9OT1RPTklDCj4g
LSNlbHNlCj4gLSNkZWZpbmUgVEVTVF9DTE9DSyBDTE9DS19SRUFMVElNRQo+IC0jZW5kaWYKPiAr
I2luY2x1ZGUgImhlbHBlcnMuaCIKClRoaXMgYXBwbGllcyB0byAxLTIuYywgMS0zLmMsIDMtMi5j
LCBhbmQgNy0yLmMuIFRoZXNlIGZpbGVzIGNhbGwKZm9yaygpIGFuZCBzbGVlcCgpIOKAlCBib3Ro
IGRlY2xhcmVkIGluIDx1bmlzdGQuaD4g4oCUIGJ1dCB0aGUgZXhwbGljaXQKI2luY2x1ZGUgPHVu
aXN0ZC5oPiBpcyByZW1vdmVkIGFuZCBub3cgb25seSBhcnJpdmVzIHRyYW5zaXRpdmVseSB2aWEK
aGVscGVycy5oLiBFYWNoIGZpbGUgc2hvdWxkIGluY2x1ZGUgdGhlIGhlYWRlcnMgaXQgZGlyZWN0
bHkgdXNlczsKcGxlYXNlIGtlZXAgI2luY2x1ZGUgPHVuaXN0ZC5oPiBpbiB0aGVzZSBmb3VyIGZp
bGVzLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBh
dGNoLiBUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcwpwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRo
b3VnaCBvZnRlbiBpdHMgZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmCnlvdSBmaW5kIGlzc3VlcyB3
aXRoIHRoZSByZXZpZXcsIHBsZWFzZSBjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlCnRoZSBz
dWdnZXN0aW9ucy4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
