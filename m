Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D6CA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 05:58:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A31BB3CC2E1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 07:58:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB08B3CB6A1
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 07:58:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C280C1A0238D
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 07:58:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7515B1F45E
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 05:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693547888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDoATlRKKK21G6ZPfFkOrD+p76IvDV0YtJUSSaxqAEQ=;
 b=lm8NNJ8Ot8jxqXe6CUiQm3JZQtMve0KbFZU4ecrdUsHdg3UYRZwdBlpIUQl+VxdFkiMttT
 qtaKTgUTbIahq9CeUplHCjkmM/xP2vv+rs76IjaBB4VEfavtX706R33Y+gDEIxJshVhOW5
 RhLs6kyMGZdFWybSje+FBXAjyHNbANk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693547888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDoATlRKKK21G6ZPfFkOrD+p76IvDV0YtJUSSaxqAEQ=;
 b=AQU1qzPbDK/Mcsr20GbPzxD6y6zs4cgnF1v2EkEyIUKfDctQ6wtZpzSlIGXH/knZ9pcFjv
 ZL6sdmXj3qpqs9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA471358B
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 05:58:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ez6sEml98WTgVAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Fri, 01 Sep 2023 05:58:01 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  1 Sep 2023 11:27:51 +0530
Message-ID: <20230901055756.7057-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZPCLZ5eIPQZ8sWoX@yuki>
References: <ZPCLZ5eIPQZ8sWoX@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap06: Add testcases for EINVAL scenarios
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap06.c | 32 +++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index 012e7de41..1a0c8e3cf 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -8,27 +8,35 @@
 /*\
  * [Description]
  *
- * Verify that, mmap() call fails when a file mapping is requested but the
- * file descriptor is not open for reading, and errno is set to EACCES.
+ * Verify that, mmap() call fails with errno:
+ *
+ * - EACCES, when a file mapping is requested but the file descriptor is not open for reading.
+ * - EINVAL, when length argument is 0.
+ * - EINVAL, when flags contains none of MAP_PRIVATE, MAP_SHARED, or MAP_SHARED_VALIDATE.
  */
 
 #include <stdlib.h>
 #include "tst_test.h"
 
+#define MMAPSIZE 1024
 #define TEMPFILE "mmapfile"
 static size_t page_sz;
 static int fd;
 
 static struct tcase {
+	size_t length;
 	int prot;
 	int flags;
+	int exp_errno;
 } tcases[] = {
-	{PROT_WRITE, MAP_FILE | MAP_PRIVATE},
-	{PROT_WRITE, MAP_FILE | MAP_SHARED},
-	{PROT_READ, MAP_FILE | MAP_PRIVATE},
-	{PROT_READ, MAP_FILE | MAP_SHARED},
-	{PROT_READ | PROT_WRITE, MAP_FILE | MAP_PRIVATE},
-	{PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED}
+	{MMAPSIZE, PROT_WRITE, MAP_FILE | MAP_PRIVATE, EACCES},
+	{MMAPSIZE, PROT_WRITE, MAP_FILE | MAP_SHARED, EACCES},
+	{MMAPSIZE, PROT_READ, MAP_FILE | MAP_PRIVATE, EACCES},
+	{MMAPSIZE, PROT_READ, MAP_FILE | MAP_SHARED, EACCES},
+	{MMAPSIZE, PROT_READ | PROT_WRITE, MAP_FILE | MAP_PRIVATE, EACCES},
+	{MMAPSIZE, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, EACCES},
+	{0, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, EINVAL},
+	{MMAPSIZE, PROT_READ | PROT_WRITE, MAP_FILE, EINVAL}
 };
 
 static void setup(void)
@@ -48,13 +56,13 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TESTPTR(mmap(NULL, page_sz, tc->prot, tc->flags, fd, 0));
+	TESTPTR(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0));
 
 	if (TST_RET_PTR != MAP_FAILED) {
 		tst_res(TFAIL, "mmap() was successful unexpectedly");
-		SAFE_MUNMAP(TST_RET_PTR, page_sz);
-	} else if (TST_ERR == EACCES) {
-		tst_res(TPASS, "mmap() failed with errno EACCES");
+		SAFE_MUNMAP(TST_RET_PTR, MMAPSIZE);
+	} else if (TST_ERR == tc->exp_errno) {
+		tst_res(TPASS, "mmap() failed with expected errno");
 	} else {
 		tst_res(TFAIL | TERRNO, "mmap() failed but unexpected errno");
 	}
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
