Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E642C28B20
	for <ltp@archiver.kernel.org>; Sat, 29 Mar 2025 01:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743210437; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/zol4taxJIa7qr/rG6DADLMZXAWC5K5HNkeMUpalIF0=;
 b=MS6PxJXhHuo6oKHpNdvHugU4UeLMA5kJLFZG+64MVLKA0u01DlyL06/ciaNLCyIR/6L83
 7xXM1/ZKnXBfcI41SzgWRkc8jdDWZe6X+yWGjVYiIas+f8n4p3ds57uW69TJjapxWPvuq6m
 tV2IUb8xvDvFoES16nlsx3OWqd7Nyvs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F7673C9D72
	for <ltp@archiver.kernel.org>; Sat, 29 Mar 2025 02:07:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9F103C9D72
 for <ltp@lists.linux.it>; Sat, 29 Mar 2025 02:06:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85D621000466
 for <ltp@lists.linux.it>; Sat, 29 Mar 2025 02:06:53 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 39A2A61135;
 Sat, 29 Mar 2025 01:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5031C4CEEA;
 Sat, 29 Mar 2025 01:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743210410;
 bh=gtnCohqVELmcawsV6NjbhkkPqDLxo8ZP2RZwSaOktPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OXNfcbioMcZNFe70LjaiqF6/770DiVEXn72cLVuxo/7X/xKxSdDSzLaZtJPQdtqXF
 DNSNJA5g4lU9jLz594FtEg3eixSeeT7jmf15/xLkHOHIDSmtymy48tlgynxRsUaif/
 ZGWwqQjZcSPEhlhgW/Ct0zOSgF9fMFa6Zcqwv13ZYns5Ykep0K81xVFe5BG/7oF5yV
 gLLfuGbRoO1zn2E31BH/bqRNuxSOcRM4RD6+8/9RrEPx/GZIPMOj2ZXDU/gOkPJtCd
 7jn93izUGhlfTyV3xh1GT7WCfYOJ+gJHkmSN2dpbEvkX3jknvcY1lKcOTGck0lwLwf
 Q/oNKv+SKyihw==
Date: Fri, 28 Mar 2025 18:06:48 -0700
To: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Bueso <dave@stgolabs.net>, Tso Ted <tytso@mit.edu>,
 Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <Z-dHqMtGneCVs3v5@bombadil.infradead.org>
References: <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
 <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
 <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
 <Z-bz0IZuTtwNYPBq@bombadil.infradead.org>
 <Z-c6BqCSmAnNxb57@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-c6BqCSmAnNxb57@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

On Fri, Mar 28, 2025 at 05:08:40PM -0700, Luis Chamberlain wrote:
> So, moving on, I think what's best is to see how we can get __find_get_block()
> to not chug on during page migration.

Something like this maybe? Passes initial 10 minutes of generic/750
on ext4 while also blasting an LBS device with dd. I'll let it soak.
The second patch is what requieres more eyeballs / suggestions / ideas.

From 86b2315f3c80dd4562a1a0fa0734921d3e92398f Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 28 Mar 2025 17:12:48 -0700
Subject: [PATCH 1/3] mm/migrate: add might_sleep() on __migrate_folio()

When we do page migration of large folios folio_mc_copy() can
cond_resched() *iff* we are on a large folio. There's a hairy
bug reported by both 0-day [0] and  syzbot [1] where it has been
detected we can call folio_mc_copy() in atomic context. While,
technically speaking that should in theory be only possible today
from buffer-head filesystems using buffer_migrate_folio_norefs()
on page migration the only buffer-head large folio filesystem -- the
block device cache, and so with block devices with large block sizes.
However tracing shows that folio_mc_copy() *isn't* being called
as often as we'd expect from buffer_migrate_folio_norefs() path
as we're likely bailing early now thanks to the check added by commit
060913999d7a ("mm: migrate: support poisoned recover from migrate
folio").

*Most* folio_mc_copy() calls in turn end up *not* being in atomic
context, and so we won't hit a splat when using:

CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

But we *want* to help proactively find callers of __migrate_folio() in
atomic context, so make might_sleep() explicit to help us root out
large folio atomic callers of migrate_folio().

Link: https://lkml.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
Link: https://lkml.kernel.org/r/67e57c41.050a0220.2f068f.0033.GAE@google.com # [1]
Link: https://lkml.kernel.org/r/Z-c6BqCSmAnNxb57@bombadil.infradead.org # [2]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..712ddd11f3f0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -751,6 +751,8 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 {
 	int rc, expected_count = folio_expected_refs(mapping, src);
 
+	might_sleep();
+
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
-- 
2.47.2


From 561e94951fce481bb2e5917230bec7008c131d9a Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 28 Mar 2025 17:44:10 -0700
Subject: [PATCH 2/3] fs/buffer: avoid getting buffer if it is folio migration
 candidate

Avoid giving a way a buffer with __find_get_block_slow() if the
folio may be a folio migration candidate. We do this as an alternative
to the issue fixed by commit ebdf4de5642fb6 ("mm: migrate: fix reference
check race between __find_get_block() and migration"), given we've
determined that we should avoid requiring folio migration callers
from holding a spin lock while calling __migrate_folio().

This alternative simply avoids completing __find_get_block_slow()
on folio migration candidates to let us later rip out the spin_lock()
held on the buffer_migrate_folio_norefs() path.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index c7abb4a029dc..6e2c3837a202 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -208,6 +208,12 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	head = folio_buffers(folio);
 	if (!head)
 		goto out_unlock;
+
+	if (folio_test_lru(folio) &&
+	    folio_test_locked(folio) &&
+	    !folio_test_writeback(folio))
+		goto out_unlock;
+
 	bh = head;
 	do {
 		if (!buffer_mapped(bh))
-- 
2.47.2


From af6963b73a8406162e6c2223fae600a799402e2b Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 28 Mar 2025 17:51:39 -0700
Subject: [PATCH 3/3] mm/migrate: avoid atomic context on
 buffer_migrate_folio_norefs() migration

The buffer_migrate_folio_norefs() should avoid holding the spin lock
held in order to ensure we can support large folios. The prior commit
"fs/buffer: avoid getting buffer if it is folio migration candidate"
ripped out the only rationale for having the atomic context,  so we can
remove the spin lock call now.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 712ddd11f3f0..f3047c685706 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -861,12 +861,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
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
@@ -884,8 +884,6 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	} while (bh != head);
 
 unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
