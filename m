From: Jan Kara <jack@suse.cz>
Date: Fri, 17 Sep 2021 14:13:31 +0200
Subject: [LTP] [mm/page]  ab19939a6a: ltp.msync04.fail
In-Reply-To: <YT8HqsXsHFeMdDxS@yuki>
References: <20210912123429.GA25450@xsang-OptiPlex-9020>
 <YT8HqsXsHFeMdDxS@yuki>
Message-ID: <20210917121331.GA14905@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
