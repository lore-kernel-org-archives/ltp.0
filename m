Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6077C3600C
	for <ltp@archiver.kernel.org>; Sat, 29 Mar 2025 00:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743206947; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=a9IKoqF/UbGBsfka/QvY7lrDLcd3SRSEXCmXrtT+Nvc=;
 b=H/V3bfbBxZm4S0kVTDm5l+uvPpNXn1fR/fEWQoIpumrhQ7Flumoa7vzAtMBaPAC1scpKi
 9LKOwDEnZ6dH8FnjMAid9n1pa3zQ6ZuZosvtZ8+rJbcl/rX/CgyYLsL/13NJrNXf82GOdXV
 6hyeEusKz3kad85V/F8oTEjmsJNieWw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB8BF3CA4C8
	for <ltp@archiver.kernel.org>; Sat, 29 Mar 2025 01:09:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50F583C2B53
 for <ltp@lists.linux.it>; Sat, 29 Mar 2025 01:08:43 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F115B6008A6
 for <ltp@lists.linux.it>; Sat, 29 Mar 2025 01:08:42 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3A6E5A43055;
 Sat, 29 Mar 2025 00:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C44C4CEE4;
 Sat, 29 Mar 2025 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743206920;
 bh=VN1DVxjBi0yPYSkPA5Ywg3ZfsV+X5/voIJAu8LCR/q4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KDHswYu2nWf4abN6VH2v+1HLSSuIYF3Q47HE8bsJmEQ7rK4MIDRSsyDoH4QFhGUNj
 pXkR0aOrLEO135/7fO1gB58RBniF9BzbusuEWztJ0HwGjuJxOpP+ar6Z714DGKwsiu
 MlYRJxeL6N13feb2eTwIPhuSP2lHp3RpgS6Po6ja+YFSyhc4NBHCUpbvK2m1fhEQn4
 Zpgc+5wQgCFv/gNfuT0K5vKN5iHGezifAxPfkOq9kfebCnOr/Dh3d45lh6vRn8VrkM
 caAMgRY95K7vjK5VGj2BhUsKJYh6xqwG07QdkmOgIZ1ODbzvjXyM4xzMvCb/aU+7pU
 cZWiCdFZ3qzCw==
Date: Fri, 28 Mar 2025 17:08:38 -0700
To: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Bueso <dave@stgolabs.net>, Tso Ted <tytso@mit.edu>,
 Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <Z-c6BqCSmAnNxb57@bombadil.infradead.org>
References: <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
 <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
 <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
 <Z-bz0IZuTtwNYPBq@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-bz0IZuTtwNYPBq@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, gost.dev@samsung.com,
 Alistair Popple <apopple@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Oliver Sang <oliver.sang@intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 28, 2025 at 12:09:06PM -0700, Luis Chamberlain wrote:
> On Fri, Mar 28, 2025 at 02:48:00AM -0700, Luis Chamberlain wrote:
> > On Thu, Mar 27, 2025 at 09:21:30PM -0700, Luis Chamberlain wrote:
> > > Would the extra ref check added via commit 060913999d7a9e50 ("mm:
> > > migrate: support poisoned recover from migrate folio") make the removal
> > > of the spin lock safe now given all the buffers are locked from the
> > > folio? This survives some basic sanity checks on my end with
> > > generic/750 against ext4 and also filling a drive at the same time with
> > > fio. I have a feeling is we are not sure, do we have a reproducer for
> > > the issue reported through ebdf4de5642fb6 ("mm: migrate: fix reference
> > > check race between __find_get_block() and migration")? I suspect the
> > > answer is no.
> 
> Sebastian, David, is there a reason CONFIG_DEBUG_ATOMIC_SLEEP=y won't
> trigger a atomic sleeping context warning when cond_resched() is used?
> Syzbot and 0-day had ways to reproduce it a kernel warning under these
> conditions, but this config didn't, and require dan explicit might_sleep()
> 
> CONFIG_PREEMPT_BUILD=y
> CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> # CONFIG_PREEMPT_LAZY is not set
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_HAVE_PREEMPT_DYNAMIC=y
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
> CONFIG_PREEMPT_NOTIFIERS=y
> CONFIG_DEBUG_PREEMPT=y
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> 
> Are there some preemption configs under which cond_resched() won't
> trigger a kernel splat where expected so the only thing I can think of
> is perhaps some preempt configs don't implicate a sleep? If true,
> instead of adding might_sleep() to one piece of code (in this case
> foio_mc_copy()) I wonder if instead just adding it to cond_resched() may
> be useful.

I think the answer to the above is "no".

And it took me quite some more testing with the below patch to convince myself
of that. Essentially, to trigger the cond_resched() atomic context warning
kernel warning we'd need to be in atomic context, and that today we can get
there through folio_mc_copy() through large folios.

Today the only atomic context we know which would end up in page
migration and folio_mc_copy() would be with buffer-head filesystems
which support large folios and which use buffer_migrate_folio_norefs() for
their migrate_folio() callback. The patch which we added which enabled the
block layer to support large folios did this only for cases where the
block size of the backing device is > PAGE_SIZE. So for instance your
qemu guest would need to have a logical block size larer than 4096 on
x86_64. To be clear, ext4 cannot possibly trigger this. No filesystem
can trigger this *case* other than the block device cache, and that
is only possible if block devices have larger block sizes.

The whole puzzle above about cond_resched() not rigger atomic warning
is because in fact, although buffer_migrate_folio_norefs() *does* always
use atomic context to call filemap_migrate_folio(), in practice I'm not
seeing it, that is, we likley bail before we even call folio_mc_copy().

So for instance we can see:

Mar 28 23:22:04 extra-ext4-4k kernel: __buffer_migrate_folio() in_atomic: 1
Mar 28 23:22:04 extra-ext4-4k kernel: __buffer_migrate_folio() in_atomic: 1
Mar 28 23:23:11 extra-ext4-4k kernel: large folios on folio_mc_copy(): 512 in_atomic(): 0
Mar 28 23:23:11 extra-ext4-4k kernel: large folios on folio_mc_copy(): in_atomic(): 0 calling cond_resched()
Mar 28 23:23:11 extra-ext4-4k kernel: large folios on folio_mc_copy(): in_atomic(): 0 calling cond_resched()

diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..1db9edfc4bc1 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -147,6 +147,11 @@ static void set_init_blocksize(struct block_device *bdev)
 			break;
 		bsize <<= 1;
 	}
+
+	if (bsize > PAGE_SIZE)
+		printk("%s: LBS device: mapping_set_folio_min_order(%u): %u\n",
+		       bdev->bd_disk->disk_name, get_order(bsize), bsize);
+
 	BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
 	mapping_set_folio_min_order(BD_INODE(bdev)->i_mapping,
 				    get_order(bsize));
diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..210df4970573 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -851,6 +851,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 recheck_buffers:
 		busy = false;
 		spin_lock(&mapping->i_private_lock);
+		printk("__buffer_migrate_folio() in_atomic: %d\n", in_atomic());
 		bh = head;
 		do {
 			if (atomic_read(&bh->b_count)) {
@@ -871,6 +872,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		}
 	}
 
+	if (check_refs)
+		printk("__buffer_migrate_folio() calling filemap_migrate_folio() in_atomic: %d\n", in_atomic());
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
diff --git a/mm/util.c b/mm/util.c
index 448117da071f..61c76712d4bb 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -735,11 +735,15 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 	long nr = folio_nr_pages(src);
 	long i = 0;
 
+	if (nr > 1)
+		printk("large folios on folio_mc_copy(): %lu in_atomic(): %d\n", nr, in_atomic());
+
 	for (;;) {
 		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
 			return -EHWPOISON;
 		if (++i == nr)
 			break;
+		printk("large folios on folio_mc_copy(): in_atomic(): %d calling cond_resched()\n", in_atomic());
 		cond_resched();
 	}


And so effectively, it is true, cond_resched() is not in atomic context
above, even though  filemap_migrate_folio() is certainly being called
in atomic context. What changes in between is folios likely won't
migrate due to later checks in filemap_migrate_folio() like the new
ref check, and instead we end up with page migraiton later of a huge
page, and *that* is not in atomic context.

So, to be clear, I *still* cannot reproduce the original reports, even
though in theory it is evident how buffer_migrate_folio_norefs() *can*
call filemap_migrate_folio() in atomic context.

How 0-day and syzbot triggered this *without* a large block size block
device is perplexing to me, if it is true that one was not used.

How we still can't reproduce in_atomic() context in folio_mc_copy() is
another fun mystery.

That is to say, I can't see how the existing code could regress here.
Given only the only buffer-head filesystem which enables large folios
is the pseudo block device cache filesystem, and you'll only get LBS
devices if the logical block size > PAGE_SIZE.

Despite all this, we have two separate reports and no clear information
if this was using a large block device enabled or not, and so given the
traces above to help root out more bugs with large folios we should just
proactively add might_sleep() to __migrate_folio(). I'll send a patch
for that, that'll enhance our test coverage.

The reason why we likely are having  hard time to reproduce the issue is
this new check:

	/* Check whether src does not
	have extra refs before we do more work */  
        if (folio_ref_count(src) != expected_count)                              
		return -EAGAIN;    .

So, moving on, I think what's best is to see how we can get __find_get_block()
to not chug on during page migration.

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
