Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF761CD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 05:28:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B1A83E2749
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:28:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A9A83CE442
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:28:18 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B45A10009DD
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 07:28:18 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-3042a388168so1220390eec.1
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 22:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780637296; x=1781242096; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsXL7524RzlfMtiygWSskd0sWV5IbdatwY8UquF0CRY=;
 b=B4iDBX5Nc2cttdKYjH+Ia3y1dh2agSDQbC0OdmStrJ/d3nd2DHm/l0qQYGXmvv2ufk
 Ow2F3CIx64AJv3XMJ2ccrwUZbkrUhpI19QkpgMPVNiIHi5ESQw1TuX0If5xVMARaZnwG
 /MSAM9XGQlhqguT49zWaN889TFpjkzA6ENDgjcMZkm95MDLkYcE255nPI73vdxXSsolP
 oKjXBY7h7XDtsD2mJZr2uGnNanDMdse+CtH9zXcxo25H+Fb8PLTH6Y0erQJyJstWXj4x
 WQLnIMvXhPiiHOl9LuNJdDmr6HhA87K/8VmXH6ijA7UJ2rl/9ihColZLLKFBux7H7TTI
 ELvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780637296; x=1781242096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IsXL7524RzlfMtiygWSskd0sWV5IbdatwY8UquF0CRY=;
 b=HJwjwNLupgwARl3kc+wUfGpTY0T1Eg90UEW67rl8GLjJi8sCatkeeBRE9PDGDE0EHo
 A8QNe9dOonKT7LBSPyfeA3DeZGf9u5DXApoyC8LYAmJvNstTFkWlB4mXDwzUvBW9iTDR
 oDzGSnALeI4nkSpGDBVtK9sHcaBnAYxFK9HmKTEJBnR1VQwDaaKqAXlsE+XqKxd4yQ0R
 fMP/eN/6v9Ps/YtkTWl14AQ3+cY7+ViwmQu2vQrC2KA3gQBPzGpkhHWB+WVs7Lsj72y8
 eHRdFB9cQSvjpP0SuAXM38zjTo48xnjIlGxgjtlhP+MFZrC7+kgBBihbaeWU/Mrrj1uq
 ocaQ==
X-Gm-Message-State: AOJu0YyFq5O8I6+RSLFmppJa03YlxtswJQaRMmdj02SI3zjXQWTjS+cI
 1+JKrKH//U1NoFtc7mv+Yty2Cg3pX4Oafcay73CyCRzE4cWBb/3ozxf3
X-Gm-Gg: Acq92OGd14et1Y+jC1SlAc5t0wO9UKbeCpkL2HIn+Hwhtw+0pxZH07B2IrAhff8nFN5
 cwhFosg1kGvBSCCBjp21uf0PeTwPrsX938Asv9RJLdb9yUIoo4RhXZv/UzhYvmsm2dsSr3Rpbft
 JEraLNN/1/EEnesDR6nUDvXtVLY5YiM1EWlhuHqHkydOGh/xEXgH6jQA7HuSoJJAY5u06DBq2ig
 DxFTBaAUL0QD2rTl83+DH85ov+q9mRnSoNAZLg7aMdee3A12XE4etc5WUliy4CSiYVpmjsJuZOG
 iZvMivolobWT6qMOOugviPviiLFImcyezJyVDeem+O2GJ2txf94Qsf1ThVaaiKuT33WDx+2V+eK
 pMBJX86oRULlvN/V2zqBTgFxWwzfDbK9uGUVCmIxG/g130AbGt+gMbV4JQmCkXLV0XyHKsT8Z2F
 NzX00+GiFI8HWi++jkWjnzwCNHIW0ZwWT6i747ulBBYVG9l6pV/mtmimXhi925IeedMMSBFi0a9
 1lN3Nh6bW/WuY5PlM/UYTnb2CrZnYt38ursGSnsU8Yx+nIZFFI=
X-Received: by 2002:a05:7301:1504:b0:2f9:1004:b2cd with SMTP id
 5a478bee46e88-3078011de63mr336826eec.20.1780637296170; 
 Thu, 04 Jun 2026 22:28:16 -0700 (PDT)
Received: from
 runnervm3jyl0.ksylce4ud4kezku4puvbvmbvsd.dx.internal.cloudapp.net
 ([172.184.204.99]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dea8e76sm6605494eec.18.2026.06.04.22.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 22:28:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri,  5 Jun 2026 05:28:14 +0000
Message-ID: <20260605052814.4342-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605042942.30480-1-wegao@suse.com>
References: <20260605042942.30480-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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

Hi Wei,

On Fri, 05 Jun 2026, Wei Gao wrote:
> mmapstress06: Convert to new API

> +/*\
> + * Test ``:manpage:`mmap(2)``` with swap behavior.

The RST role is malformed. Other tests in the tree use it without
the surrounding double-backticks, e.g.:

  * Test :manpage:`mmap(2)` with swap behavior.

> +#include "tst_test.h"
> +#include "tst_safe_macros.h"

tst_test.h already includes tst_safe_macros.h; the second include
is redundant.

> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)

WIFEXITED() and WEXITSTATUS() require <sys/wait.h>. That header is
not included, and nothing in the include chain pulls it in. Every
other test in testcases/kernel/mem/ that uses these macros includes
<sys/wait.h> explicitly (ksm05.c, vma01.c, mmapstress09.c).

> +	sysinfo(&s);
> +	total_swap = (unsigned long long)s.totalswap * s.mem_unit;
> +
> +	if (total_swap < map_size) {

This checks total (configured) swap, not available (free) swap. On a
system with 1 GB of total swap where 800 MB is already in use, the
check passes but the test would fail at runtime when only 200 MB of
free swap remains.

The tst_test framework provides .min_swap_avail (in megabytes) in
struct tst_test to guard against this; that field also removes the
need for the hand-rolled sysinfo() block. The swap check should also
test against the amount actually needed (map_size - mem_limit, around
500 MB), not against map_size (1000 MB).

The commit message also says "forcing the kernel to swap out exactly
500MB of memory", but the test only checks that cg_swap_after is
larger than cg_swap_before -- any non-zero increase would pass. The
word "exactly" is inaccurate.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
