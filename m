Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B69C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 10:51:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 692EA3C9670
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 11:50:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D2BA3C2DD2
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 11:50:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A17C1400526
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 11:50:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 568A41F3B5;
 Tue, 18 Jan 2022 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642503047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8G5chwlZ2KDyc9zfexHOuyCWONjwYtr6Bc2lRsCmYrk=;
 b=bW+cXSq1JACSgwnN3C8ls/TAKX8KQxYcO6eg05bpNLAdxbwou46JzPWe1t/NH+oF6lzkZ0
 tL11jeT5CFjZkYCzidY2xOECIEY41jAASz6k7XjdmmM3NmQUFSmEpdFUb1tbN6HclJsvVw
 N9SPO39B0jEOic9+ZegCEqb5Ksb/tBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642503047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8G5chwlZ2KDyc9zfexHOuyCWONjwYtr6Bc2lRsCmYrk=;
 b=JIWjNn204IHc6jf+7ZP+7HAW3RDqygYD4Tein6xeAXtzqGOAT1S0p/RReGh7lj53SXKetN
 lfdcbtHOO//kKTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25ED113DC7;
 Tue, 18 Jan 2022 10:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lTKsBoeb5mFgOAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 18 Jan 2022 10:50:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 18 Jan 2022 11:50:44 +0100
Message-Id: <20220118105044.547-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Reduce default number of threads in dio_sparse.c
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

Initialized options out of setup and reduced default number of
threads from 1000 to 16

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 testcases/kernel/io/ltp-aiodio/dio_sparse.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 929adbfba..8635df82f 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -33,11 +33,11 @@ static char *str_writesize;
 static char *str_filesize;
 static char *str_offset;
 
-static int numchildren;
-static long long writesize;
-static long long filesize;
-static long long offset;
-static long long alignment;
+static int numchildren = 16;
+static long long writesize = 1024;
+static long long filesize = 100 * 1024 * 1024;
+static long long offset = 0;
+static long long alignment = 512;
 
 static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
 {
@@ -60,12 +60,6 @@ static void setup(void)
 {
 	struct stat sb;
 
-	numchildren = 1000;
-	writesize = 1024;
-	filesize = 100 * 1024 * 1024;
-	offset = 0;
-	alignment = 512;
-
 	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
 
@@ -129,7 +123,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &str_numchildren, "Number of threads (default 1000)"},
+		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
 		{"s:", &str_filesize, "Size of file (default 100M)"},
 		{"o:", &str_offset, "File offset (default 0)"},
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
