Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA09C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 03:58:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 793883CD6A6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 05:58:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD7EB3CD6A6
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 05:58:01 +0200 (CEST)
Received: from mta1.migadu.com (out-19.mta1.migadu.com
 [IPv6:2001:41d0:203:375::13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AADED200279
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 05:57:59 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=fT5yAyDESYOmFDS3/nEWxopgMThtyyuuXPHlV5OmlUU=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787889479; v=1; x=1788494279;
 b=R+o9OphpSkLmbOaHrPo2gRdzAtkMB1RfmpBbtZM7/ZvBPQtqcc8ewJMQYuXxeUZC0tjcOx7H
 FCrRZesEgC7z2ZaVn5gacDmnVyTfrDBEJ14+dEeVxsFZg+4WXSK/ym/v5kNMj66YTY9RpnsWgM5
 u5S/qAJKObLK8aZmdHs0X6mM=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 055274b413752636;
 Fri, 28 Aug 2026 03:57:59 +0000
X-Mizu-Trace-ID: 055274b413752636
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 11:57:55 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apEHQxmBxBG4Vm7w@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260827-swapon_discard_coverage-v1-0-633bcb11c181@suse.com>
 <20260827-swapon_discard_coverage-v1-2-633bcb11c181@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827-swapon_discard_coverage-v1-2-633bcb11c181@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 27, 2026 at 01:54:05PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Verify that swapon(2) discard flags (SWAP_FLAG_DISCARD,
> SWAP_FLAG_DISCARD_ONCE, SWAP_FLAG_DISCARD_PAGES) correctly control
> swapon-time area discard on block devices supporting discard operations.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/swapon/.gitignore |   1 +
>  testcases/kernel/syscalls/swapon/swapon04.c | 197 ++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 737c63e31..ca190dd97 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1676,6 +1676,7 @@ swapoff02 swapoff02
>  swapon01 swapon01
>  swapon02 swapon02
>  swapon03 swapon03
> +swapon04 swapon04
>  
>  #Exclusive syscall() for POWER6 machines only
>  switch01 endian_switch01
> diff --git a/testcases/kernel/syscalls/swapon/.gitignore b/testcases/kernel/syscalls/swapon/.gitignore
> index 729226b11..db03b81ea 100644
> --- a/testcases/kernel/syscalls/swapon/.gitignore
> +++ b/testcases/kernel/syscalls/swapon/.gitignore
> @@ -1,3 +1,4 @@
>  /swapon01
>  /swapon02
>  /swapon03
> +/swapon04
> diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
> new file mode 100644
> index 000000000..cf527586b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/swapon/swapon04.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Linux Test Project, 2026
> + */
> +
> +/*\
> + * Check that :manpage:`swapon(2)` discard flags control swapon-time area discard:
> + *
> + * - With 0 (no flags), the swap area is not discarded at swapon.
> + * - With SWAP_FLAG_DISCARD, the swap area is discarded at swapon.
> + * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE, the swap area is discarded at swapon.
> + * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES, swapon-time area discard
> + *   is disabled (page-cluster discard only).
> + * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES,
> + *   SWAP_FLAG_DISCARD_ONCE takes precedence and discards the swap area at swapon.
> + * - With SWAP_FLAG_DISCARD_ONCE or SWAP_FLAG_DISCARD_PAGES alone (without the
> + *   SWAP_FLAG_DISCARD master enable bit), discard is not enabled.
> + *
> + * [Algorithm]
> + *
> + * - Create a backing file on the test filesystem and fill it completely.
> + * - Attach the backing file to a loop device supporting discard.
> + * - For each test case, populate the backing file and format it with mkswap.
> + * - Record the allocated block count before swapon().
> + * - Call swapon() with the test case flags.
> + * - Verify whether the allocated block count dropped (discarded) or remained.
> + * - Call swapoff() to reset the swap device state.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +#include "tse_swap.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/fallocate.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define BACKING_FILE MNTPOINT "/swap_backing_file"
> +#define SWAP_SIZE_MB 16
> +
> +static char loop_dev[PATH_MAX];
> +static int loop_dev_id = -1;
> +static int loop_attached;
> +static int swap_active;
> +static size_t max_header_blocks;
> +
> +static struct tcase {
> +	int flags;
> +	int exp_discard;
> +	const char *desc;
> +} tcases[] = {
> +	{
> +		.desc = "0 (no flags)",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD,
> +		.exp_discard = 1,
> +		.desc = "SWAP_FLAG_DISCARD",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE,
> +		.exp_discard = 1,
> +		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE",
> +	},

I encountered an intermittent failure on my x86_64 platform running kernel 6.6.
This needs further investigation.

tst_test.c:1986: TINFO: === Testing on xfs ===
tst_test.c:1291: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
tst_test.c:1303: TINFO: Mounting /dev/loop0 to /tmp/LTP_swa4Dz6aP/mntpoint fstyp=xfs flags=0
tst_device.c:103: TINFO: Found free device 1 '/dev/loop1'
swapon04.c:170: TPASS: blocks_after == blocks_before (32768)
swapon04.c:168: TPASS: blocks_after <= max_header_blocks (8 <= 16)
swapon04.c:168: TFAIL: blocks_after (32648) > max_header_blocks (16)
swapon04.c:170: TPASS: blocks_after == blocks_before (32768)
swapon04.c:168: TPASS: blocks_after <= max_header_blocks (8 <= 16)
swapon04.c:170: TPASS: blocks_after == blocks_before (32768)
swapon04.c:170: TPASS: blocks_after == blocks_before (32768)

> +	{
> +		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES,
> +		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES,
> +		.exp_discard = 1,
> +		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD_ONCE,
> +		.desc = "SWAP_FLAG_DISCARD_ONCE (alone without master flag)",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD_PAGES,
> +		.desc = "SWAP_FLAG_DISCARD_PAGES (alone without master flag)",
> +	},
> +};
> +
> +static void setup(void)
> +{
> +	char discard_path[PATH_MAX];
> +	unsigned long discard_max_bytes = 0;
> +	size_t page_size, blk_size, alloc_units;
> +	struct stat st;
> +	int fd;
> +
> +	if (access("/proc/swaps", F_OK))
> +		tst_brk(TCONF, "swap is not supported by kernel");
> +
> +	fd = SAFE_OPEN(BACKING_FILE, O_RDWR | O_CREAT | O_TRUNC, 0600);
> +	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, 4096));
> +
> +	if (TST_RET != 0) {
> +		SAFE_CLOSE(fd);
> +
> +		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS) {
> +			tst_brk(TCONF, "Filesystem %s does not support FALLOC_FL_PUNCH_HOLE",
> +				tst_device->fs_type);
> +		}
> +
> +		tst_brk(TBROK | TERRNO, "fallocate() error");
> +	}
> +
> +	SAFE_FTRUNCATE(fd, SWAP_SIZE_MB * TST_MB);
> +	SAFE_CLOSE(fd);
> +
> +	loop_dev_id = tst_find_free_loopdev(loop_dev, sizeof(loop_dev));
> +	if (loop_dev_id < 0)
> +		tst_brk(TBROK, "No free loop device found");
> +
> +	if (tst_attach_device(loop_dev, BACKING_FILE))
> +		tst_brk(TBROK, "Failed to attach %s to %s", loop_dev, BACKING_FILE);
> +	loop_attached = 1;
> +
> +	snprintf(discard_path, sizeof(discard_path),
> +		 "/sys/block/loop%d/queue/discard_max_bytes", loop_dev_id);
> +	if (FILE_SCANF(discard_path, "%lu", &discard_max_bytes) != 0 || discard_max_bytes == 0) {
> +		tst_brk(TCONF, "Loop device %s does not support discard on %s",
> +			loop_dev, tst_device->fs_type);
> +	}
> +
> +	SAFE_STAT(BACKING_FILE, &st);
> +
> +	page_size = getpagesize();
> +	blk_size = st.st_blksize;
> +	alloc_units = page_size > blk_size ? page_size : blk_size;
> +
> +	/* Minimum 512-byte blocks for 1 page + small tolerance for filesystem metadata */
> +	max_header_blocks = (alloc_units / 512) * 2;
> +}
> +
> +static void verify_swapon(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct stat st;
> +	blkcnt_t blocks_before, blocks_after;
> +	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
> +
> +	tst_fill_file(BACKING_FILE, 'A', TST_MB, SWAP_SIZE_MB);
> +
> +	tst_cmd(mkswap_argv, "/dev/null", "/dev/null", TST_CMD_TCONF_ON_MISSING);
> +
> +	SAFE_STAT(BACKING_FILE, &st);
> +	blocks_before = st.st_blocks;
> +
> +	if (!blocks_before)
> +		tst_brk(TBROK, "Backing file has 0 allocated blocks");
> +
> +	TEST(tst_syscall(__NR_swapon, loop_dev, tc->flags));
> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO, "swapon(%s, %s)", loop_dev, tc->desc);
> +		return;
> +	}
> +	swap_active = 1;
> +
> +	SAFE_STAT(BACKING_FILE, &st);
> +	blocks_after = st.st_blocks;
> +
> +	if (tc->exp_discard)
> +		TST_EXP_LE_LU(blocks_after, max_header_blocks);
> +	else
> +		TST_EXP_EQ_LI(blocks_after, blocks_before);
> +
> +	if (tst_syscall(__NR_swapoff, loop_dev) != 0)
> +		tst_brk(TBROK | TTERRNO, "swapoff(%s) failed", loop_dev);
> +	swap_active = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (swap_active && tst_syscall(__NR_swapoff, loop_dev) != 0)
> +		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", loop_dev);
> +	swap_active = 0;
> +
> +	if (loop_attached)
> +		tst_detach_device(loop_dev);
> +	loop_attached = 0;
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_swapon,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
