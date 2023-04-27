Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE36CC77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:08:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AF6C3CE4C6
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:08:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713DA3CBA98
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8661810004BF
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:08:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C774821B01
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1682597282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zLbjsq3uCMIUgtGRJdfv59Tk2swWok93BwosHgWfXIg=;
 b=DUZtWfQbo6TvYuzNM6jQI3ooXmVSSYxRr9VcNpAN2t2MOVNui4UVNzMs6lk6GtUywh9dSe
 ONfQkDWcQG/v8SROsMnEv8yLzIA774jiCvbjctt0gsNVRZMX0toDfhRG3uGMwv/T5knXLr
 vNBl2pWHDtszefx15Crfxknqx41Bb60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1682597282;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zLbjsq3uCMIUgtGRJdfv59Tk2swWok93BwosHgWfXIg=;
 b=M1JxfhHcDMMY/D6I1zjkLXq8fJ1t2iV8ZXz97aUW6HcoM4HR/JgYsAqzj+QtqpC7a2RSfQ
 Bjb9rY/TGs4li2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7070C13910
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u2nLEaJlSmRvSwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 12:08:02 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 27 Apr 2023 17:37:56 +0530
Message-Id: <20230427120800.27849-1-akumar@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] dup01.c: use TST_EXP_FD macro and add inode check
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

- simplify using TST_EXP_FD() macro
- add inode comparison check for the newly allocated file descriptor
- add test description

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/dup/dup01.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index 74e24cc02..ce6f39ed3 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -7,27 +7,32 @@
  *
  */
 
+/*\
+ * [Description]
+ *
+ * Verify that dup(2) syscall executes successfully and allocates
+ * a new file descriptor which refers to the same open file as oldfd.
+ */
+
 #include "tst_test.h"
 
 static int fd;
+static struct stat buf1, buf2;
 
 static void verify_dup(void)
 {
-	TEST(dup(fd));
-
-	if (TST_RET < -1) {
-		tst_res(TFAIL, "Invalid dup() return value %ld", TST_RET);
-	} else if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "dup(%d) Failed", fd);
-	} else {
-		tst_res(TPASS, "dup(%d) returned %ld", fd, TST_RET);
-		SAFE_CLOSE(TST_RET);
-	}
+	TST_EXP_FD(dup(fd), "dup(%d)", fd);
+
+	SAFE_FSTAT(TST_RET, &buf2);
+	TST_EXP_EQ_LU(buf1.st_ino, buf2.st_ino);
+
+	SAFE_CLOSE(TST_RET);
 }
 
 static void setup(void)
 {
 	fd = SAFE_OPEN("dupfile", O_RDWR | O_CREAT, 0700);
+	SAFE_FSTAT(fd, &buf1);
 }
 
 static void cleanup(void)
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
