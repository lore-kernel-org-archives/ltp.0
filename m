Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332EDC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 15:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07F203C9181
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 16:43:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5A113C916E
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 16:42:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 32E6B1400BEF
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 16:42:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 442F9212C0;
 Mon, 20 Dec 2021 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640014974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0d3hqNUFZemoI+odca+lvpBNVO+seGuY4hVmBjFkK5k=;
 b=S/TTJyzfQazqpew/6Ezan7095D2p+f95tu7AOSkAD+x0pTKd7VTXC033ngQ55gSy6h8x2U
 AKvGhIwPe56aeqYGpGzyVioudzwPp2Pry6cC4+nLF8mdlFmWQgmRLLlp6zRAiD7ino0CP9
 j2lkeS9xOOAcPa8nLZS5JokfDEPuS74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640014974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0d3hqNUFZemoI+odca+lvpBNVO+seGuY4hVmBjFkK5k=;
 b=NR8qsL4Dp0luaQ0vsj5/6bjSkKlFKJ6/2mbt+QNKMwAEKi0P6xiMu2LdFbl0Td9SWbTkbj
 JVOpML2BbFNhQbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC95E13D6B;
 Mon, 20 Dec 2021 15:42:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QK/QNH2kwGEbQQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 20 Dec 2021 15:42:53 +0000
Date: Mon, 20 Dec 2021 16:44:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YcCk13sQIpG+E0jR@yuki>
References: <20211220131043.18894-1-rpalethorpe@suse.com>
 <20211220131043.18894-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211220131043.18894-3-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] cgroup: Add memcontrol02
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

Hi!
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
> index c3565f85c..f7de40d53 100644
> --- a/testcases/kernel/controllers/memcg/.gitignore
> +++ b/testcases/kernel/controllers/memcg/.gitignore
> @@ -6,3 +6,4 @@
>  /regression/memcg_test_4
>  /stress/memcg_process_stress
>  memcontrol01
> +memcontrol02
> diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
> new file mode 100644
> index 000000000..002637db0
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*\
> + *
> + * [Description]
> + *
> + * Conversion of second kself test in cgroup/test_memcontrol.c.
> + *
> + * This test creates a memory cgroup, allocates some anonymous memory
> + * and some pagecache and check memory.current and some memory.stat
> + * values.
> + *
> + * Note that the V1 rss and cache counters were renamed to anon and
> + * file in V2. Besides error reporting, this test mainly differs from
> + * the kselftest in that it supports V1.
> + */
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +
> +#include "tst_test.h"
> +#include "tst_cgroup.h"
> +
> +#define MB(x) (x << 20)
> +
> +static size_t page_size;
> +static const struct tst_cgroup_group *cg_test;
> +static int is_v1_memcg;
> +static struct tst_cgroup_group *cg_child;
> +static int fd;
> +
> +/*
> + * Checks if two given values differ by less than err% of their sum.
> + */
> +static inline int values_close(const ssize_t a,
> +			       const ssize_t b,
> +			       const ssize_t err)
> +{
> +	return labs(a - b) <= (a + b) / 100 * err;
> +}
> +
> +static void alloc_anon_50M_check(void)
> +{
> +	const ssize_t size = MB(50);
> +	char *buf, *ptr;
> +	ssize_t anon, current;
> +	const char *const anon_key_fmt = is_v1_memcg ? "rss %zd" : "anon %zd";
> +
> +	buf = SAFE_MALLOC(size);
> +	for (ptr = buf; ptr < buf + size; ptr += page_size)
> +		*ptr = 0;
> +
> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zd", &current);
> +	TST_EXP_POSITIVE(current >= size,
> +			 "(memory.current=%zd) >= (size=%zd)", current, size);
> +
> +	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", anon_key_fmt, &anon);
> +
> +	TST_EXP_POSITIVE(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
> +
> +	TST_EXP_POSITIVE(values_close(size, current, 3),
> +			 "(size=%zd) ~= (memory.stat.anon=%zd)", size, current);
> +	TST_EXP_POSITIVE(values_close(anon, current, 3),
> +			 "(memory.current=%zd) ~= (memory.stat.anon=%zd)",
> +			 current, anon);
> +}
> +
> +static void alloc_pagecache(const int fd, size_t size)
> +{
> +	char buf[BUFSIZ];
> +	struct stat st;
> +	size_t i;
> +
> +	SAFE_FSTAT(fd, &st);
> +	size += st.st_size;
> +
> +	SAFE_FTRUNCATE(fd, size);
> +
> +	for (i = 0; i < size; i += sizeof(buf))
> +		SAFE_READ(0, fd, buf, sizeof(buf));
> +}
> +
> +static void alloc_pagecache_50M_check(void)
> +{
> +	const size_t size = MB(50);
> +	size_t current, file;
> +	const char *const file_key_fmt = is_v1_memcg ? "cache %zd" : "file %zd";
> +
> +	fd = SAFE_OPEN("page_cache", O_RDWR | O_CREAT);
> +	alloc_pagecache(fd, size);
> +
> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
> +	TST_EXP_POSITIVE(current >= size,
> +			 "(memory.current=%zu) >= (size=%zu)", current, size);
> +
> +	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", file_key_fmt, &file);
> +	TST_EXP_POSITIVE(file > 0, "(memory.stat.file=%zd) > 0", file);
> +
> +	TST_EXP_POSITIVE(values_close(file, current, 10),
> +			 "(memory.current=%zd) ~= (memory.stat.file=%zd)",
> +			 current, file);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_memcg_current(unsigned int n)
> +{
> +	size_t current;
> +
> +	cg_child = tst_cgroup_group_mk(cg_test, "child");
> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
> +	TST_EXP_POSITIVE(current == 0, "(current=%zu) == 0", current);

I find these TST_EXP_POSITIVE() macros slightly confusing.

Note that we do have TST_EXP_VAL(), so this can be better defined as
TST_EXP_VAL(current, 0);

But even then all the macros all written in a way that they do expect
a syscall as a first parameter and the messages are not clear.

Maybe we need a different solution. We already have tst_assert_foo()
functions for sysfs/proc files so maybe we need something as compare
function for the cgroup file attributes:

	enum cmp {
		CMP_EQ,
		CMP_NE,
		CMP_LT,
		CMP_GT,
		CMP_LE,
		CMP_GE,
		CMP_EPS,
	};

	CGROUP_ASSERT_CMP_SIZE(cg_child, "memory.current", CMP_EQ, 0);

	CGROUP_ASSERT_CMP_SIZE(cg_child, "memory.current", CMP_EPS, file, 10);


	or even simple macro that would compare two values accordingly
	to the OP and print PASS/FAIL would be better than this.

> +	if (!SAFE_FORK()) {
> +		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
> +		if (!n)
> +			alloc_anon_50M_check();
> +		else
> +			alloc_pagecache_50M_check();
> +	} else {
> +		tst_reap_children();
> +		cg_child = tst_cgroup_group_rm(cg_child);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +
> +	tst_cgroup_require("memory", NULL);
> +	cg_test = tst_cgroup_get_test_group();
> +
> +	is_v1_memcg = TST_CGROUP_VER(cg_test, "memory") == TST_CGROUP_V1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (cg_child)
> +		cg_child = tst_cgroup_group_rm(cg_child);
> +
> +	tst_cgroup_cleanup();
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = 2,
> +	.test = test_memcg_current,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
> -- 
> 2.34.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
