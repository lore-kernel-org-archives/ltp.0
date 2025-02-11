Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F9C021A1
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 15:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3E13C996F
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 16:23:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FC873C993E
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 16:22:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4972665DB99
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 16:22:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECBE238B70
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739276638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xzIkajK3jgW+vAAcqY4w2HEQ4Cc83/T8ZG/NY27YJsA=;
 b=HMpJcYSADJZpdde1Fcs3y4znhR/xnRmcGbHtyNOZWBaOea53N4PMDEOYXQFhvOYOFKRqYO
 CVlJmNu4DzgrSbcKbQS/R9nASMy9BysHZW5rEkliCVjbS3TRLBF3kP/hSCBEKorOlnjpPz
 VU8XMARKgQpN739izInVbukxIouPjtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739276638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xzIkajK3jgW+vAAcqY4w2HEQ4Cc83/T8ZG/NY27YJsA=;
 b=/ZEDiunGxF9i4aIy48kGNzNJ+AicaGpQzkvEo3VxAI4E8Ul0dOyF1vP6d5tulNKWHWb8vX
 Xwle1UXHr2YzidDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z1KgX6GI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BQiu80O7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739276637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xzIkajK3jgW+vAAcqY4w2HEQ4Cc83/T8ZG/NY27YJsA=;
 b=z1KgX6GIJykSvrmf9gWaD5bm0eVF+Z3JL1K8BHKbmRi7MMuMhgxrq6D9oGsiMM/L9k0GOg
 +MdZ4GPGffvVc0lh+Te2ipgQn95p1yKe4FdrgFXQUeVGw2Drvw5EfSjbvvXbDzBDXjF2Ll
 aWlMufSeTOweSY2795/W/oOBFNV33l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739276637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xzIkajK3jgW+vAAcqY4w2HEQ4Cc83/T8ZG/NY27YJsA=;
 b=BQiu80O76Ww/cjVPqZnuNJRBDr1eA3xbOwaZLtETycVgwOEv51cg+aykoG9tNpt0tjVGJ9
 yUMyF2s96VM1PNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2D3D13782
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 12:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Du/0Nl1Bq2dsIQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 12:23:57 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 13:23:49 +0100
Message-ID: <20250211122354.18324-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: ECBE238B70
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fsplough: Implement runtime awareness
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

Switch fsplough test to run for 30 seconds by default, with the option
to set a fixed number of loops on command line instead. The test will
always exit when runtime expires and a warning will be printed
if there were too few iterations due to expired runtime.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/fs/fsplough/fsplough.c | 39 ++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/fsplough/fsplough.c b/testcases/kernel/fs/fsplough/fsplough.c
index 66aa37c47..6ce644a8d 100644
--- a/testcases/kernel/fs/fsplough/fsplough.c
+++ b/testcases/kernel/fs/fsplough/fsplough.c
@@ -25,12 +25,13 @@ static char *workdir_arg;
 static char *directwr_flag;
 static char *directrd_flag;
 static char *loop_arg;
-static int loop_count = 4096;
+static int loop_count;
 
 static int read_fd = -1, write_fd = -1;
 static char *writebuf, *filedata;
 static size_t blocksize, bufsize, filesize;
 
+static struct tst_test test;
 static void do_write(void *buf, size_t offset, size_t size);
 static void do_pwrite(void *buf, size_t offset, size_t size);
 static void do_writev(void *buf, size_t offset, size_t size);
@@ -163,6 +164,7 @@ static void setup(void)
 {
 	struct statvfs statbuf;
 	size_t pagesize;
+	int runtime;
 
 	srand(time(0));
 	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
@@ -190,7 +192,17 @@ static void setup(void)
 		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	filedata = SAFE_MALLOC(filesize);
 
-	tst_set_timeout(bufsize * loop_count / (8 * 1024 * 1024));
+	if (loop_arg) {
+		/*
+		 * Executing fixed number of loops. Use calculated runtime
+		 * as timeout and apply the timeout multiplier.
+		 */
+		runtime = bufsize * loop_count / (8 * 1024 * 1024);
+		runtime = tst_multiply_timeout(runtime);
+
+		if (runtime > test.runtime)
+			tst_set_runtime(runtime);
+	}
 }
 
 static void run(void)
@@ -199,7 +211,10 @@ static void run(void)
 	int i, f, fails = 0;
 
 	/* Test data consistency between random writes */
-	for (i = 0; i < loop_count; i++) {
+	for (i = 0; !loop_arg || i < loop_count; i++) {
+		if (!tst_remaining_runtime())
+			break;
+
 		length = fill_buffer(writebuf, bufsize);
 		start = rand() % (filesize + 1 - length);
 
@@ -222,6 +237,20 @@ static void run(void)
 		}
 	}
 
+	if (i < loop_count / 2) {
+		tst_res(TWARN, "Runtime expired, exiting early after %d loops",
+			i);
+		tst_res(TINFO, "If you are running on slow machine, "
+			"try exporting LTP_TIMEOUT_MUL > 1");
+	} else if (i < loop_count) {
+		tst_res(TINFO, "Runtime expired, exiting early after %d loops",
+			i);
+	} else if (!loop_arg && i < 10) {
+		tst_res(TWARN, "Slow sytem: test performed only %d loops!", i);
+	} else {
+		tst_res(TPASS, "Exiting after %d loops", i);
+	}
+
 	if (!fails)
 		tst_res(TPASS, "Partial data are consistent");
 
@@ -269,8 +298,10 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.runtime = 30,
 	.options = (struct tst_option[]) {
-		{"c:", &loop_arg, "Number of write loops (default: 4096)"},
+		{"c:", &loop_arg,
+			"Number of write loops (default: loop for 30 seconds)"},
 		{"d:", &workdir_arg, "Path to working directory"},
 		{"W", &directwr_flag, "Use direct I/O for writing"},
 		{"R", &directrd_flag, "Use direct I/O for reading"},
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
