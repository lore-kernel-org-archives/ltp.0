Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6B7C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 09:40:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43FA83C9879
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 10:40:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12E803C97F7
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:39:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C73BC600634
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 10:39:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F58E1F380;
 Tue,  1 Feb 2022 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643708396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c1P9EJfv7qv0T2aNyZSJJtdkJKp001LMCBrYbnegPyE=;
 b=08TKzzYsO/4zNqnlNtB1jzVrfkvWcqIQVsT5EbacOhpgjCYgR4bdrCgjq+s7PMixIgCjMj
 Jb+CYyB5ZU1VXIFrbohfH4vOdrj9mld2AHZ5uEc5h4CP2E+vS7YOhe2sjszNW7iTuQOcRV
 rN9k31kZhoWyQPVzjM2noV0a3kyxVlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643708396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c1P9EJfv7qv0T2aNyZSJJtdkJKp001LMCBrYbnegPyE=;
 b=iA3n3IL/EYQLaK/tIgd6uQq2laNnFVKFsr+XpiHSRkzSsYYJYLu/4EO1nL9z2jo/qz05+P
 e6Yr6HRfiDIt+dDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7A1F13CF0;
 Tue,  1 Feb 2022 09:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PJGgMuv/+GGgdQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 01 Feb 2022 09:39:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  1 Feb 2022 10:39:54 +0100
Message-Id: <20220201093954.1660-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Check for maximum available pids in dio_sparse.c
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
In v2 setup message for children has been moved from TCONF to TINFO.
And other small fixes.

 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 26 +++++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 0039daa8d..1da1ae37f 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -54,14 +54,29 @@ static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
 		w = SAFE_WRITE(0, fd, bufptr, ws);
 		i += w;
 	}
+
+	free(bufptr);
 }
 
 static void setup(void)
 {
 	struct stat sb;
+	int max_pids;
+
+	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX)) {
+		tst_brk(TBROK, "Invalid number of children '%s'",
+			str_numchildren);
+	}
 
-	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
-		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
+	max_pids = tst_get_free_pids();
+	if (numchildren > max_pids) {
+		numchildren = max_pids;
+
+		tst_res(TINFO,
+			"Number of children reduced to %d due to system "
+			"limitations",
+			numchildren);
+	}
 
 	if (tst_parse_filesize(str_writesize, &writesize, 1, LLONG_MAX))
 		tst_brk(TBROK, "Invalid write blocks size '%s'", str_writesize);
@@ -75,7 +90,8 @@ static void setup(void)
 	SAFE_STAT(".", &sb);
 	alignment = sb.st_blksize;
 
-	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 
 	tst_res(TINFO, "Dirtying free blocks");
 	dirty_freeblocks(100 * 1024 * 1024);
@@ -91,7 +107,7 @@ static void cleanup(void)
 
 static void run(void)
 {
-	char *filename = "dio_sparse";
+	char *filename = "file.bin";
 	int status;
 	int fd;
 	int i;
@@ -129,7 +145,7 @@ static struct tst_test test = {
 		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
 		{"s:", &str_filesize, "Size of file (default 100M)"},
 		{"o:", &str_offset, "File offset (default 0)"},
-		{}
+		{},
 	},
 	.skip_filesystems = (const char *[]) {
 		"tmpfs",
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
