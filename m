Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF581C5B572
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 14:58:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C25243D0649
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 16:58:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C7063CB8FE
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 16:57:58 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1FFF6200231
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 16:57:58 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-52838fe2172so4384971cf.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786460277; x=1787065077; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X42hLc5K8jMKCgB1FBeAJhtbObDC8Ejqbw5Bml6GHEw=;
 b=cdHi8AOzCsGe3WzqmHJiG/gg595WVrFprXtgC2xfIHDn+i/TW9wVQrEKwRbZ0ikn9+
 gY9r7s12U15GHOnCGbqzCH+N+vHJrORcRPvizgY5jZB26bjh7RF8r/LuvlnlwUGAfsey
 KCPoY4l0YB4QjoLZzzPfeQSjnfWHapx2W83TGDf4bMy5uinjc5Df5dqNFyRNkclCdvU0
 XBcfaYjKYYIIJ5VZMFn+uuZ2rcwnmzA6bKmVVN9OPkaCiLL5+ccH/Lfpxo5fky9FWV98
 B/P83lJiEiBiSEZSNosQ5c5kFBzv726QjavD6wV66HRqIpxX6xz3qbLwg71kkuk5BesX
 qd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786460277; x=1787065077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X42hLc5K8jMKCgB1FBeAJhtbObDC8Ejqbw5Bml6GHEw=;
 b=ZafGWG5uG2uqe6F/G/wyrAQ9VqO9K0DXmDzcIun1RTBltxoAj2sobqJiI57aqjFOws
 P4IKDROF1aY79t6eGVPAxc9ll0IPfawzV/CiUIPUuvRsEV8LfzkCM7U30ofcbNEffgVm
 mtN6Pz6v9/7wtzhSXvusFQkuWMHbI2irt51w/za+LoO+JxJ9aUj0GDoigCylGtlaj+Kv
 oLHlL1tA2GXYkuO0EaHyrqmu2nI6oRgdqzLvZFw54xOLjJMRxcggBR8sAIYQiNVYzKHo
 cyLyQyiF7uJWR5bbvAfUrGWvvCOiBdWqkTUN38UlPl7DjI0gK8zJDfG+YEf9FWvRd1ol
 ANkA==
X-Gm-Message-State: AOJu0Yz/RcCwFRE5ZB/MT+qFB1RXl1GJsf/+9qK/uwF6J4HlSr4ZNUcf
 1RN/y9v49eYFadjJD9mgvikzZ7YnrUP9UXBfZJQaO8YTry/z1XqJeJDV
X-Gm-Gg: AR+sD13kav2R1Zj+PfSu+PrSXtJbUXxi+FHV7ozuQ3wJ1eiss1K8v5YoFd62FmpKahV
 yosYCn4X9299BjeIJsej6VD4y72XQ5d0AuQe1iCWhUNfPU8mkzp5eG4nixEYly+IfXt7Z0r9hBe
 RiQX6Jz7z3OSncXrUqYRzeQKJ5Aq4HX3TwMz6Wdha0LF4/Doko+UD7EMbXBB0xmRwTs0s07KA5/
 CWNCOlzNWXeuW3j9Szulj6XY8/UFAcuxpVAYoVjzOWghhyrkiuSPSeeO2NDwI4gmISTiJwvpsoZ
 oSz5lVNk8UQqZ7fV0R/yOxGCl0BepIMnSNrTveuQc0Hr9Sr6FFAB4B7UzDaVYs0WvZHeErozqDg
 zC/SP9gm72XjR5XLL58Pypddgr6wldTdnTjOnBPE4T07NjZ5ABnMX/Y5lBKxLrqbTxyMSvBNJch
 iPQY2sDuLrbLdOAesPE6ZpJtBQF4k+tQ4QznY6Wwm3Gbo60zKWuX5awr1cI0XkVClOHdnEySY4o
 OotBxVjyEwFvMLetynKy/OvMFD1TNpbkr4/Dg+ev3O8WN2uGi5wCOp+yS66bhso9dOU37sU5OOi
X-Received: by 2002:a05:622a:54b:b0:51b:9878:8242 with SMTP id
 d75a77b69052e-52d584f61c4mr31349271cf.6.1786460276596; 
 Tue, 11 Aug 2026 07:57:56 -0700 (PDT)
Received: from
 runnervmzvulz.2d4yuw4mzllehnbsihy5bpj2mb.cx.internal.cloudapp.net
 ([20.81.159.116]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d57bd25f3sm12585991cf.15.2026.08.11.07.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 07:57:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 11 Aug 2026 14:57:54 +0000
Message-ID: <20260811145754.3959-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811144854.97821-1-avinesh.kumar@suse.com>
References: <20260811144854.97821-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Remove timer_*/speculative tests for invalid
 timerid
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Tue, 11 Aug 2026, Avinesh Kumar wrote:
> openposix: Remove timer_*/speculative tests for invalid timerid

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/speculative/6-1.c
> deleted file mode 100644

Could timer_getoverrun/coverage.txt also add assertion 6 as WON'T with the
rationale used by the other coverage updates? Its table still stops at
assertion 5 although assertions.xml defines assertion 6, so deleting all
speculative/6-* tests leaves the assertion's disposition undocumented.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
