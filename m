Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A1C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 13:35:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A257460EC0
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 13:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A257460EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 593EF3C687F
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 15:35:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 117693C0958
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 15:35:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35B77601FC5
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 15:35:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB381FD52;
 Tue, 26 Oct 2021 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635255321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYjPeetmM5oaPkV6H8FCtIl9w0Rvuk1NwOPyNDy4n6c=;
 b=n+i/6DFH61D+rhb+bDcpBrv1SJRfxnAXIaSn4hzow/P+NlssnPvjAJB2IBgRKAdw9lSO4F
 2+Ac0ycqhlofUQ0uf8slbFst0DTyx9vEvR679/Fhy10nb1ZySfPd+mSIBoDviv168UZX+E
 KsmObC2nLCdNwD4FR7BpPQHlD2Ernoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635255321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYjPeetmM5oaPkV6H8FCtIl9w0Rvuk1NwOPyNDy4n6c=;
 b=jLF0IeKw4IP+RKdPOaqTxHe5kVWFL4E2eNBS0C781bqjrIgZsxPFcbB/7IXWfXhjBWUdIh
 K9teRs1NqAzCq9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0509613AEF;
 Tue, 26 Oct 2021 13:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id k9tqABkEeGEJegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 13:35:21 +0000
Date: Tue, 26 Oct 2021 15:36:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgESh8jbi+l1KNk@yuki>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 01/11] syscalls/quotactl01: Also test with
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

> +/*\
> + * [Description]
> + * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems
                                                               ^
							       ext4?

It seems that the test is using ext4 only, are there any other
filesystems that should be tested here?

> + * with visible quota files(cover two formats, vfsv0 and vfsv1):
>   *
> - * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
>   * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
> - * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
> + *
> + * 2 quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>   *    for user.
> + *
>   * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>   *    for user.
> + *
>   * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>   *    flag for user.
> + *
>   * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>   *    flag for user.
> + *
>   * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
> + *
>   * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
> + *
>   * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
>   *    ID with Q_GETNEXTQUOTA flag for user.
> + *
>   * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
> + *
>   * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
> + *
>   * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
>   *     for group.
> + *
>   * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
>   *     for group.
> + *
>   * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
>   *     flag for group.
> + *
>   * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
>   *     flag for group.
> + *
>   * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
> + *
>   * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
> + *
>   * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
>   *     ID with Q_GETNEXTQUOTA flag for group.
> + *
>   * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
>   */

This does not render as a list in asciidoc once the documentation is
rendered. I would have converted it to a bulleted style lists, i.e. the
list items would start with - instead of 1).

Also it's a bit poinless to repeat the quotactl(2) succeeds on each
line. It would make much more sense to put that part to the sentence
that describes the list as:

 * This testcases checks that quotactl(2) succeeds to:
 *
 *  - turn on quota with Q_QUOTAON flag
 *  - ...

> @@ -43,16 +66,12 @@
>  #include "lapi/quotactl.h"
>  #include "tst_test.h"
>  
> -#ifndef QFMT_VFS_V0
> -# define QFMT_VFS_V0	2
> -#endif
>  #define USRPATH MNTPOINT "/aquota.user"
>  #define GRPPATH MNTPOINT "/aquota.group"
> -#define FMTID	QFMT_VFS_V0
>  #define MNTPOINT	"mntpoint"
>  
> -static int32_t fmt_id = FMTID;
> -static int test_id;
> +static int32_t fmt_id;
> +static int test_id, mount_flag;
>  static char usrpath[] = USRPATH;
>  static char grppath[] = GRPPATH;
>  static struct dqblk set_dq = {
> @@ -163,9 +182,22 @@ static struct tcase {
>  
>  static void setup(void)
>  {
> -	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
> -
> -	SAFE_CMD(cmd, NULL, NULL);
> +	const char *const vfsv0_cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
> +	const char *const vfsv1_cmd[] = {"quotacheck", "-ugF", "vfsv1", MNTPOINT, NULL};
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota,grpquota");
> +	mount_flag = 1;

Why are you moving the mount from the tst_test structure here?

Do we have to remount the device to change the quota format?

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
>  	test_id = geteuid();
>  	if (access(USRPATH, F_OK) == -1)
> @@ -182,6 +214,12 @@ static void setup(void)
>  		getnextquota_nsup = 1;
>  }
>  
> +static void cleanup(void)
> +{
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
>  static void verify_quota(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> @@ -222,13 +260,14 @@ static struct tst_test test = {
>  	},
>  	.test = verify_quota,
>  	.tcnt = ARRAY_SIZE(tcases),
> -	.mount_device = 1,
> +	.needs_device = 1,
>  	.dev_fs_type = "ext4",
>  	.mntpoint = MNTPOINT,
> -	.mnt_data = "usrquota,grpquota",
>  	.needs_cmds = (const char *const []) {
>  		"quotacheck",
>  		NULL
>  	},
>  	.setup = setup,
> +	.cleanup = cleanup,
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
