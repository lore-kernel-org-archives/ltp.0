Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A2C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 22:49:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E85373C9288
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 23:49:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36FFB3C73DA
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 23:49:08 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8BF5100096E
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 23:49:07 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB4161F84;
 Fri,  7 Jan 2022 22:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A920C36AE5;
 Fri,  7 Jan 2022 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641595744;
 bh=ViSqgQgJuvP+htaIPnhi8An9uFQEuN9qNJ/GiLYWh+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X1oCrg9LFE1Jvd6RAH9k2xELL+kLGarb8CZsayVgHdtMIvEHSd954rjT0/h/vgDkJ
 MpYyr7hl6H4CWPGTx3439RkplHvCY55qpaVJGndfucNbQvIn9Iymj+K7GLh5rKCoks
 d69kq4uXX0gwXguQeQwuZZi9TBwkdprAMFqRI+VRr2pZ7cDz36FN2y8wgYijT3hrBd
 rB6bCFVMEQD+XgWq4ccMp2s2ysLS/5o77YvCIFS6hR2MRwFL8gefSwCApG83MM8NYS
 dVCkXbrZKfnNSsUpWsFw414UvdLkMmk72imthqc/e5G+iz3NR6iPW9GkuY5dfulAMf
 Z6pGm4B+hGWhA==
Date: Fri, 7 Jan 2022 14:49:02 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <YdjDXiXYjQMJnr/c@sol.localdomain>
References: <20211226132851.GC34518@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211226132851.GC34518@xsang-OptiPlex-9020>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [f2fs]  a1e09b03e6: ltp.ADSP024.fail
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
Cc: lkp@intel.com, lkp@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Dec 26, 2021 at 09:28:52PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: a1e09b03e6f5c1d713c88259909137c0fd264ede ("f2fs: use iomap for direct I/O")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20211221
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: f2fs
> 	test: ltp-aiodio.part2
> 	ucode: 0x21
> 

This is caused by an f2fs bug where it exposes DIO-allocated blocks to users
before they have been initialized.  This test actually fails both before and
after my commit "f2fs: use iomap for direct I/O".  It is nondeterministic, which
is why it may have appeared to be a regression.

I'll start a separate discussion on linux-f2fs-devel about this, since this
thread has too many irrelevant mailing lists and this has been discussed before.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
