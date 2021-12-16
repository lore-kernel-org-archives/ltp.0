Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD6DC433F5
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 09:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E05ED3C8F8A
	for <ltp@archiver.kernel.org>; Thu, 16 Dec 2021 10:31:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E98163C092C
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 10:31:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 57A0B1A0196D
 for <ltp@lists.linux.it>; Thu, 16 Dec 2021 10:31:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0601F45D;
 Thu, 16 Dec 2021 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639647083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w1AOsvdTyOS0qMPyUJBPZmt+sfyZs12VgOU7KfjMXbw=;
 b=BapRc1Hr6EVtvkzMj6tkGeAG51XMnlSBp+pPfxBBugys7kzQaYiVN9hX9vhB/vxomoIQFl
 vtCVQA86Wuy/Sn6TY8qs9G8UO73NADGiUZtaAuoRtlCFXpuiEdzLjhPPMZSk3b/Lr5lQxl
 xSs7JaszfLj2+xh1zLy/I1fXmm3dWpQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C07C13BAE;
 Thu, 16 Dec 2021 09:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pw5JDGsHu2FGYwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 16 Dec 2021 09:31:23 +0000
To: ltp@lists.linux.it
Date: Thu, 16 Dec 2021 10:31:15 +0100
Message-Id: <20211216093115.23982-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Check for maximum available pids in dio_sparse.c
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 929adbfba..5236539ff 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -59,6 +59,7 @@ static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
 static void setup(void)
 {
 	struct stat sb;
+	int max_pids;
 
 	numchildren = 1000;
 	writesize = 1024;
@@ -69,6 +70,13 @@ static void setup(void)
 	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
 
+	max_pids = tst_get_free_pids();
+	if (numchildren > max_pids) {
+		numchildren = max_pids;
+
+		tst_res(TCONF, "Number of children reduced to %d due to system limitations", numchildren);
+	}
+
 	if (tst_parse_filesize(str_writesize, &writesize, 1, LLONG_MAX))
 		tst_brk(TBROK, "Invalid write blocks size '%s'", str_writesize);
 
@@ -129,10 +137,10 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &str_numchildren, "Number of threads (default 1000)"},
-		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
-		{"s:", &str_filesize, "Size of file (default 100M)"},
-		{"o:", &str_offset, "File offset (default 0)"},
-		{}
+		{"n:", &str_numchildren, "-n\t Number of threads (default 1000)"},
+		{"w:", &str_writesize, "-w\t Size of writing blocks (default 1K)"},
+		{"s:", &str_filesize, "-s\t Size of file (default 100M)"},
+		{"o:", &str_offset, "-o\t File offset (default 0)"},
+		{},
 	},
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
