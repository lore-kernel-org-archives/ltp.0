Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ADEC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:21:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99EC61078
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C99EC61078
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161EA3C677D
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 16:21:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 079243C677D
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:20:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BBEF100145F
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:20:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1A01FD42;
 Tue, 26 Oct 2021 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635258053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCMm7BQ0znS7jJgQ2CGadZlZ8wmPmaGigi7mmy2aJNU=;
 b=DTvvYK9xjljqY+r7YOUeWDFaBaNrrm5hoLa2KmgY9DsQ0JAvUJUOlIwb/t/LBD76Z8W48I
 mNRkJJDLgxSJvaSESDkrRGiAjCUQqVzzksDKz8va25U1cdzewg9qQS/fQIdOEb7CFvRso5
 2LeNVg9JFr2pJG5PP34QBu+ToLEC8yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635258053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCMm7BQ0znS7jJgQ2CGadZlZ8wmPmaGigi7mmy2aJNU=;
 b=rVE0Nzjuq5vk22tl7aLjiaKQnP29jSY/t7C+88xC6T0c9sI65qW0IrUtfl5MN8/9hOy4sT
 TEPzikWz0ozdS7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2664513B06;
 Tue, 26 Oct 2021 14:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LwAQCMUOeGG2EgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 14:20:53 +0000
Date: Tue, 26 Oct 2021 16:21:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgO9rqcXS5dh1us@yuki>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562888-5987-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562888-5987-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 07/11] syscalls/quotactl08: Test quoatctl01 but
 quota info hidden in filesystem
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

On Mon, Oct 18, 2021 at 09:14:44PM +0800, Yang Xu wrote:
> It uses two variants(quotactl and quotactl_fd). The difference for quotactl01
> is that we don't use quotacheck command and quota info hidden in filesystem.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/quotactl/.gitignore |   1 +
>  .../kernel/syscalls/quotactl/quotactl08.c     | 246 ++++++++++++++++++
>  .../kernel/syscalls/quotactl/quotactl_var.h   |  29 +++
>  4 files changed, 277 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/quotactl/quotactl08.c
>  create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_var.h
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b19316805..cdeb3e142 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1073,6 +1073,7 @@ quotactl04 quotactl04
>  quotactl05 quotactl05
>  quotactl06 quotactl06
>  quotactl07 quotactl07
> +quotactl08 quotactl08
>  
>  read01 read01
>  read02 read02
> diff --git a/testcases/kernel/syscalls/quotactl/.gitignore b/testcases/kernel/syscalls/quotactl/.gitignore
> index 8d2ef94d9..dab9b3420 100644
> --- a/testcases/kernel/syscalls/quotactl/.gitignore
> +++ b/testcases/kernel/syscalls/quotactl/.gitignore
> @@ -5,3 +5,4 @@
>  /quotactl05
>  /quotactl06
>  /quotactl07
> +/quotactl08
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> new file mode 100644
> index 000000000..554a204b1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems
> + * without visible quota files(quota information is stored in hidden system inodes):
> + *
> + * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
> + *
> + * 2 quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> + *    for user.
> + *
> + * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> + *    for user.
> + *
> + * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> + *    flag for user.
> + *
> + * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> + *    flag for user.
> + *
> + * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
> + *
> + * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
> + *
> + * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
> + *    ID with Q_GETNEXTQUOTA flag for user.
> + *
> + * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
> + *
> + * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
> + *
> + * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> + *     for group.
> + *
> + * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> + *     for group.
> + *
> + * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> + *     flag for group.
> + *
> + * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> + *     flag for group.
> + *
> + * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
> + *
> + * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
> + *
> + * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
> + *     ID with Q_GETNEXTQUOTA flag for group.
> + *
> + * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
> + */

The same comments apply for this comment as well.

> +#include "config.h"

The config.h should ideally be included in the lapi/quotactl.h instead.

> +#include <errno.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "lapi/quotactl.h"

And this is included in the quotactl_var.h so no need to include it here
as well.

> +#include "quotactl_var.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define TESTFILE	MNTPOINT "/testfile"
> +
> +static int32_t fmt_id = QFMT_VFS_V1;
> +static int test_id, fd = -1;
> +static struct dqblk set_dq = {
> +	.dqb_bsoftlimit = 100,
> +	.dqb_valid = QIF_BLIMITS
> +};
> +static struct dqblk res_dq;
> +
> +static struct dqinfo set_qf = {
> +	.dqi_bgrace = 80,
> +	.dqi_valid = IIF_BGRACE
> +};
> +static struct dqinfo res_qf;
> +static int32_t fmt_buf;
> +static int getnextquota_nsup;
> +
> +static struct if_nextdqblk res_ndq;
> +
> +static struct tcase {
> +	int cmd;
> +	int *id;
> +	void *addr;
> +	void *set_data;
> +	void *res_data;
> +	int sz;
> +	char *des;
> +	char *tname;
> +} tcases[] = {
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for user",
> +	"QCMD(Q_QUOTAON, USRQUOTA)"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq,
> +	NULL, NULL, 0, "set disk quota limit for user",
> +	"QCMD(Q_SETQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_GETQUOTA, USRQUOTA), &test_id, &res_dq,
> +	&set_dq.dqb_bsoftlimit, &res_dq.dqb_bsoftlimit,
> +	sizeof(res_dq.dqb_bsoftlimit), "get disk quota limit for user",
> +	"QCMD(Q_GETQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_SETINFO, USRQUOTA), &test_id, &set_qf,
> +	NULL, NULL, 0, "set information about quotafile for user",
> +	"QCMD(Q_SETINFO, USRQUOTA)"},
> +
> +	{QCMD(Q_GETINFO, USRQUOTA), &test_id, &res_qf,
> +	&set_qf.dqi_bgrace, &res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for user",
> +	"QCMD(Q_GETINFO, USRQUOTA)"},
> +
> +	{QCMD(Q_GETFMT, USRQUOTA), &test_id, &fmt_buf,
> +	&fmt_id, &fmt_buf, sizeof(fmt_buf),
> +	"get quota format for user",
> +	"QCMD(Q_GETFMT, USRQUOTA)"},
> +
> +	{QCMD(Q_SYNC, USRQUOTA), &test_id, &res_dq,
> +	NULL, NULL, 0, "update quota usages for user",
> +	"QCMD(Q_SYNC, USRQUOTA)"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_id, &res_ndq,
> +	&test_id, &res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for user",
> +	"QCMD(Q_GETNEXTQUOTA, USRQUOTA)"},
> +
> +	{QCMD(Q_QUOTAOFF, USRQUOTA), &test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for user",
> +	"QCMD(Q_QUOTAOFF, USRQUOTA)"},
> +
> +	{QCMD(Q_QUOTAON, GRPQUOTA), &fmt_id, NULL,
> +	NULL, NULL, 0, "turn on quota for group",
> +	"QCMD(Q_QUOTAON, GRPQUOTA)"},
> +
> +	{QCMD(Q_SETQUOTA, GRPQUOTA), &test_id, &set_dq,
> +	NULL, NULL, 0, "set disk quota limit for group",
> +	"QCMD(Q_SETQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETQUOTA, GRPQUOTA), &test_id, &res_dq, &set_dq.dqb_bsoftlimit,
> +	&res_dq.dqb_bsoftlimit, sizeof(res_dq.dqb_bsoftlimit),
> +	"set disk quota limit for group",
> +	"QCMD(Q_GETQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_SETINFO, GRPQUOTA), &test_id, &set_qf,
> +	NULL, NULL, 0, "set information about quotafile for group",
> +	"QCMD(Q_SETINFO, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETINFO, GRPQUOTA), &test_id, &res_qf, &set_qf.dqi_bgrace,
> +	&res_qf.dqi_bgrace, sizeof(res_qf.dqi_bgrace),
> +	"get information about quotafile for group",
> +	"QCMD(Q_GETINFO, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETFMT, GRPQUOTA), &test_id, &fmt_buf,
> +	&fmt_id, &fmt_buf, sizeof(fmt_buf), "get quota format for group",
> +	"QCMD(Q_GETFMT, GRPQUOTA)"},
> +
> +	{QCMD(Q_SYNC, GRPQUOTA), &test_id, &res_dq,
> +	NULL, NULL, 0, "update quota usages for group",
> +	"QCMD(Q_SYNC, GRPQUOTA)"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, GRPQUOTA), &test_id, &res_ndq,
> +	&test_id, &res_ndq.dqb_id, sizeof(res_ndq.dqb_id),
> +	"get next disk quota limit for group",
> +	"QCMD(Q_GETNEXTQUOTA, GRPQUOTA)"},
> +
> +	{QCMD(Q_QUOTAOFF, GRPQUOTA), &test_id, NULL,
> +	NULL, NULL, 0, "turn off quota for group",
> +	"QCMD(Q_QUOTAOFF, GRPQUOTA)"},
> +};
> +
> +static void setup(void)
> +{
> +	quotactl_info();
> +
> +	test_id = geteuid();

The test has .needs_root flag set, so as far as I can tell this will
always return 0, or do I miss something?

> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);	
                                                         ^
							 Trailing
							 whitespace
> +	//tst_require_quota_support(tst_device->dev, fmt_id, NULL);

Why do we have this here?

> +	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
> +		test_id, (void *) &res_ndq));
> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> +		getnextquota_nsup = 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static void verify_quota(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	res_dq.dqb_bsoftlimit = 0;
> +	res_qf.dqi_igrace = 0;
> +	fmt_buf = 0;
> +	res_ndq.dqb_id = -1;
> +
> +	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> +	if ((tc->cmd == QCMD(Q_GETNEXTQUOTA, USRQUOTA) ||
> +		tc->cmd == QCMD(Q_GETNEXTQUOTA, GRPQUOTA)) &&
> +		getnextquota_nsup) {
> +		tst_res(TCONF, "current system doesn't support this cmd");
> +		return;
> +	}
> +	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
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
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_QFMT_V2",
> +		NULL
> +	},
> +	.test = verify_quota,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.mount_device = 1,
> +	.dev_fs_type = "ext4",
> +	.dev_fs_opts = (const char *const []){"-O", "quota", NULL},
> +	.mntpoint = MNTPOINT,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = 2,
> +};
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl_var.h b/testcases/kernel/syscalls/quotactl/quotactl_var.h
> new file mode 100644
> index 000000000..27d57294c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/quotactl/quotactl_var.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef LTP_QUOTACTL_VAR_H
> +#define LTP_QUOTACTL_VAR_H
> +
> +#include "lapi/quotactl.h"
> +
> +#define TEST_VARIANTS 2
> +
> +static int do_quotactl(int fd, int cmd, const char *special, int id, caddr_t addr)
> +{
> +	if (tst_variant == 0)
> +		return quotactl(cmd, special, id, addr);
> +	return quotactl_fd(fd, cmd, id, addr);
> +}
> +
> +static void quotactl_info(void)
> +{
> +	if (tst_variant == 0)
> +		tst_res(TINFO, "Test quotactl()");
> +	else
> +		tst_res(TINFO, "Test quotactl_fd()");
> +}
> +#endif /* LTP_QUOTACTL_VAR_H */
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
