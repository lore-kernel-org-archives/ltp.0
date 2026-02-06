Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06607EE2095
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 12:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770380720; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=17CLqqzg8rqlm2zHxRg6fFtkmt7/1h8vsHXfedseij4=;
 b=ItudmsXUiQ6AUDfqiSxtvSv8rOnXsBKh/Lfeov/SwRbkppobEFunfMzpi6v9b2erFGB9m
 2/LbM55roCOORjkjzWkrf6o890UkjTpIomw0YTuRpXxoTID6aaLOwt1wse4KZk2vefXxawm
 f/Bkw1EHhrfbkQKmdafsKYjQH8LV1is=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 775CF3CC882
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 13:25:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76A793C1C05
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 13:24:57 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72A4314010D9
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 13:24:55 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 79CA0444C0;
 Fri,  6 Feb 2026 12:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9139EC19422;
 Fri,  6 Feb 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770380692;
 bh=O7a8wY2zkizo/ijNU2invfJSeItdPymgjFUDFVkv854=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IZIJZ1tlaooJmKV4EzSy9QGMYd/KPYLJN/nujUHugQhzq6u1LkV/0McKFni3++GtG
 dogEinMnXpF6hMO+MLs+jb+nNylr8WiCd67HNDFlm2doQNhGy9CnM9jeuIfCkpG7sO
 fG4MPeAy5wQzlUying7T2UTfgatPx56VUFGatWi8DViuk8R+Y15wCl2RPgjDx2Neyl
 YIuxesqevK55Mq5XfLkh7N21ZPV8be6iQxQqwHYPlrQTsknGd2T1MJ3nVKTwU5z/CC
 3EzQvMtto3bjPPetbUp83zcDx8AF8URrVgIQRIJR9IbtN3SPRzNun9XuTGN0wamypJ
 UOApmRe/nSJCA==
Date: Fri, 6 Feb 2026 13:24:48 +0100
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <20260206-fluktuation-verwachsen-3354f2185f31@brauner>
References: <20260127225209.2293342-1-luca.boccassi@gmail.com>
 <202602061056.b94e9170-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202602061056.b94e9170-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is
 called on another ns
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
From: Christian Brauner via ltp <ltp@lists.linux.it>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: lkp@intel.com, luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, oe-lkp@lists.linux.dev, christian@brauner.io
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Feb 06, 2026 at 10:51:24AM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.ioctl_pidfd06.fail" on:
> 
> commit: 16cc0cf19e0b75a336cbf619d208e22b351bd430 ("[PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns")
> url: https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com/pidfs-return-EREMOTE-when-PIDFD_GET_INFO-is-called-on-another-ns/20260128-065425
> base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
> patch link: https://lore.kernel.org/all/20260127225209.2293342-1-luca.boccassi@gmail.com/
> patch subject: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: btrfs
> 	test: syscalls-00/ioctl_pidfd06
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602061056.b94e9170-lkp@intel.com
> 
> 
> 2026-02-03 16:33:15 kirk -U ltp -f temp_single_test --env TMPDIR=/fs/sdb1/tmpdir
> Host information
> 
> 	Hostname:   lkp-ivb-d04
> 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
> 	Directory:  /tmp/kirk.root/tmppqdrj0by
> 
> Connecting to SUT: default
> 
> Starting suite: temp_single_test
> ---------------------------------
> [1;37mioctl_pidfd06: [0m[1;31mfail[0m | [1;33mtainted[0m  (0.034s)
>                                                                                                                                 
> Execution time: 0.100s
> 
> 	Suite:       temp_single_test
> 	Total runs:  1
> 	Runtime:     0.034s
> 	Passed:      0
> 	Failed:      1
> 	Skipped:     0
> 	Broken:      0
> 	Warnings:    0
> 	Kernel:      Linux 6.19.0-rc5-00159-g16cc0cf19e0b #1 SMP PREEMPT_DYNAMIC Tue Feb  3 23:56:34 CST 2026
> 	Machine:     unknown
> 	Arch:        x86_64
> 	RAM:         6899592 kB
> 	Swap:        0 kB
> 	Distro:      debian 13
> 
> Disconnecting from SUT: default
> Session stopped

Thanks! This is an intentional change in behavior and only affects
systemd which is happy to adapt to that change.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
