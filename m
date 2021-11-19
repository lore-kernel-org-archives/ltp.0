Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57BCC433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 12:27:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB57161A8C
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB57161A8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19C2C3C89AB
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 13:27:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CA593C2E5C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 13:27:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBF4A6006ED
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 13:27:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 013451FD38;
 Fri, 19 Nov 2021 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637324850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqz66Fl2TurnYexG5SRI2wjeRn1iets49JhT/5tIHdw=;
 b=2LszXyPBvm9AZ2grVsvbbOkEkgFk0OXsLJ+ImzBR3ElC05t2arc+UCFnB6h3h9gqF7oe8k
 BuLlIHsXcUCQt5R4Ytwv+M45Cz5ZIZKovZL5BN85t4exG6lhmECoqwm9JMpx725K9o8wkJ
 nS34P1rBbdOrdsypgQMx7kmi7+xxItY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637324850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqz66Fl2TurnYexG5SRI2wjeRn1iets49JhT/5tIHdw=;
 b=kMEh6ACJdI1aNZPfMRpY3A5QItNswSOqFFfB4h1zyG7lHJ+5epi4nWW3Oi/wd1l5Wu/1XJ
 mWIXC4M14AHgLCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A825F13B2A;
 Fri, 19 Nov 2021 12:27:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zFuuJzGYl2HfSAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 12:27:29 +0000
Date: Fri, 19 Nov 2021 13:28:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <acervesato@suse.de>
Message-ID: <YZeYc1dgffw8em7j@yuki>
References: <20211119104130.26480-1-acervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211119104130.26480-1-acervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] dio_truncate.c test refactory with LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with minor changes, thanks.

Apart from simple formatting fixes the most complicated change was
removal of the loop that waits the children at the end of the run().
Since if any of the children returns prematurely the waitpid() for the
pid will fail and the test will exit with TBROK. The easiest solution
was simply to remove the loop since the children exit with 0 now the
library will collect them for us just fine.

Full diff:

diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 3681c9bdb..68c10ac7a 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -10,13 +10,17 @@
  *
  * This test is mixing direct I/O and truncate operations checking if they can
  * be used together at the same time. Multiple children are spawned to read a
- * file that is edited using DIO write/read operations. Algorithm:
+ * file that is written to using direct I/O and truncated in a loop.
+ *
+ * [Algorithm]
+ *
  * - Spawn multiple children which start to read on 'file'
  * - Parent start to fill and truncate 'file' many times with zero char when
  *   children are reading
  * - Parent start to fill and truncate a junk file many times with non-zero char
+ *
  * If no issues occur on direct IO/truncate operations and the file always
- * contains non-zero characters, test PASS. Otherwise, test will FAIL.
+ * contains zero characters, test PASS. Otherwise, test will FAIL.
  */
 
 #define _GNU_SOURCE
@@ -53,7 +57,8 @@ static char *check_zero(char *buf, int size)
 		buf++;
 		size--;
 	}
-	return 0; /* all zeros */
+
+	return 0;
 }
 
 static void dio_read(const char *filename, size_t bs)
@@ -67,19 +72,19 @@ static void dio_read(const char *filename, size_t bs)
 	while ((fd = open(filename, O_RDONLY | O_DIRECT, 0666)) < 0)
 		usleep(100);
 
-	tst_res(TINFO, "child reading file");
+	tst_res(TINFO, "child %i reading file", getpid());
 	while (*run_child) {
 		off_t offset;
 		char *bufoff;
 
-		/* read the file, checking for zeros */
 		offset = SAFE_LSEEK(fd, SEEK_SET, 0);
 		do {
 			r = read(fd, bufptr, 64 * 1024);
 			if (r > 0) {
 				bufoff = check_zero(bufptr, r);
 				if (bufoff) {
-					tst_res(TINFO, "non-zero read at offset %p", offset + bufoff);
+					tst_res(TINFO, "non-zero read at offset %zu",
+						offset + (bufoff - bufptr));
 					free(bufptr);
 					SAFE_CLOSE(fd);
 					return;
@@ -91,8 +96,6 @@ static void dio_read(const char *filename, size_t bs)
 
 	free(bufptr);
 	SAFE_CLOSE(fd);
-
-	tst_res(TPASS, "zero buffer only after truncate");
 }
 
 static void dio_append(const char *path, char pattern, size_t bs, size_t bcount)
@@ -128,7 +131,6 @@ static void run(void)
 	char *filename = "file";
 	int filesize = FILE_SIZE;
 	int num_children = NUM_CHILDREN;
-	int pid[NUM_CHILDREN];
 	int status;
 	int i;
 	int fail = 0;
@@ -136,13 +138,14 @@ static void run(void)
 	*run_child = 1;
 
 	for (i = 0; i < num_children; i++) {
-		pid[i] = SAFE_FORK();
-		if (pid[i] == 0) {
+		if (!SAFE_FORK()) {
 			dio_read(filename, filesize);
 			return;
 		}
 	}
 
+	tst_res(TINFO, "parent writes/truncates the file");
+
 	for (i = 0; i < 100; i++) {
 		dio_append(filename, 0, filesize, 100);
 		SAFE_TRUNCATE(filename, 0);
@@ -161,9 +164,6 @@ static void run(void)
 		tst_res(TPASS, "All bytes read were zeroed");
 
 	*run_child = 0;
-
-	for (i = 0; i < num_children; i++)
-		SAFE_WAITPID(pid[i], &status, 0);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
