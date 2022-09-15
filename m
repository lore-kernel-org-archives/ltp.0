Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABA3ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:37:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66683CAC2A
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:37:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AC893CABFA
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7648D60029D
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:47 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA1EE20271;
 Thu, 15 Sep 2022 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663234605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIbSPilA0kQUNcoA4XiehTFwgbwRam1GOQFtdDlFkjk=;
 b=Aqs7hC4kUU8x1Lsv/PLDuzGOgFasQq42XveS2jeHd7Vjuwcq71n+m3G2mvY+ZQnyqXMefw
 r7BPwKldghLbiGd5KamXFAOo17G0irv3O4rcTtUBqx61sxDRPG2HdD2SCcnmC/nuTOa7k0
 WKrQQow314MrPL8hvzhxWOMcGe4UKTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663234605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIbSPilA0kQUNcoA4XiehTFwgbwRam1GOQFtdDlFkjk=;
 b=hEj+e+vHd54c9J/r5ux963ijiWfubDASQrx+aqzEZkyLVZrclwLQ6znVkG1zaREJBXRkzf
 bH3gEuh8YxAtADCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4DAAE13310;
 Thu, 15 Sep 2022 09:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id KGFmEC3yImPGIgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 09:36:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 11:36:32 +0200
Message-Id: <20220915093639.2261-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915093639.2261-1-pvorel@suse.cz>
References: <20220915093639.2261-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/8] tst_supported_fs: Implement skip list
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

as it will be needed for $ALL_FILESYSTEMS shell implementation in the
next commit. Pass tmpfs to LVM scripts (as it was required there).

Also print TCONF if there are not supported filesystems.

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_supported_fs.c           | 70 ++++++++++++++++++----
 testcases/misc/lvm/generate_lvm_runfile.sh |  2 +-
 testcases/misc/lvm/prepare_lvm.sh          |  2 +-
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 43eac194f..2b42d5bb3 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -5,42 +5,90 @@
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
+}
+
+static char **parse_skiplist(char *fs)
+{
+	char **skiplist;
+	int i, cnt = 1;
+
+	for (i = 0; fs[i]; i++) {
+		if (optarg[i] == SKIP_DELIMITER)
+			cnt++;
+	}
+
+	skiplist = malloc(++cnt * sizeof(char *));
+	if (!skiplist) {
+		fprintf(stderr, "malloc() failed\n");
+		return NULL;
+	}
+
+	for (i = 0; i < cnt; i++)
+		skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);
+
+	return skiplist;
 }
 
 int main(int argc, char *argv[])
 {
-	const char *skiplist[] = {"tmpfs", NULL};
 	const char *const *filesystems;
-	int i;
+	int i, ret;
+	char **skiplist = NULL;
 
-	if (argc > 2) {
+	while ((ret = getopt(argc, argv, "hs:"))) {
+		if (ret < 0)
+			break;
+
+		switch (ret) {
+		case '?':
+			usage();
+			return 1;
+
+		case 'h':
+			usage();
+			return 0;
+
+		case 's':
+			skiplist = parse_skiplist(optarg);
+			if (!skiplist)
+				return 1;
+			break;
+		}
+	}
+
+	if (argc - optind > 1) {
 		fprintf(stderr, "Can't specify multiple fs_type\n");
 		usage();
 		return 2;
 	}
 
-	if (argv[1] && !strcmp(argv[1], "-h")) {
-		usage();
-		return 0;
-	}
+	if (optind < argc)
+		return !tst_fs_is_supported(argv[optind]);
+
+
+	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 
-	if (argv[1])
-		return !tst_fs_is_supported(argv[1]);
+	if (!filesystems[0])
+		tst_brk(TCONF, "There are no supported filesystems");
 
-	filesystems = tst_get_supported_fs_types(skiplist);
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
 
diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 477aed116..7f7e149d9 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -17,7 +17,7 @@ generate_runfile()
 	trap '[ $? -eq 0 ] || tst_brk TBROK "Cannot create LVM runfile"' EXIT
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
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
