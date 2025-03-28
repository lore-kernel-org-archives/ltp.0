Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B483C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 04:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743135717; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cLGhtxX9DOJ+KDxrdSk/rkXotlVkLw03Ovoo4QlIMuU=;
 b=lkxsGSzWAQcwiSionwot8NK12p95BrEayGX8RQ4eWwwq24x71zxrQB2jDna9i6uHTeX8t
 ukT+ZOwhQQfzBsZXXjnxqC0SUIussHLYoexPDUfnGZU+ErzdDFnZN9IQatI0xJauxWfPp4s
 gbSw9+OckE70BMsNbgZ5qHN9TwpsmkE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7509A3CA19B
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 05:21:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 701743C99F2
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 05:21:36 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 helo=sea.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 58C1D201DB4
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 05:21:34 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8425443F29;
 Fri, 28 Mar 2025 04:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB44C4CEE4;
 Fri, 28 Mar 2025 04:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743135690;
 bh=EkZr+InM+IE+kVx2qsfh4jplm5ZGyo/xPOkhd09hklc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t0GeXZzYKN4pot90kVRCo8FSkgmYZFvOjZ60Zuyy6iByYStTWb7psQOlbk/wCHJg+
 AcceYumfrBCUDVPOuU3bLcJ1z0UAeSSDfl1MxByNAzLaiJ2bQURoGk/jIM3WzG7VyL
 HV6BpgRfWJK8hQ58Qm9sqm4R9j79X/eQfQNXmCBpMvHSpL/8/PPDb9kcvLCX7ikNWC
 nC4/ykbJdl3mogEPpX4Hq03d6gL0QCdmtcZZCB6fAD1jR/UiBNEnmevAGCwTd09qvq
 rceggSr4u732Mk/KggVDiMnsrTYPYNPao4ISic0fCXJrfPJyRmtFb9WJnkKyrLNKIv
 vRgJc2/a04frg==
Date: Thu, 27 Mar 2025 21:21:28 -0700
To: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
References: <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
 Christian Brauner <brauner@kernel.org>, David Bueso <dave@stgolabs.net>,
 lkp@intel.com, David Hildenbrand <david@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Oliver Sang <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 27, 2025 at 06:44:56PM -0700, Luis Chamberlain wrote:
> On Tue, Mar 25, 2025 at 02:52:49PM +0800, Oliver Sang wrote:
> > hi, Luis,
> > 
> > On Sun, Mar 23, 2025 at 12:07:27AM -0700, Luis Chamberlain wrote:
> > > On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> > > > On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > > > > Hey Luis,
> > > > > 
> > > > > This looks like the same issue the bot reported here:
> > > > > 
> > > > > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > > > > 
> > > > > There is a fix for it queued in next-20250318 and later. Could you
> > > > > please double check with your reproducer against a more recent next?
> > > > 
> > > > Confirmed, at least it's been 30 minutes and no crashes now where as
> > > > before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> > > > the hopes I can trigger the warning originally reported by this thread.
> > > > 
> > > > Even though from code inspection I see how the kernel warning would
> > > > trigger I just want to force trigger it on a test, and I can't yet.
> > > 
> > > Survied 5 hours now. This certainly fixed that crash.
> > > 
> > > As for the kernel warning, I can't yet reproduce that, so trying to
> > > run generic/750 forever and looping
> > > ./testcases/kernel/syscalls/close_range/close_range01
> > > and yet nothing.
> > > 
> > > Oliver can you reproduce the kernel warning on next-20250321 ?
> > 
> > the issue still exists on
> > 9388ec571cb1ad (tag: next-20250321, linux-next/master) Add linux-next specific files for 20250321
> > 
> > but randomly (reproduced 7 times in 12 runs, then ltp.close_range01 also failed.
>a> on another 5 times, the issue cannot be reproduced then ltp.close_range01 pass)
> 
> OK I narrowed down a reproducer to requiring the patch below 
> 
> 
> diff --git a/mm/util.c b/mm/util.c
> index 448117da071f..3585bdb8700a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -735,6 +735,8 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
>  	long nr = folio_nr_pages(src);
>  	long i = 0;
>  
> +	might_sleep();
> +
>  	for (;;) {
>  		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
>  			return -EHWPOISON;
> 
> 
> And  then just running:
> 
> dd if=/dev/zero of=/dev/vde bs=1024M count=1024
> 
> For some reason a kernel with the following didn't trigger it so the
> above patch is needed
> 
> 
> CONFIG_PROVE_LOCKING=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_ACPI_SLEEP=y
> 
> It may have to do with my preemtpion settings:
> 
> CONFIG_PREEMPT_BUILD=y
> CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_LAZY is not set
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_DYNAMIC=y
> CONFIG_PREEMPT_RCU=y
> 
> And so now to see how we should fix it.

Would the extra ref check added via commit 060913999d7a9e50 ("mm:
migrate: support poisoned recover from migrate folio") make the removal
of the spin lock safe now given all the buffers are locked from the
folio? This survives some basic sanity checks on my end with
generic/750 against ext4 and also filling a drive at the same time with
fio. I have a feeling is we are not sure, do we have a reproducer for
the issue reported through ebdf4de5642fb6 ("mm: migrate: fix reference
check race between __find_get_block() and migration")? I suspect the
answer is now. The only other thing I can think of at this tie is to add
the lru_cache_disabled() || cpu_is_isolated(smp_processor_id())) checks
on __find_get_block_slow() as we do in bh_lru_install() but I am not
sure if that suffices for the old races.

Thoughts?

diff --git a/mm/migrate.c b/mm/migrate.c
index 97f0edf0c032..6a5d125ecde9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -859,12 +859,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 			}
 			bh = bh->b_this_page;
 		} while (bh != head);
+		spin_unlock(&mapping->i_private_lock);
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
 				goto unlock_buffers;
 			}
-			spin_unlock(&mapping->i_private_lock);
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
@@ -882,8 +882,6 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	} while (bh != head);
 
 unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
diff --git a/mm/util.c b/mm/util.c
index 448117da071f..3585bdb8700a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -735,6 +735,8 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 	long nr = folio_nr_pages(src);
 	long i = 0;
 
+	might_sleep();
+
 	for (;;) {
 		if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
 			return -EHWPOISON;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
