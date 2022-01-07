Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53AAC433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 15:49:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7776D3C9253
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 16:49:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA8473C0843
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 16:49:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10B75601230
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 16:49:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 426FD21115;
 Fri,  7 Jan 2022 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641570545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bDJLqw7IH76F67rKPMUiGlV/1TNYysVPI+7aRsuNIMM=;
 b=10MtQHUL3AYC3tsleVNXNlTUF5B3ce1eZZMaMtAsEpKm0Wrm/cPispR+kjbe73RTnTuhVW
 +4WY2FL9N55FUahm6TNa+9HoHdjC7y9IYYVbZqRsC+I/Ecgt02s3JP3L5Tq2v4o+vnLvJC
 MTXydDw5J/IhOVE02PoikKATEK9Zw58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641570545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bDJLqw7IH76F67rKPMUiGlV/1TNYysVPI+7aRsuNIMM=;
 b=YDTL4ZHQBmAY5kt3C67RmVXGtQMvQz8RsQR0DnsciVnUqn9cOubdSSRMcjz+J8Ax/uSoLW
 FvqQZ3/ezXjU+yDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DEE613D17;
 Fri,  7 Jan 2022 15:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j4scA/Fg2GFLHgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jan 2022 15:49:05 +0000
Date: Fri, 7 Jan 2022 16:50:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YdhhTeot7Z9861B0@yuki>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639380414-24390-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/6] syscalls/quotactl09: Test error when quota
 info hidden in filesystem
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
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl09.c b/testcases/kernel/syscalls/quotactl/quotactl09.c
> new file mode 100644
> index 000000000..c7c485077
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl09.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the quotactl syscall without visible quota files
> + * (use quotactl and quotactl_fd syscall):
> + *
> + * - EFAULT when addr or special is invalid
> + * - EINVAL when cmd or type is invalid
> + * - ENOTBLK when special is not a block device
> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range
> + *   allowed by the quota format
> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the
> + *   specified operation
> + *
> + * Minimum e2fsprogs version required is 1.43.
> + */
> +
> +#include <errno.h>
> +#include <sys/quota.h>
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +#include "quotactl_syscall_var.h"
> +
> +#define OPTION_INVALID 999
> +
> +static int32_t fmt_id = QFMT_VFS_V1;
> +static int test_id, mount_flag;
> +static int getnextquota_nsup;
> +
> +static struct if_nextdqblk res_ndq;
> +
> +static struct dqblk set_dqmax = {
> +	.dqb_bsoftlimit = 0x7fffffffffffffffLL,  /* 2^63-1 */
> +	.dqb_valid = QIF_BLIMITS
> +};
> +
> +static struct tst_cap dropadmin = {
> +	.action = TST_CAP_DROP,
> +	.id = CAP_SYS_ADMIN,
> +	.name = "CAP_SYS_ADMIN",
> +};
> +
> +static struct tst_cap needadmin = {
> +	.action = TST_CAP_REQ,
> +	.id = CAP_SYS_ADMIN,
> +	.name = "CAP_SYS_ADMIN",
> +};
> +
> +static struct tcase {
> +	int cmd;
> +	int *id;
> +	void *addr;
> +	int exp_err;
> +	int on_flag;
> +} tcases[] = {
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1},
> +	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, NULL, EINVAL, 0},
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOTBLK, 0},
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1},
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EPERM, 0},
> +};
> +
> +static void verify_quotactl(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int quota_on = 0;
> +	int drop_flag = 0;
> +
> +	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) && getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
> +		return;
> +	}
> +
> +	if (tc->on_flag) {
> +		TEST(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> +			fmt_id, NULL));
> +		if (TST_RET == -1)
> +			tst_brk(TBROK,
> +				"quotactl with Q_QUOTAON returned %ld", TST_RET);
> +		quota_on = 1;
> +	}
> +
> +	if (tc->exp_err == EPERM) {
> +		tst_cap_action(&dropadmin);
> +		drop_flag = 1;
> +	}
> +
> +	if (tst_variant) {
> +		if (tc->exp_err == ENOTBLK) {
> +			tst_res(TCONF, "quotactl_fd() doesn't have this error, skip");
> +			return;
> +		}
> +	}
> +	if (tc->exp_err == ENOTBLK)
> +		TEST(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr));
> +	else
> +		TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));

How does this work for the tst_variant == 1? We still do pass the fd
pointing to device right?

Actually one way to simplify the whole patchset would be to open() and
close() the device in each do_quotactl() call in the case that
tst_variant == 1. We wouldn't have to pass the file descriptor to the
function and everything will just work fine.

> +	if (TST_RET == -1) {
> +		if (tc->exp_err == TST_ERR) {
> +			tst_res(TPASS | TTERRNO, "quotactl failed as expected");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"quotactl failed unexpectedly; expected %s, but got",
> +				tst_strerrno(tc->exp_err));
> +		}
> +	} else {
> +		tst_res(TFAIL, "quotactl returned wrong value: %ld", TST_RET);
> +	}

Use TST_EXP_FAIL() in new testcases please.

> +	if (quota_on) {
> +		TEST(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> +			fmt_id, NULL));
> +		if (TST_RET == -1)
> +			tst_brk(TBROK,
> +				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
> +		quota_on = 0;
> +	}
> +
> +	if (drop_flag) {
> +		tst_cap_action(&needadmin);
> +		drop_flag = 0;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	unsigned int i;
> +	const char *const fs_opts[] = { "-O quota", NULL};
> +
> +	quotactl_info();
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> +	mount_flag = 1;
> +
> +	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
> +		test_id, (void *) &res_ndq));
> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> +		getnextquota_nsup = 1;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
> +		if (!tcases[i].addr)
> +			tcases[i].addr = tst_get_bad_addr(NULL);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_QFMT_V2",
> +		NULL
> +	},
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_quotactl,
> +	.dev_fs_type = "ext4",
> +	.mntpoint = MNTPOINT,
> +	.needs_device = 1,
> +	.needs_root = 1,
> +	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4 >= 1.43.0",
> +		NULL
> +	}
> +};
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
