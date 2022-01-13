Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F952C433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 14:21:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1477A3C9531
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 15:21:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AC1A3C9507
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 15:21:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B3B801A00888
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 15:21:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B73CA1F3BC;
 Thu, 13 Jan 2022 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642083668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPERglBrNBQoCkgjJacv/Af6vPH7JpM127YowoFFRp8=;
 b=XY97dndU7ZXGf3IQ/h3sF4HLir7Et0z/tvGO//CJFOKO2DSS/GA2r4skJ9C0zKnjR12CEQ
 qnG96FZUZB87+mDGzFWllhPyuS2JQJuBvgszwXjVCJGsDYPVdSOqoiQZP5Ml44A24LkvTF
 HErIsT7vvAq8luVIG4gttzLJssgkcHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642083668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPERglBrNBQoCkgjJacv/Af6vPH7JpM127YowoFFRp8=;
 b=KPkHrlQ2jkgjX4tGulSNX1fIIfEgyGeYXdk4E6b2O2jufT4tEW1IJk4P8CS0Phi/Rij139
 p6oAyWdmhERWF8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A31DC1330C;
 Thu, 13 Jan 2022 14:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XC5HJlQ14GHedwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jan 2022 14:21:08 +0000
Date: Thu, 13 Jan 2022 15:22:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YeA1toicLOoqmwyv@yuki>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/quotactl09: Test error when quota
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
> + * - EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't
> + *   under this moutpoint)
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
> +static int getnextquota_nsup, external_fd = -1;
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
> +	int use_external_fd;
> +	char *des;
> +} tcases[] = {
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1, 0,
> +	"EFAULT when addr or special is invalid"},
> +
> +	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, NULL, EINVAL, 0, 0,
> +	"EINVAL when cmd or type is invalid"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, ENOTBLK, 0, 0,
> +	"ENOTBLK when special is not a block device"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1, 0,
> +	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EPERM, 0, 0,
> +	"EPERM when the caller lacked the required privilege for specified operations"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL, EINVAL, 0, 1,
> +	"EINVAL when cmd is Q_QUOTAON, but the fd refers to a regular file(doesn't under "
> +	"this mountpoint)"}
> +};
> +
> +static void verify_quotactl(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int quota_on = 0;
> +	int drop_flag = 0;
> +
> +	tst_res(TINFO, "Testing %s", tc->des);
> +	if (tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) && getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support Q_GETNEXTQUOTA");
> +		return;
> +	}
> +
> +	if (tc->on_flag) {
> +		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> +			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAON, USRQUOTA))");
> +		if (!TST_PASS)
> +			return;
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
> +	} else {
> +		if (tc->use_external_fd) {
> +			tst_res(TCONF, "quotactl() doesn't use fd, skip");
> +			return;
> +		}
> +	}
> +	if (tc->exp_err == ENOTBLK)
> +		TST_EXP_FAIL(do_quotactl(fd, tc->cmd, "/dev/null", *tc->id, tc->addr),
> +			ENOTBLK, "do_quotactl()");
> +	else
> +		TST_EXP_FAIL(do_quotactl(tc->use_external_fd ? external_fd : fd, tc->cmd,
> +			tst_device->dev, *tc->id, tc->addr), tc->exp_err, "do_quotactl()");
> +
> +	if (quota_on) {
> +		TST_EXP_PASS_SILENT(do_quotactl(fd, QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> +			fmt_id, NULL), "do_quotactl(QCMD(Q_QUOTAOFF, USRQUOTA)");
> +		if (!TST_PASS)
> +			return;
> +		quota_on = 0;

There is no need to clear this flag.

> +	}
> +
> +	if (drop_flag) {
> +		tst_cap_action(&needadmin);
> +		drop_flag = 0;

And this flag.

> +	}
> +}
> +
> +static void setup(void)
> +{
> +	unsigned int i;
> +	const char *const fs_opts[] = { "-O quota", NULL};
> +
> +	quotactl_info();
> +	external_fd = SAFE_CREAT("testfile", O_RDONLY);
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);

Why don't we pass the fs_opts in tst_test instead and use .mount_device = 1?

Should be as easy as:

static struct tst_test test = {
	...
	.dev_fs_opts = (const char *const []){"-O quota", NULL},
	.mount_device = 1,
	...
};

Or is there a reason why this wouldn't work?


With the changes outlined in the other email and the minor issues I've
pointed out here fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
