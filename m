Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179C8C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:46:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDF061108
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BDF061108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A8953C89AC
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:46:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2623C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:14 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 32285602129
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:14 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 585349FE1A;
 Fri, 19 Nov 2021 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307973; bh=0Z7I7oQi8+JmkSbZyKMpNPCmODMu0W6vYAAZnAvuDFc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=tfd8E5tIy7cldHlWw3asw2RzP5Tc5H5MXgXMd+esaVLKvWoGeV9p9tnNXv06ZnVQX
 mqoLE4gTTEK0+5TEBzxNJInVnhqcHa1QHfXk5n7tDz3jsg7F78zF4sOiHnijd58PjD
 X8lLcCdq3EgUvCh0/ExJwfxCMuPAxXnlcKQhRc/c=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:52 +0100
Message-Id: <20211119074602.857595-3-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119074602.857595-1-lkml@jv-coder.de>
References: <20211119074602.857595-1-lkml@jv-coder.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/12] posix/mq_(timed)send/5-1: Fix error reporting
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

In case mq_receive failed, the whole test could still return PASS/FAIL

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../conformance/interfaces/mq_send/5-1.c                    | 3 +--
 .../conformance/interfaces/mq_timedsend/5-1.c               | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
index a2b3025d4..174e4f69e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
@@ -68,7 +68,6 @@ int main(void)
 	char msgrcd[BUFFER];
 	const char *msgptr = MSGSTR;
 	struct mq_attr attr;
-	int unresolved = 0;
 	unsigned pri;
 
 	sprintf(gqname, "/mq_send_5-1_%d", getpid());
@@ -128,7 +127,7 @@ int main(void)
 		/* receive one message and allow child's mq_send to complete */
 		if (mq_receive(gqueue, msgrcd, BUFFER, &pri) == -1) {
 			perror("mq_receive() did not return success");
-			unresolved = 1;
+			return cleanup_for_exit(gqueue, gqname, PTS_UNRESOLVED);
 		}
 
 		/* child has 5 seconds to call mq_send() again and notify us */
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
index fb4a81fef..371cdbcd4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/5-1.c
@@ -58,7 +58,6 @@ int main(void)
 	char msgrcd[BUFFER];
 	const char *msgptr = MSGSTR;
 	struct mq_attr attr;
-	int unresolved = 0;
 	unsigned pri;
 
 	sprintf(gqname, "/mq_timedsend_5-1_%d", getpid());
@@ -119,7 +118,10 @@ int main(void)
 		/* receive message and allow blocked send to complete */
 		if (mq_receive(gqueue, msgrcd, BUFFER, &pri) == -1) {
 			perror("mq_receive() did not return success");
-			unresolved = 1;
+			kill(pid, SIGKILL);	//kill child
+			mq_close(gqueue);
+			mq_unlink(gqname);
+			return PTS_UNRESOLVED;
 		}
 
 		if (sleep(3) == 0) {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
