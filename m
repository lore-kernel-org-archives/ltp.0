Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBDDC27C50
	for <ltp@archiver.kernel.org>; Tue,  4 Jun 2024 13:45:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79A23D093C
	for <ltp@archiver.kernel.org>; Tue,  4 Jun 2024 15:45:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE9E93D0916
 for <ltp@lists.linux.it>; Tue,  4 Jun 2024 15:45:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE8E4207A04
 for <ltp@lists.linux.it>; Tue,  4 Jun 2024 15:45:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 306E71F7F9;
 Tue,  4 Jun 2024 13:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717508716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9i2VLm5wwLJkYowpsCX6Kkzdk63MkvnTz1/6ULv4Sw=;
 b=Oe7wZ4LLesSQ1A+p8/4RzIHElYe5vvWfU0q+8q6f5Ng7QbZZSHYyX7rGSHd2aYMOR/mtfm
 0C6rcrEUQPZ607bq93FQfvmXKzUmdwyYmqCaYylKKVOoTaiTwNsy8TEBIdCPW3i/6072ce
 0iWyW4MxFlrAXABy98zW/be/Kr4bres=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717508716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9i2VLm5wwLJkYowpsCX6Kkzdk63MkvnTz1/6ULv4Sw=;
 b=tvlLzRXZcUURhKbmMJkttULWf6zCaF9nyazCx2lP6r59NnASqIDMEdcGC1maPyUZ8Tkx6a
 19XoQ5UTL8pTeSDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717508716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9i2VLm5wwLJkYowpsCX6Kkzdk63MkvnTz1/6ULv4Sw=;
 b=Oe7wZ4LLesSQ1A+p8/4RzIHElYe5vvWfU0q+8q6f5Ng7QbZZSHYyX7rGSHd2aYMOR/mtfm
 0C6rcrEUQPZ607bq93FQfvmXKzUmdwyYmqCaYylKKVOoTaiTwNsy8TEBIdCPW3i/6072ce
 0iWyW4MxFlrAXABy98zW/be/Kr4bres=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717508716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p9i2VLm5wwLJkYowpsCX6Kkzdk63MkvnTz1/6ULv4Sw=;
 b=tvlLzRXZcUURhKbmMJkttULWf6zCaF9nyazCx2lP6r59NnASqIDMEdcGC1maPyUZ8Tkx6a
 19XoQ5UTL8pTeSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1073313A93;
 Tue,  4 Jun 2024 13:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADLoAWwaX2YBAwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 04 Jun 2024 13:45:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 04 Jun 2024 15:44:40 +0200
MIME-Version: 1.0
Message-Id: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
X-B4-Tracking: v=1; b=H4sIAEcaX2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMT3dK8nMy8bANL3ZRkEwsDozQLc6M0SyWg8oKi1LTMCrBR0bG1tQB
 IysRsWgAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=3wSWdhBvsAsSDWSqpGVzcS9sqa+I6Upt06rD8QIFPME=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmXxpMNSwqprAs1Xh4aC1WTtlqD5IYNy9wcafZq
 ANR9UvMY32JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZl8aTAAKCRDLzBqyILPm
 Rk43C/9vidk80Wu9gOU/DNOz4xfX3k4L5hHIBNGGN++BKMOveGlfoJ8pcfq2OwW++m8tcFdXt6t
 0ZgCP7VLauwNZVkfgEPiL2BxKwQ1TKN7qSmbVMMzXSi2ySKTAESei/MZSRDw55xna69OsBcljnA
 Lip5H/kWtuAIgwk/B+Le9xW30auOITaXrl2aRUQnQV9tPHWB/p/NXQRufhbbFApDD64A/IDgAXo
 9ZbZk3+wFIxLr5BRsk7Q6ue1wWIQkMdbB7YDWAvt0jx4BOpdgut8ruc2UlXmi5cPKAN+7H0iHDD
 aGK8qGaFPoSaY5UVXfyYrKt1nY5S9uMMCmx/Y0viI+cmmUG51I99ypJhCWs+5KE87HPJCni9Nsa
 wh40kp466imNvFB4YrGi4FXyq3Uyl7fWTVmgjw04N2AE5utjp3YJmI15EHM3D2o1aruW7h3yH17
 q5WJY4f4imy0zm/dzRGYJ3rTilzuE55fnucRuET59fBhKlwKs6wKhRGtWP8tdoJQXP3CI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix unlink09 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This patch will fix unlink09 test by checking for filesystems which
are not supporting inode attributes.

Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This will fix the 2cf78f47a6 and resolve issues on filesystems
which are not supporting inode attributes.
---
 testcases/kernel/syscalls/unlink/unlink09.c | 38 +++++++++++++++++++----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..ed6f0adc3 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -11,6 +11,8 @@
  *
  * - EPERM when target file is marked as immutable or append-only
  * - EROFS when target file is on a read-only filesystem.
+ *
+ * Test won't be executed if inode attributes are not supported.
  */
 
 #include <sys/ioctl.h>
@@ -22,8 +24,8 @@
 #define DIR_EROFS "erofs"
 #define TEST_EROFS "erofs/test_erofs"
 
-static int fd_immutable;
-static int fd_append_only;
+static int fd_immutable = -1;
+static int fd_append_only = -1;
 
 static struct test_case_t {
 	char *filename;
@@ -43,12 +45,18 @@ static void setup(void)
 {
 	int attr;
 
-	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
-	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	fd_immutable = SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
+	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
+
+	if (TST_RET == -1 && TST_ERR == ENOTTY) {
+		SAFE_CLOSE(fd_immutable);
+		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
+	}
+
 	attr |= FS_IMMUTABLE_FL;
 	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
 
-	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
+	fd_append_only = SAFE_CREAT(TEST_EPERM_APPEND_ONLY, 0600);
 	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
 	attr |= FS_APPEND_FL;
 	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
@@ -58,15 +66,19 @@ static void cleanup(void)
 {
 	int attr;
 
-	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
-	attr &= ~FS_IMMUTABLE_FL;
-	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
-	SAFE_CLOSE(fd_immutable);
+	if (fd_immutable != -1) {
+		SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
+		attr &= ~FS_IMMUTABLE_FL;
+		SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
+		SAFE_CLOSE(fd_immutable);
+	}
 
-	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
-	attr &= ~FS_APPEND_FL;
-	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
-	SAFE_CLOSE(fd_append_only);
+	if (fd_append_only != -1) {
+		SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
+		attr &= ~FS_APPEND_FL;
+		SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
+		SAFE_CLOSE(fd_append_only);
+	}
 }
 
 static void verify_unlink(unsigned int i)

---
base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
change-id: 20240604-unlink09-dc4802f872f9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
