Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8403FC19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:20:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6C4E3C9457
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:20:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0C553C25DD
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 46B95140075D
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECA5220FBF;
 Thu,  4 Aug 2022 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmSCTFGsp+RLL0Eo1ZxitP5FtK3BFPrrS7SzZK6nwW8=;
 b=fA5K7Hgqss5Ilhx5P+2LbHWKeQkiolhuUjgb8W0ok1t4tgvdtAAu7kEGRJWpgLPRodv35U
 S69xarDE6OfrHt4MgSEzrhyrHZr9bd/foSUGx8rx9J6Nm1C9hShpN2a4dSh1LSUGTtGxT+
 KzA9/ikBdaH7xeJ6yWlxN0iav/CdXm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmSCTFGsp+RLL0Eo1ZxitP5FtK3BFPrrS7SzZK6nwW8=;
 b=VhxsTDd4UqvbLoPwRBC8db9q/WdyfWrR+PSS+w2RB58Y9xSpXmkexdrUDx1CHQAIErX0kt
 TBngUe4kr3SJrfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6E0113A94;
 Thu,  4 Aug 2022 12:19:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2A5bJ2m562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:41 +0200
Message-Id: <20220804121946.19564-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/10] tst_supported_fs: Implement skip list
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

as it will be needed for $ALL_FILESYSTEMS shell implementation in the
next commit. Pass tmpfs to LVM scripts (as it was required there),
but allow to use zram01.sh with tmpfs as it works with it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3

 testcases/lib/tst_supported_fs.c           | 56 +++++++++++++++++-----
 testcases/misc/lvm/generate_lvm_runfile.sh |  2 +-
 testcases/misc/lvm/prepare_lvm.sh          |  2 +-
 3 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 43eac194f..87be2b759 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -5,42 +5,74 @@
  */
 
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 
+#define SKIP_DELIMITER ','
+
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_fs.h"
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: tst_supported_fs [fs_type]\n");
+	fprintf(stderr, "Usage: tst_supported_fs [-s skip_list] [fs_type]\n");
 	fprintf(stderr, "   If fs_type is supported, return 0\n");
 	fprintf(stderr, "   If fs_type isn't supported, return 1\n");
 	fprintf(stderr, "   If fs_type isn't specified, print the list of supported filesystems\n");
 	fprintf(stderr, "   fs_type - a specified filesystem type\n");
+	fprintf(stderr, "   skip_list - filesystems to skip, delimiter: '%c'\n",
+			SKIP_DELIMITER);
 }
 
 int main(int argc, char *argv[])
 {
-	const char *skiplist[] = {"tmpfs", NULL};
 	const char *const *filesystems;
-	int i;
+	int i, ret, cnt = 1;
+	char **skiplist = NULL;
+	char *fs;
 
-	if (argc > 2) {
-		fprintf(stderr, "Can't specify multiple fs_type\n");
-		usage();
-		return 2;
+	while ((ret = getopt(argc, argv, "hs:"))) {
+		if (ret < 0)
+			break;
+
+		switch (ret) {
+		case '?':
+			return 1;
+
+		case 'h':
+			usage();
+			return 0;
+
+		case 's':
+			fs = optarg;
+			for (i = 0; fs[i]; i++) {
+				if (optarg[i] == SKIP_DELIMITER)
+					cnt++;
+			}
+			skiplist = malloc(++cnt * sizeof(char *));
+			if (!skiplist) {
+				fprintf(stderr, "malloc() failed\n");
+				return 1;
+			}
+
+			fs = optarg;
+			for (i = 0; i < cnt; i++)
+				skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);
+			break;
+		}
 	}
 
-	if (argv[1] && !strcmp(argv[1], "-h")) {
+	if (argc - optind > 1) {
+		fprintf(stderr, "Can't specify multiple fs_type\n");
 		usage();
-		return 0;
+		return 2;
 	}
 
-	if (argv[1])
-		return !tst_fs_is_supported(argv[1]);
+	if (optind < argc)
+		return !tst_fs_is_supported(argv[optind]);
 
-	filesystems = tst_get_supported_fs_types(skiplist);
+	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
 
diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 72b286a69..843dd6bb8 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -16,7 +16,7 @@ generate_runfile()
 	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
 	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
 	OUTFILE="$LTPROOT/runtest/lvm.local"
-	FS_LIST=`tst_supported_fs`
+	FS_LIST=$(tst_supported_fs -s tmpfs)
 	echo -n "" >"$OUTFILE"
 
 	for fsname in $FS_LIST; do
diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
index d3ae4b23f..29f386df8 100755
--- a/testcases/misc/lvm/prepare_lvm.sh
+++ b/testcases/misc/lvm/prepare_lvm.sh
@@ -70,7 +70,7 @@ prepare_mounts()
 
 prepare_lvm()
 {
-	FS_LIST=`tst_supported_fs | sort -u`
+	FS_LIST=$(tst_supported_fs -s tmpfs | sort -u)
 	ROD mkdir -p "$LVM_TMPDIR"
 	ROD mkdir -p "$LVM_IMGDIR"
 	chmod 777 "$LVM_TMPDIR"
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
