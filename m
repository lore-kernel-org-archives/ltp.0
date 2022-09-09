Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B58ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B58B3CAA11
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:19:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 887F43CAA10
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CEC1810011AB
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 85C3D21F40;
 Fri,  9 Sep 2022 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZmNBbFDpzxBA2+wTMBlKOnODyawYHapRMhmU0Si1eA=;
 b=ZsGyKK80JH1Tz4rYV2h8BeRxZVLA6McnGghYYIGTpbn0A+Ck6pi7qKaKL89cOz5d727HyT
 RPMK2HYgh4sOmpR+FftTJNGlbRf1o5uQdPe2auJiCOVJA6uohW8DyFFsyAO3arQD+iegI6
 tYDM1oTV+ymw+HDMdMhPUcNzGESaPpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZmNBbFDpzxBA2+wTMBlKOnODyawYHapRMhmU0Si1eA=;
 b=fhv6jCJpUjJg2FIVTJrTmIz1o+MEaz178B79v58p4XSpDNlm0sCjyX1EYixTMjPH/yxYIO
 E4bIFheEtC6q4XCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D725A13A93;
 Fri,  9 Sep 2022 14:18:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0PN9MUdLG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:35 +0200
Message-Id: <20220909141840.18327-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 05/10] tst_supported_fs: Support skip list when
 query single fs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

And use this feature in zram01.sh

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v4->v5:
* tst_fs_is_supported_skiplist() returns TST_FS_UNSUPPORTED,
  errors handled in testcases/lib/tst_supported_fs.c (Cyril)
* testcases/lib/tst_supported_fs.c: put parsing code to separate
  function parse_skiplist() (Cyril)
* testcases/lib/tst_supported_fs.c: Print usage on getopts error (Cyril)
* zram01.sh: use -f tmpfs in tst_supported_fs call

 include/tst_fs.h                               | 10 ++++++++++
 lib/tst_supported_fs_types.c                   | 16 ++++++++++++++++
 testcases/kernel/device-drivers/zram/zram01.sh |  3 +--
 testcases/lib/tst_supported_fs.c               |  7 ++++---
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index cc6d9b547..e399aef54 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -183,6 +183,16 @@ enum tst_fs_impl {
  */
 enum tst_fs_impl tst_fs_is_supported(const char *fs_type);
 
+/*
+ * Check filesystem support (@see tst_fs_is_supported()), but consider also
+ * filesystems to skip.
+ *
+ * @fs_type A filesystem name to check the support for.
+ * @skiplist A NULL terminated array of filesystems to skip.
+ */
+enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
+					      *const *skiplist);
+
 /*
  * Returns NULL-terminated array of kernel-supported filesystems.
  *
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 9726d193a..cde162555 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -134,6 +134,22 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
 	return TST_FS_UNSUPPORTED;
 }
 
+enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
+					      *const *skiplist)
+{
+	int ret;
+
+	ret = tst_fs_is_supported(fs_type);
+
+	if (!ret)
+		return ret;
+
+	if (tst_fs_in_skiplist(fs_type, skiplist))
+		return TST_FS_UNSUPPORTED;
+
+	return ret;
+}
+
 const char **tst_get_supported_fs_types(const char *const *skiplist)
 {
 	unsigned int i, j = 0;
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index ad01291bf..8b92b699f 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -38,8 +38,7 @@ initialize_vars()
 	local fs limit size stream=-1
 	dev_num=0
 
-	for fs in $(tst_supported_fs); do
-		[ "$fs" = "tmpfs" ] && continue
+	for fs in $(tst_supported_fs -s tmpfs); do
 		size="26214400"
 		limit="25M"
 		if [ "$fs" = "btrfs" ]; then
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 1c259e62a..032b9d10b 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -81,10 +81,11 @@ int main(int argc, char *argv[])
 	}
 
 	if (optind < argc) {
-		ret = tst_fs_is_supported(argv[optind]);
+		ret = tst_fs_is_supported_skiplist(argv[optind],
+						   (const char * const*)skiplist);
 
 		if (ret == TST_FS_UNSUPPORTED)
-			tst_brk(TCONF, "%s is not supported", argv[optind]);
+			tst_brk(TCONF, "%s is skipped or not supported", argv[optind]);
 
 		return !ret;
 	}
@@ -92,7 +93,7 @@ int main(int argc, char *argv[])
 	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 
 	if (!filesystems[0])
-		tst_brk(TCONF, "There are no supported filesystems");
+		tst_brk(TCONF, "There are no supported filesystems or all skipped");
 
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
