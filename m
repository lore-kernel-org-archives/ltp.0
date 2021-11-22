Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E23C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:26:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7044E3C8D31
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 08:26:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8A863C0681
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:26:13 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CEDF5200C25
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:26:12 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 5B5399FB3D;
 Mon, 22 Nov 2021 07:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637565971; bh=eN8nqL1qFMkX7apzXHsqash81gM7p096ry4EjNr2dP0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=jPbSH7a4CnJTmimESjHEgYgp6ziphzpmhkf9wAr9aHvEvnTMszhY97Jz/H6QEa+Uo
 MOD+6yvFyeU+2O9hSSy6S2jtNS5MMe17SVhQ3LRjALT+vQh20Y9yxsAnhosoSpmo0O
 4/1AXm2fQYpYmPdbEKrnqBdNvfSSzHyDMFbOL+ug=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Mon, 22 Nov 2021 08:25:58 +0100
Message-Id: <20211122072601.4096577-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] posix/conformance/interfaces/fork/7-1: Fix test
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The test could never fail:
It only checked for errno after executing getcats, but getcats
never sets errno, instead it returns its forth parameter.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/fork/7-1.c         | 42 +++++++++----------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
index aaf1403f9..cff904816 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
@@ -49,33 +49,22 @@
 #define MESSCAT_IN  "messcat.txt"
 #define MESSCAT_OUT "messcat.cat"
 
-static void read_catalog(nl_catd cat, char *who)
+static int read_catalog(nl_catd cat)
 {
+	static const char *notfound = "not found";
 	char *msg = NULL;
 	int i, j;
 
-#if VERBOSE > 0
-	output("Reading the message catalog from %s...\n", who);
-#endif
-
-	errno = 0;
-
-	for (i = 1; i <= 2; i++) {
+	for (i = 1; i <= 3; i++) {
 		for (j = 1; j <= 2; j++) {
 
-			msg = catgets(cat, i, j, "not found");
-
-			if (errno != 0)
-				UNRESOLVED(errno, "catgets returned an error");
-#if VERBOSE > 1
-			output("set %i msg %i: %s\n", i, j, msg);
-#endif
+			msg = catgets(cat, i, j, notfound);
+			if (msg == notfound) {
+				return 1;
+			}
 		}
 	}
-
-#if VERBOSE > 0
-	output("Message catalog read successfully in %s\n", who);
-#endif
+	return 0;
 }
 
 static char *messcat_in =
@@ -132,7 +121,10 @@ int main(void)
 	if (messcat == (nl_catd) - 1)
 		UNRESOLVED(errno, "Could not open ./" MESSCAT_OUT);
 
-	read_catalog(messcat, "parent");
+	if (read_catalog(messcat)) {
+		printf("UNRESOLVED: Unable to read message catalog in parent\n");
+		return PTS_UNRESOLVED;
+	}
 
 	child = fork();
 
@@ -140,8 +132,11 @@ int main(void)
 		UNRESOLVED(errno, "Failed to fork");
 
 	if (child == 0) {
-		read_catalog(messcat, "child");
-		exit(PTS_PASS);
+		if (read_catalog(messcat)) {
+			printf("FAILED: Unable to read message catalog in child\n");
+			return PTS_FAIL;
+		}
+		return PTS_PASS;
 	}
 
 	ctl = waitpid(child, &status, 0);
@@ -157,7 +152,8 @@ int main(void)
 	if (ret != 0)
 		UNRESOLVED(errno, "Failed to close the message catalog");
 
-	system("rm -f " MESSCAT_IN " " MESSCAT_OUT);
+	unlink(MESSCAT_IN);
+	unlink(MESSCAT_OUT);
 
 #if VERBOSE > 0
 	output("Test passed\n");
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
