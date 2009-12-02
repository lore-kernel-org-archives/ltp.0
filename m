Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1NFuL8-0002ug-QY
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 18:54:14 +0000
Received: from xenotime.net ([72.52.64.118])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NFuKx-0004S8-7g
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 18:54:10 +0000
Received: from chimera.site ([96.253.169.185]) by xenotime.net for
	<ltp-list@lists.sourceforge.net>; Wed, 2 Dec 2009 10:53:55 -0800
Date: Wed, 2 Dec 2009 10:53:54 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
Message-Id: <20091202105354.f7137c98.rdunlap@xenotime.net>
In-Reply-To: <7A65EEA3-78FD-49C3-B683-265B93F8AC96@sun.com>
References: <1F5364AE-321E-44E9-8B0D-B8E17597A0DA@fuhm.net>
	<907888CC-F4B2-448F-8F48-B96A566D323B@fuhm.net>
	<1259667765.9614.19.camel@marge.simson.net>
	<20091201143558.GB12730@quack.suse.cz>
	<20091201160324.GA25873@quack.suse.cz>
	<7A65EEA3-78FD-49C3-B683-265B93F8AC96@sun.com>
Mime-Version: 1.0
Subject: Re: [LTP] writev data loss bug in (at least) 2.6.31 and 2.6.32pre8
	x86-64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andreas Dilger <adilger@sun.com>, ltp-list@lists.sourceforge.net
Cc: Mike Galbraith <gleep@gmx.de>, ext4 development <linux-ext4@vger.kernel.org>, James Y Knight <foom@fuhm.net>, Jan Kara <jack@suse.cz>, npiggin@suse.de

On Tue, 01 Dec 2009 15:02:04 -0700 Andreas Dilger wrote:

> On 2009-12-01, at 09:03, Jan Kara wrote:
> > On Tue 01-12-09 15:35:59, Jan Kara wrote:
> >> On Tue 01-12-09 12:42:45, Mike Galbraith wrote:
> >>> On Mon, 2009-11-30 at 19:48 -0500, James Y Knight wrote:
> >>>> On Nov 30, 2009, at 3:55 PM, James Y Knight wrote:
> >>>>> This test case is distilled from an actual application which  
> >>>>> doesn't even intentionally use writev: it just uses C++'s  
> >>>>> ofstream class to write data to a file. Unfortunately, that  
> >>>>> class smart and uses writev under the covers. Unfortunately, I  
> >>>>> guess nobody ever tests linux writev behavior, since it's broken  
> >>>>> _so_much_of_the_time_. I really am quite astounded to see such a  
> >>>>> bad track record for such a fundamental core system call....
> 
> I suspect an excellent way of exposing problems with the writev()  
> interface would be to wire it into fsx, which is commonly run as a  
> stress test for Linux.  I don't know if it would have caught this  
> case, but it definitely couldn't hurt to get more testing cycles for it.

Maybe someone from LTP would be interested in adding this test functionality
to fsx-linux ?

Source/test program is available at
http://marc.info/?l=linux-kernel&m=125961612418323&w=2


> >>  Ext4 also has this problem but delayed allocation mitigates the  
> >> effect to an error in accounting of blocks reserved for delayed  
> >> allocation and thus under normal circumstances nothing bad happens.
> 
> It looks like ext4 might still hit this problem, if delalloc is  
> disabled.  Could you please submit a similar patch for ext4 also.
> 
> >  The patch below fixes the issue for me...
> >
> > 									Honza
> >
> > From 1b2ad411dd86afbfdb3c5b0f913230e9f1f0b858 Mon Sep 17 00:00:00 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Tue, 1 Dec 2009 16:53:06 +0100
> > Subject: [PATCH] ext3: Fix data / filesystem corruption when write  
> > fails to copy data
> >
> > When ext3_write_begin fails after allocating some blocks or  
> > generic_perform_write fails to copy data to write, we truncate  
> > blocks already instantiated beyond i_size. Although these blocks  
> > were never inside i_size, we have to truncate pagecache of these  
> > blocks so that corresponding buffers get unmapped. Otherwise  
> > subsequent __block_prepare_write (called because we are retrying the  
> > write) will find the buffers mapped, not call ->get_block, and thus  
> > the page will be backed by already freed blocks leading to  
> > filesystem and data corruption.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > fs/ext3/inode.c |   18 ++++++++++++++----
> > 1 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
> > index 354ed3b..f9d6937 100644
> > --- a/fs/ext3/inode.c
> > +++ b/fs/ext3/inode.c
> > @@ -1151,6 +1151,16 @@ static int  
> > do_journal_get_write_access(handle_t *handle,
> > 	return ext3_journal_get_write_access(handle, bh);
> > }
> >
> > +/*
> > + * Truncate blocks that were not used by write. We have to truncate  
> > the
> > + * pagecache as well so that corresponding buffers get properly  
> > unmapped.
> > + */
> > +static void ext3_truncate_failed_write(struct inode *inode)
> > +{
> > +	truncate_inode_pages(inode->i_mapping, inode->i_size);
> > +	ext3_truncate(inode);
> > +}
> > +
> > static int ext3_write_begin(struct file *file, struct address_space  
> > *mapping,
> > 				loff_t pos, unsigned len, unsigned flags,
> > 				struct page **pagep, void **fsdata)
> > @@ -1209,7 +1219,7 @@ write_begin_failed:
> > 		unlock_page(page);
> > 		page_cache_release(page);
> > 		if (pos + len > inode->i_size)
> > -			ext3_truncate(inode);
> > +			ext3_truncate_failed_write(inode);
> > 	}
> > 	if (ret == -ENOSPC && ext3_should_retry_alloc(inode->i_sb, &retries))
> > 		goto retry;
> > @@ -1304,7 +1314,7 @@ static int ext3_ordered_write_end(struct file  
> > *file,
> > 	page_cache_release(page);
> >
> > 	if (pos + len > inode->i_size)
> > -		ext3_truncate(inode);
> > +		ext3_truncate_failed_write(inode);
> > 	return ret ? ret : copied;
> > }
> >
> > @@ -1330,7 +1340,7 @@ static int ext3_writeback_write_end(struct  
> > file *file,
> > 	page_cache_release(page);
> >
> > 	if (pos + len > inode->i_size)
> > -		ext3_truncate(inode);
> > +		ext3_truncate_failed_write(inode);
> > 	return ret ? ret : copied;
> > }
> >
> > @@ -1383,7 +1393,7 @@ static int ext3_journalled_write_end(struct  
> > file *file,
> > 	page_cache_release(page);
> >
> > 	if (pos + len > inode->i_size)
> > -		ext3_truncate(inode);
> > +		ext3_truncate_failed_write(inode);
> > 	return ret ? ret : copied;
> > }
> >
> > -- 
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Sr. Staff Engineer, Lustre Group
> Sun Microsystems of Canada, Inc.


---
~Randy

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
