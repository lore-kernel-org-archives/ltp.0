Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B6CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791809030; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IS3HVbqnHMhryPPeuPGCv3GvmUXEEPHP4WOS8MqOjwI=;
 b=htl8mKBtJlEKpGgLnLp8VkGJ3mp2Y7OaCKI0pX1s9YaQ/7wbMvpptsXY7n9C22oIqyWRP
 V+pCdDTLuRajVKHJK85x3m+fWbNiprPjnbRSdVGqfNgoMl+pXYyEJ6rSj+FEjmdRs0GJ99S
 NJAxbcBiHWoQf2aRlqeaEtd0iUfdQF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD91A3EA856
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 14:43:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16D823E2A2F
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 14:43:31 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6082320091B
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 14:43:30 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so15927025e9.3
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791809010; x=1792413810; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1VPNQkqoaKRW5T9PNTN+G1auZ/d9QuPu/+PtfEIkatg=;
 b=RKhu/7gUxd5GCH0xkrRw9jVnGscq2HcU1xvzbYY+1Nh3MAn709E/fi0Id2b+DUJxBQ
 LWz1+aF/TXJMAymBxDOZ71vxEDiyF4avU2jfsEX+i1q+5Ow9L0pGZXPH2GA3SV8ilcx2
 VSfD4NGUHPZxq7SeWvrsWV0UXgTejVJXnyZCoYQ2OzqH1E41oghdEoD/MiUbMU7K644U
 2Uo2Omoha2EVJgpvgvF63R0PkVq7l1NWehUlv84/pdmpT4Wx+tAAsWOuqX0V2dFpCD0A
 Uogwc+cSDHOGe0Ab6leU/cAQF9ahP2o9jPaccNWxJKf+97Mseuijw/YzMV9eJAGG+01A
 UhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791809010; x=1792413810;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1VPNQkqoaKRW5T9PNTN+G1auZ/d9QuPu/+PtfEIkatg=;
 b=O7cr7/VwdIq2/MpRFwAuXPss2FPtqOXHw+7ED9967BMdsFOMo/zKBfLZc60ytqIWr8
 vuUOcMM3ISuhZ0r64wSSQqsK/e7mXNf/LHPEr4kylNcJN6W0XaCOrH9um/EB9d+twUN/
 RP/GwhEHh86g4t04xIDLZQL5sVBa+Nw1YC7LdXdrIFaQ0uJwMrs1VWKAD+GcivqcDSTl
 wj2cxLk1/S8ff97ikgEfJL0T4LcJRd+P0lBY4oz8Ug84qB2b8M4S3zYKCSleBIfN6oqF
 bpbssfFoF2TpsRb8KgbiN6wUAy/DTieQlzMLZysvCvZj5Ej0lf1q/sfxpr68oB5dFYTS
 6osw==
X-Gm-Message-State: AFq9FYIXsR5syHOw+Ut5AJtP3RK9GG3R26hni2pY/FCBHXdP1jl5Lgjm
 SdbCPb++EMFAGJ1md/zQvOy/KPrRg/uH/Oi7eL46eid/SK7T0bJXcp94O4TW0uhDMNpKhO4G76r
 fGGS8Brec4fk6
X-Gm-Gg: AYBFou2hg2qEjCzqsU0A/Z19lpGWJwsgTL7M9nI9nMBxhX+4yDJpLvOyKU/4oLjCHeV
 D8qC3MzwlCLtHMgpx0rEJOojwb7tdYltUP8QXTfCXCBuaFxnlRufOu/Yf1HorftTcEnRcAm4Rxa
 GeZsEqKHIQL7lrj+1hOnOXA6NBd1FjwIipR4bO2OdET8Xw9rLkBKLtiOr4BODV3VlLegQwdBj+m
 GC+6WASDMOdaeEGCceErwkTmwSspjgiAjGBS/dpyWDTomJ7sNPvrz3irBNIrAeKaxnYlbyC0C5R
 27RsvLqG0O3qichwoufLpmMTgMpAJ8j2Xo5IiDavPgyAW728ROHkpscwKg8aFhix921S4InxPUz
 m8D1+jLKiP/LV/f3rvPcyke22Xq8kbejk5F0a+QNqDSd0STRFLqeI2hx7FimYfSXJsQvMR3SrdZ
 ecEpv8EcETowzUE7kjFaYqkM8PMBjrbgTL8swGnnQWA6JNQ17cGRVRyk8KPPELmaBDawBE3dKsu
 BoVP1Sa5q/kQMIUYWOCjM1UIzh429jmtNFikfDeQyxpr50jjIExSM+y9poEpPxcRXwDlhOKpJ3V
 RQ==
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id
 5b1f17b1804b1-4a18e4b8966mr164413415e9.26.1791809009452; 
 Mon, 12 Oct 2026 05:43:29 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19303d4a8sm117181945e9.2.2026.10.12.05.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:43:28 -0700 (PDT)
Message-ID: <lbvEwRyhGK5uRMDXEGYnefAp6akeeV6nr278@localhost.localdomain>
To: "Gaurav Pathak" <gpathak@suse.de>
In-Reply-To: <20261012072403.77119-2-gpathak@suse.de>
Date: Mon, 12 Oct 2026 12:43:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] syscalls/statx13: Add basic test for
 STATX_WRITE_ATOMIC on regular file
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gaurav,

> From: Gaurav Pathak <gaurav.pathak@suse.com>
> 
> This patch adds a new test to validate these atomic write limit fields.
> The test ensures the filesystem correctly advertises the STATX_ATTR_WRITE_ATOMIC
> attribute when queried on a file opened with O_DIRECT. It also verifies that the
> reported optimized maximum is logically consistent by falling within the
> absolute minimum and maximum boundaries. Furthermore, it checks that all
> reported atomic write unit sizes are valid powers of two, adhering to the strict
> requirements of the kernel block layer.
> 
> If the underlying storage hardware or filesystem lacks atomic write
> support, the test gracefully skips with TCONF.
> 
> Closes: #1224

we don't add Github tags in the git history, please remove it.

> 
> Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>
> ---
>  configure.ac                               |   4 +-
>  include/lapi/stat.h                        |  17 ++-
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>  testcases/kernel/syscalls/statx/statx13.c  | 139 +++++++++++++++++++++
>  5 files changed, 160 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/statx/statx13.c
> 
> diff --git a/configure.ac b/configure.ac
> index 18bfdb88c..d5a609fa7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -181,7 +181,9 @@ AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
>  AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
>  AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
>  AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> -AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
> +AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align, struct statx.stx_atomic_write_unit_max_opt,
> +				  struct statx.stx_atomic_write_unit_min, struct statx.stx_atomic_write_unit_max,
> +				  struct statx.stx_atomic_write_segments_max],,,[
>  #define _GNU_SOURCE
>  #include <sys/stat.h>
>  ])
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index 17b62ea98..859e410ab 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -93,7 +93,14 @@ struct statx_timestamp {
>  	uint64_t	stx_mnt_id; \
>  	uint32_t	stx_dio_mem_align; \
>  	uint32_t	stx_dio_offset_align; \
> -	uint64_t	__spare3[12]; \
> +	uint64_t	stx_subvol; \
> +	uint32_t	stx_atomic_write_unit_min; \
> +	uint32_t	stx_atomic_write_unit_max; \
> +	uint32_t	stx_atomic_write_segments_max; \
> +	uint32_t	stx_dio_read_offset_align; \
> +	uint32_t	stx_atomic_write_unit_max_opt; \
> +	uint32_t	__spare2[1]; \
> +	uint64_t	__spare3[8]; \
>  };
>  
>  LTP_DEFINE_STATX_STRUCT(statx_fallback);
> @@ -197,6 +204,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>  # define STATX_DIOALIGN		0x00002000U
>  #endif
>  
> +#ifndef STATX_WRITE_ATOMIC
> +#define STATX_WRITE_ATOMIC  0x00010000U
> +#endif
> +
>  #ifndef STATX__RESERVED
>  # define STATX__RESERVED	0x80000000U
>  #endif
> @@ -248,6 +259,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>  # define STATX_MNT_ID_UNIQUE  0x00004000U
>  #endif
>  
> +#ifndef STATX_ATTR_WRITE_ATOMIC
> +#define STATX_ATTR_WRITE_ATOMIC	0x00400000
> +#endif
> +
>  #define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
>  	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
>  
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d953f0558..b8c7fbb0f 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1926,6 +1926,7 @@ statx09 statx09
>  statx10 statx10
>  statx11 statx11
>  statx12 statx12
> +statx13 statx13
>  
>  membarrier01 membarrier01
>  
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index f6a423eed..e601a46a3 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -10,3 +10,4 @@
>  /statx10
>  /statx11
>  /statx12
> +/statx13
> diff --git a/testcases/kernel/syscalls/statx/statx13.c b/testcases/kernel/syscalls/statx/statx13.c
> new file mode 100644
> index 000000000..cc445fa57
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx13.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 SUSE LLC <gaurav.pathak@suse.com>
> + */
> +
> +/*\
> + * This test validates the STATX_WRITE_ATOMIC feature (introduced in Linux 6.13).
> + * It ensures that supported filesystems (xfs and nfs) correctly report their
> + * atomic write limits to user space when queried via statx().
> + *
> + * The test performs the following validations:
> + *
> + * - Creates a test file using O_DIRECT (a prerequisite for atomic writes).
> + * - Calls statx() with the STATX_WRITE_ATOMIC mask to retrieve the limits.
> + * - Verifies that stx_atomic_write_unit_min, stx_atomic_write_unit_max, and
> + *   stx_atomic_write_unit_max_opt are logically consistent (e.g., max_opt is
> + *   within the min and max bounds).
> + * - Ensures all reported atomic write unit sizes are valid powers of two.

This looks more like [Algorithm] section.

> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE MNTPOINT "/testfile"
> +#define MODE 0644
> +
> +#define WRITE_SIZE 4096
> +#define ALIGNMENT  4096

We need to use the right page size when we use O_DIRECT. Please take a look
at the other tests using O_DIRECT, so we avoid defining a default value for it.

> +
> +static int file_fd = -1;
> +
> +static void verify_statx(void)
> +{
> +	struct ltp_statx buff;
> +
> +	TST_EXP_PASS_SILENT(SAFE_STATX(AT_FDCWD, TESTFILE, 0, STATX_BASIC_STATS | STATX_WRITE_ATOMIC, &buff));

SAFE_STATX() will fail the syscall, so it shadows TST_EXP_PASS_SILENT().
We need to use raw statx() in these cases, because it's our subject of test,
performing a TST_EXP_PASS() check on it.

We really want to know if statx() fails when STATX_WRITE_ATOMIC is passed.

> +
> +	if (!TST_PASS)
> +		return;
> +
> +	if (!(buff.data.stx_attributes & STATX_ATTR_WRITE_ATOMIC))
> +		tst_brk(TCONF, "Filesystem does not support STATX_WRITE_ATOMIC");
> +
> +#if HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MIN
> +	if (buff.data.stx_atomic_write_unit_min <= buff.data.stx_atomic_write_unit_max)
> +		tst_res(TPASS, "stx_atomic_write_unit_min(%u) <= stx_atomic_write_unit_max(%u)",
> +				buff.data.stx_atomic_write_unit_min, buff.data.stx_atomic_write_unit_max);
> +	else
> +		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) > stx_atomic_write_unit_max(%u)",
> +				buff.data.stx_atomic_write_unit_min, buff.data.stx_atomic_write_unit_max);
> +
> +	if (buff.data.stx_atomic_write_unit_min > 0 &&
> +			__builtin_popcount(buff.data.stx_atomic_write_unit_min) == 1)
> +		tst_res(TPASS, "stx_atomic_write_unit_min(%u) is power of 2",
> +				buff.data.stx_atomic_write_unit_min);
> +	else
> +		tst_res(TFAIL, "stx_atomic_write_unit_min(%u) is not a power of 2",
> +				buff.data.stx_atomic_write_unit_min);
> +
> +	if (buff.data.stx_atomic_write_unit_max > 0 &&
> +			__builtin_popcount(buff.data.stx_atomic_write_unit_max) == 1)
> +		tst_res(TPASS, "stx_atomic_write_unit_max(%u) is power of 2",
> +				buff.data.stx_atomic_write_unit_max);
> +	else
> +		tst_res(TFAIL, "stx_atomic_write_unit_max(%u) is not a power of 2",
> +				buff.data.stx_atomic_write_unit_max);
> +#else
> +	tst_res(TCONF, "stx_atomic_write_unit_max or stx_atomic_write_unit_min is not defined in struct statx");
> +#endif

This is not correct. If stx_atomic_write_unit_max is not defined, we should
fallback that into the LTP fallback headers and _before_ even starting the
test, check if statx() supports it. If it doesn't then we can TCONF.

> +
> +#if HAVE_STRUCT_STATX_STX_ATOMIC_WRITE_UNIT_MAX_OPT
> +	if (buff.data.stx_atomic_write_unit_max_opt == 0) {
> +		tst_res(TPASS, "stx_atomic_write_unit_max_opt is 0 (no optimized max reported)");
> +	} else {
> +		if (buff.data.stx_atomic_write_unit_max_opt > buff.data.stx_atomic_write_unit_max)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) exceeds max (%u)",
> +					buff.data.stx_atomic_write_unit_max_opt,
> +					buff.data.stx_atomic_write_unit_max);
> +
> +		else if (buff.data.stx_atomic_write_unit_max_opt < buff.data.stx_atomic_write_unit_min)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is less than min (%u)",
> +					buff.data.stx_atomic_write_unit_max_opt,
> +					buff.data.stx_atomic_write_unit_min);
> +		else
> +			tst_res(TPASS, "stx_atomic_write_unit_max_opt (%u) is within valid range [%u, %u]",
> +					buff.data.stx_atomic_write_unit_max_opt,
> +					buff.data.stx_atomic_write_unit_min,
> +					buff.data.stx_atomic_write_unit_max);
> +
> +		if (__builtin_popcount(buff.data.stx_atomic_write_unit_max_opt) != 1)
> +			tst_res(TFAIL, "stx_atomic_write_unit_max_opt (%u) is not a power of 2",
> +					buff.data.stx_atomic_write_unit_max_opt);
> +	}
> +#else
> +	tst_res(TCONF, "stx_atomic_write_unit_max_opt is not defined in struct statx");
> +#endif

Same mistake here.

> +}
> +
> +static void setup(void)
> +{
> +	char *data_buff = SAFE_MEMALIGN(ALIGNMENT, WRITE_SIZE);
> +
> +	umask(0);

This is not needed.

> +	memset(data_buff, '@', WRITE_SIZE);
> +
> +	file_fd =  SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT | O_DIRECT, MODE);
> +	SAFE_WRITE(SAFE_WRITE_ALL, file_fd, data_buff, WRITE_SIZE);

SAFE_CLOSE() goes here.

> +
> +	free(data_buff);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (file_fd != -1)
> +		SAFE_CLOSE(file_fd);

We can close it right after SAFE_WRITE() because file descriptior is never
in use during the test.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_statx,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "6.11",
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.filesystems = (struct tst_fs[]) {
> +		{
> +			.type = "xfs",
> +			.mkfs_opts = (const char *const []){"-f", "-bsize=16K", NULL},
> +		},
> +		{
> +			.type = "ext4",
> +			.mkfs_opts = (const char *const []){"-O", "bigalloc", "-b", "4096", "-C", "65536", NULL},
> +		},
> +		{}
> +	},
> +};
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
