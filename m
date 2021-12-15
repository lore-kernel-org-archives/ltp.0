Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09453C433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:51:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74EE3C8F8D
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 11:51:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 449443C2BBF
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 11:51:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B6B201001343
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 11:51:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 077B4212C5;
 Wed, 15 Dec 2021 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639565463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KPPiBc4hjj/6u7zRUi+qxN8v5KxNUsEwfdM5TQaDXac=;
 b=NEiUh85VOujaWNe2Tlw8kHEwou4mAoFrBqLqVSgMaH6KfWGQo1whdi1ogypaFA22alYfOw
 TqvUoq/jKSREGSWY1LvBrWR8iyo/i1Y24S5nMyx8fC+zNu3M13H+Dw7oUutQYuLltkL97F
 BOT4aNXz5nCOrlVHVOSjOoE/sA3jLMM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA6FF13B1C;
 Wed, 15 Dec 2021 10:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5QHII5bIuWFAfQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Wed, 15 Dec 2021 10:51:02 +0000
To: ltp@lists.linux.it
Date: Wed, 15 Dec 2021 11:51:00 +0100
Message-Id: <20211215105100.7292-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add options to dio_truncate.c test
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

Added options are the following:
-n number of children to spawn
-s file size
-a number of appends
-c number of append & truncate

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 67 ++++++++++++++-----
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 2eebf2891..ac011231f 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -33,22 +33,30 @@
 #include "tst_test.h"
 #include "common.h"
 
-#define NUM_CHILDREN 16
-#define FILE_SIZE (64 * 1024)
-
 static int *run_child;
 
-static void dio_read(const char *filename, size_t bs)
+static char *str_numchildren;
+static char *str_filesize;
+static char *str_numappends;
+static char *str_numwrites;
+
+static int numchildren;
+static long long filesize;
+static long long alignment;
+static int numappends;
+static int numwrites;
+
+static void dio_read(const char *filename, long long align, size_t bs)
 {
 	int fd;
 	int r;
 	char *bufptr;
 
-	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
-
 	while ((fd = open(filename, O_RDONLY | O_DIRECT, 0666)) < 0)
 		usleep(100);
 
+	bufptr = SAFE_MEMALIGN(align, bs);
+
 	tst_res(TINFO, "child %i reading file", getpid());
 	while (*run_child) {
 		off_t offset;
@@ -77,19 +85,41 @@ static void dio_read(const char *filename, size_t bs)
 
 static void setup(void)
 {
+	struct stat sb;
+
+	numchildren = 16;
+	filesize = 64 * 1024;
+	numappends = 100;
+	numwrites = 100;
+	alignment = 512;
+
+	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
+
+	if (tst_parse_filesize(str_filesize, &filesize, 1, LLONG_MAX))
+		tst_brk(TBROK, "Invalid file size '%s'", str_filesize);
+
+	if (tst_parse_int(str_numappends, &numappends, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of appends '%s'", str_numappends);
+
+	if (tst_parse_int(str_numwrites, &numwrites, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid number of truncate/append '%s'", str_numwrites);
+
+	SAFE_STAT(".", &sb);
+	alignment = sb.st_blksize;
+
 	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 }
 
 static void cleanup(void)
 {
+	*run_child = 0;
 	SAFE_MUNMAP(run_child, sizeof(int));
 }
 
 static void run(void)
 {
-	char *filename = "file";
-	int filesize = FILE_SIZE;
-	int num_children = NUM_CHILDREN;
+	char *filename = "file.bin";
 	int wflags = O_DIRECT | O_WRONLY | O_CREAT;
 	int status;
 	int i;
@@ -97,19 +127,19 @@ static void run(void)
 
 	*run_child = 1;
 
-	for (i = 0; i < num_children; i++) {
+	for (i = 0; i < numchildren; i++) {
 		if (!SAFE_FORK()) {
-			dio_read(filename, filesize);
+			dio_read(filename, alignment, filesize);
 			return;
 		}
 	}
 
-	tst_res(TINFO, "parent writes/truncates the file");
+	tst_res(TINFO, "Parent writes/truncates the file");
 
-	for (i = 0; i < 100; i++) {
-		io_append(filename, 0, wflags, filesize, 100);
+	for (i = 0; i < numwrites; i++) {
+		io_append(filename, 0, wflags, filesize, numappends);
 		SAFE_TRUNCATE(filename, 0);
-		io_append("junkfile", 0xaa, wflags, filesize, 100);
+		io_append("junkfile", 0xaa, wflags, filesize, numappends);
 		SAFE_TRUNCATE("junkfile", 0);
 
 		if (SAFE_WAITPID(-1, &status, WNOHANG)) {
@@ -132,4 +162,11 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.options = (struct tst_option[]) {
+		{"n:", &str_numchildren, "Number of threads (default 16)"},
+		{"s:", &str_filesize, "Size of file (default 64K)"},
+		{"a:", &str_numappends, "Number of appends (default 100)"},
+		{"c:", &str_numwrites, "Number of append & truncate (default 100)"},
+		{}
+	},
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
