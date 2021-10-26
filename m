Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067CC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 13:45:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9BE60EB4
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 13:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F9BE60EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF71D3C6859
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 15:45:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3C693C135F
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 15:44:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C7A22009C9
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 15:44:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 372FB1FD42;
 Tue, 26 Oct 2021 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635255895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zPZhNmSgVFZnWXX7Xl1Y3MZpng32I2Fvk4C4FXM6as=;
 b=vaAI/y0Jrt/9ewyyOwfpbfHmY9wIv7fZI0ovdq9PQOTROZ16XpU+dHkbcgm4G/CQ87fZlJ
 t/5OOhaWwDhHEPNOajBU7N/FV1YXHMLKKhA4VtnbUOBSCocQawsSgYuXNm7PQFzInc0qT0
 uG41mbOmyq86MKTMC7OX3qG4czSKFi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635255895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zPZhNmSgVFZnWXX7Xl1Y3MZpng32I2Fvk4C4FXM6as=;
 b=Erl/SjIB/ZfNy5ayClS4863EpJl+/+SG1izLtTwelTjuIfuDnRLnnc3hOZAt8w9voAas2W
 OK3/AONUZgxSV8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E82113B06;
 Tue, 26 Oct 2021 13:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E8TtBVcGeGGEfgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 13:44:55 +0000
Date: Tue, 26 Oct 2021 15:45:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgGiMSDSwVOhMfW@yuki>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562591-5830-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 02/11] syscalls/quotactl06???Also test with
 vfsv1 format
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
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -1,26 +1,42 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> + * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
>   * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the quotactl syscall with visible quota files
> + * (cover two formats, vfsv0 and vfsv1):
>   *
> - * Tests basic error handling of the quotactl syscall.
>   * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
>   * existed but not a regular file.
> + *
>   * 2) quotaclt fails with ENOENT when the file specified by special
>   * or addr does not exist.
> + *
>   * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
>   * Q_QUOTAON had already been performed.
> + *
>   * 4) quotactl fails with EFAULT when addr or special is invalid.
> + *
>   * 5) quotactl fails with EINVAL when cmd or type is invalid.
> + *
>   * 6) quotactl fails with ENOTBLK when special is not a block device.
> + *
>   * 7) quotactl fails with ESRCH when no disk quota is found for the
>   * indicated user and quotas have not been turned on for this fs.
> + *
>   * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
>   * format was not found.
> + *
>   * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
>   * is no ID greater than or equal to id that has an active quota.
> + *
>   * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
>   * specified limits are out of the range allowed by the quota format.
> + *
>   * 11) quotactl fails with EPERM when the caller lacked the required
>   * privilege (CAP_SYS_ADMIN) for the specified operation.
>   */

Same comments apply here as well.

> @@ -32,10 +48,7 @@
>  #include "tst_capability.h"
>  
>  #define OPTION_INVALID 999
> -#define QFMT_VFS_V0     2
>  #define USRPATH MNTPOINT "/aquota.user"
> -#define FMTID QFMT_VFS_V0
> -
>  #define MNTPOINT "mntpoint"
>  #define TESTDIR1 MNTPOINT "/testdir1"
>  #define TESTDIR2 MNTPOINT "/testdir2"
> @@ -43,10 +56,10 @@
>  static char usrpath[] = USRPATH;
>  static char testdir1[] = TESTDIR1;
>  static char testdir2[] = TESTDIR2;
> -static int32_t fmt_id = FMTID;
> +static int32_t fmt_id;
>  static int32_t fmt_invalid = 999;
>  static int test_invalid;
> -static int test_id;
> +static int test_id, mount_flag;
>  static int getnextquota_nsup;
>  
>  static struct if_nextdqblk res_ndq;
> @@ -105,7 +118,7 @@ static void verify_quotactl(unsigned int n)
>  
>  	if (tc->on_flag) {
>  		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> -			FMTID, usrpath));
> +			fmt_id, usrpath));
>  		if (TST_RET == -1)
>  			tst_brk(TBROK,
>  				"quotactl with Q_QUOTAON returned %ld", TST_RET);
> @@ -135,7 +148,7 @@ static void verify_quotactl(unsigned int n)
>  
>  	if (quota_on) {
>  		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> -			FMTID, usrpath));
> +			fmt_id, usrpath));
>  		if (TST_RET == -1)
>  			tst_brk(TBROK,
>  				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
> @@ -150,10 +163,23 @@ static void verify_quotactl(unsigned int n)
>  
>  static void setup(void)
>  {
> -	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
> +	const char *const vfsv0_cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
> +	const char *const vfsv1_cmd[] = {"quotacheck", "-uF", "vfsv1", MNTPOINT, NULL};

If we are going to repeat this snippet in each test it may make sense to
put it into a header as we do with variants:

	static struct quotactl_variant {
		int32_t fmt_id;
		const char *fmt_name;
	} variants[] = {
		{.fmt_id = QFMT_VFS_V0, .fmt_name = "vfsv0"}
		{.fmt_id = QFMT_VFS_V1, .fmt_name = "vfsv1"}
	};

Then we can construct the rest easily from these as:

	const char *const cmd[] = {"quotacheck", "-uF", variants[variant].fmt_name, MNTPOINT, NULL};

	tst_res(TINFO, "quotactl() with %s format", variants[variant].fmt_name);

	SAFE_CMD(cmd, NULL, NULL);
	fmt_id = variants[variant].fmt_id;


>  	unsigned int i;
>  
> -	SAFE_CMD(cmd, NULL, NULL);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
> +	mount_flag = 1;
> +
> +	if (tst_variant) {
> +		tst_res(TINFO, "quotactl() with vfsv1 format");
> +		SAFE_CMD(vfsv1_cmd, NULL, NULL);
> +		fmt_id = QFMT_VFS_V1;
> +	} else {
> +		tst_res(TINFO, "quotactl() with vfsv0 format");
> +		SAFE_CMD(vfsv0_cmd, NULL, NULL);
> +		fmt_id = QFMT_VFS_V0;
> +	}
>  
>  	if (access(USRPATH, F_OK) == -1)
>  		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
> @@ -175,8 +201,15 @@ static void setup(void)
>  	}
>  }
>  
> +static void cleanup(void)
> +{
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
>  static struct tst_test test = {
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.needs_kconfigs = (const char *[]) {
>  		"CONFIG_QFMT_V2",
>  		NULL
> @@ -185,11 +218,11 @@ static struct tst_test test = {
>  	.test = verify_quotactl,
>  	.dev_fs_type = "ext4",
>  	.mntpoint = MNTPOINT,
> -	.mount_device = 1,
> -	.mnt_data = "usrquota",
> +	.needs_device = 1,
>  	.needs_cmds = (const char *const []) {
>  		"quotacheck",
>  		NULL
>  	},
>  	.needs_root = 1,
> +	.test_variants = 2,
>  };
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
