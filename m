Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD09C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 12:50:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3399E3CC208
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 13:50:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40E573CAEFC
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 13:49:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A84952A1AAC
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 13:49:54 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 795D520688;
 Mon,  5 Dec 2022 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670244593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWBrL4LF8yfwQIWdQ0zXEwt+JJU6NieF+YyQd7zYKa0=;
 b=ussUglQD4t0bKeRkImOaOf7daf37FWoVGbjWksAMODcRpsayX+UENV89cS6JGSDMtHjxxu
 dQ2cnfoPQjGqzXHsww4GY/TheFwa5uTuF4M2PAqUQ0FwWvJHb0A8LWv0856dhWokTB3jlu
 L2zpHMasinNwZYum0x3RLMcSgUS9ZPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670244593;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWBrL4LF8yfwQIWdQ0zXEwt+JJU6NieF+YyQd7zYKa0=;
 b=GPfEB8OBOAWVyxi/ZBRLS7zpHmMORIeHqIMHEdZPfMjMOAbL90pejh+mTcgNRdYGza8/UZ
 M+2isxK15uoqMMDA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 20D9B2C141;
 Mon,  5 Dec 2022 12:49:53 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-2-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 05 Dec 2022 12:28:01 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-2-tsahu@linux.ibm.com>
Message-ID: <87r0xet3pt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] Hugetlb: Migrating libhugetlbfs fork-cow
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
Reply-To: rpalethorpe@suse.de
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/fork-cow.c test
>
> Test Description: This checks copy-on-write semantics, specifically the
> semantics of a MAP_PRIVATE mapping across a fork().  Some versions of the
> powerpc kernel had a bug in huge_ptep_set_wrprotect() which would fail to
> flush the hash table after setting the write protect bit in the parent's
> page tables, thus allowing the parent to pollute the child's mapping.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   2 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugefork/Makefile      |  10 ++
>  .../kernel/mem/hugetlb/hugefork/hugefork01.c  | 108 ++++++++++++++++++
>  4 files changed, 121 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/Makefile
>  create mode 100644 testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
n> index ec1fc2515..4c16e1e7c 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,6 +1,8 @@
>  hugefallocate01 hugefallocate01
>  hugefallocate02 hugefallocate02
>  
> +hugefork01 hugefork01
> +
>  hugemmap01 hugemmap01
>  hugemmap02 hugemmap02
>  hugemmap04 hugemmap04
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index c0906f3d3..adea760c7 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -1,6 +1,7 @@
>  /cpuset/cpuset01
>  /hugetlb/hugefallocate/hugefallocate01
>  /hugetlb/hugefallocate/hugefallocate02
> +/hugetlb/hugefork/hugefork01
>  /hugetlb/hugemmap/hugemmap01
>  /hugetlb/hugemmap/hugemmap02
>  /hugetlb/hugemmap/hugemmap04
> diff --git a/testcases/kernel/mem/hugetlb/hugefork/Makefile b/testcases/kernel/mem/hugetlb/hugefork/Makefile
> new file mode 100644
> index 000000000..77ebb0aef
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefork/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
> +# Ngie Cooper, July 2009
> +
> +top_srcdir		?= ../../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(abs_srcdir)/../Makefile.inc
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> diff --git a/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
> new file mode 100644
> index 000000000..b59c461e3
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugefork/hugefork01.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2008 David Gibson, IBM Corporation.
> + * Author: David Gibson
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This checks copy-on-write semantics, specifically the semantics of a
> + * MAP_PRIVATE mapping across a fork().  Some versions of the powerpc
> + * kernel had a bug in huge_ptep_set_wrprotect() which would fail to
> + * flush the hash table after setting the write protect bit in the parent's
> + * page tables, thus allowing the parent to pollute the child's mapping.
> + *
> + */
> +
> +#include <sys/wait.h>
> +#include <sys/mman.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +
> +#include "hugetlb.h"
> +
> +#define RANDOM_CONSTANT		0x1234ABCD
> +#define OTHER_CONSTANT		0xfeef5678

It seems their are actually 3 constants as "random" is inverted. I'd
prefer it if they had names like C1, C2, C3 with no connotations.

> +#define MNTPOINT "hugetlbfs/"
> +static int  fd = -1;
> +static long hpage_size;
> +
> +static void run_test(void)
> +{
> +	int status;
> +	volatile unsigned int *p;
> +	volatile unsigned int *child_readback;
> +	int parent_readback;
> +	pid_t pid;
> +
> +	child_readback = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
> +			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +	*child_readback = 0;
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	*p = RANDOM_CONSTANT;
> +
> +	pid = SAFE_FORK();
> +	if (pid != 0) {
> +		*p = ~RANDOM_CONSTANT;
> +		TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +		parent_readback = *p;
> +		TST_CHECKPOINT_WAKE(0);
> +	} else {
> +		TST_CHECKPOINT_WAIT(0);
> +		*child_readback = *p;
> +		*p = OTHER_CONSTANT;
> +		TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (WEXITSTATUS(status) != 0) {
> +		tst_res(TFAIL, "Child failed: %d", WEXITSTATUS(status));
> +		goto cleanup;
> +	}

This can be replaced with tst_reap_children();

> +
> +	tst_res(TINFO, "child_readback = 0x%x, parent_readback = 0x%x",
> +			*child_readback, parent_readback);
> +
> +	if (*child_readback != RANDOM_CONSTANT) {
> +		tst_res(TFAIL, "Child read back 0x%x instead of 0x%x",
> +		     *child_readback, RANDOM_CONSTANT);

I think this could be checked at the end of the child and the extra mmap
for child_readback removed. The LTP lib already creats some shared
memory with children to propagate results.

Assuming that mmap is not needed for the original bug reproducer.

> +		goto cleanup;

I don't think this is necessary.

> +	}
> +	if (parent_readback != ~RANDOM_CONSTANT) {

These comparisons could be replaced with TST_EXP_EQ_LU or TST_EXP_EXPR.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
