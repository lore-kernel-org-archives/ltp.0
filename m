Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF7DC2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 14:12:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 036443C9721
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 15:12:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32BE93C950D
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:11:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E43A600CEE
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:11:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8201A1F397;
 Wed, 26 Jan 2022 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643206316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4RSq5PmkHcN8DKu8rWRpBCvf9T9IzwLpG57SIMMZ3eI=;
 b=IskHlW18zQVsThVUz1Hlo/cJBp5y55K2c0Kw4pzo6JqRegWB8772wRMBP7FCAwRQV1XKlG
 8tMCmuiwtDB/uVPITx3+l0UCZTn1f541GVxgVqBRVgkJ3DBNmIJQA9ediq2BcvLUMXAbMc
 gUvcZAyUe0DnNoU7bKTVEmWXNyaeCfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643206316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4RSq5PmkHcN8DKu8rWRpBCvf9T9IzwLpG57SIMMZ3eI=;
 b=oMFCZdHRBW77kN7QhkOnkaln2yz1IYoPI8KnE3FFuMi/E5H17sa9TWV7cxv7F9f7c4Lnm9
 0j43a1kBVC2bG1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60BFB13E1A;
 Wed, 26 Jan 2022 14:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jlhCFaxW8WEYcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 14:11:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 15:11:52 +0100
Message-Id: <20220126141152.6428-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Rename array used for .all_filesystems flag
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

Although fs_type_whitelist[] is also used for whitelisting with
.skip_filesystems, the main purpose is to be used for .all_filesystems.

Thus rename it to all_filesystems[].

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_supported_fs_types.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 23e5ce8775..6f1c46da35 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -14,7 +14,11 @@
 #include "tst_test.h"
 #include "tst_fs.h"
 
-static const char *const fs_type_whitelist[] = {
+/*
+ * Filesystems to be tested with .all_filesystems and also the only filesystems
+ * which can be whitelisted with .skip_filesystems.
+ */
+static const char *const all_filesystems[] = {
 	"ext2",
 	"ext3",
 	"ext4",
@@ -27,7 +31,7 @@ static const char *const fs_type_whitelist[] = {
 	NULL
 };
 
-static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];
+static const char *fs_types[ARRAY_SIZE(all_filesystems)];
 
 static int has_mkfs(const char *fs_type)
 {
@@ -151,24 +155,24 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 		return fs_types;
 	}
 
-	for (i = 0; fs_type_whitelist[i]; i++) {
-		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
+	for (i = 0; all_filesystems[i]; i++) {
+		if (tst_fs_in_skiplist(all_filesystems[i], skiplist)) {
 			tst_res(TINFO, "Skipping %s as requested by the test",
-				fs_type_whitelist[i]);
+				all_filesystems[i]);
 			continue;
 		}
 
-		sup = tst_fs_is_supported(fs_type_whitelist[i]);
+		sup = tst_fs_is_supported(all_filesystems[i]);
 
 		if (skip_fuse && sup == TST_FS_FUSE) {
 			tst_res(TINFO,
 				"Skipping FUSE based %s as requested by the test",
-				fs_type_whitelist[i]);
+				all_filesystems[i]);
 			continue;
 		}
 
 		if (sup)
-			fs_types[j++] = fs_type_whitelist[i];
+			fs_types[j++] = all_filesystems[i];
 	}
 
 	return fs_types;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
