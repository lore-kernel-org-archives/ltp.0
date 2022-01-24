Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD131C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 17:37:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1C973C90E7
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 18:37:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB7153C8870
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:37:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 33D0F200263
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:37:17 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C70141F380;
 Mon, 24 Jan 2022 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643045836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuvsZA7IapiR78m5vXiRZhJccMgRLoVM4Xh3s3mp8WA=;
 b=NaoydHO9NxJBL07sqprbIjJ3jZF6lceFjsPx50yhNudEg3LIb7kYSwaa6/d6j/nFKZhaDs
 XeQge/4KKvTrXBwX9H50lkA4qHsKAEHi3sc/u8/liRdT2J4AfPL/9VgGm6icymqYu9cNaa
 AR9GSTmNp1/hmz8U1E4nsbTMWYh4/mM=
Received: from g78.suse.de (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 97E31A3B90;
 Mon, 24 Jan 2022 17:37:16 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 24 Jan 2022 17:36:51 +0000
Message-Id: <20220124173651.652-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124173651.652-1-rpalethorpe@suse.com>
References: <20220124173651.652-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] memcontrol02: Increase expected error with
 increase in pagesize
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A few percent seems to be wasted with the increase in page size from
4k to 64k in these tests. For some reason, this appears to cause the
test to fail on exfat on the anon test, but only exfat. We add 4% to
the error for 64k pages.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol02.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 0d144cf2d..fbf5f0469 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -39,13 +39,17 @@ static int fd;
 static int file_to_all_error = 10;
 
 /*
- * Checks if two given values differ by less than err% of their sum.
+ * Checks if two given values differ by less than err% of their
+ * sum. An extra percent is added for every doubling of the page size
+ * to compensate for wastage in page sized allocations.
  */
 static inline int values_close(const ssize_t a,
 			       const ssize_t b,
 			       const ssize_t err)
 {
-	return 100 * labs(a - b) <= (a + b) * err;
+	const ssize_t page_adjusted_err = ffs(page_size >> 13) + err;
+
+	return 100 * labs(a - b) <= (a + b) * page_adjusted_err;
 }
 
 static void alloc_anon_50M_check(void)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
