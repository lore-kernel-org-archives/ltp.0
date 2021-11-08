Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A245FC433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 15:39:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B9C6124D
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 15:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7B9C6124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B7733C0675
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 16:39:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3A083C04C0
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 16:39:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 089891A00E0C
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 16:39:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D2C92195D;
 Mon,  8 Nov 2021 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636385970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYBOZL5wRKA8A/CjwOmcYd5EvLyvi0jGn8lXJ7xJ/aY=;
 b=EX8ZcMFLLN41CuyVljOeFDyEJpzw8Mp58pVUviV+we8OrY5YxbIcg0SXnWBbBAeq3IPg61
 3xeVmKhEgesXs11vcVM6yjO7NdHADWDT+M3kbbBt45Lu4l5Is41oIZpaP6u/pwrb+kmX0d
 h5awj2u0OB9/rCwKB3KaUT3s5phiFv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636385970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYBOZL5wRKA8A/CjwOmcYd5EvLyvi0jGn8lXJ7xJ/aY=;
 b=429fZ3LVeCTdvU5+a1tSahypsv7y1F8hVw7+ANCjtkxSOv8tnNDc6gddzTX8OVRATnNdno
 WbSqwm1Gruqlo6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4D213BBD;
 Mon,  8 Nov 2021 15:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q5wyBbJEiWFXTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 08 Nov 2021 15:39:30 +0000
Date: Mon, 8 Nov 2021 16:40:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YYlE7jrR6nSeu0x1@yuki>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1635337569-4634-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1635337569-4634-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/13] syscalls/quotactl04: Remove useless
 mount option
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
> Adjust header position.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3

So this went in to Linux 3.5 looking at supported versions of SLES and
RHEL it looks that anything older went out of support, so it's likely
that we do not care anymore.

Or does anyone still needs to test quota on kernels older than 3.5?


> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  .../kernel/syscalls/quotactl/quotactl04.c     | 41 ++++++++-----------
>  1 file changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index fd3afc888..f34050716 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -1,24 +1,22 @@
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
>   *
> - * This testcase checks the basic flag of quotactl(2) for project quota on
> - * non-XFS filesystems.
> + * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
>   *
> - * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
> - * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> - *    for project.
> - * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
> - *    for project.
> - * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
> - *    flag for project.
> - * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
> - *    flag for project.
> - * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
> - * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
> - *    ID with Q_GETNEXTQUOTA flag for project.
> - * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
> + * - turn on quota with Q_QUOTAON flag for project
> + * - set disk quota limits with Q_SETQUOTA flag for project
> + * - get disk quota limits with Q_GETQUOTA flag for project
> + * - set information about quotafile with Q_SETINFO flag for project
> + * - get information about quotafile with Q_GETINFO flag for project
> + * - get quota format with Q_GETFMT flag for project
> + * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for project
> + * - turn off quota with Q_QUOTAOFF flag for project
>   *
>   * Minimum e2fsprogs version required is 1.43.
>   */

It would be cleaner to separate the change to the description from the
possibly functional change that removes the mount option. It would be
much easier to revert the functional change in the very unlikely case
that we ever need it.

> @@ -29,14 +27,9 @@
>  #include <stdio.h>
>  #include <sys/stat.h>
>  #include <sys/mount.h>
> -#include "config.h"
> -#include "lapi/quotactl.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_test.h"
> -
> -#ifndef QFMT_VFS_V1
> -# define QFMT_VFS_V1 4
> -#endif
> +#include "lapi/quotactl.h"
>  
>  #define FMTID QFMT_VFS_V1
>  #define MNTPOINT	"mntpoint"
> @@ -141,7 +134,7 @@ static void setup(void)
>  		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
>  	pclose(f);
>  	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> -	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
>  }
>  
>  static void cleanup(void)
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
