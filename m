Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122CCC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:13:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E41E3E9697
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:13:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA6033C0401
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:12:55 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6256210006CC
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:12:55 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f3c172f5so2172849a91.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783951974; x=1784556774; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mCTbZKMfiCrZkIli4SqOr3EBz/5VoaMtyeUEZClCjU=;
 b=Ud51Xk/3s9vggYwFGRrkZoaryqnTfUNjLA0kX91jyr0tXtexH8QdMTtP5Tn/X3ZNH9
 o5Gshe9Am44yD3QbqPyazYmlJGdMGQAR/Gpt5w/+LkMDsbKsyS6gEVKRwfTAEL11K+A1
 1MezaRTaHRvGfTUAluTesCZP2tc+zq0E3hnxcvnmKlZ45pBk6zrogKeRmaIuF6EWgW82
 UUrJLvMhEJwj8wXiJVDUW8bNPvmV/k43An2Z4mA2bfNmAbS/GelfZ1dZYUIBOMeVrIlH
 kotYewNjyPuj3wN4/yHbewbXIu7hNxcHyBwpBeJtnb3OPkxbFwVXP6/stbj9sTSUc9WL
 VhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951974; x=1784556774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9mCTbZKMfiCrZkIli4SqOr3EBz/5VoaMtyeUEZClCjU=;
 b=PYycCQ2w2t1FhZBCnt0ES71u7Zt6pYxVPz1j7qJ7T/KapuxaMv4n1H8X55xlhYJRCf
 ZHHb7I7dDKGZXZDD6YPbT2/gVWuiLOvF4kkK6VmOgaXjD1trZrrvK9Yq+tJFK7G2z6fo
 TtMHpy3ZkJPykYHH61SRDXVyMrc1EqPlnEwY7yiMhqiPttBAZLmqi2feqpVfnH4dPU3y
 grof/s2OGbGXDD2Gl73WqdMT13Uuva00Zau2o7O/aE1+YoDxjmU75XsYqpHAA/zYsKSx
 RezQZHoLQGtY0FuFD6HrdspikKaQE2EQEeqo4REI1aIFxszVpBmCOCjmX6YjhEmNCRgX
 wDOw==
X-Gm-Message-State: AOJu0YyzJqUZSVktgPqmt9OtVOHwDrMHBxIfSow3h6s4yEJgiHISqDZt
 yLoYgjIRTxFN3NEyJUEfPL0gynP7/5Jl1Jzd9MXWyTLh8zXgDVVCrhdK
X-Gm-Gg: AfdE7cksm5/EP04NlWkPl5PFBbEMEN7BBcBjkn/E1/VFMkT9Guimq3XiXvGzi1+YJmo
 tsCb6LX/4q9DoZBlJfinmDRSFq45vfEXQUyHpUZhOefYDg+b1ZBfrCVtXEh0UG6Wh/OBGFmUQw0
 sIe1rO15Ha5VNWjgOOOgYVuIbI5sE4ELVJE0XbLv4qcFxsO8KP8djg3xc8OCAr3vSloXHP4I4sD
 txTyNKr15w3rrQCxUJy0i3NzGEX4MldozyBsl/WZiZRXcR3XyzfGvC5ESpG7fgM4oRjbIYI5AZl
 VHgBetlyBzp6Q8LWdkwEIWdvUCENAY5G6xzsYFM+71AhzdviofQfnxiY09cO9cI3vpjf9Skr5rX
 SvKDlTgDCSJ57hyQ7Y15CECgJT8s1fRWOLVhQ+x/Z94Q0SeMU+2ltx2PZ8YU09uZngL+ay5MhMP
 WZweP1LzIW8tjWMRtglcw6qeoWdWR1+oSKxTqr7hZIyKa9VUdSOhQKndqddnBgyRGy0vyIn/kGl
 rkHs9T55Be81jpjZAZtu2ZUfj455LD3uQ==
X-Received: by 2002:a17:90b:4d84:b0:37f:9ce1:7367 with SMTP id
 98e67ed59e1d1-38dc7771584mr8958385a91.29.1783951973640; 
 Mon, 13 Jul 2026 07:12:53 -0700 (PDT)
Received: from
 runnervm5mmn9.kmusrrbtkyxulm0zfhyauikn0a.phxx.internal.cloudapp.net
 ([172.182.225.160]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174839f89sm71328453eec.10.2026.07.13.07.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:12:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 14:12:52 +0000
Message-ID: <20260713141252.4091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-shell_oom_protection-v1-1-b732e8647894@suse.com>
References: <20260713-shell_oom_protection-v1-1-b732e8647894@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shell: add optional OOM protection
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

Hi Andrea,

On Mon, Jul 13 2026, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> shell: add optional OOM protection

--- [PATCH 1/2] ---

> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 Linux Test Project
> +
> +TST_TESTFUNC=test
> +TST_OOM_PROTECTION=1

The new test is missing both the mandatory doc block and the mandatory env
block. All other tests in testcases/lib/tests/ carry them (e.g.
shell_loader.sh, shell_loader_cleanup.sh). Add at minimum:

  # ---
  # doc
  # Verify that TST_OOM_PROTECTION shields the shell harness from the OOM
  # killer and resets the test process oom_score_adj to 0.
  # ---
  #
  # ---
  # env
  # {
  # }
  # ---

> +TST_TESTFUNC=test

Is naming the test function "test" intentional? "test" is a POSIX shell
builtin and a standalone utility; shell-tests.md forbids naming functions
after common shell commands. Rename to e.g. "do_test" and update
TST_TESTFUNC accordingly.

> +. tst_test.sh
> +tst_run

Every other test in testcases/lib/tests/ uses the ". tst_loader.sh" /
". tst_run.sh" pattern. This test uses the pure-shell harness directly.
Is that because tst_loader.sh goes through the C binary (tst_run_shell)
and therefore never exercises the OOM protection that lives in tst_test.sh?

If so, can the test still be brought into the standard structure, or does
this require the OOM protection to be moved into the C backend first?

Verdict - Needs revision

Pre-existing issues:
  testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh uses
  TST_TESTFUNC=test (function named after shell builtin); it also lacks
  doc/env blocks. These pre-date this series.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
