Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19113C43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 05:58:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58E853C9787
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 07:58:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3459B3C8088
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 07:58:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61B11200B6B
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 07:58:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ABA21F9BC
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 05:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658815093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l6l/cH4bk27HgVeycS6HZRLDINxNuds3yXYGE4wsCxU=;
 b=Vd3c11HdqtZ9rB06ArdGG1nrCaMWQ3594Tx9ltug/3r17AukbAD20XS0chHzeubRTuXDjH
 ZBrJxFegMzbz6H306DeV9GkkwEBSAJO1M2IeTIEHYxtZXCDcJ3AVeDpbLiuuYgrG9psv89
 RtcBJno7U78/ZCBQc/WvSZeue83UnoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658815093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l6l/cH4bk27HgVeycS6HZRLDINxNuds3yXYGE4wsCxU=;
 b=X2Wyfno7rNNj4PmMmSmqa0zbQ8heMWLTDbHRhA3nyBpYB3SQkTelHNHAQNyCKa+/63xa0I
 Qkafgu19mPcj6CAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 037B713A7C
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 05:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1LzmLHSC32JZRgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 05:58:12 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 26 Jul 2022 11:28:10 +0530
Message-Id: <20220726055810.15176-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Typo fixes in comments
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 include/tst_fs.h        | 2 +-
 lib/tst_fs_link_count.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index bc6692bd4..26b8b353f 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -193,7 +193,7 @@ const char **tst_get_supported_fs_types(const char *const *skiplist);
  * Returns 1 if filesystem is in skiplist 0 otherwise.
  *
  * @fs_type A filesystem type to lookup.
- * @skiplist A NULL terminated array of fileystemsytems to skip.
+ * @skiplist A NULL terminated array of filesystems to skip.
  */
 int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
 
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
index b8807236d..6a6bb52b2 100644
--- a/lib/tst_fs_link_count.c
+++ b/lib/tst_fs_link_count.c
@@ -119,7 +119,7 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir)
 		return 0;
 	}
 
-	/* for current kernel, subdir limit is not availiable for all fs */
+	/* for current kernel, subdir limit is not available for all fs */
 	fs_type = tst_fs_type(cleanup, dir);
 
 	whitelist_size = ARRAY_SIZE(subdir_limit_whitelist);
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
