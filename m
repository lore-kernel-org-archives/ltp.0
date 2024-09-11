Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A588EE57C6
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642363C1DB3
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 18:35:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 207223C0359
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93C7F1016BAB
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C37A21FD04
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjnI/qQWRFEGoxGrRgaRhxyplnx8bO3U4Qkhu+Fe6YM=;
 b=O0Q7PCXrLlJIFiU+rgwwemtlL0pl8IqkL4XMSxtlbLplo81G/XOo0twOrFihFJF/jfjxS6
 uyxeiB/Mpfq+4fGxGfufw1Ic+K32gfJIktBT/UQ18n1QSLCj/WhfOCcIYPkaKLlp09dubJ
 etZ8+fVkGkSakBPlYCylQ5wf47Xem1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjnI/qQWRFEGoxGrRgaRhxyplnx8bO3U4Qkhu+Fe6YM=;
 b=CrMyd21CTEMxs5KbO5WXgKIlKtvQd0yMk4oaqramj7abxkHWuvxImI/6I1RTT3wmD+jK8m
 qhRy24CDuBnV7cBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjnI/qQWRFEGoxGrRgaRhxyplnx8bO3U4Qkhu+Fe6YM=;
 b=O0Q7PCXrLlJIFiU+rgwwemtlL0pl8IqkL4XMSxtlbLplo81G/XOo0twOrFihFJF/jfjxS6
 uyxeiB/Mpfq+4fGxGfufw1Ic+K32gfJIktBT/UQ18n1QSLCj/WhfOCcIYPkaKLlp09dubJ
 etZ8+fVkGkSakBPlYCylQ5wf47Xem1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjnI/qQWRFEGoxGrRgaRhxyplnx8bO3U4Qkhu+Fe6YM=;
 b=CrMyd21CTEMxs5KbO5WXgKIlKtvQd0yMk4oaqramj7abxkHWuvxImI/6I1RTT3wmD+jK8m
 qhRy24CDuBnV7cBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9B913A8C
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GOXsKa/G4WZcBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Sep 2024 18:34:39 +0200
Message-ID: <20240911163443.95398-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911163443.95398-1-mdoucha@suse.cz>
References: <20240911163443.95398-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] getdents02: Enable .all_filesystems
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

Run the getdents() error test on all filesystems.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/getdents/getdents02.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 25aa30d9d..805a8bc48 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -26,7 +26,9 @@
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
-#define TEST_DIR	"test_dir"
+#define MNTPOINT	"mntpoint"
+#define TEST_DIR	MNTPOINT "/test_dir"
+#define TEST_FILE	MNTPOINT "/test"
 
 static char *dirp;
 static size_t size;
@@ -61,8 +63,8 @@ static void setup(void)
 	size = tst_dirp_size();
 	dirp = tst_alloc(size);
 
-	fd = SAFE_OPEN(".", O_RDONLY);
-	fd_file = SAFE_OPEN("test", O_CREAT | O_RDWR, 0644);
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+	fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0644);
 
 	dirp_bad = tst_get_bad_addr(NULL);
 
@@ -92,9 +94,12 @@ static void run(unsigned int i)
 }
 
 static struct tst_test test = {
-	.needs_tmpdir = 1,
 	.test = run,
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test_variants = TEST_VARIANTS,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT
 };
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
