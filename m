Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAD2C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 14:01:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09BE73C9536
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 15:01:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B54E3C2CF4
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 15:01:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2787B6000FD
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 15:01:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 46A241F387;
 Thu, 13 Jan 2022 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642082505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4bZLflv9z9YotKP2EaRFyagfseE5L3cKh775nOwjpa4=;
 b=AsDPgduFw1ZOL/+VbhuCYVNbfCZ8FsXpLZBqFnLoGptEORneP8681yGR8bY8NDcfKigl7I
 4Qz9RHnI5ki24FVgDnXwNllSw/mtj5NlEvFda9dcKEc+kf00cYZYSmioh3SG9UpdTCU/UQ
 Wed3oGRb0ZDDz7xKRurIA+ThmOAokA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642082505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4bZLflv9z9YotKP2EaRFyagfseE5L3cKh775nOwjpa4=;
 b=bjJoh4lG76FWXhvTvncf2ua4WnciRngtgoqfynGDedKfSzxeiLs4Y7GOv1CtMQEq/JeD3U
 +fCygnKrzI+v6qCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DE2F1330C;
 Thu, 13 Jan 2022 14:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sa2oCckw4GF0bgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jan 2022 14:01:45 +0000
Date: Thu, 13 Jan 2022 15:03:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YeAxK/IMvCIb0Sp7@yuki>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641973691-22981-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641973691-22981-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/3] syscalls/quotactl07: Refactor this case
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
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
> index 2992a6112..2427ef682 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl07.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
> @@ -7,7 +7,9 @@
>  /*\
>   * [Description]
>   *
> - * This is a regresstion test for kernel commit 3dd4d40b4208
> + * This is not only a functional test but also a error test for Q_XQUOTARM.
> + *
> + * It is a regresstion test for kernel commit 3dd4d40b4208
>   * ("xfs: Sanity check flags of Q_XQUOTARM call").
>   */
>  
> @@ -15,51 +17,71 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <sys/quota.h>
> +#include <sys/statvfs.h>
>  #include "tst_test.h"
> -#include "lapi/quotactl.h"
> +#include "quotactl_syscall_var.h"
>  
>  #ifdef HAVE_XFS_XQM_H
>  # include <xfs/xqm.h>
>  
> -#define MNTPOINT    "mntpoint"
> -
> -static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
> -static unsigned int valid_type = XFS_USER_QUOTA;
>  /* Include a valid quota type to avoid other EINVAL error */
>  static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
> +static unsigned int valid_type = XFS_USER_QUOTA;
> +static int mount_flag;
>  
>  static void verify_quota(void)
>  {
> -	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
> -	if (TST_ERR == EINVAL)
> -		tst_res(TPASS, "Q_XQUOTARM has quota type check");
> +	struct statfs before, after;
> +
> +	SAFE_STATFS(MNTPOINT, &before);
> +	TST_EXP_PASS(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
> +			(void *)&valid_type), "do_quotactl(Q_XQUOTARM,valid_type)");
> +	SAFE_STATFS(MNTPOINT, &after);
> +	if (before.f_bavail <= after.f_bavail)
> +		tst_res(TPASS, "Q_XQUOTARM to free space, delta(%lu)", after.f_bavail - before.f_bavail);
>  	else
> -		tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
> +		tst_res(TFAIL, "Q_XQUOTARM to free space, delta(-%lu)", before.f_bavail - after.f_bavail);
> +
> +	TST_EXP_FAIL(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
> +			(void *)&invalid_type), EINVAL, "do_quotactl(Q_XQUOTARM, invalid_type)");
>  }
>  
>  static void setup(void)
>  {
> -	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
> -	if (TST_RET == -1)
> -		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
> +	quotactl_info();
> +
> +	/* ensure superblock has quota data, but not running */
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
> +	mount_flag = 1;
> +	SAFE_UMOUNT(MNTPOINT);
> +	mount_flag = 0;
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noquota");
> +	mount_flag = 1;

Maybe just SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "remount, noquota") ?

If we can remount the device without umounting it the code would be a
bit shorter.

Anyways looks good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
