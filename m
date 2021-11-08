Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069B2C433F5
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 15:28:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E24E6120D
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 15:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E24E6120D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A22483C0529
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 16:28:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 264E33C03E6
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 16:28:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 580C414016F4
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 16:28:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9ED381FD6E;
 Mon,  8 Nov 2021 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636385304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFSZT3g8aHBxq90qo5RsuEHlrLJc/WT8vRbikx/occA=;
 b=jW5cLLMS4DRQAooQKUDiE15qYLjpSWbAeg8nYAvPvBjbeQUm4+v5ti3yZk9Hgr+MqeCscM
 E2E6m3RHRE4vWer5akdw6j54ihvkz9SNReVki5sOAujAAkZvLncqoeQdArgg40yclu9vnc
 J/FpEdJCf8i5H/0oCScDQgJyWh9KOSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636385304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFSZT3g8aHBxq90qo5RsuEHlrLJc/WT8vRbikx/occA=;
 b=Os1rhzU/W51xk86DLqQVb1noig1d2QV4HzvmYDcyMhZjXr5b0z7DPqF02H0Bt7n121XB3o
 mXheSMxdGdlVK2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 863E713BA7;
 Mon,  8 Nov 2021 15:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RjJvIBhCiWFbRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 08 Nov 2021 15:28:24 +0000
Date: Mon, 8 Nov 2021 16:29:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YYlCVBY4z4Q0MNHw@yuki>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1635337569-4634-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1635337569-4634-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/13] syscalls/quotactl06: Also test with
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

> Add a linux tag and fix docparse formatting.

I guess that the 'remove useless geteuid()' should be in the description
for this patch and not in the previous one.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  .../kernel/syscalls/quotactl/quotactl06.c     | 90 ++++++++++++-------
>  1 file changed, 56 insertions(+), 34 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
> index a10d1ca07..76343adf9 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
> @@ -1,41 +1,49 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
> - * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the quotactl syscall with visible quota files
> + * (cover two formats, vfsv0 and vfsv1):
> + *
> + * - EACCES when cmd is Q_QUOTAON and addr existed but not a regular file
> + * - ENOENT when the file specified by special or addr does not exist
> + * - EBUSTY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed
> + * - EFAULT when addr or special is invalid
> + * - EINVAL when cmd or type is invalid
> + * - ENOTBLK when special is not a block device
> + * - ESRCH when no disk quota is found for the indicated user and quotas have not been
> + *   turned on for this fs
> + * - ESRCH when cmd is Q_QUOTAON, but the quota format was not found
> + * - ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or equal to id that
> + *   has an active quota
> + * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range allowed
> + *   by the quota format
> + * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the specified
> + *   operation
> + *
> + * For ERANGE error, the vfsv0 and vfsv1 format's maximum quota limit setting have been
> + * fixed since the following kernel patch:
> + *
> + *  commit 7e08da50cf706151f324349f9235ebd311226997
> + *  Author: Jan Kara <jack@suse.cz>
> + *  Date:   Wed Mar 4 14:42:02 2015 +0100
>   *
> - * Tests basic error handling of the quotactl syscall.
> - * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
> - * existed but not a regular file.
> - * 2) quotaclt fails with ENOENT when the file specified by special
> - * or addr does not exist.
> - * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
> - * Q_QUOTAON had already been performed.
> - * 4) quotactl fails with EFAULT when addr or special is invalid.
> - * 5) quotactl fails with EINVAL when cmd or type is invalid.
> - * 6) quotactl fails with ENOTBLK when special is not a block device.
> - * 7) quotactl fails with ESRCH when no disk quota is found for the
> - * indicated user and quotas have not been turned on for this fs.
> - * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
> - * format was not found.
> - * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
> - * is no ID greater than or equal to id that has an active quota.
> - * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
> - * specified limits are out of the range allowed by the quota format.
> - * 11) quotactl fails with EPERM when the caller lacked the required
> - * privilege (CAP_SYS_ADMIN) for the specified operation.
> + *  quota: Fix maximum quota limit settings
>   */
>  
>  #include <errno.h>
>  #include <sys/quota.h>
>  #include "tst_test.h"
> -#include "lapi/quotactl.h"
> +#include "quotactl_fmt_var.h"
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
> @@ -43,9 +51,9 @@
>  static char usrpath[] = USRPATH;
>  static char testdir1[] = TESTDIR1;
>  static char testdir2[] = TESTDIR2;
> -static int32_t fmt_id = FMTID;
> +static int32_t fmt_id;
>  static int32_t fmt_invalid = 999;
> -static int test_invalid;
> +static int test_invalid = 1;
>  static int test_id;
>  static int getnextquota_nsup;
>  
> @@ -105,7 +113,7 @@ static void verify_quotactl(unsigned int n)
>  
>  	if (tc->on_flag) {
>  		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
> -			FMTID, usrpath));
> +			fmt_id, usrpath));
>  		if (TST_RET == -1)
>  			tst_brk(TBROK,
>  				"quotactl with Q_QUOTAON returned %ld", TST_RET);
> @@ -135,7 +143,7 @@ static void verify_quotactl(unsigned int n)
>  
>  	if (quota_on) {
>  		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
> -			FMTID, usrpath));
> +			fmt_id, usrpath));
>  		if (TST_RET == -1)
>  			tst_brk(TBROK,
>  				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
> @@ -150,19 +158,22 @@ static void verify_quotactl(unsigned int n)
>  
>  static void setup(void)
>  {
> -	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
>  	unsigned int i;
> +	const char *const cmd[] = {"quotacheck", "-ugF", fmt_variants[tst_variant].fmt_name, MNTPOINT, NULL};

Here as well, I would consider storing the variants pointer.

> +	tst_res(TINFO, "quotactl() with %s format", fmt_variants[tst_variant].fmt_name);
>  	SAFE_CMD(cmd, NULL, NULL);
> +	fmt_id = fmt_variants[tst_variant].fmt_id;
> +	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
> +	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
>  
>  	if (access(USRPATH, F_OK) == -1)
>  		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
>  
>  	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
>  
> -	SAFE_MKDIR(TESTDIR1, 0666);
> -	test_id = geteuid();
> -	test_invalid = test_id + 1;
> +	if (access(TESTDIR1, F_OK) == -1 && errno == ENOENT)
> +		SAFE_MKDIR(TESTDIR1, 0666);

Why don't we SAFE_RMDIR() in the test cleanup and create the directory
here unconditionally?

Other than this:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
