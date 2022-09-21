Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC7CC6FA82
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 15:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 577AD3CAD59
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 17:50:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85253CAA99
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 17:50:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E24FF2001A6
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 17:50:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 199AD219B7;
 Wed, 21 Sep 2022 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663775407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Y/O3ek55i59DCZ/vJRMHphS/eErN3dSR7MBp97Bqr8=;
 b=y+41c1VC9+M6YbcXuSd/axE97D2ihxIg9mAVUPn+H4I8qN69bVtbn8KOyM9JTzNnREUkK1
 Si4SGvpwBoiwFy10UslQb+MPGAeZvPNABCaY3RCjXxe0hUTk6trQZhaAqk/E5Yw3XsrG+O
 daPLkEuhsZelyk0LmZk+oTb4jDkrSrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663775407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Y/O3ek55i59DCZ/vJRMHphS/eErN3dSR7MBp97Bqr8=;
 b=OpeEsnczFO/Rh0sRiCZ+LV1uB5QQNfDfwPtGpc/99JRp54G2WEtyLnaT9y8pScnoTTkNit
 XfFSca87SjDhu5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0179013A00;
 Wed, 21 Sep 2022 15:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z18EO64yK2OpeAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 21 Sep 2022 15:50:06 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: pvorel@suse.cz,
	ltp@lists.linux.it
Date: Wed, 21 Sep 2022 17:50:06 +0200
Message-Id: <20220921155006.13360-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_supported_fs: Implement checking paths against
 skiplist
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Implement tst_supported_fs feature suggested by pvorel in his patch:
tst_test.sh: Fix filesystem support detection

Although the tst_fs_type_name() functions could use some improvements,
e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get properly
skipped and vfat is missing from the list of known filesystems.

 testcases/lib/tst_supported_fs.c | 49 ++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 70d4d38c7..5873d0ba1 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -32,9 +32,13 @@ static void usage(void)
 	fprintf(stderr, "tst_supported_fs -s skip_list fs_type\n");
 	fprintf(stderr, "   if fs_type is in skip_list, return 1 otherwise return 0\n\n");
 
+	fprintf(stderr, "tst_supported_fs -s skip_list -d path\n");
+	fprintf(stderr, "   if filesystem mounted on path is in skip_list, return 1 otherwise return 0\n\n");
+
 	fprintf(stderr, "fs_type - a specified filesystem type\n");
 	fprintf(stderr, "skip_list - filesystems to skip, delimiter: '%c'\n",
 			SKIP_DELIMITER);
+	fprintf(stderr, "path - any valid file or directory\n");
 }
 
 static char **parse_skiplist(char *fs)
@@ -62,10 +66,11 @@ static char **parse_skiplist(char *fs)
 int main(int argc, char *argv[])
 {
 	const char *const *filesystems;
+	const char *fsname = NULL;
 	int i, ret;
 	char **skiplist = NULL;
 
-	while ((ret = getopt(argc, argv, "hs:"))) {
+	while ((ret = getopt(argc, argv, "hs:d:"))) {
 		if (ret < 0)
 			break;
 
@@ -83,9 +88,26 @@ int main(int argc, char *argv[])
 			if (!skiplist)
 				return 1;
 			break;
+
+		case 'd':
+			if (fsname) {
+				fprintf(stderr,
+					"Can't specify multiple paths\n");
+				usage();
+				return 2;
+			}
+
+			fsname = tst_fs_type_name(tst_fs_type(optarg));
+			break;
 		}
 	}
 
+	if (fsname && !skiplist) {
+		fprintf(stderr, "Parameter -d requires skiplist\n");
+		usage();
+		return 2;
+	}
+
 	if (argc - optind > 1) {
 		fprintf(stderr, "Can't specify multiple fs_type\n");
 		usage();
@@ -94,22 +116,33 @@ int main(int argc, char *argv[])
 
 	/* fs_type */
 	if (optind < argc) {
-		if (argv[optind][0] == '\0')
+		if (fsname) {
+			fprintf(stderr, "Can't specify fs_type and -d together\n");
+			usage();
+			return 2;
+
+		}
+
+		fsname = argv[optind];
+	}
+
+	if (fsname) {
+		if (fsname[0] == '\0')
 			tst_brk(TCONF, "fs_type is empty");
 
 		if (skiplist) {
-			if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplist))
-				tst_brk(TCONF, "%s is skipped", argv[optind]);
+			if (tst_fs_in_skiplist(fsname, (const char * const*)skiplist))
+				tst_brk(TCONF, "%s is skipped", fsname);
 			else
-				tst_res(TINFO, "%s is not skipped", argv[optind]);
+				tst_res(TINFO, "%s is not skipped", fsname);
 
 			return 0;
 		}
 
-		if (tst_fs_is_supported(argv[optind]) == TST_FS_UNSUPPORTED)
-			tst_brk(TCONF, "%s is not supported", argv[optind]);
+		if (tst_fs_is_supported(fsname) == TST_FS_UNSUPPORTED)
+			tst_brk(TCONF, "%s is not supported", fsname);
 		else
-			tst_res(TINFO, "%s is supported", argv[optind]);
+			tst_res(TINFO, "%s is supported", fsname);
 
 		return 0;
 	}
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
