Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDE7C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 10:33:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EA1D3CF96B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 11:33:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2713A3CE0E9
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:33:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4199C20A6C6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:33:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 63F621F841;
 Tue, 30 Jan 2024 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706610802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qoe3a4nyjqqN7K+KAjKWk6b3CSiKZr4yaX0whNjlnyg=;
 b=oLOZIqj+olxinD/JoUUrF/UiuVbLOsFZnJ4IOI9ADjQObVIs/pOHbj4MA7OjGvF2f+4zrq
 EjG+uXPiMA+iETPVckI/TchMIqAXNDUpqEO8o2Keg/GVQIQ9+jMkoqQQYzgKMoIn/nPBz+
 C52AFlpV1S5WShBxZnERIwfQzbcfwzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706610802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qoe3a4nyjqqN7K+KAjKWk6b3CSiKZr4yaX0whNjlnyg=;
 b=5urMKm8fpEEvCMHA/SUsFjUdYh/joouLaokpG0BEj81rAdTAf/xooOvVqboVZ4d0Fm191W
 KQ+ImLSiy3XjBKDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706610802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qoe3a4nyjqqN7K+KAjKWk6b3CSiKZr4yaX0whNjlnyg=;
 b=oLOZIqj+olxinD/JoUUrF/UiuVbLOsFZnJ4IOI9ADjQObVIs/pOHbj4MA7OjGvF2f+4zrq
 EjG+uXPiMA+iETPVckI/TchMIqAXNDUpqEO8o2Keg/GVQIQ9+jMkoqQQYzgKMoIn/nPBz+
 C52AFlpV1S5WShBxZnERIwfQzbcfwzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706610802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qoe3a4nyjqqN7K+KAjKWk6b3CSiKZr4yaX0whNjlnyg=;
 b=5urMKm8fpEEvCMHA/SUsFjUdYh/joouLaokpG0BEj81rAdTAf/xooOvVqboVZ4d0Fm191W
 KQ+ImLSiy3XjBKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 348F813A66;
 Tue, 30 Jan 2024 10:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wTszCnLQuGX9MAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 30 Jan 2024 10:33:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 30 Jan 2024 11:33:19 +0100
Message-Id: <20240130103319.22763-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oLOZIqj+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5urMKm8f
X-Spamd-Result: default: False [2.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[11.80%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 63F621F841
X-Spamd-Bar: ++
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix dio_append/aiodio_append tests
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

Ensure that dio_append and aiodio_append will end all children if
parent asked for it. The way we have to do it, is to ensure that
*run_child variable is checked before opening the file to read.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common.h     | 12 ++++++++++--
 testcases/kernel/io/ltp-aiodio/dio_append.c |  4 ++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 200bbe18e..9a2d27166 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -62,8 +62,12 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 	int i;
 	int r;
 
-	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
+	while ((fd = open(filename, O_RDONLY, 0666)) < 0) {
+		if (!*run_child)
+			return;
+
 		usleep(100);
+	}
 
 	tst_res(TINFO, "child %i reading file", getpid());
 
@@ -102,8 +106,12 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
 	int fd;
 	int r;
 
-	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
+	while ((fd = open(filename, O_RDONLY, 0666)) < 0) {
+		if (!*run_child)
+			return;
+
 		usleep(100);
+	}
 
 	tst_res(TINFO, "child %i reading file", getpid());
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 057ae73d9..bd48a8252 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -33,7 +33,7 @@ static void setup(void)
 {
 	numchildren = 16;
 	writesize = 64 * 1024;
-	appends = 1000;
+	appends = 10000;
 
 	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
@@ -97,7 +97,7 @@ static struct tst_test test = {
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of processes (default 16)"},
 		{"w:", &str_writesize, "Write size for each append (default 64K)"},
-		{"c:", &str_appends, "Number of appends (default 1000)"},
+		{"c:", &str_appends, "Number of appends (default 10000)"},
 		{}
 	},
 	.skip_filesystems = (const char *[]) {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
