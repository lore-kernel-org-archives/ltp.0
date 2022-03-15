Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD477C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 17:19:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A4A23C935A
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 18:19:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4CE3C3129
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 18:19:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9D35600048
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 18:19:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A63021F38A;
 Tue, 15 Mar 2022 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647364776;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XBWDx1qRWr3TgxkiRtzFj8TFJPHbtT4eLJqBWqsS0E=;
 b=P4TtAqjkCZsro9TEJ80QUoJIAPr4FIIrpgh+Q4FndWHeuLjPGul2gKmTHZB1563TvzaShX
 zFufbbN++ZhK/ml3C1p3E11BYxQPuSI5b6RWKPczr9It007C/g69ETC13GSq9Rk5uSKmRV
 lY3dciHAMpX7flP+iu+ucl/MzKeqDnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647364776;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XBWDx1qRWr3TgxkiRtzFj8TFJPHbtT4eLJqBWqsS0E=;
 b=78BLnoSdUwWx+qbMuWzO3aBa/TA9T803zo601oh+G72fAijjpegwwV1m1nBOcMQZlrBx65
 8xri24RKlNwUrlAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7641513B66;
 Tue, 15 Mar 2022 17:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +j7RGqjKMGJwVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Mar 2022 17:19:36 +0000
Date: Tue, 15 Mar 2022 18:19:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YjDKpuBVMuVUY/l6@pevik>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572612959-20577-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/quotactl04: add project quota
 test for non-xfs filesystem
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> This is a variant about quotactl01. It is used to test project quota.
> I split it into a new case instead of adding it in quotaclt01 because
> two points:
> 1)before linux 4.10, ext4 doesn't support project quota
...
> +	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
commit 689c958cbe6b is from v4.5-rc1. But you use Q_GETNEXTQUOTA, which is from
926132c0257a ("quota: add new quotactl Q_GETNEXTQUOTA") from v4.6-rc1.

Others looks to me quite old (before UAPI split in v3.7-rc1.

Thus it could be .min_kver = "v4.5" for the rest (unless there is some other
dependency). Or am I missing something? But maybe we just don't care.

Kind regards,
Petr

> 2)on old kernel, kernel doesn't permit mount both prjquota and grpquota together

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/lapi/quotactl.h                       |   4 +
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/quotactl/.gitignore |   1 +
>  .../kernel/syscalls/quotactl/quotactl04.c     | 155 ++++++++++++++++++
>  4 files changed, 161 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/quotactl/quotactl04.c

> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
> index 787f4691e..b9ab54483 100644
> --- a/include/lapi/quotactl.h
> +++ b/include/lapi/quotactl.h
> @@ -13,6 +13,10 @@
>  #endif
>  #include <sys/quota.h>

> +#ifndef PRJQUOTA
> +# define PRJQUOTA 2
> +#endif
> +
>  # ifndef Q_XGETQSTATV
>  #  define Q_XGETQSTATV XQM_CMD(8)
>  # endif
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 12d3e0d3b..c30e9e620 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -953,6 +953,7 @@ pwritev202_64 pwritev202_64
>  quotactl01 quotactl01
>  quotactl02 quotactl02
>  quotactl03 quotactl03
> +quotactl04 quotactl04

>  read01 read01
>  read02 read02
> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
> index b0ef075e7..1db7c5d98 100644
> --- a/testcases/kernel/syscalls/quotactl/.gitignore
> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
> @@ -1,3 +1,4 @@
>  /quotactl01
>  /quotactl02
>  /quotactl03
> +/quotactl04
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> new file mode 100644
> index 000000000..25ab016cf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + *
> + * This testcase checks the basic flag of quotactl(2) for project quota on
> + * non-XFS filesystems.
> + *
> + * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
> + * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> + *    for project.
> + * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> + *    for project.
> + * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> + *    flag for project.
> + * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> + *    flag for project.
> + * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
> + * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
> + *    ID with Q_GETNEXTQUOTA flag for project.
> + * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
> + */
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include "config.h"
> +#include "lapi/quotactl.h"
> +#include "tst_test.h"
> +
> +#ifndef QFMT_VFS_V1
> +# define QFMT_VFS_V1 4
> +#endif
> +#define FMTID QFMT_VFS_V1
> +#define MNTPOINT	"mntpoint"
> +static int32_t fmt_id = FMTID;
> +static int test_id, mount_flag;
> +static struct dqblk set_dq = {
> +	.dqb_bsoftlimit = 100,
> +	.dqb_valid = QIF_BLIMITS
> +};
> +static struct dqblk res_dq;
> +static struct dqinfo set_qf = {
> +	.dqi_bgrace = 80,
> +	.dqi_valid = IIF_BGRACE
> +};
> +
> +static struct dqinfo res_qf;
> +static int32_t fmt_buf;
> +
> +#if defined(HAVE_STRUCT_IF_NEXTDQBLK)
> +static struct if_nextdqblk res_ndq;
> +#endif
> +
> +static struct tcase {
> +	int cmd;
> +	int *id;
> +	void *addr;
> +	void *set_data;
> +	void *res_data;
> +	int sz;
> +	char *des;
> +} tcases[] = {
> +	{QCMD(Q_QUOTAON, PRJQUOTA), &fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for project"},
> +
> +	{QCMD(Q_SETQUOTA, PRJQUOTA), &test_id, &set_dq,
> +	NULL, NULL, 0, "set disk quota limit for project"},
> +
> +	{QCMD(Q_GETQUOTA, PRJQUOTA), &test_id, &res_dq,
> +	&set_dq.dqb_bsoftlimit, &res_dq.dqb_bsoftlimit,
> +	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for project"},
> +
> +	{QCMD(Q_SETINFO, PRJQUOTA), &test_id, &set_qf,
> +	NULL, NULL, 0, "set information about quotafile for project"},
> +
> +	{QCMD(Q_GETINFO, PRJQUOTA), &test_id, &res_qf,
> +	&set_qf.dqi_bgrace, &res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for project"},
> +
> +	{QCMD(Q_GETFMT, PRJQUOTA), &test_id, &fmt_buf,
> +	&fmt_id, &fmt_buf, sizeof(fmt_buf),
> +	"get quota format for project"},
> +
> +#if defined(HAVE_STRUCT_IF_NEXTDQBLK)
> +	{QCMD(Q_GETNEXTQUOTA, PRJQUOTA), &test_id, &res_ndq,
> +	&test_id, &res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for project"},
> +#endif
> +
> +	{QCMD(Q_QUOTAOFF, PRJQUOTA), &test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for project"},
> +
> +};
> +
> +static void setup(void)
> +{
> +	const char *const extra_opts[] = {"-O quota,project", NULL};
> +
> +	test_id = geteuid();
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, extra_opts);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
> +	mount_flag = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mount_flag && tst_umount(MNTPOINT))
> +	tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
> +static void verify_quota(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	res_dq.dqb_bsoftlimit = 0;
> +	res_qf.dqi_igrace = 0;
> +	fmt_buf = 0;
> +
> +	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
> +		return;
> +	}
> +
> +	if (memcmp(tc->res_data, tc->set_data, tc->sz)) {
> +		tst_res(TFAIL, "quotactl failed to %s", tc->des);
> +		tst_res_hexd(TINFO, tc->res_data, tc->sz, "retval:   ");
> +		tst_res_hexd(TINFO, tc->set_data, tc->sz, "expected: ");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "quotactl succeeded to %s", tc->des);
> +}
> +
> +static const char *kconfigs[] = {
> +	"CONFIG_QFMT_V2",
> +	NULL
> +};
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.needs_kconfigs = kconfigs,
> +	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
> +	.test = verify_quota,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_device = 1,
> +	.dev_fs_type = "ext4",
> +	.mntpoint = MNTPOINT,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
