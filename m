Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B95C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 14:49:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31A573C9514
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:49:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E16753C932A
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:49:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 422041400184
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:49:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7CA8E218E2;
 Tue, 25 Jan 2022 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643122181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXWV2cU8nFbERVLsvoDawcCZQ09K7K0YWK5GJqNsueg=;
 b=BXPmGP4Xbk02fiD04EBpXQJCEvxQvI+kYC81H8DF5cJsJWa6lLmPRwZd1VMaIa8PWS0CVT
 KaCW+jtB9vg2iZQQfxhyY9WCcjTLyZ0fHUB0gqe0iN1C3a72vu5z3J5T+lA9b32o8+7WC2
 VwZf510yR8W6WUXwlxQ0ejjytauo3uY=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 42432A3B81;
 Tue, 25 Jan 2022 14:49:41 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 25 Jan 2022 14:49:21 +0000
Message-Id: <20220125144923.5849-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124173651.652-1-rpalethorpe@suse.com>
References: <20220124173651.652-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] memcontrol02: Add VFAT/MSDOS magic and set
 error to 50% for it also
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

VFAT also allocates some extra non-pagecache memory for tracking
buffers.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fs.h                                  | 1 +
 testcases/kernel/controllers/memcg/memcontrol02.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index efcdff608..3bab9da8b 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -30,6 +30,7 @@
 #define TST_EXOFS_MAGIC    0x5DF5
 #define TST_OVERLAYFS_MAGIC 0x794c7630
 #define TST_FUSE_MAGIC     0x65735546
+#define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
 #define TST_EXFAT_MAGIC    0x2011BAB0UL
 
 enum {
diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
index 0b8f317a8..411f5aea6 100644
--- a/testcases/kernel/controllers/memcg/memcontrol02.c
+++ b/testcases/kernel/controllers/memcg/memcontrol02.c
@@ -153,6 +153,7 @@ static void setup(void)
 	cg_test = tst_cgroup_get_test_group();
 
 	switch (tst_fs_type(TMPDIR)) {
+	case TST_VFAT_MAGIC:
 	case TST_EXFAT_MAGIC:
 	case TST_EXT234_MAGIC:
 		file_to_all_error = 50;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
