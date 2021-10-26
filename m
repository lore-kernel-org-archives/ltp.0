Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15908C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:02:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DB260D07
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26DB260D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081033C6878
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 16:02:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5235F3C67D8
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:02:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9615A601562
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:02:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEB6521637;
 Tue, 26 Oct 2021 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635256943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/AoX1kWzQkEK+fE11EE2MjrcRUVqFDjExt7AVCm2x3k=;
 b=hLiQLdiS2XJbfmAvGqVAMfGpOjaxfWu7P2blB/uI74RikJ2PK1mjsEmURxgeIhmSBgOln9
 EldKuVEXySQtFYB0SDQBwNEUGAtoR6jzZ84Nl1kz/TSSdTlVFOuy5UtSpa5qWLm8ykcbHC
 9PPYuYtEdIftpawqLLbzfs5wNR4HFkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635256943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/AoX1kWzQkEK+fE11EE2MjrcRUVqFDjExt7AVCm2x3k=;
 b=LzUXGf8qNLyy17aRO4/O8NtLFa346P5/cNsrdj3BnO+dyyRtiuEHjDZGhQLjFj24NNmnpE
 tKGBIdo/T26yhtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBA9013B06;
 Tue, 26 Oct 2021 14:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e9s5K28KeGFtCQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 14:02:23 +0000
Date: Tue, 26 Oct 2021 16:03:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgKoQ72mqFN6uD3@yuki>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562591-5830-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 03/11] syscalls/quotactl04: Remove useless
 quotactl mount options
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
> When use -O quota options for mkfs.ext4, quota mount option
> will be ignored[1]. So remove it.
> 
> Also add docparse formatting.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c319d3
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/quotactl/quotactl04.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index fd3afc888..ca6a94263 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -2,22 +2,33 @@
>  /*
>   * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>   * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
>   *
>   * This testcase checks the basic flag of quotactl(2) for project quota on
>   * non-XFS filesystems.
>   *
>   * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for project.
> + *
>   * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>   *    for project.
> + *
>   * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>   *    for project.
> + *
>   * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>   *    flag for project.
> + *
>   * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>   *    flag for project.
> + *
>   * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for project.
> + *
>   * 7) quotactl(2) succeeds to get disk quota limit greater than or equal to
>   *    ID with Q_GETNEXTQUOTA flag for project.
> + *
>   * 8) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for project.
>   *
>   * Minimum e2fsprogs version required is 1.43.

Here as well, the list should be changed to render properly in
asciidoc.

> @@ -34,10 +45,6 @@
>  #include "tst_safe_stdio.h"
>  #include "tst_test.h"
>  
> -#ifndef QFMT_VFS_V1
> -# define QFMT_VFS_V1 4
> -#endif
> -
>  #define FMTID QFMT_VFS_V1
>  #define MNTPOINT	"mntpoint"
>  static int32_t fmt_id = FMTID;
> @@ -141,7 +148,7 @@ static void setup(void)
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
