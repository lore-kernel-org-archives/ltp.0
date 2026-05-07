Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04BCD3445
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB3043E2497
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:40:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01DDD3E2497
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:39:58 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D75E600277
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:39:57 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-130a4aae5ccso2077307c88.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778146796; x=1778751596; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMGHJXGfeUpjfTZk0XpnjgqoHPX4Y1+7TAWthqjuXa8=;
 b=Js9EXSe+hR8VTd0M+rCn8tk8hvYx89LpHQ3D7KAP5W61G5rqHCVeb48wYzkMsmRtBL
 P7aFeETamb55iOHJ3saY3hNGfqAtkDgE+kuSzii6l+JLcM9FYpMukMTC88/eniIT27Tq
 pvqfdlpTHiobCAJS4j4EAoObdo9YdAm2SKOzwxNBwqOnZu0M0UW/OSVkwj/rvJgbWQVN
 5cmTZX/cUeObD5G0iA5cMDfME3zFsokkaj5GhWO2welgZ6pMwfvIb+DwReKG5f51p5nA
 jn6/dHrRSkEHPj9NixNRoLDMnGIrTtE7Sn6Tf4jaRovndtyHN3JP8yNrhgPGo7P+oE0m
 hd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146796; x=1778751596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WMGHJXGfeUpjfTZk0XpnjgqoHPX4Y1+7TAWthqjuXa8=;
 b=FHZreStc6Cc+sk8DOTUPCS97fSc/UQrWwqq/6/aSPSwQJF9TygZKTh8uPBdTS80b9V
 D7cSYJGwZHin+/CsmZji+lsdBX6Q2EKkcM00FhYufTmUABT/SESQCnT609LAYAwtA0s9
 ErKslcPlKu5AT6JWdb8OiBUo8ibU42sZYbEJQAzKptHMP65XufFJiDFAi6HceAtCw1w9
 i89GEWtLW9oe10rLrFKu0VwpITEl1zIY+kKrktumvRViGXikqtT594Ck6gh/uKO8tiiG
 VJMQX1Ahr6RrJEyofJkKHyCNEz8c96FI08eaw48zXtLWEJ1MjeMSIu2pycGAa+3jjzho
 msSQ==
X-Gm-Message-State: AOJu0YxhX0xbGGi+jlj7TfrbGI0DKPMgYbbE8SiYnK/YiynCQnlHL/cX
 OxHNF0NjxSFZT5+aSQhjUqG2fiZy+Eg8UmGcijdK8f6VlUxuwOtpsFP9
X-Gm-Gg: AeBDiesqJTVyqUXVrO3lC5cmrOueiO9ieCc1jnbT0GMuYpTi6ddrfMh6MYlYI7GyYEQ
 ryD9abDt2GDhpkofJLSoaPHerM3uqw8Et0Y7YIL5Am7Jfj3tLbC7/UUxU/3AqFMcXrxm91yXBF7
 6YqPhd2+7m3YZOhPDl4IJraDxoJ71xp5oOeN2VFUaLjKXBz4WV1GdvCJoy98p8yJjehPvwDkU5Q
 rDd7InqxSRtAbK+5xzxA4FnLI49O6W+JYfMxUHCJ9aBWfcAZRsnqkPsVIHTzuhZUHyX3v/rg43S
 nET1fkx/r07k1hxcox9C3LwFGTbrixYeTIuV0mGnLivu1cqJAtg3S5J/wykojkvc33QebT/lx99
 olT4PI6HCR6ysSXh7mUPU7Wr+JGYu4rk/wnn5VzEpz4Eb52qwPyg5/9I4ojXabQtBwDGbeTtAyg
 mky/ekwt4eBod8vWjJlSnWjkxPgBPP6WCPcWzmdpWBGDpwViH7YZ1IJdJlisVH+khWRO3aJW7mI
 T/sZaeH3Omi20QgY2BGjPkhUbR6M/ZJ26QQi1lQS9VZW7X9Z3luGvXWPkDl
X-Received: by 2002:a05:7022:92a:b0:12a:7165:7405 with SMTP id
 a92af1059eb24-131853edbddmr3721707c88.8.1778146795877; 
 Thu, 07 May 2026 02:39:55 -0700 (PDT)
Received: from
 runnervmeorf1.w42nivuh1ygu3fj3od5gocisve.yx.internal.cloudapp.net
 ([57.151.137.37]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-131f9789e3dsm7596515c88.8.2026.05.07.02.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:39:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu,  7 May 2026 09:39:54 +0000
Message-ID: <20260507093954.4091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507073417.64123-1-sachinp@linux.ibm.com>
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Add io_uring04 test for vectored I/O operations
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU2FjaGluLAoKT24gVGh1LCA3IE1heSAyMDI2LCBTYWNoaW4gU2FudCB3cm90ZToKPiBbUEFU
Q0ggMS80XSBpb191cmluZzogQWRkIGlvX3VyaW5nMDQgdGVzdCBmb3IgdmVjdG9yZWQgSS9PIG9w
ZXJhdGlvbnMKPiBbUEFUQ0ggMi80XSBpb191cmluZzogQWRkIGlvX3VyaW5nMDUgdGVzdCBmb3Ig
cGFydGlhbCB2ZWN0b3Igb3BlcmF0aW9ucwo+IFtQQVRDSCAzLzRdIGlvX3VyaW5nOiBBZGQgaW9f
dXJpbmcwNiB0ZXN0IGZvciB2YXJ5aW5nIGJ1ZmZlciBzaXplcwo+IFtQQVRDSCA0LzRdIGlvX3Vy
aW5nOiByZW1vdmUgdW51c2VkIGlvX3VyaW5nX2luaXRfYnVmZmVyX3BhdHRlcm4oKQoKU2VyaWVz
IGxvb2tzIGdvb2QuIEFsbCBmb3VyIHBhdGNoZXMgYXJlIGNsZWFuIOKAlCBwcm9wZXIgc3RydWN0
dXJlLCBjb3JyZWN0ClNBRkVfKiB1c2FnZSwgcnVudGltZSBkZXRlY3Rpb24gdmlhIHNhdmVfcmVz
dG9yZSBhbmQKaW9fdXJpbmdfc2V0dXBfc3VwcG9ydGVkX2J5X2tlcm5lbCgpLCBhbmQgbG9naWNh
bCBzZXJpZXMgb3JkZXJpbmcuCgpSZXZpZXdlZC1ieTogTFRQIEFJIFJldmlld2VyIDxsdHAtYWlA
bm9yZXBseS5naXRodWIuY29tPgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSBy
ZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiAobm90
IGF2YWlsYWJsZSkKClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRp
dmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQg
aXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25v
cmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
