Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C65C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 12:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D5833CA1E0
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 13:44:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52ED53C0512
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 13:44:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56C15200D34
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 13:44:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29D2B1F39A;
 Tue, 22 Feb 2022 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645533851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mzEcgeyv4J9B4seIgFxHcBSDDy7pmprDMcKq2AADXAA=;
 b=3Vrlh5G1r+t4cq3yPtMrJlQpjql6WRog718VHpzd1bI7QYwHYbzpAoiHyg9LnF8ji8bJ0T
 08GKI4k8g97m1AWpGp5PqMmnFdA2kWS5j8HwZGMEKV8E3o4pHjPHOHPwbYKqnbP3LM6OGQ
 7F9C/K0CAeNYADDFNyFoVr8Qa8IDYP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645533851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mzEcgeyv4J9B4seIgFxHcBSDDy7pmprDMcKq2AADXAA=;
 b=c0y0ZEu3P3c3rPYRycP6igX1X3eFfMJUeUsDDiHcdZnF9P8e/BuZl411yIsVztZxXGw7tc
 aVrbq0ZUT2BqlsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1372513C1E;
 Tue, 22 Feb 2022 12:44:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3VJ3A5vaFGLvRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Feb 2022 12:44:11 +0000
Date: Tue, 22 Feb 2022 13:46:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YhTbHxQMmeuse/Wf@yuki>
References: <20220201091938.23362-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220201091938.23362-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactoring aiodio_sparse.c using LTP API
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
Pushed with a few changes, thanks.

I've mainly added a few elements to the tst_test structure to match the
fixes we did for dio_sparse.c and also removed a few obvious comments.


diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 33a25a28c..2aa5662bb 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -35,10 +35,10 @@ static char *str_writesize;
 static char *str_filesize;
 static char *str_numaio;
 
-static int numchildren = 1000;
+static int numchildren = 16;
 static long long writesize = 1024;
 static long long filesize = 100 * 1024 * 1024;
-static long long alignment = 512;
+static long long alignment;
 static int numaio = 16;
 
 static void check_event(struct io_event event)
@@ -76,9 +76,6 @@ static void aiodio_sparse(char *filename, long long align, long long ws,
 	for (i = 0; i < naio; i++)
 		iocbs[i] = iocb + i;
 
-	/*
-	 * allocate the iocbs array and iocbs with buffers
-	 */
 	offset = 0;
 	for (i = 0; i < naio; i++) {
 		void *bufptr;
@@ -89,16 +86,10 @@ static void aiodio_sparse(char *filename, long long align, long long ws,
 		offset += ws;
 	}
 
-	/*
-	 * start the 1st naio write requests
-	 */
 	w = io_submit(myctx, naio, iocbs);
 	if (w < 0)
 		tst_brk(TBROK, "io_submit: %s", tst_strerrno(-w));
 
-	/*
-	 * As AIO requests finish, keep issuing more AIO until done.
-	 */
 	aio_inflight = naio;
 
 	while (offset < fs) {
@@ -129,9 +120,6 @@ static void aiodio_sparse(char *filename, long long align, long long ws,
 		aio_inflight++;
 	}
 
-	/*
-	 * wait for AIO requests in flight.
-	 */
 	while (aio_inflight > 0) {
 		int n;
 
@@ -175,8 +163,7 @@ static void setup(void)
 	if ((numaio * writesize) > filesize) {
 		numaio = filesize / writesize;
 		tst_res(TINFO,
-			"Numbers of AIO have been reduced to %d so we fit "
-			"filesize",
+			"Numbers of AIO have been reduced to %d so we fit filesize",
 			numaio);
 	}
 
@@ -192,8 +179,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	*run_child = 0;
-	SAFE_MUNMAP(run_child, sizeof(int));
+	if (run_child) {
+		*run_child = 0;
+		SAFE_MUNMAP(run_child, sizeof(int));
+	}
 }
 
 static void run(void)
@@ -230,12 +219,17 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &str_numchildren, "Number of threads (default 1000)"},
+		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
 		{"s:", &str_filesize, "Size of file (default 100M)"},
 		{"o:", &str_numaio, "Number of AIO control blocks (default 16)"},
 		{},
 	},
+	.skip_filesystems = (const char *[]) {
+		"tmpfs",
+		NULL
+	},
+	.timeout = 1800,
 };
 #else
 TST_TEST_TCONF("test requires libaio and its development packages");

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
