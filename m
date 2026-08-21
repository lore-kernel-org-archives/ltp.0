Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2693FC5DF7D
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 18:39:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65C833D0F40
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 20:39:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48BB73C55FC
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 20:39:22 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51B9F2009F4
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 20:39:22 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-907b06a2295so3251146d6.0
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787337561; x=1787942361; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OVA121l73pBKWt/hzje3LqlpvXX+Avh2klkDJX9QcUc=;
 b=MfzevX2qD8twrc1beadCxiyfQQuELeGNm8vYPLDDr0Ox5jsIFytRIIbGMxUWjCLJ55
 M3izAT3Wcchzem3aTRuMp7cdJc6RXVDybnz6/qGBg1vKdlf4gC1/5PtzjBSvchQQzALM
 JMgVm6mZEN7xdczHpowVw1y3p/0952w9fB5EHbwWEJ/Qhvpyuda7vAB+/yl6QdwvtGs7
 AOnOk3zHDkCL+HIGv0cy/48tqAOqUVR7kfwNhTuZGCEt/WlKKg+HfFg81mP1RSoC6Vh4
 KW4xJiLyckk8uU8TX0zScMJJXS9fHV1rMCTZQzAiMheZ34mD1MLIQZgAlbwwSiRM3Bpz
 jx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787337561; x=1787942361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OVA121l73pBKWt/hzje3LqlpvXX+Avh2klkDJX9QcUc=;
 b=ss7PrhoIe2mcJkvVvLyXj2WGi66ahQkGuv3/2nnXkyrpVoRPfFRys1Mvm8R3Q2uqUU
 /+4fEzjUyH5S+JYHboXTMB1sproiHvY/St+11aqaWFGxsIJsn51j09fiIkojYHes0z14
 hIRdJwbkjRh++wp/aNC2LXUxjoiH+BMnuFzFo1r4VtZ53rIMk3teVsUTiZiS1aqQ5ptq
 J7iLOlaI6lHUvGVoXvd5v32uemTf6B7IOi2suI8Row5VGIAsyuYV2V1FJqS3dOMTO/Sc
 oQi233x/TUD199UrQ3Mmj2ZCRdk710VaPOrEoPvTAs0hDOvt7cgC5YDiCTSPm5BIkr+w
 aM8A==
X-Gm-Message-State: AFuF++kmfBl3F/ZBkY+qXevLntMv1pZ8kWJYPTveIVIffQaPJJZUa7lQ
 /SYN/Sjc5i4WCQdtgWcwR10jr00A3Lyc7WdssyDgPtySJCVA//JdOYLt
X-Gm-Gg: AR+sD11s7TAe9rTbj3ZM6QDmmfkGJiNTwCiZrE16Y+HF2dBtHk9fUof9RFLaUjTn0uT
 onCvsqmi5dnRNu8fNFU4dJyToBo2SYbfquXXgERnkWyvJ0uPhSoVAqKcJDMjLT8gffgXWTUTYVp
 kMbpubtLOY/Fl3uRQn/c3Cg2TEVsTNlSRDKOJ/DauJ8DO/mLr4SET+gIbn23Pc43lzFjS0I2aiw
 r64D50W+nXXVp4TES4bIt3eR9z0JNz78TL8zksoNlUZXkAU/ZP0A8FyXQU2rjfLpRemsNSDUcUa
 FSTJwSfRgTwoMMoM3vAESDWuX7FsbOTX8ZKCRS4lzYLSuqbAJF3Clbafbsnk3ExxIhKkL8j7EkQ
 dbPI0HHFsnnBKzMvDsNNDZw7i/htw2xWBTrgtDVf2l8Tm2gj/uPNkDIx/5z55nUwrnQrRIjuEdG
 gvgoG3xmG+nkLfgHj3faG+oDH18p8iwKtxa0bpNeyOwLfdlSrRVL0h8AqvsrRbd5vxQUQnQRAoZ
 ViwF8BxYMpN6kql/zXgZZC/1/sMPPxinCAcR8+3abP3dkbQO/pcvhcT1tcW2sihu9vvuj6dgWQO
X-Received: by 2002:a05:622a:8c7:b0:52d:771a:231f with SMTP id
 d75a77b69052e-52df5739764mr87855491cf.12.1787337560848; 
 Fri, 21 Aug 2026 11:39:20 -0700 (PDT)
Received: from
 runnervm76f27.morafjup3qwelmjmd1ehkbn3kc.bx.internal.cloudapp.net
 ([20.106.183.53]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e099c38c0sm812731cf.13.2026.08.21.11.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:39:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Fri, 21 Aug 2026 18:39:19 +0000
Message-ID: <20260821183919.8954-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821121239.50594-1-samir@linux.ibm.com>
References: <20260821121239.50594-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap: Migrate alloc-instantiate-race test from
 libhugetlbfs
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

Hi Samir,

On Aug 21, 2026, Samir Mulani wrote:
> hugemmap: Migrate alloc-instantiate-race test from libhugetlbfs

> +		SAFE_PTHREAD_CREATE(&thread1, NULL, thread_racer, &ri1);
> +		SAFE_PTHREAD_CREATE(&thread2, NULL, thread_racer, &ri2);
> +
> +		/* Wake both threads to start the race simultaneously */
> +		TST_CHECKPOINT_WAKE2(0, 2);

Medium: Could the MAP_PRIVATE pthread race run in a child process so that
the parent can translate SIGBUS into TFAIL?

The allocation failure under test makes hugetlb_no_page() return
VM_FAULT_SIGBUS. An unhandled SIGBUS in either thread terminates the whole
thread group, after which LTP's check_child_status() reports TBROK instead
of identifying the kernel regression as TFAIL. The MAP_SHARED variant
already translates signal deaths in its child racers.

> +	cpu_set_t cpuset;
> +	int total_cpus, cpu_idx;
> +
> +	CPU_ZERO(&cpuset);
> +
> +	total_cpus = get_nprocs_conf();
> +
> +	if (sched_getaffinity(0, sizeof(cpu_set_t), &cpuset) == -1)
> +		tst_brk(TBROK | TERRNO, "sched_getaffinity() failed");

Medium: Could this use a dynamic mask sized with tst_ncpus_max(),
CPU_ALLOC(), and CPU_ALLOC_SIZE()?

sched_getaffinity() returns EINVAL when the supplied buffer is smaller
than the kernel affinity mask. A kernel supporting more than CPU_SETSIZE
CPUs therefore produces TBROK even when the test has two usable CPUs.

> +#include <pthread.h>
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"

Medium: Could hugemmap42 be added to the Makefile's existing
CFLAGS += -pthread rule?

The test links on modern glibc because libpthread was merged into libc,
but older supported libc versions need -pthread to resolve the symbols
used by the safe pthread wrappers.

> +/hugetlb/hugemmap/hugemmap42

Low: Could this entry be moved to a leaf
testcases/kernel/mem/hugetlb/hugemmap/.gitignore?

New test binaries should be ignored in their own test directory rather
than in testcases/kernel/mem/.gitignore.

> +	.hugepages = {2, TST_NEEDS},
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.min_cpus = 2,
> +};

Low: Could the kernel fix for this regression be added as a linux-git
tag so that failures provide the missing-fix hint?

> + * other racing process.
> + */
> [...]
> +	.needs_root = 1,

Low: Could the exported description explain that root is needed to
reserve hugepages and mount hugetlbfs?

> +	SAFE_CLOSE(fd_race);
> +	fd_race = -1;
> [...]
> +	if (fd_race >= 0)
> +		SAFE_CLOSE(fd_race);

Low: Could the redundant assignment be removed and the cleanup guard use
fd_race != -1, with the same changes for fd_sync?

SAFE_CLOSE() already sets the descriptor to -1, and != -1 is the LTP
descriptor-validity convention.

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
