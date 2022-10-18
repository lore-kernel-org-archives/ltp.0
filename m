Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FD0C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:48:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABBCB3CB064
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:48:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 776203CA7C2
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:48:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C45626006E7
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:48:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0E2C020803;
 Tue, 18 Oct 2022 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666097314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSgWOVF01BYCkGwH7umYcV4dd+b4CopfI9SlKwcGztI=;
 b=Q+lgsvqd7tqfnPmY/AtvAj5hd2z9DWMz5vkO5bLoqKS8yIDHMjwQhbAt9PTkbe+O9IjFwJ
 cA9S7kns3cQM/mSn9yDM2OwzqLA0Qid6VJxurr2gbqXt+X+sKKH8PGbi18ZfwIbDVC7swh
 GKNlWltyfPWSp089kh/dDVPbJHtIMok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666097314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSgWOVF01BYCkGwH7umYcV4dd+b4CopfI9SlKwcGztI=;
 b=hhbampYQJb2hT8ceMNf6T1ba+EoMgCrYHtT++SRzYA9Do4rukvYLKB4EGrVgfJLBGmFvBf
 m70gDDuzFALE+wDg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C13232C141;
 Tue, 18 Oct 2022 12:48:32 +0000 (UTC)
References: <20221006110642.12410-1-andrea.cervesato@suse.com>
 <20221006110642.12410-5-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 18 Oct 2022 13:29:15 +0100
In-reply-to: <20221006110642.12410-5-andrea.cervesato@suse.com>
Message-ID: <875yghjo11.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 3/3] Add process_madvise03 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Test for checking MADV_PAGEOUT functionality over memory-mapped file
> in process_madvise syscall.

So this one doesn't need swap, but it has some other issues.

>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/cma/.gitignore      |   1 +
>  .../kernel/syscalls/cma/process_madvise03.c   | 139 ++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/cma/process_madvise03.c
>
> diff --git a/testcases/kernel/syscalls/cma/.gitignore b/testcases/kernel/syscalls/cma/.gitignore
> index 47ae3e445..147b03c48 100644
> --- a/testcases/kernel/syscalls/cma/.gitignore
> +++ b/testcases/kernel/syscalls/cma/.gitignore
> @@ -4,3 +4,4 @@
>  /process_vm_writev02
>  /process_madvise01
>  /process_madvise02
> +/process_madvise03
> diff --git a/testcases/kernel/syscalls/cma/process_madvise03.c b/testcases/kernel/syscalls/cma/process_madvise03.c
> new file mode 100644
> index 000000000..3f12ef530
> --- /dev/null
> +++ b/testcases/kernel/syscalls/cma/process_madvise03.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Spawn child inside cgroup and set max memory. Allocate file-backed memory
> + * pages inside child and reclaim it with MADV_PAGEOUT. Then check if memory
> + * pages have been written back to the backing storage.
> + *
> + * The advice might be ignored for some pages in the range when it is
> + * not applicable, so test passes if pages mapped in RAM decrease after
> + * reclaiming memory with MADV_PAGEOUT and RAM doesn't contain
> + * reclaimed memory anymore.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/mman.h>
> +#include "tst_test.h"
> +#include "lapi/mmap.h"
> +#include "lapi/syscalls.h"
> +#include "cma.h"
> +
> +#define MEM_CHILD	(10 * 1024 * 1024)
> +
> +static char *filename = "file.bin";
> +static void **data_ptr;
> +
> +static void child_alloc(void)
> +{
> +	int fd;
> +	char *ptr;
> +	int freed = 1;
> +	struct addr_mapping map_before;
> +	struct addr_mapping map_after;
> +
> +	tst_res(TINFO, "Allocate file-backed memory");
> +
> +	fd = SAFE_OPEN(filename, O_CREAT | O_RDWR);
> +	SAFE_FTRUNCATE(fd, MEM_CHILD);
> +
> +	*data_ptr = SAFE_MMAP(NULL, MEM_CHILD,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fd, 0);
> +
> +	tst_res(TINFO, "Dirty memory");
> +	memset(*data_ptr, 'a', MEM_CHILD);
> +
> +	read_address_mapping((unsigned long)*data_ptr, &map_before);
> +
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	for (ptr = *data_ptr; *ptr != '\0'; ptr++) {
> +		if (*ptr == 'a') {
> +			freed = 0;
> +			break;
> +		}
> +	}

This will loop once, or?

> +
> +	if (freed) {
> +		tst_res(TFAIL, "Memory has been freed");

We'll probably get a segfault or sigbus if its unmapped somehow. I guess
you could do a memcmp on the range to test that it didn't randomly
change though.

Otherwise this one looks good.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
