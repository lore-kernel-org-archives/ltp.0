Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8090DC433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 15:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153E33C90AB
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 16:59:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E55513C903D
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 16:59:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AFC4A60042A
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 16:59:21 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id ED858210E5
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641311960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ng2S+ciXtZieJky7ac894wHVGqf0J88DVfr+gbJULH4=;
 b=sIiAP4+wcCkAygS9T7AQBMgglTe1P7PnAg1HJPHOmhECcLFNSjXPjWkYAsk7HnSOA4eXAy
 /X6tXLPLJeyyObvTd9QL04C1tA7tdjx5ZN3nzs1Y+rHdfPMxNHLL31GgiYAF6/U+lq0EdH
 r3ZxgrM22p2umhAO6V0Jp4GX7jOM1dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641311960;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ng2S+ciXtZieJky7ac894wHVGqf0J88DVfr+gbJULH4=;
 b=tl/OmcHjonM6x9TXl7qAD6OowjOOw4BEb/091Wrd3q/d9w8Y6NL6cMcFLXNgSWm+0ir3w6
 +WANVPUbhDOcXECQ==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9A42EA3B83;
 Tue,  4 Jan 2022 15:59:20 +0000 (UTC)
References: <20220104122010.23069-1-rpalethorpe@suse.com>
 <20220104122010.23069-5-rpalethorpe@suse.com> <YdRhmxXqDNAV2sva@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 04 Jan 2022 15:26:02 +0000
In-reply-to: <YdRhmxXqDNAV2sva@yuki>
Message-ID: <871r1no5kd.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] cgroup: Add memcontrol02
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

Cyril Hrubis <chrubis@suse.cz> writes:

>> + *
>> + * [Description]
>> + *
>> + * Conversion of second kself test in cgroup/test_memcontrol.c.
>> + *
>> + * Original description:
>> + * "This test creates a memory cgroup, allocates some anonymous memory
>> + * and some pagecache and check memory.current and some memory.stat
>> + * values."
>> + *
>> + * Note that the V1 rss and cache counters were renamed to anon and
>> + * file in V2. Besides error reporting, this test differs from the
>> + * kselftest in the following ways:
>> + *
>> + * . It supports V1.
>> + * . It writes instead of reads to fill the page cache. Because no
>> + *   pages were allocated on tmpfs.
>
> Shouldn't we actually run the test both for read/write and skip the read
> part of tmpfs?
>
> Well I guess that the pages are put into the page cache the same way
> regardless if they came from userspace write or as a request for data to
> be read from the disk, so probably not I guess.

I reckon there are a lot of ways to fill the page cache from
userland. mmap and madvise also come to mind. I don't know how many ways
there are to get/allocate a page from the page cache internally. I guess
it's possible to circumvent the accountancy.

I think for now just writing is good enough. This doesn't appear to be
the only test which measures the page cache. So I think we should look
at what the other tests do first. 

>
>> + * . It runs on most filesystems available
>> + * . On EXFAT and extN we change the margine of error between all and file
>                                            ^
> 					   margin
>> + *   memory to 50%. Because these allocate non-page-cache memory during writes.
>> + */
>> +#define _GNU_SOURCE
>> +
>> +#include <stdlib.h>
>> +#include <stdio.h>
>
> Do we really need stdio here?

Sorry, nope.

>
>> +#include "tst_test.h"
>> +#include "tst_cgroup.h"
>> +
>> +#define TMPDIR "mntdir"
>> +#define MB(x) (x << 20)
>> +
>> +static size_t page_size;
>> +static const struct tst_cgroup_group *cg_test;
>> +static int is_v1_memcg;
>> +static struct tst_cgroup_group *cg_child;
>> +static int fd;
>> +static int file_to_all_error = 10;
>> +
>> +/*
>> + * Checks if two given values differ by less than err% of their sum.
>> + */
>> +static inline int values_close(const ssize_t a,
>> +			       const ssize_t b,
>> +			       const ssize_t err)
>> +{
>> +	return labs(a - b) <= (a + b) / 100 * err;
>> +}
>
> I guess that this crude integer version works only since we allocate
> reasonable large memory sizes.

I suppose I could multiply both sides of the inequality by
100... perhaps we could even use the FPU, I hear it's quite usable in
userland. :-p

>
>> +static void alloc_anon_50M_check(void)
>> +{
>> +	const ssize_t size = MB(50);
>> +	char *buf, *ptr;
>> +	ssize_t anon, current;
>> +	const char *const anon_key_fmt = is_v1_memcg ? "rss %zd" : "anon %zd";
>> +
>> +	buf = SAFE_MALLOC(size);
>> +	for (ptr = buf; ptr < buf + size; ptr += page_size)
>> +		*ptr = 0;
>> +
>> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zd", &current);
>> +	TST_EXP_EXPR(current >= size,
>> +		     "(memory.current=%zd) >= (size=%zd)", current, size);
>> +
>> +	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", anon_key_fmt, &anon);
>> +
>> +	TST_EXP_EXPR(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
>> +	TST_EXP_EXPR(values_close(size, current, 3),
>> +		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, current);
>> +	TST_EXP_EXPR(values_close(anon, current, 3),
>> +		     "(memory.current=%zd) ~= (memory.stat.anon=%zd)",
>> +		     current, anon);
>> +}
>> +
>> +static void alloc_pagecache(const int fd, size_t size)
>> +{
>> +	char buf[BUFSIZ];
>> +	size_t i;
>
> We may as well fill the buffer with something so that this function will
> not trigger static analyzers.

+1
>
>> +	for (i = 0; i < size; i += sizeof(buf))
>> +		SAFE_WRITE(1, fd, buf, sizeof(buf));
>> +}
>> +
>> +static void alloc_pagecache_50M_check(void)
>> +{
>> +	const size_t size = MB(50);
>> +	size_t current, file;
>> +	const char *const file_key_fmt = is_v1_memcg ? "cache %zd" : "file %zd";
>
> This may be a global initialized in the test setup.

Is it not easier to read when set in the context it is used? Otherwise
the key name is hidden in setup.

>
>> +	TEST(open(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600));
>> +
>> +	if (TST_RET < 0) {
>> +		if (TST_ERR == EOPNOTSUPP)
>> +			tst_brk(TCONF, "O_TMPFILE not supported by FS");
>> +
>> +		tst_brk(TBROK | TTERRNO,
>> +			"open(%s, O_TMPFILE | O_RDWR | O_EXCL", TMPDIR"/.");
>> +	}
>> +	fd = TST_RET;
>> +
>> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
>> +	tst_res(TINFO, "Created temp file: memory.current=%zu", current);
>> +
>> +	alloc_pagecache(fd, size);
>> +
>> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
>> +	TST_EXP_EXPR(current >= size,
>> +			 "(memory.current=%zu) >= (size=%zu)", current, size);
>> +
>> +	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", file_key_fmt, &file);
>> +	TST_EXP_EXPR(file > 0, "(memory.stat.file=%zd) > 0", file);
>> +
>> +	TST_EXP_EXPR(values_close(file, current, file_to_all_error),
>> +			 "(memory.current=%zd) ~= (memory.stat.file=%zd)",
>> +			 current, file);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static void test_memcg_current(unsigned int n)
>> +{
>> +	size_t current;
>> +
>> +	cg_child = tst_cgroup_group_mk(cg_test, "child");
>> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
>> +	TST_EXP_EXPR(current == 0, "(current=%zu) == 0", current);
>> +
>> +	if (!SAFE_FORK()) {
>> +		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
>> +
>> +		SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
>> +		tst_res(TINFO, "Added proc to memcg: memory.current=%zu",
>> +			current);
>> +
>> +		if (!n)
>> +			alloc_anon_50M_check();
>> +		else
>> +			alloc_pagecache_50M_check();
>> +	} else {
>> +		tst_reap_children();
>> +		cg_child = tst_cgroup_group_rm(cg_child);
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
>> +
>> +	tst_cgroup_require("memory", NULL);
>> +	cg_test = tst_cgroup_get_test_group();
>> +
>> +	is_v1_memcg = TST_CGROUP_VER(cg_test, "memory") == TST_CGROUP_V1;
>
> I find this statement a bit confusing, maybe TST_CGGROUP_IS_V1() and
> TST_CGROUP_IS_V2() macros in the library would make it slightly
> better.

Yeah, I suppose this is proving to be tiresome.

>
>> +	switch (tst_fs_type(TMPDIR)) {
>> +	case TST_EXFAT_MAGIC:
>> +	case TST_EXT234_MAGIC:
>> +		file_to_all_error = 50;
>> +		break;
>> +	}
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (cg_child)
>> +		cg_child = tst_cgroup_group_rm(cg_child);
>> +
>> +	tst_cgroup_cleanup();
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.tcnt = 2,
>> +	.test = test_memcg_current,
>> +	.mount_device = 1,
>> +	.dev_min_size = 256,
>> +	.mntpoint = TMPDIR,
>> +	.all_filesystems = 1,
>> +	.forks_child = 1,
>> +	.needs_root = 1,
>> +};
>
> Generally minus typos and minor things it looks good, I guess that it
> can as well go in if you fix the typos as it is.
>
> Reviewed-by: Cyril Hrubis <chrubis@susec.cz>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
