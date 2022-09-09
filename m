Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944E5ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:19:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0959E3CAA77
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:19:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 466373CAA67
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53EDE601AFD
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:18:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEC7F21F3E;
 Fri,  9 Sep 2022 14:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEiEwmW5jdz8lY+uMq32UyRl6LPLBbY5ZIK8+IgPuao=;
 b=rFvPu3c41o88Jensz/IseMJS1aSe3eqBWognIIm1kajW3B4u2s4RmMyId6K2/t/rilHu2f
 Akd5IsRdLF4Is+e0i1fTz7l5ggLZjkXSE3LoqqXoIm/be/Q5oqPYaZffbVHbldzMaz4jrG
 1c122Pq11qw3+tLjZg5aGUNlh7W5S7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEiEwmW5jdz8lY+uMq32UyRl6LPLBbY5ZIK8+IgPuao=;
 b=Hljjn4J9MZsh8PcUJtYJwl09b8fczPfSTP/sdf0T9Dhdtk4B34rSHK89hsXjr/zEVy4poc
 sL/NTNvlfFzoVHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFD3B13A93;
 Fri,  9 Sep 2022 14:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wLNyN0ZLG2NmWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:18:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 Sep 2022 16:18:34 +0200
Message-Id: <20220909141840.18327-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909141840.18327-1-pvorel@suse.cz>
References: <20220909141840.18327-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 04/10] tst_supported_fs: Implement skip list
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

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v4->v5:
* testcases/lib/tst_supported_fs.c: put parsing code to separate
  function parse_skiplist() (Cyril)

 testcases/lib/tst_supported_fs.c           | 65 ++++++++++++++++++----
 testcases/misc/lvm/generate_lvm_runfile.sh |  2 +-
 testcases/misc/lvm/prepare_lvm.sh          |  2 +-
 3 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 6e544070c..1c259e62a 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -5,40 +5,83 @@
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
+	char **skiplist = NULL;
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
 	int i, ret;
+	char **skiplist = NULL;
 
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
 	}
 
-	if (argv[1] && !strcmp(argv[1], "-h")) {
+	if (argc - optind > 1) {
+		fprintf(stderr, "Can't specify multiple fs_type\n");
 		usage();
-		return 0;
+		return 2;
 	}
 
-	if (argv[1]) {
-		ret = tst_fs_is_supported(argv[1]);
+	if (optind < argc) {
+		ret = tst_fs_is_supported(argv[optind]);
 
 		if (ret == TST_FS_UNSUPPORTED)
 			tst_brk(TCONF, "%s is not supported", argv[optind]);
@@ -46,7 +89,7 @@ int main(int argc, char *argv[])
 		return !ret;
 	}
 
-	filesystems = tst_get_supported_fs_types(skiplist);
+	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 
 	if (!filesystems[0])
 		tst_brk(TCONF, "There are no supported filesystems");
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
