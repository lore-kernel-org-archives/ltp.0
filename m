Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54EDC433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 14:21:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 856863C9023
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 15:21:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 255973C876C
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:21:43 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3641B1A007E9
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:21:42 +0100 (CET)
Received: from mussarela.. (unknown [179.93.189.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 961AC3FFD5; 
 Fri, 17 Dec 2021 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1639750900;
 bh=QFppDQDs3kQ2tZSo17MmSW61YVyJgs28UZx+zU48LUI=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=H25LDkLvRRYpD8WC4KKHcwxBOki7MbOxVBq+utITX47L46q8WRweUzkC1+WrO6hOB
 0cXk7NMkIOYehF1dUEJxjiKvQcwjKob4FESyvscnyhySwaRD+If1aAGkqHI4abchrN
 6N0hBwZvmqcDEcDckzEUj1h6wJ3iWtcXFU/qs3Au3C+CKiiCNzk4rhcOf7Avip7RxV
 FmNERCUUlTl+qdESpvrzOY3BDKkrgd6KqgPBRuYQKgptQ6mHOvcT/EsMQcnYhd5WBY
 +ppnBcaQv3c66d8IDEx79WSJLQQEHwkOlZvCf2/eplfrPQc34lDiCBk18qHqxVbb2i
 iWA6BLeehsxFA==
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: ltp@lists.linux.it
Date: Fri, 17 Dec 2021 11:21:30 -0300
Message-Id: <20211217142130.1182702-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/dup202: make sure fds are not equal to ofd
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

If the test is executed by a process which has many open file descriptors,
creat may end up returning ofd == 10, which it will try to dup2 to, and,
then, SAFE_CLOSE will be run twice over fd=10, making it fail the second
time.

Test output would be like this:
dup202.c:90: TPASS: original(100444) and duped(100444) are the same mode
dup202.c:90: TPASS: original(100222) and duped(100222) are the same mode
dup202.c:90: TPASS: original(100666) and duped(100666) are the same mode
dup202.c:78: TINFO: original mode 0777, new mode 0444 after chmod
dup202.c:90: TPASS: original(100444) and duped(100444) are the same mode
dup202.c:94: TBROK: close(10) failed: EBADF (9)

It is easy to reproduce by simply exec'ing the test from a program that
has fds 0 to 10 opened.

Fix it by allocating enough file descriptors on the setup phase, and
assigning those new file descriptors to the fds that are going to be dup2
to.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/syscalls/dup2/dup202.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/dup2/dup202.c b/testcases/kernel/syscalls/dup2/dup202.c
index 64c800d35a10..659f3a4ecdff 100644
--- a/testcases/kernel/syscalls/dup2/dup202.c
+++ b/testcases/kernel/syscalls/dup2/dup202.c
@@ -29,7 +29,7 @@ static char testfile[40];
 static int ofd = -1, nfd = -1;
 
 /* set these to a known index into our local file descriptor table */
-static int duprdo = 10, dupwro = 20, duprdwr = 30;
+static int duprdo, dupwro, duprdwr;
 
 static struct tcase {
 	int *nfd;
@@ -47,8 +47,23 @@ static struct tcase {
 
 static void setup(void)
 {
+	int nextfd;
+
 	umask(0);
 	sprintf(testfile, "dup202.%d", getpid());
+
+	/* Pick up fds that are known not to collide with creat */
+	nextfd = SAFE_CREAT(testfile, 0777);
+	duprdo = SAFE_DUP(nextfd);
+	dupwro = SAFE_DUP(nextfd);
+	duprdwr = SAFE_DUP(nextfd);
+	/* SAFE_CLOSE will set fd to -1 */
+	close(duprdwr);
+	close(dupwro);
+	close(duprdo);
+	SAFE_CLOSE(nextfd);
+	SAFE_UNLINK(testfile);
+
 }
 
 static void cleanup(void)
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
