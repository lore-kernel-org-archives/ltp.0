Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2B6C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 12:13:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E4C60F9C
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 12:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4E4C60F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 315DA3C884C
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 14:13:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4A7B3C1D17
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 14:13:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F411D6008DC
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 14:13:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 478771FE6E;
 Fri, 17 Sep 2021 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631880814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ce0dhYuZF8iH1ahdO1gFqxDTSsqLzOXS7SfUCTPjcGY=;
 b=qHcpYaRngDtEfV86461CjMLdbL/d3/7kVV+kBB0UNIdc876p2ED36DDn58h87Qsy8j7MlK
 tWbpGE2OgJsF9MipVfiQ66E/X4yEfO6DUJ2tcj+eHs9LXtlW0ZcAfaWZqNhwBMCGmEWWUE
 LfHkxUxUbEuGbBaqaEKuU2nTRyuw/rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631880814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ce0dhYuZF8iH1ahdO1gFqxDTSsqLzOXS7SfUCTPjcGY=;
 b=V9Ml5E1H1a688V4ItoqJiJdy23i/X2Gyg2SqcMsBsPfM9sI13Lx87nXMKhrGA+A41m0ae8
 o63lQsV0sCfEwMAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
 by relay2.suse.de (Postfix) with ESMTP id 2BF9AA3B9C;
 Fri, 17 Sep 2021 12:13:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id C68F41E0CA7; Fri, 17 Sep 2021 14:13:31 +0200 (CEST)
Date: Fri, 17 Sep 2021 14:13:31 +0200
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20210917121331.GA14905@quack2.suse.cz>
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
 <YT8HqsXsHFeMdDxS@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YT8HqsXsHFeMdDxS@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [mm/page]  ab19939a6a: ltp.msync04.fail
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Chi Wu <wuchi.zero@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
 lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>,
 Sedat Dilek <sedat.dilek@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917121331.o7CnrwlK4Iu0xneiJ7JaIea1reBFJKlQ-uv0yOFxn7E@z>

On Mon 13-09-21 10:11:22, Cyril Hrubis wrote:
> Hi!
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > 
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20210907
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: xfs
> > 	test: syscalls-03
> > 	ucode: 0xe2
> > 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> 
> The msync04 test formats a device with a diffrent filesystems, for each
> filesystem it maps a file, writes to the mapped page and the checks a
> dirty bit in /proc/kpageflags before and after msync() on that page.
> 
> This seems to be broken after this patch for ntfs over FUSE and it looks
> like the page does not have a dirty bit set right after it has been
> written to.
> 
> Also I guess that we should increase the number of the pages we dirty or
> attempt to retry since a single page may be flushed to the storage if we
> are unlucky and the process is preempted between the write and the
> initial check for the dirty bit.

Yes, I agree. The most likely explanation I see for this is that the
identified commit results in waking flush worker earlier so it may now
succeed in cleaning the page before get_dirty_bit() in the LTP testcase
manages to see it. This is a principial race in this testcase, you can
perhaps make it less likely but not completely fix it AFAICT.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
