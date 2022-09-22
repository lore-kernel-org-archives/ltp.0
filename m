Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5248ECAAD8
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 21:10:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 932253CAD68
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 23:10:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE74A3CAD82
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 23:09:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE4AC601E8D
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 23:09:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21DA92199C;
 Thu, 22 Sep 2022 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663880980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXS0ZoEnXLzhhTQpUewsa25M9mE4ekWsMAUnjztRNjE=;
 b=CZssrq1LQyVs4dfVn8z74JRcdhJYjP83Nd54U9oZRugCbnJLm4siTM4It3sll1cQCXIwG4
 cVmsaj0UpVBqm0sYQA7KI6de3ndzNc+degDKbF6a73f7yAQz9p0yb44Agh3+7bFSR7N78N
 XoRkexdjHZlI2kwFn1ZLiq8qx6LVxZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663880980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXS0ZoEnXLzhhTQpUewsa25M9mE4ekWsMAUnjztRNjE=;
 b=1Sq2aP4Cxdk8a58Pld/qTUOupkfZdxWHO9+RoPc9hlwIWgR7G90jMDkaI6+NvlUFhM28Y1
 XaP/028PLQmSkuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC34E1346B;
 Thu, 22 Sep 2022 21:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MFhHMBPPLGMYKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 21:09:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Sep 2022 23:09:29 +0200
Message-Id: <20220922210931.23982-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922210931.23982-1-pvorel@suse.cz>
References: <20220922210931.23982-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3 v2] tst_supported_fs: Unify messaging
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

Most of the messages used fprintf() instead of tst_{res,brk}(),
thus convert all messages to fprintf().

Add macros to shorten code.

Fixes: eb47b4497 ("tst_supported_fs: Support skip list when query single fs")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I'm not sure about this myself. Shouldn't we rather use tst_brk() and
tst_res() instead? It's show tst_supported_fs as command.


 testcases/lib/tst_supported_fs.c | 61 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 26577c726..947aa4dae 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -15,6 +15,22 @@
 #include "tst_test.h"
 #include "tst_fs.h"
 
+#define err(...) ({ \
+	fprintf(stderr, __VA_ARGS__); \
+	fprintf(stderr, "\n"); \
+	usage(); \
+	return 2; })
+
+#define fail(...) ({ \
+	fprintf(stderr, __VA_ARGS__); \
+	fprintf(stderr, "\n"); \
+	return 1; })
+
+#define info(...) ({ \
+	fprintf(stderr, __VA_ARGS__); \
+	fprintf(stderr, "\n"); \
+	return 0; })
+
 static void usage(void)
 {
 	fprintf(stderr, "Usage:\n");
@@ -90,67 +106,50 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'd':
-			if (fsname) {
-				fprintf(stderr,
-					"Can't specify multiple paths\n");
-				usage();
-				return 2;
-			}
+			if (fsname)
+				err("Can't specify multiple paths");
 
 			fsname = tst_fs_type_name(tst_fs_type(optarg));
 			break;
 		}
 	}
 
-	if (fsname && !skiplist) {
-		fprintf(stderr, "Parameter -d requires skiplist\n");
-		usage();
-		return 2;
-	}
+	if (fsname && !skiplist)
+		err("Parameter -d requires skiplist");
 
-	if (argc - optind > 1) {
-		fprintf(stderr, "Can't specify multiple fs_type\n");
-		usage();
-		return 2;
-	}
+	if (argc - optind > 1)
+		err("Can't specify multiple fs_type");
 
 	/* fs_type */
 	if (optind < argc) {
-		if (fsname) {
-			fprintf(stderr, "Can't specify fs_type and -d together\n");
-			usage();
-			return 2;
-		}
+		if (fsname)
+			err("Can't specify fs_type and -d together");
 
 		fsname = argv[optind];
 	}
 
 	if (fsname) {
 		if (fsname[0] == '\0')
-			tst_brk(TCONF, "fs_type is empty");
+			err("fs_type is empty");
 
 		if (skiplist) {
 			if (tst_fs_in_skiplist(fsname, (const char * const*)skiplist))
-				tst_brk(TCONF, "%s is skipped", fsname);
-			else
-				tst_res(TINFO, "%s is not skipped", fsname);
+				fail("%s is skipped", fsname);
 
-			return 0;
+			info("%s is not skipped", fsname);
 		}
 
 		if (tst_fs_is_supported(fsname) == TST_FS_UNSUPPORTED)
-			tst_brk(TCONF, "%s is not supported", fsname);
-		else
-			tst_res(TINFO, "%s is supported", fsname);
+			fail("%s is not supported", fsname);
 
-		return 0;
+		info("%s is supported", fsname);
 	}
 
 	/* all filesystems */
 	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
 
 	if (!filesystems[0])
-		tst_brk(TCONF, "There are no supported filesystems or all skipped");
+		fail("There are no supported filesystems or all skipped");
 
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
