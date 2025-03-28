Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A33C3600C
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 01:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743126322; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=p4u5gN5MiprYkG6xAW//OdLbiywbe4OlIgdO3im5ZRI=;
 b=TD8M1BDh7BftUiMn+YW6gbacFWqFNJi4OrxrXNKu0jX9/s0tkUn0unO9j06yFAlcQBhdn
 9NoWednQqdS1wxSEw1l0qLfVoM9X57tBLKrTElvax/wdec6Yl19i8fQGuPu/N0K31VdYz86
 h/CN2wsZ767wijBQc7msAahZS1k86x0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D76103CA176
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 02:45:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD9A33C9DDB
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 02:44:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 13ED9206504
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 02:44:58 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3199FA40558;
 Fri, 28 Mar 2025 01:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD72C4CEDD;
 Fri, 28 Mar 2025 01:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743126296;
 bh=nmX44Vf41ol4npyO99GzzC0pNas8m8Ih6yuWRheOadE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aak77eVxgOs5jMI+fjhFIE+Ao8wo47UiPu5Gj+hZto6CkK81IzKyILDwcqP9AirtZ
 9UysemMxSpd0C19m3nQEnirDtkxmNOYeN0r89WwrGnctr863l379xBLJJpCuYugSDW
 Un+zBxdUIzi8RFIWw4QuyDRMpd+bVGICq9n5hr2gItcy3f6C2QwkubP5t08yQDDFDV
 xAJIhc3Jqfi7bT7FKQ6FkUPeV5KHyNuu/5YMevspDCl8I9lzRRRVBLA9N3X1DY2+Ft
 I4hG40QMjJsr2ceJV2sGODVTN8ldHrgaNdTrbxfqPyQAqPQqA004KVKAcVziEcwmPt
 jqipjAMDnvEuw==
Date: Thu, 27 Mar 2025 18:44:54 -0700
To: Oliver Sang <oliver.sang@intel.com>
Message-ID: <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
References: <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
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
 Jan Kara <jack@suse.cz>, lkp@intel.com, David Hildenbrand <david@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 25, 2025 at 02:52:49PM +0800, Oliver Sang wrote:
> hi, Luis,
> 
> On Sun, Mar 23, 2025 at 12:07:27AM -0700, Luis Chamberlain wrote:
> > On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> > > On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > > > Hey Luis,
> > > > 
> > > > This looks like the same issue the bot reported here:
> > > > 
> > > > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > > > 
> > > > There is a fix for it queued in next-20250318 and later. Could you
> > > > please double check with your reproducer against a more recent next?
> > > 
> > > Confirmed, at least it's been 30 minutes and no crashes now where as
> > > before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> > > the hopes I can trigger the warning originally reported by this thread.
> > > 
> > > Even though from code inspection I see how the kernel warning would
> > > trigger I just want to force trigger it on a test, and I can't yet.
> > 
> > Survied 5 hours now. This certainly fixed that crash.
> > 
> > As for the kernel warning, I can't yet reproduce that, so trying to
> > run generic/750 forever and looping
> > ./testcases/kernel/syscalls/close_range/close_range01
> > and yet nothing.
> > 
> > Oliver can you reproduce the kernel warning on next-20250321 ?
> 
> the issue still exists on
> 9388ec571cb1ad (tag: next-20250321, linux-next/master) Add linux-next specific files for 20250321
> 
> but randomly (reproduced 7 times in 12 runs, then ltp.close_range01 also failed.
> on another 5 times, the issue cannot be reproduced then ltp.close_range01 pass)

OK I narrowed down a reproducer to requiring the patch below 


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


And  then just running:

dd if=/dev/zero of=/dev/vde bs=1024M count=1024

For some reason a kernel with the following didn't trigger it so the
above patch is needed


CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_ACPI_SLEEP=y

It may have to do with my preemtpion settings:

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_LAZY is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_RCU=y

And so now to see how we should fix it.

  LUis



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
