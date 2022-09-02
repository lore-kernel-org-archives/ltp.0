Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268ACECAAD5
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 13:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C93D03CA887
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 15:37:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B3243C65EB
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1B63600C48
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36DDA34699;
 Fri,  2 Sep 2022 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662125836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Jf2yv4i6KyQDWtZn9p98nopbJn8Bk5rTwBUeZIF18A=;
 b=WsSvrixIC0KI5i7UjOrPI7Foc5L9aPIdRMIlcbIjK6IgBREtZEVbF1VW9GXocey2Lif+Rz
 nKbPFctA4sN4oX6IwX4h5h44VNj1M4UTFssCHIU/bLhnQsaOrFDWRjKee9Gj+sAKgvqxOi
 c07q59h4trthL50NNHcHZozj/15aUME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662125836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Jf2yv4i6KyQDWtZn9p98nopbJn8Bk5rTwBUeZIF18A=;
 b=I7p9ACeQF+tN6DJiU9rQgEKK7TnMcH3vIrJ1jJP4IesmaQoD5bT7WExbyuYtA7/5Yn45od
 AeDhvnx8tuWSfLCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDAE61330E;
 Fri,  2 Sep 2022 13:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wCkAOQsHEmObBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 13:37:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 15:37:04 +0200
Message-Id: <20220902133710.1785-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902133710.1785-1-pvorel@suse.cz>
References: <20220902133710.1785-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/9] tst_supported_fs: Implement skip list
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
next commit. Pass tmpfs to LVM scripts (as it was required there),
but allow to use zram01.sh with tmpfs as it works with it.

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Note, I'm not sure if changes in this commit in tst_supported_fs.c will
not be heavily rewritten due tracking minimal filesystem usage.

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
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
