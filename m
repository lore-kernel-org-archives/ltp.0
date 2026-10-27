Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C8606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oJBhcb7x
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BBCE3EB292
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 03:15:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FBCF3D2387
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:14:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E26B8600657
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793067296; x=1824603296;
 h=date:from:to:cc:subject:message-id:mime-version: in-reply-to;
 bh=5lA/7pKtWck7vCkOArCrpRySsoQA1+UgX9wXJWD4Lx4=;
 b=oJBhcb7xk8o/EiJgXWpwWVpOsdX6xGBLFrogtn2alrokNmGnxBnfy0H3
 AToAb7QsmTsuvA8sBX7Cdi7d1FCxPaVbqduXghNSohzOSBWj7KvK1DTEE
 5WcGMbQr4C77HyJYw7WJest9I8BZZv+vH/FhjdAcBd+WuKfG1Mpi2VHEu
 JCLcK82oEsa1IROnkwo/Gdch2UoUY8dMaCmUBFaTRf4n6Gki3VzwM8OZu
 3yNU8aD70uuXnkZFui0mL17Wn1WfR2JHQt4oPoaWilgI41gZVzunW61Uf
 ZuFEgpsJIY2hJm54RBPywePWTKMsA8waKLa8ywj8F2QhBLqTJXiSvP1iU g==;
X-CSE-ConnectionGUID: jKAKrfTeRcCzNBT8wlmErA==
X-CSE-MsgGUID: CIpsTkq6S5C5JzBL2b/bDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1766395"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1766395"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 19:14:52 -0700
X-CSE-ConnectionGUID: BBkXL+RGRbmu52r90EePmw==
X-CSE-MsgGUID: 2uWGC/EqS3CQ29R2mdsaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4370330"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.182.64])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 19:14:50 -0700
Date: Tue, 27 Oct 2026 10:14:46 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Message-ID: <202610262143.a92547a9-lkp@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ad2359d.0083e9c2.97e0f.79de@mx.google.com>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] f2fs: verify inode data-block ownership at mount
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: lkp@intel.com, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, yi1.lai@intel.com,
 oe-lkp@lists.linux.dev, jaegeuk@kernel.org, ltp@lists.linux.it,
 haoranwangsec@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hello,

kernel test robot noticed "last_state.incomplete/bootup failure" on:

commit: 612a9db3132785844663564c15691d5feac8a259 ("[PATCH] f2fs: verify inode data-block ownership at mount")
url: https://github.com/intel-lab-lkp/linux/commits/Haoran-Wang/f2fs-verify-inode-data-block-ownership-at-mount/20261016-223258
base: v7.3-rc7
patch link: https://lore.kernel.org/all/6ad2359d.0083e9c2.97e0f.79de@mx.google.com/
patch subject: [PATCH] f2fs: verify inode data-block ownership at mount

in testcase: ltp
version: ltp-x86_64-af1ad307f-1_20261024 with following parameters:

	disk: 1HDD
	fs: f2fs
	test: ltp-aiodio.part2-02


config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)

[  +3.766884] [    T594] mount: /fs/sda1: fsconfig() failed: Structure needs cleaning.


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610262143.a92547a9-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261026/202610262143.a92547a9-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
