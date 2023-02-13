Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E0DC636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 09:36:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 465793CBF96
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 10:36:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D7683CBF8A
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 10:36:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1BC931400242
 for <ltp@lists.linux.it>; Mon, 13 Feb 2023 10:36:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E9D641F45F;
 Mon, 13 Feb 2023 09:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676280965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kh6kkLEptvRq2cOIqAorOawHYSRpCzO67GMhtKVbR8A=;
 b=CgSETvUZWyTLYU0Q0zLov/MDQicRU12dzMr2yACclKhspg8YZlmax6Dtgc24QZTHgn5FBv
 olpxZGelAfOTpNuW4eW3s3XbYwqTRoaCm1neTGeZEWFutkuQBPZFVXFTDXAzWoeVgTHwur
 AXoI3NA9Kli1Eq+7mA1K+wJW4mHVTCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676280965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kh6kkLEptvRq2cOIqAorOawHYSRpCzO67GMhtKVbR8A=;
 b=QL6L4+CfOchxSpceQ06/dVeWvWGVP+3Zbc8AXI3HrQtArzDZlpivdwIyvzYPcJUbZ3j4xi
 e3Yw7bXVYtRgRtAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 99CD72C141;
 Mon, 13 Feb 2023 09:36:05 +0000 (UTC)
References: <87bksklax3.fsf@suse.de>
 <20230127100553.29986-1-william.roche@oracle.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: william.roche@oracle.com
Date: Mon, 13 Feb 2023 09:34:23 +0000
Organization: Linux Private Site
In-reply-to: <20230127100553.29986-1-william.roche@oracle.com>
Message-ID: <87lel1q54q.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v2 0/1] Add some memory page soft-offlining
 control
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

william.roche@oracle.com writes:

> From: William Roche <william.roche@oracle.com>
>
> After a long delay (since August) and many days of work on this topic,
> I come back with a new version of this test proposal.
> This version is still using a set of threads running the same code and
> competing with each other. They all allocate a set of memory pages,
> write a sentinel value into each of them and soft-offline them before
> verifying the sentinel value and unmapping them - in a loop.
>
> I've tried to address all the feedbacks I had:
>
> - added madvise11 to the runtest/syscalls file [Petr]
> - more complete and compliant Description comment [Petr]
> - removed no longer used header files
> - removed inline comments [Petr + Richard]
> - removed unnecessary comments [Petr]
> - number of threads dynamically tuned (with limits) [Richard]
> - warn about unexpected mmap errors [Richard]
> - lower case (not camel) variable names [Petr + Richard]
> - removal of an unneeded temporary "copy" variable [Richard]
> - removed unnecessary additional checks of SAFE_* functions [Petr]
> - removed the min_kver=2.6.33 [Petr]
> - added the commit id into the test_tst structure [Richard]
> - "make check-madvise11" is now clean [Petr + Richard]
>
> But also:
>
> - separate functions for mmap and madvise (dealing with error cases)
> - simplified the page sentinel value setting and verification
> - give information about number of threads and memory to be used by an
>   iteration of the test
> - count the iterations to unpoison the right number of pages in case of
>   multiple successful iterations
> - moved sigaction setting to setup()
> - SAFE_MALLOC() used
> - significantly reduced the number of threads used
> - significantly reduced the runtime timeout
>
>
>
> Note about the tst_fuzzy_sync framework use:
> What required the largest part of my work was this aspect that has been
> mentioned by Richard, as I agree with him about putting the emphasis on
> the competing critical sections of code (mmap and madvise). I finally
> could create a version of this test using the tst_fuzzy_sync mechanism
> that could reproduce the race condition.
> But I chose not to use it for the following reasons:
> - my fuzzy version was not as reliable as the multithreaded version to
>   identify our race condition -- On a kernel where the race fixed by
>   d4ae9916ea29 is still there, the fuzzy version of the test could give
>   false positive results on about 10% of the runs, where this
>   multithreaded version hasn't shown a false positive in my tests.
> - Another reason why I chose to submit this multithreaded test version is
>   that it is generally (about 80% of the cases) much faster to fall on
>   the race condition than the fuzzy version.
>
> So I hope you'll find this multithreaded test useful.
> Tested on ARM and x86.

OK, just looking now. There was a two week delay because I was focused
on non LTP stuff.

>
>
> William Roche (1):
>   madvise11: Add test for memory allocation / Soft-offlining possible
>     race
>
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |   1 +
>  testcases/kernel/syscalls/madvise/Makefile    |   3 +
>  testcases/kernel/syscalls/madvise/madvise11.c | 405 ++++++++++++++++++
>  4 files changed, 410 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
