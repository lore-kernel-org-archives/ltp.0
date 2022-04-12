Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED885C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 12:41:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCA6C3CA55E
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 14:41:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBA273CA49D
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 14:41:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A61B9600048
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 14:41:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAB7E21608;
 Tue, 12 Apr 2022 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649767293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fq4+ZfyZFaPM/R5xXTi9uoCZKYhd4G4U0RDigTpZQMI=;
 b=Yo2g0SnK/y+eMJCF39tXvzB+r9XCmGSy54+2bARiyte9hly6CPNPsQuLzUxdJcEpm/jDIH
 Fs0JnxRuRGHzTqbyP4krO+zHl1WrJQsmRopfJmm6H7ZtmSdkQ3uTlbNVvfylGvIF0UZo2B
 UtEpb2yYFu1wX6cRn8c7+bkTNfcoB0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649767293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fq4+ZfyZFaPM/R5xXTi9uoCZKYhd4G4U0RDigTpZQMI=;
 b=pEvLqTxq1p4B8UlQ2+dL1z9R/pkJjWUzEBrdMHadUwufb2Ak9gAcLu75wzp8lVqMkMX0nA
 hn1i1SiDUD4WnGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB8B213780;
 Tue, 12 Apr 2022 12:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6srYI31zVWJOAQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 12 Apr 2022 12:41:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Apr 2022 14:41:31 +0200
Message-Id: <20220412124131.11655-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Fix wqueue09 according with 5.17 kernel updates
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

Kernel 5.17 introduced many changes in the watch_queue support. In
particular, commit 3b4c0371928c17af03e8397ac842346624017ce6 changes the
behaviour of IOC_WATCH_QUEUE_SET_SIZE and ioctl control over watch_queue
buffer size: now we need to generate more events than before. In
particular, more than the bitmap size to the number of notes.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
This patch fixes the issue of loosing events on big number of iterations
such as -i 1000 by introducing also setup/cleanup.

 testcases/kernel/watchqueue/wqueue09.c | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/watchqueue/wqueue09.c b/testcases/kernel/watchqueue/wqueue09.c
index 55d567249..9f077b35b 100644
--- a/testcases/kernel/watchqueue/wqueue09.c
+++ b/testcases/kernel/watchqueue/wqueue09.c
@@ -11,11 +11,16 @@
 
 #define _GNU_SOURCE
 
+#include <unistd.h>
 #include "tst_test.h"
 #include "lapi/keyctl.h"
 #include "common.h"
 
+#define WATCH_QUEUE_NOTE_SIZE 128
+
 static int data_lost;
+static key_serial_t key;
+static int fd;
 
 static void saw_data_loss(struct watch_notification *n,
 			  LTP_ATTRIBUTE_UNUSED size_t len, unsigned int wtype)
@@ -27,29 +32,38 @@ static void saw_data_loss(struct watch_notification *n,
 		data_lost = 1;
 }
 
-static void run(void)
+static void setup(void)
 {
-	int fd;
-	key_serial_t key;
-
 	fd = wqueue_watch(1, &wqueue_filter);
-
 	key = wqueue_add_key(fd);
-	keyctl(KEYCTL_UPDATE, key, "b", 1);
-	keyctl(KEYCTL_REVOKE, key);
+}
+
+static void run(void)
+{
+	int i, iterations;
+
+	iterations = (getpagesize() / WATCH_QUEUE_NOTE_SIZE) * 2;
+	for (i = 0; i < iterations; i++)
+		keyctl(KEYCTL_UPDATE, key, "b", 1);
 
 	data_lost = 0;
 	while (!data_lost)
 		wqueue_consumer(fd, saw_data_loss);
 
-	SAFE_CLOSE(fd);
-
 	if (data_lost)
 		tst_res(TPASS, "Meta loss notification received");
 	else
 		tst_res(TFAIL, "Event not recognized");
 }
 
+static void cleanup(void)
+{
+	keyctl(KEYCTL_REVOKE, key);
+	SAFE_CLOSE(fd);
+}
+
 static struct tst_test test = {
 	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
