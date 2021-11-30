Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581B6C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 12:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E07173C8102
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 13:11:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98E1F3C7169
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 13:10:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0E6E21400989
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 13:10:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 818B6212C0;
 Tue, 30 Nov 2021 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638274245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVS4nSIxwytrRIuRPOEutCXpMjUfR5ztm+IfNj2VIug=;
 b=vROo+TdFPoYQnFz2ZN/qJ+KXyKDqI718JAlA9fG/fIzAQ0pO3EKLiw8uOYluz2V/SR8xwp
 xMwuv31d7e+FI5XzdjSEWgoPKBCFtPbmSN7wA4dgNJckCuXc7xcMM490QJ5fKTGJN5Vq/J
 iTL7XVHNVaivshSFQjnbxZHZgu882Yk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F92B13C98;
 Tue, 30 Nov 2021 12:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YPxcBcUUpmGTbAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 30 Nov 2021 12:10:45 +0000
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 13:10:22 +0100
Message-Id: <20211130121022.14296-3-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130121022.14296-1-andrea.cervesato@suse.com>
References: <20211130121022.14296-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Use common.h in dio_truncate test
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
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 48 ++-----------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 68c10ac7a..2eebf2891 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -31,36 +31,13 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include "tst_test.h"
+#include "common.h"
 
 #define NUM_CHILDREN 16
 #define FILE_SIZE (64 * 1024)
 
 static int *run_child;
 
-static char *check_zero(char *buf, int size)
-{
-	char *p;
-
-	p = buf;
-
-	while (size > 0) {
-		if (*buf != 0) {
-			tst_res(TINFO,
-				"non zero buffer at buf[%lu] => 0x%02x,%02x,%02x,%02x",
-				buf - p, (unsigned int)buf[0],
-				size > 1 ? (unsigned int)buf[1] : 0,
-				size > 2 ? (unsigned int)buf[2] : 0,
-				size > 3 ? (unsigned int)buf[3] : 0);
-			tst_res(TINFO, "buf %p, p %p", buf, p);
-			return buf;
-		}
-		buf++;
-		size--;
-	}
-
-	return 0;
-}
-
 static void dio_read(const char *filename, size_t bs)
 {
 	int fd;
@@ -98,24 +75,6 @@ static void dio_read(const char *filename, size_t bs)
 	SAFE_CLOSE(fd);
 }
 
-static void dio_append(const char *path, char pattern, size_t bs, size_t bcount)
-{
-	int fd;
-	size_t i;
-	char *bufptr;
-
-	bufptr = SAFE_MEMALIGN(getpagesize(), bs);
-	memset(bufptr, pattern, bs);
-
-	fd = SAFE_OPEN(path, O_CREAT | O_WRONLY | O_DIRECT, 0666);
-
-	for (i = 0; i < bcount; i++)
-		SAFE_WRITE(1, fd, bufptr, bs);
-
-	free(bufptr);
-	SAFE_CLOSE(fd);
-}
-
 static void setup(void)
 {
 	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
@@ -131,6 +90,7 @@ static void run(void)
 	char *filename = "file";
 	int filesize = FILE_SIZE;
 	int num_children = NUM_CHILDREN;
+	int wflags = O_DIRECT | O_WRONLY | O_CREAT;
 	int status;
 	int i;
 	int fail = 0;
@@ -147,9 +107,9 @@ static void run(void)
 	tst_res(TINFO, "parent writes/truncates the file");
 
 	for (i = 0; i < 100; i++) {
-		dio_append(filename, 0, filesize, 100);
+		io_append(filename, 0, wflags, filesize, 100);
 		SAFE_TRUNCATE(filename, 0);
-		dio_append("junkfile", 0xaa, filesize, 100);
+		io_append("junkfile", 0xaa, wflags, filesize, 100);
 		SAFE_TRUNCATE("junkfile", 0);
 
 		if (SAFE_WAITPID(-1, &status, WNOHANG)) {
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
