Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7C9C28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 05:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741755665; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=OOGq8jumGuD66VYWxLTbSOxhGwAbcu6yWXUCz61huiI=;
 b=e7LWsDH5pl81SFyjYQDPc/5BO1Sw3Wf50+MWJPGNG1PMoI9NjcgqpSnfiND9E+VjyqjiV
 pNPyrMWE0KKFugMcrmcEZlSieBPCSzc/OiWrqf+R0kAAZJsCn0Z5VjIyoR1LXdPiRh51eIv
 BiaWgLAndQCZWgzO7eGV3ISluwIetVE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3538C3CA40B
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 06:01:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A03763C0265
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:00:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org;
 envelope-from=mcgrof@infradead.org; receiver=lists.linux.it)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9AAAB6005C3
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:00:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=4VfUOjWo+32AuDiC0iqDr/l/PZ8nRE39G5zh1X+A1H0=; b=t/IlGc//5oKhH6cZ8+VHa8bIfM
 tvt1u6yhti395QXHvt9kcozQoMQbFXQZouoDZl+V2ogFnAQJqk/1QHNdwflgIwO/UhbQY6ft0lyU2
 6MpOs3RjEmatQ+7feZOUZaGhmt7nC11d8dLCRfIC7urgrHjiypoz6KwayU8iq8yAdeGDDc0t/BBIl
 epyGrqE59e6CTlhp4neui5oR2SlfVz3+AaYwkHb+AOyhJgu9BMAf5VKZhHlIWc8C4S6MQymNXAD84
 BcObPxnc+TcSehPM8PIDNsHyDEHH1zfY6rxeGK6Rf6liXSVNtNB3icLV8j33REoK6YIPEBIbrN6F7
 CrPzSN/Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red
 Hat Linux)) id 1tsECj-00000007U8E-2579;
 Wed, 12 Mar 2025 05:00:29 +0000
To: liwang@redhat.com, brauner@kernel.org, hare@suse.de, willy@infradead.org,
 david@fromorbit.com, djwong@kernel.org
Date: Tue, 11 Mar 2025 22:00:28 -0700
Message-ID: <20250312050028.1784117-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
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
Cc: p.raghav@samsung.com, ritesh.list@gmail.com, lkp@intel.com,
 john.g.garry@oracle.com, da.gomez@samsung.com, gost.dev@samsung.com,
 oe-lkp@lists.linux.dev, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mcgrof@kernel.org, oliver.sang@intel.com,
 kbusch@kernel.org, kernel@pankajraghav.com, hch@lst.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The commit titled "block/bdev: lift block size restrictions to 64k"
lifted the block layer's max supported block size to 64k inside the
helper blk_validate_block_size() now that we support large folios on
the block layer. However, block drivers have relied on the call for
queue_limits_commit_update() to validate and ensure the logical block
size < PAGE_SIZE.

We should take time to validate each block driver before enabling
support for larger logical block sizes, so that those that didn't
have support stay that way and don't need modifications.

Li Wang reported this as a regression on LTP via:

testcases/kernel/syscalls/ioctl/ioctl_loop06

Which uses the loopback driver to enable larger logical block sizes
first with LOOP_CONFIGURE and then LOOP_SET_BLOCK_SIZE. While
I see no reason why the loopback block driver can't support
larger logical block sizes than PAGE_SIZE, leave this validation
step as a secondary effort for each block driver.

Reported-by: Li Wang <liwang@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101538.84c33cd4-lkp@intel.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/blk-settings.c   | 4 +++-
 include/linux/blkdev.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index c44dadc35e1e..5cdd0d7d2af2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -254,7 +254,9 @@ int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->logical_block_size)
 		lim->logical_block_size = SECTOR_SIZE;
-	else if (blk_validate_block_size(lim->logical_block_size)) {
+	else if (blk_validate_block_size(lim->logical_block_size) ||
+		 (lim->logical_block_size > PAGE_SIZE &&
+		   !(lim->features & BLK_FEAT_LBS))) {
 		pr_warn("Invalid logical block size (%d)\n", lim->logical_block_size);
 		return -EINVAL;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a97428e8bbbe..cdab3731a646 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -341,6 +341,9 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_ATOMIC_WRITES \
 	((__force blk_features_t)(1u << 16))
 
+/* Supports sector sizes > PAGE_SIZE */
+#define BLK_FEAT_LBS		((__force blk_features_t)(1u << 17))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
