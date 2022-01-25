Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A84C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 12:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25A303C93B7
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 13:18:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 444433C04B0
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 13:17:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B090600872
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 13:17:52 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 770941F380;
 Tue, 25 Jan 2022 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643113072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVqHXUz3Jk2sVZPobpwss8wYXdEwQhEkUDfTqU6jT1c=;
 b=tuKwVeRGyMDb2VZ7lsq2tT/lEEKkXD4V1KG7HhiPQXYjM1MMrNCHHZ7auGcys1mCftKDGC
 s0LWiIIeHKRISWuaIq2GSqcHD4RQYF2b627WVXxihUHuHddAruSb/ORBGoMtaYMNQ3u+JP
 4v1SxOFrZZ3r+QYYJk3EgvhnrmZSj20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643113072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVqHXUz3Jk2sVZPobpwss8wYXdEwQhEkUDfTqU6jT1c=;
 b=VCZjPdrGnM7d1HUGXoXQd3hRCeAU1h0LWuD+W314V+Qhasb2GjNlTWFT4KaIBmvzXw7IVA
 cUB2oZsAwISCrDCg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 60066A3B8A;
 Tue, 25 Jan 2022 12:17:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 8EB67A05E6; Tue, 25 Jan 2022 13:17:46 +0100 (CET)
Date: Tue, 25 Jan 2022 13:17:46 +0100
From: Jan Kara <jack@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20220125121746.wrs4254pfs2mwexb@quack3.lan>
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
 <YT8HqsXsHFeMdDxS@yuki> <20210917121331.GA14905@quack2.suse.cz>
 <87o840xiel.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o840xiel.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On Tue 25-01-22 09:27:30, Richard Palethorpe wrote:
> Hello,
> 
> Jan Kara <jack@suse.cz> writes:
> 
> > On Mon 13-09-21 10:11:22, Cyril Hrubis wrote:
> >> Hi!
> >> > FYI, we noticed the following commit (built with gcc-9):
> >> > 
> >> > commit: ab19939a6a5010cba4e9cb04dd8bee03c72edcbd ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> >> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >> > 
> >> > 
> >> > in testcase: ltp
> >> > version: ltp-x86_64-14c1f76-1_20210907
> >> > with following parameters:
> >> > 
> >> > 	disk: 1HDD
> >> > 	fs: xfs
> >> > 	test: syscalls-03
> >> > 	ucode: 0xe2
> >> > 
> >> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> >> > test-url: http://linux-test-project.github.io/
> >> 
> >> The msync04 test formats a device with a diffrent filesystems, for each
> >> filesystem it maps a file, writes to the mapped page and the checks a
> >> dirty bit in /proc/kpageflags before and after msync() on that page.
> >> 
> >> This seems to be broken after this patch for ntfs over FUSE and it looks
> >> like the page does not have a dirty bit set right after it has been
> >> written to.
> >> 
> >> Also I guess that we should increase the number of the pages we dirty or
> >> attempt to retry since a single page may be flushed to the storage if we
> >> are unlucky and the process is preempted between the write and the
> >> initial check for the dirty bit.
> >
> > Yes, I agree. The most likely explanation I see for this is that the
> > identified commit results in waking flush worker earlier so it may now
> > succeed in cleaning the page before get_dirty_bit() in the LTP testcase
> > manages to see it. This is a principial race in this testcase, you can
> > perhaps make it less likely but not completely fix it AFAICT.
> 
> If the dirty bit is not set, then I guess dropping the pagecache will
> not write anything to the underlying storage?

Correct.

> So when we see no dirty bit is set, we can drop the pagecache then read
> the file to check the value was written correctly? If so then we can
> exit with TCONF saying msync couldn't be tested because the storage was
> written to too quickly.

Yes, that would work.

> Also I guess we can optimize the get_dirty_bit function. It's doing 3
> syscalls instead of 1 AFAICT.

And this could reduce the race window. So nice I guess.

But IMHO what would be a more sensible test is that msync is indeed persisting
the data. So something like: mmap file, write to mmap, msync, abort fs,
mount fs again, check the data is there. We do have framework for stuff
like this in fstests (but we don't test msync AFAIK, only fsync), not sure
if LTP has something for this as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
