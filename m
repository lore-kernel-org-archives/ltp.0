Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6948FEE14DC
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:08:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914573CE9AE
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 12:08:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C13E33CB62A
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:08:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C646214088E1
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:08:36 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 45BAD6121A;
 Thu,  7 Sep 2023 10:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD56EC433B9;
 Thu,  7 Sep 2023 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694081313;
 bh=Uvh3itFPi3f2rNpOz+0wOaEQRtpvKFcxcWUQaF3LklI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=EtWqmmplqobrFkXZqA+C7sfxzPaEIL9Y22Fcnw9YpEvU2FEsElv/t+cy0s6+7mf1m
 bHrY6wtyiXtwsZ12km6c23k6cyvDWtlRqEkV/MjGcERAB3hc289tg2dJACy5uvBTTH
 YhU19WjlcM3/U14KPux3paYzq4EEHRmp5DYyB9/H7NEIJgcQ1QojzRfh/SYOtS9wCo
 LA7bSBlqWWGZ34OJwnsqNHXDbprUvWgiwqme1wFI1Hf0AtJP0WUBJuyNuf60Uah/YN
 mCzzU4voEA/JR07skPUB74LyKMTmBieFxHvGbDBU1TrqaTMDKLA6mQOQrbRgcY3kwR
 y4RNefNwkmlNA==
Message-ID: <84d2418526ca59f3c706eea27dee583ccf678c14.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Date: Thu, 07 Sep 2023 06:08:31 -0400
In-Reply-To: <202309071017.a64aca5e-oliver.sang@intel.com>
References: <202309071017.a64aca5e-oliver.sang@intel.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [tmpfs]  d48c339729: ltp.mount03.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 2023-09-07 at 10:59 +0800, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "ltp.mount03.fail" on:
> 
> commit: d48c3397291690c3576d6c983b0a86ecbc203cac ("tmpfs: add support for multigrain timestamps")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 708283abf896dd4853e673cc8cba70acaf9bf4ea]
> [test failed on linux-next/master a47fc304d2b678db1a5d760a7d644dac9b067752]
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20230715
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: f2fs
> 	test: syscalls-00/mount03
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com
> 
> 
> we also noticed this issue doesn't always happen, as below, on d48c339729,
> 13 out of 30 runs failed, while others can pass.
> and on parent commit, we didn't observe the failure on 30 runs.
> 
> ffb6cf19e0633406 d48c3397291690c3576d6c983b0
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :30          43%          13:30    ltp.mount03.fail
> 
> 
> when failure happens, it shows
> tst_test.c:1634: TINFO: === Testing on tmpfs ===
> ...
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:140: TFAIL: st.st_atime(1694017088) < atime(1694069961)
> 
> 
> when it pass:
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1693999383) > atime(1693999381)
> 
> 
> below detail log while running mount03:
> 
> Running tests.......
> <<<test_start>>>
> tag=mount03 stime=1694017062
> cmdline="mount03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
> tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
> tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
> tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
> tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
> tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:157: TINFO: Skipping vfat as requested by the test
> tst_supported_fs_types.c:157: TINFO: Skipping exfat as requested by the test
> tst_supported_fs_types.c:157: TINFO: Skipping ntfs as requested by the test
> tst_supported_fs_types.c:90: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1634: TINFO: === Testing on ext2 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=ext2 flags=20
> mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime == atime (1694017064)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017064)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017066) > atime(1694017064)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017064)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017067) > atime(1694017066)
> mount03.c:148: TPASS: dir_st.st_atime(1694017067) > dir_atime(1694017064)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: === Testing on ext3 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=ext3 flags=20
> mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime == atime (1694017068)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017068)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017070) > atime(1694017068)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017068)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017072) > atime(1694017070)
> mount03.c:148: TPASS: dir_st.st_atime(1694017072) > dir_atime(1694017068)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: === Testing on ext4 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.46.6-rc1 (12-Sep-2022)
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=ext4 flags=20
> mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime == atime (1694017073)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017073)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017075) > atime(1694017073)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017073)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017076) > atime(1694017075)
> mount03.c:148: TPASS: dir_st.st_atime(1694017076) > dir_atime(1694017073)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: === Testing on xfs ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=xfs flags=20
> mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime == atime (1694017077)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017077)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017080) > atime(1694017077)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017077)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017081) > atime(1694017080)
> mount03.c:148: TPASS: dir_st.st_atime(1694017081) > dir_atime(1694017077)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: === Testing on btrfs ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=btrfs flags=20
> mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime == atime (1694017082)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017082)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017084) > atime(1694017082)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017082)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:137: TPASS: st.st_atime(1694017085) > atime(1694017084)
> mount03.c:148: TPASS: dir_st.st_atime(1694017085) > dir_atime(1694017082)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> tst_test.c:1634: TINFO: === Testing on tmpfs ===
> tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
> mount03.c:214: TINFO: Testing flag MS_RDONLY
> mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODEV
> mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOEXEC
> mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_REMOUNT
> mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=tmpfs flags=20
> mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOSUID
> mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NOATIME
> mount03.c:143: TPASS: st.st_atime == atime (1694017085)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017085)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_NODIRATIME
> mount03.c:137: TPASS: st.st_atime(1694017087) > atime(1694017086)
> mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017086)
> mount03.c:235: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> mount03.c:214: TINFO: Testing flag MS_STRICTATIME
> mount03.c:140: TFAIL: st.st_atime(1694017088) < atime(1694069961)
> mount03.c:148: TPASS: dir_st.st_atime(1694017088) > dir_atime(1694017087)
> mount03.c:229: TPASS: statfs() gets the correct mount flag
> mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
> tst_device.c:442: TINFO: No device is mounted at mntpoint
> 
> Summary:
> passed   113
> failed   1
> broken   0
> skipped  0
> warnings 0
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=26 termination_type=exited termination_id=1 corefile=no
> cutime=5 cstime=284
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20230516-75-g2e582e743
> 
>        ###############################################################
> 
>             Done executing testcases.
>             LTP Version:  20230516-75-g2e582e743
>        ###############################################################
> 
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230907/202309071017.a64aca5e-oliver.sang@intel.com
> 
> 
> 

I suspect what happened here is that the atime got updated to a fine-
grained value (possibly at create time), and then later got updated with
an earlier, coarse-grained value.

Probably we can just fix this by being more careful not to update unless
the new atime is later than the older one. I'll see if I can reproduce
it and come up with a fix.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
