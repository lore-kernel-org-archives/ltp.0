Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FBFC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 08:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AADB3C9486
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 09:51:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D9F33C8C94
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 09:51:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98C9F6017D8
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 09:51:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB47A210FC;
 Fri, 18 Mar 2022 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647593462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtZnSv3EVgwpdSOF/a+AZirCRp3RU6Qv2IBxvmNeqLk=;
 b=r503wSWbLMtBBXxDmG86z6vOgHfPLrsEDrp4A17r0pW0jVOSLsGhUPyQErd2j4MOkygG9n
 8j+DNVSL+GZkl1efME+m8dsd7dcD96bDYjihiY18fDRGP2Y8brl8+aXIChr2gwCJt2QSW1
 0ZvHrX7uY6F0HAShNr/asCNXLjf0yrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647593462;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtZnSv3EVgwpdSOF/a+AZirCRp3RU6Qv2IBxvmNeqLk=;
 b=bLMuzOlBcCuyRvVQ+u4DxRAMdP6kY6a4jKuAsuxXuODpUngTwbQ0O6T4hjTgNPlsubF2sl
 kYeODnOGhNkLCpCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D23C13BB5;
 Fri, 18 Mar 2022 08:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HbzSFvZHNGLyMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Mar 2022 08:51:02 +0000
Date: Fri, 18 Mar 2022 09:51:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YjRH9NOKME95aABF@pevik>
References: <YjN+hsHidEX0ivoX@pevik>
 <6233F9CA.7060207@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6233F9CA.7060207@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] quotactl0{2, 3, 5,
 7}.c dependency problems on older kernels
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "martin.doucha@suse.com" <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr
> > Hi Xu,

> > actually quotactl0{2,3,5,7}.c and quotactl03.c fail on only on v4.5:

> > tst_kconfig.c:82: TINFO: Parsing kernel config '/.config'
> > tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > [  271.093416] XFS (loop0): Superblock has unknown read-only compatible features (0x4) enabled.
> > [  271.096902] XFS (loop0): Attempted to mount read-only compatible filesystem read-write.
> > [  271.100128] XFS (loop0): Filesystem can only be safely mounted read only.
> > [  271.101852] XFS (loop0): SB validate failed with error -22.
> > tst_test.c:1010: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d6a0) failed: EINVAL (22)
> That is because you use a newer xfsprogs (it provides newer mkfs.xfs and 
> enable reflink feature by default[1]). But older kernel can't regcozine 
> this feature bits[2](it supports reflink feature bits since kernel 
> 4.9-rc1), then mount failed.

> [1]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=ec1b42e6d58dcb7cfc5de6fc825832944997e176
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f0ec1b8ef11df0a51954df7e3ff3ca4aadb0d34b

> I don't think this is a problem, user should know its kernel version
> and xfsprogs vesion. Linux distribution has sloved this well except you 
> used yourself compiled kernel.

TL;DR: Understand and we can stop debugging to not waste time.

Giving userspace tool needs to match kernel brings extra barrier when bisecting
in the history :). I suppose there is no list to match these (actually it'd be
better to ask on linux-xfs). I'd have to experiment with slightly older ones -
I'm using mkfs.xfs 5.14.2 from openSUSE Tumbleweed (i.e. latest stable).

> > Tested on config:
> > grep -e QUOTA -e QFMT /.config
> > CONFIG_XFS_QUOTA=y
> > CONFIG_QUOTA=y
> > CONFIG_QUOTA_NETLINK_INTERFACE=y
> > # CONFIG_PRINT_QUOTA_WARNING is not set
> > # CONFIG_QUOTA_DEBUG is not set
> > CONFIG_QUOTA_TREE=y
> > # CONFIG_QFMT_V1 is not set
> > CONFIG_QFMT_V2=y
> > CONFIG_QUOTACTL=y
> > CONFIG_QUOTACTL_COMPAT=y

> > But not work either on v4.10:
> > [  299.235456] XFS (loop0): EXPERIMENTAL reflink feature enabled. Use at your own risk!
> > [  299.239463] XFS (loop0): Mounting V5 Filesystem
> > [  299.240950] XFS (loop0): Log size 1368 blocks too small, minimum size is 1580 blocks
> In xfstests, we use -lsize parameter[3] or use a value then get the 
> correct value from error log[4]. reflink feature will increase log 
> size[5], so we can disable reflink feature by using mkfs.xfs -m 
> reflink=0 /dev/loop0 (it also need mkfs.xfs support, so we may need a 
> mkfs.xfs cmd version check[5], if meet this version, use mkfs.xfs -m 
> reflink=0, if less than this version, we can ignore this version and 
> don't use mkfs.xfs extra option).

> Firstly, can you try mkfs.xfs -m reflink=0 way whether fix these  two 
> problems?

Yes, adding .dev_fs_opts:
@@ -84,6 +88,12 @@ static struct tst_test test = {
        .test_all = verify_quota,
        .format_device = 1,
        .dev_fs_type = "xfs",
+       .dev_fs_opts = (const char *const[]){
+               "-m",
+               "reflink=0",
+               NULL,
+       },
+

... helps to quotactl0{2,3,5,7}.c helps to all:

quotactl0{2,3,5}.c TPASS/TCONF:
tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='-m reflink=0' extra opts=''
[   55.193262] XFS (loop0): Mounting V5 Filesystem
[   55.197574] XFS (loop0): Ending clean mount
[   55.199560] XFS (loop0): Quotacheck needed: Please wait.
[   55.202735] XFS (loop0): Quotacheck: Done.
tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
quotactl_syscall_var.h:27: TINFO: Test quotactl()
quotactl02.c:119: TINFO: Test #0: QCMD(Q_XGETQSTAT, USRQUOTA) off
quotactl02.h:64: TPASS: quotactl() succeeded to turn off xfs quota and get xfs quota off status for user
...
../../../../include/lapi/quotactl.h:18: TCONF: syscall(443) __NR_quotactl_fd not supported on your arch

quotactl07.c fails on Q_XQUOTARM, but that's correct (missing 3dd4d40b4208 from v5.5)

tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='-m reflink=0' extra opts=''
...
quotactl07.c:37: TPASS: do_quotactl(Q_XQUOTARM,valid_type) passed
quotactl07.c:41: TPASS: Q_XQUOTARM to free space, delta(1)
quotactl07.c:45: TFAIL: do_quotactl(Q_XQUOTARM, invalid_type) succeeded
[  116.407282] XFS (loop0): Unmounting Filesystem
tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
...
../../../../include/lapi/quotactl.h:18: TCONF: syscall(443) __NR_quotactl_fd not supported on your arch

=> not sure if we want to add this "-m reflink=0" to these tests (into
quotactl_syscall_var.h, which they all use).

Kind regards,
Petr

> [3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=7e07c4bebb08414ca8228ea91bdf57828fd4d110
> [4]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/common/xfs#n81
> [5]https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=a5132d9b3634fb6436d1f06642ceda82e64ea2f5

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
