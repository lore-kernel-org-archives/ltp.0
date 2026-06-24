Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0241CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:57:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D9463E6211
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:57:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F2AE3D0E80
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:57:32 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12A401000760
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:57:32 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso1222994eec.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782298650; x=1782903450; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4BfDnAlOS/azCvYCTHk7sANQjBsLQYigfdv1yeEQIg=;
 b=sZDeAHbYG7d3X/ULF7DjWA04ayBaGVuN/qhe/FHJuEFZ+qfvBRmsz3nEgwDjgYo3Fr
 Ti8JNQTWzJyXqN+vU6sdnk3Q9OxL7d8BAA8NH0ArIjSl5DaCsfmEPKE3BleF7Tj6/nXG
 WFYJWI1sX1/or3zvTRRz5oXdNWuW/qkoH6kxYynpf4dPFboZYz7L0d0lLitLkRizcO+b
 Rez3hAbFTU0CtVIxXadbuZevDqW33vgHWxCZsgp66NEVIBjoKUYwMyNGw8ENnuGA3/Fu
 W9e573plS7kLwF6Vp+x8cPOhxzGGdN/XVrMuY/hqotaMfESe+7Q9DN1rnMXuQDjV1Lx4
 3Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782298650; x=1782903450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/4BfDnAlOS/azCvYCTHk7sANQjBsLQYigfdv1yeEQIg=;
 b=f2KV4vPyhGDlwl9pMKCIs+17t1fvpyRkTHrGlB3eIyilqpX6dYAVVJstvqwCP7vX/o
 j0wwD7zn2eZBaJWFVgNVyShcm8g9u0YnrLUScjvqyfRD8Z2WhfqUgyAIPRuV30cjviF4
 SSAOtoiELaXbKcbFar6dX6TKFGPFiPw62+TYvNs3sHlpKyhwrJBaaTwF28OhZn+8ryuK
 JGWbvDsA7Tt13D8iiJUE+RFuaAbYwYMHwq+ydDV1COLJV+YeiWvob6/Ua3ZNuhmTsfC4
 ITUZunaVvQh/IwM6VgEk1lfxmydSQQGszfXbbEwnAeFzH22ooh5IUciyU0Bih+Quven7
 XsMw==
X-Gm-Message-State: AOJu0YzxfECm2OQa93MkMvbp/gwg3XCjM99usPgFRRAzvBSPpcbY2NZB
 wXk/N9z3iaqcF1pURLdu3X5yw1WThDr7ETAviLtyqdQU0tXEzL+tzzsV
X-Gm-Gg: AfdE7cl7klDas70jAdgJ6EMsrp6vMCPTLjEN2DSwkqneKchOzrP3i2un5fF2M4hvXvM
 xFdanlxb/ikeoWmi0Mu+RYwujPOoBoQtJXlWWyYORfqxcdaSXAGnUfwpLeU4Hdk8/6uQmf9eRsO
 KyY/addPlJl5IGTU9uuDC7T4Bge2rY1P1Y6xZD0sE6mstfCP52vGzN6GEC53aCb2N2Ejx/KyPHO
 wmY+SzpDxEbpXsAoNzUhPBKqVyZZZ28mkOJnvpDrbJqmXscezjdejtWb6vcti/IXevOHvxaahrC
 Xfn9HJiSplCAtv/7EJzolDmS5HYWvT6uXfdW4w85RSEjFmXaS3XoneziTafO6qq/u16S9Q+uhkQ
 d/MarG+ul8lbf8tfxHUdF7tWFasNoeIkH2jZTyRthhqRGNE5C65E1Vkaid8Ce5sTq9aPDWERUv7
 7DYtQhdfUQyeJhOvm5zjXb2qhb8nnZpiEV97csC7/VDPparkjTXsMzpeop0HDNu8h348bu8UGq+
 IhiO0zNW70wxYwwIHSURa84wWg+xHlrJu4LzYZL
X-Received: by 2002:a05:7300:2389:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-30c68dc1424mr2749990eec.22.1782298650254; 
 Wed, 24 Jun 2026 03:57:30 -0700 (PDT)
Received: from
 runnervm7b5n9.4xo3wpb4ugwubdrh1nu51nyeia.phxx.internal.cloudapp.net
 ([20.171.20.59]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c5af35cccsm10016402eec.30.2026.06.24.03.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:57:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jun 2026 10:57:28 +0000
Message-ID: <20260624105728.4178-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624091900.4107041-3-chrubis@suse.cz>
References: <20260624091900.4107041-3-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_test: Add may_kmemleak flag and annotate tests
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

Hi Cyril,

On Wed, 24 Jun 2026, Cyril Hrubis wrote:
> tst_test: Add may_kmemleak flag and annotate tests

--- [PATCH 1/13] ---

> This information was so far recoded only in the comment in the cve

Typo: "recoded" should be "recorded".

--- [PATCH 8/13] ---

> lib: tst_test: Move the iterations to struct tst_test

> -		iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
> +		tst_test->iterations = SAFE_STRTOL(optarg, 0, UINT_MAX);

safe_strtol() takes `long min, long max` parameters. On 32-bit
systems where sizeof(long) == 4, passing UINT_MAX (4294967295U) as
a long overflows to -1, making the valid range [0, -1]. This causes
the range check to reject all positive values, breaking the -i
option on 32-bit.

Should this use INT_MAX (as before) or SAFE_STRTOUL?

--- [PATCH 10/13] ---

> The tags should be in the format year-seq. With the CVE prefix our
> tolling is broken e.g. tst_test.c prints wrong URLs.

Typo: "tolling" should be "tooling".

--- [PATCH 12/13] ---

> We also drop the __NR_mmap2 ifdef because the lapi/syscalls.h defines
> the fallbacks to -1 when a syscall is not implemented on an achitecture,

Typo: "achitecture" should be "architecture".

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
