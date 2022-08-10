Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E705C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 09:49:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1A53C55FE
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 11:49:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 490F23C1BEA
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 11:49:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 712811400BD9
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 11:49:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9EAB33C8A;
 Wed, 10 Aug 2022 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1660124944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y70pG4HjxmqtWmNd5bT0JGZhwX26es3EJItssaQdtLs=;
 b=F3YBjxito9aPd4x/qIWLq3Wv1IwQuRzhtsPFJny6OGgKiOP2aut5q0bRzg3fOgTRNxiAfe
 ir4q96vPEMx0aBVRt1vZHrZ1mF5QyCD0nKGfw5QaGZdnpF+obpOHcVkwKZd7budgc3NTVE
 vmI7PGFZV7g/i3vx3pEApt5EgExpLXE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B48B413AB3;
 Wed, 10 Aug 2022 09:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s6tnKRB/82LuJwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 10 Aug 2022 09:49:04 +0000
To: ltp@lists.linux.it
Date: Wed, 10 Aug 2022 11:48:24 +0200
Message-Id: <20220810094824.10778-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Refactor pidns32 test using new LTP API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/containers/pidns/pidns32.c | 36 ++++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index 215ca44a7..cbc91df68 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -7,29 +7,31 @@
 /*\
  * [Description]
  *
- * Clone a process with CLONE_NEWPID flag and reach the maximum amount of
- * nested containers checking for errors.
+ * Clone a process with CLONE_NEWPID flag and check for the maxium amount of
+ * nested containers.
  */
 
+#define _GNU_SOURCE
+
+#include <sys/mman.h>
 #include "tst_test.h"
 #include "lapi/namespaces_constants.h"
 
 #define MAXNEST 32
 
-static int child_func(void *arg)
+static int *level;
+
+static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
 	pid_t cpid;
-	int *level = (int *)arg;
 	int status;
 
-	tst_res(TINFO, "%p=%d", level, *level);
-
 	if (*level == MAXNEST)
 		return 0;
 
 	(*level)++;
 
-	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, level);
+	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
 	if (cpid < 0)
 		tst_brk(TBROK | TERRNO, "clone failed");
 
@@ -38,30 +40,32 @@ static int child_func(void *arg)
 	return 0;
 }
 
+static void setup(void)
+{
+	level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	*level = 1;
+}
+
 static void run(void)
 {
 	int ret, status;
-	int level = 1;
 
-	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, &level);
+	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "clone failed");
 
-	tst_res(TINFO, "%p=%d", &level, level);
-
 	SAFE_WAITPID(ret, &status, 0);
 
-	tst_res(TINFO, "%p=%d", &level, level);
-
-	if (level < MAXNEST) {
-		tst_res(TFAIL, "Not enough nested containers: %d", level);
+	if (*level < MAXNEST) {
+		tst_res(TFAIL, "Nested containers should be %d, but they are %d", MAXNEST, *level);
 		return;
 	}
 
-	tst_res(TPASS, "All containers have been nested");
+	tst_res(TPASS, "All %d containers have been nested", MAXNEST);
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
+	.setup = setup,
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
