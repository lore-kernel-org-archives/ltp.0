Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6297DC433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 15:01:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C45A3C90A7
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 16:01:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF73D3C8F89
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 16:01:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD25260064C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 16:01:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B194B1F37B;
 Tue,  4 Jan 2022 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641308482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zgd2vmGl1yYaTcmMhis7Jjmbh+/vO+NC71+ZSNMZZZY=;
 b=UZK4d/Aj8P0L0XqVbqXHx7VI/tYhOAsy9VZVnKjspC8jWjENo/FJvE4tVirBXf5RTUNV81
 x1xASE9995MbqiN8d8NWyMKSEAsN3C3Ee7Em+R22GQwOlpl+pzzzmpoqt0KLYvM8eZxmEU
 BKK7g9Gq4OHhNKEtk9uC8O5BLJmDJck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641308482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zgd2vmGl1yYaTcmMhis7Jjmbh+/vO+NC71+ZSNMZZZY=;
 b=4U2saru/6p9qQkTsk1Jg1SrzdALpeMRycco9eV+YSslHvj4Mm/pT1NdktH3XfGDJJL2trN
 9SxyklQR+Lv82EAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D9EF13B16;
 Tue,  4 Jan 2022 15:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WpFkJUJh1GH/HwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 04 Jan 2022 15:01:22 +0000
Date: Tue, 4 Jan 2022 16:02:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YdRhmxXqDNAV2sva@yuki>
References: <20220104122010.23069-1-rpalethorpe@suse.com>
 <20220104122010.23069-5-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104122010.23069-5-rpalethorpe@suse.com>
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test appears to compare the overall "current" counter with anon
> and file (page cache) memory counters. The file test assumes much more
> memory will be consumed by the page cache. This is certainly true on
> XFS and BTRFS where little or no memory outside the page cache is
> used. However on ext4, ntfs and especially exfat, we can see more
> memory being used.
> 
> This seems to be related to fs/buffer.c and buffer_head usage. exfat
> in particular allocates a lot of memory. This is possibly due to the
> buffer_head being allocated in cont_write_begin:
> 
>  Children      Self       Samples         bytes_alloc  Parent symbol
>  ........  ........  ............  ..................  .................
> 
>     97.66%    97.66%        102401                 168  exfat_write_begin
>             |
>             ---0xf7eec549
>                entry_SYSENTER_compat_after_hwframe
>                do_fast_syscall_32
>                __noinstr_text_start
>                ksys_write
>                vfs_write
>                new_sync_write
>                generic_file_write_iter
>                __generic_file_write_iter
>                generic_perform_write
>                exfat_write_begin
>                cont_write_begin
>                __block_write_begin_int
>                create_page_buffers
>                create_empty_buffers
>                alloc_page_buffers
>                alloc_buffer_head
>                kmem_cache_alloc
>                kmem_cache_alloc
> 
>      0.20%     0.20%           205                 584  exfat_write_begin
>      0.06%     0.06%            64                 168  exfat_fill_super
>      0.05%     0.05%            49                 256  exfat_fill_super
>      0.00%     0.00%             4                 584  exfat_fill_super
>      0.00%     0.00%             1                 256  exfat_create
>      0.00%     0.00%             1                1528  exfat_create
>      0.00%     0.00%             1                1528  exfat_fill_super
>      0.00%     0.00%             1                 312  exfat_fill_super
> 
> We can see (using slub_debug=U,buffer_head) that these buffer_head
> objects are not freed until the file is unlinked:
> 
>  Outputting '/sys/kernel/debug/slab/buffer_head/alloc_traces' ...
>  102480 alloc_buffer_head+0x1b/0x90 age=0/268/2629529 pid=248-430 cpus=0,2
> 
>  Outputting '/sys/kernel/debug/slab/buffer_head/free_traces' ...
>  102400 <not-available> age=4297543659 pid=0 cpus=0
>      80 free_buffer_head+0x21/0x60 age=147/266217/2629538 pid=337-427 cpus=1-2
> 
> ext4 and ntfs also use some of the "buffer" code, but don't seem to
> allocate quite as much. Although ext4 begins to fail when slub debug
> is enabled due to the extra memory debugging uses.
> 
> In any case, it appears that the CGroup code is correct, so I have
> increased the error margin when exfat or ext234 is detected.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  runtest/controllers                           |   1 +
>  testcases/kernel/controllers/memcg/.gitignore |   1 +
>  .../kernel/controllers/memcg/memcontrol02.c   | 183 ++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 testcases/kernel/controllers/memcg/memcontrol02.c
> 
> diff --git a/runtest/controllers b/runtest/controllers
> index 2b41a94d3..09e0107e4 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -18,6 +18,7 @@ memcg_control		memcg_control_test.sh
>  
>  # kselftest ports
>  memcontrol01 memcontrol01
> +memcontrol02 memcontrol02
>  
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
> index 000000000..f236e6cdc
> --- /dev/null
> +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*\
> + *
> + * [Description]
> + *
> + * Conversion of second kself test in cgroup/test_memcontrol.c.
> + *
> + * Original description:
> + * "This test creates a memory cgroup, allocates some anonymous memory
> + * and some pagecache and check memory.current and some memory.stat
> + * values."
> + *
> + * Note that the V1 rss and cache counters were renamed to anon and
> + * file in V2. Besides error reporting, this test differs from the
> + * kselftest in the following ways:
> + *
> + * . It supports V1.
> + * . It writes instead of reads to fill the page cache. Because no
> + *   pages were allocated on tmpfs.

Shouldn't we actually run the test both for read/write and skip the read
part of tmpfs?

Well I guess that the pages are put into the page cache the same way
regardless if they came from userspace write or as a request for data to
be read from the disk, so probably not I guess.

> + * . It runs on most filesystems available
> + * . On EXFAT and extN we change the margine of error between all and file
                                           ^
					   margin
> + *   memory to 50%. Because these allocate non-page-cache memory during writes.
> + */
> +#define _GNU_SOURCE
> +
> +#include <stdlib.h>
> +#include <stdio.h>

Do we really need stdio here?

> +#include "tst_test.h"
> +#include "tst_cgroup.h"
> +
> +#define TMPDIR "mntdir"
> +#define MB(x) (x << 20)
> +
> +static size_t page_size;
> +static const struct tst_cgroup_group *cg_test;
> +static int is_v1_memcg;
> +static struct tst_cgroup_group *cg_child;
> +static int fd;
> +static int file_to_all_error = 10;
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

I guess that this crude integer version works only since we allocate
reasonable large memory sizes.

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
> +	TST_EXP_EXPR(current >= size,
> +		     "(memory.current=%zd) >= (size=%zd)", current, size);
> +
> +	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", anon_key_fmt, &anon);
> +
> +	TST_EXP_EXPR(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
> +	TST_EXP_EXPR(values_close(size, current, 3),
> +		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, current);
> +	TST_EXP_EXPR(values_close(anon, current, 3),
> +		     "(memory.current=%zd) ~= (memory.stat.anon=%zd)",
> +		     current, anon);
> +}
> +
> +static void alloc_pagecache(const int fd, size_t size)
> +{
> +	char buf[BUFSIZ];
> +	size_t i;

We may as well fill the buffer with something so that this function will
not trigger static analyzers.

> +	for (i = 0; i < size; i += sizeof(buf))
> +		SAFE_WRITE(1, fd, buf, sizeof(buf));
> +}
> +
> +static void alloc_pagecache_50M_check(void)
> +{
> +	const size_t size = MB(50);
> +	size_t current, file;
> +	const char *const file_key_fmt = is_v1_memcg ? "cache %zd" : "file %zd";

This may be a global initialized in the test setup.

> +	TEST(open(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600));
> +
> +	if (TST_RET < 0) {
> +		if (TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "O_TMPFILE not supported by FS");
> +
> +		tst_brk(TBROK | TTERRNO,
> +			"open(%s, O_TMPFILE | O_RDWR | O_EXCL", TMPDIR"/.");
> +	}
> +	fd = TST_RET;
> +
> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
> +	tst_res(TINFO, "Created temp file: memory.current=%zu", current);
> +
> +	alloc_pagecache(fd, size);
> +
> +	SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
> +	TST_EXP_EXPR(current >= size,
> +			 "(memory.current=%zu) >= (size=%zu)", current, size);
> +
> +	SAFE_CGROUP_LINES_SCANF(cg_child, "memory.stat", file_key_fmt, &file);
> +	TST_EXP_EXPR(file > 0, "(memory.stat.file=%zd) > 0", file);
> +
> +	TST_EXP_EXPR(values_close(file, current, file_to_all_error),
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
> +	TST_EXP_EXPR(current == 0, "(current=%zu) == 0", current);
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_CGROUP_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
> +
> +		SAFE_CGROUP_SCANF(cg_child, "memory.current", "%zu", &current);
> +		tst_res(TINFO, "Added proc to memcg: memory.current=%zu",
> +			current);
> +
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

I find this statement a bit confusing, maybe TST_CGGROUP_IS_V1() and
TST_CGROUP_IS_V2() macros in the library would make it slightly better.

> +	switch (tst_fs_type(TMPDIR)) {
> +	case TST_EXFAT_MAGIC:
> +	case TST_EXT234_MAGIC:
> +		file_to_all_error = 50;
> +		break;
> +	}
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
> +	.mount_device = 1,
> +	.dev_min_size = 256,
> +	.mntpoint = TMPDIR,
> +	.all_filesystems = 1,
> +	.forks_child = 1,
> +	.needs_root = 1,
> +};

Generally minus typos and minor things it looks good, I guess that it
can as well go in if you fix the typos as it is.

Reviewed-by: Cyril Hrubis <chrubis@susec.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
