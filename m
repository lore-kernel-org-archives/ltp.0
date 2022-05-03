Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735DC433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:49:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88B583CACC8
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:49:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 685BB3CA9A7
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D70221400535
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81F4521872;
 Tue,  3 May 2022 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrVukndCbOkeqmE2IJpoTqUwgj3/pN3CP79NeYW0w6A=;
 b=MMTi/PASaRuAWwiJmiU/rvGiOwQkcmQxrA84aQaIpZecgLaNFZ9J4SexcmVDuHDUBwCbib
 veVxbzPTgkESbkgs0Do0aVRdA7dgx66fCpeHLlc01MhwmIYJi+5GNaNlonEAll2LF9CgqI
 pC69EDvwMxNPuiNt831mZplfvviRaHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrVukndCbOkeqmE2IJpoTqUwgj3/pN3CP79NeYW0w6A=;
 b=qDHqi/uzhyC0BAGYbcjO3ZUmhLbelAkH1h9L/jHMRvv9H8wJXZxYqYDUmkWbA1GtSmma2J
 gflgqcm2rqeBLjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B63F13ABE;
 Tue,  3 May 2022 17:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gQxOGSxqcWInPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:14 +0200
Message-Id: <20220503174718.21205-27-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 26/30] ltp-aiodio/dio_{truncate,
 append}: Convert to runtime
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Change the code so that the test runtime is capped at the maximal
runtime allowed for the test, which is set to 30 minutes by default.

The io_append() in common.h has to check for runtime to make this work.

CC: Andrea Cervesato <andrea.cervesato@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/common.h       | 6 +++++-
 testcases/kernel/io/ltp-aiodio/dio_append.c   | 4 ++++
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index 0a242b91e..d9cbd8611 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -44,9 +44,13 @@ static inline void io_append(const char *path, char pattern, int flags, size_t b
 
 	fd = SAFE_OPEN(path, flags, 0666);
 
-	for (i = 0; i < bcount; i++)
+	for (i = 0; i < bcount; i++) {
 		SAFE_WRITE(1, fd, bufptr, bs);
 
+		if (!tst_remaining_runtime())
+			break;
+	}
+
 	free(bufptr);
 	SAFE_CLOSE(fd);
 }
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index c099793f6..3a950f3c6 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -71,6 +71,9 @@ static void run(void)
 
 	io_append(filename, 0, O_DIRECT | O_WRONLY | O_CREAT, writesize, appends);
 
+	if (!tst_remaining_runtime())
+		tst_res(TINFO, "Test out of runtime, exitting");
+
 	if (SAFE_WAITPID(-1, &status, WNOHANG))
 		tst_res(TFAIL, "Non zero bytes read");
 	else
@@ -87,6 +90,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.max_iteration_runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of processes (default 16)"},
 		{"w:", &str_writesize, "Write size for each append (default 64K)"},
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 1fbf83de0..b04302a7b 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -142,6 +142,11 @@ static void run(void)
 			fail = 1;
 			break;
 		}
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Test out of runtime, exitting");
+			break;
+		}
 	}
 
 	if (fail)
@@ -158,6 +163,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.max_iteration_runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"s:", &str_filesize, "Size of file (default 64K)"},
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
