Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61974C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:40:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0569F3CAA00
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:40:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 842EE3CA9D8
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D862C1A010F3
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92B151F460;
 Thu, 12 May 2022 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6uHDTT2X6lcglYy9DCkHYprj/JAOsY4FrviplG3Ok1A=;
 b=PvrfvtSRclL70b6UUlME5fD9UzAP0j9j4D8c/T9ZYcjdyK/SsELpVUH3RzMwWUZxHYigG5
 Qt2zxAV4rtsTdJBZhhoRFFTNmarzm2bLKQteNGKeYdIRy+Q2VWzh9r5FRdoeKXW9OqQqVV
 65YDdR/IUpwByIDuio+HwjZ/72AFt7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6uHDTT2X6lcglYy9DCkHYprj/JAOsY4FrviplG3Ok1A=;
 b=k66AeSY0jr5yzyYMWxDYsp2frV7T3RQhvvZ24t7nOpZrgeJHIWOo3DSXwmtvzr/uDC9ik7
 QyCK52fjOvOikMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C01D13ABE;
 Thu, 12 May 2022 12:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TPEEHT7/fGJYGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:10 +0200
Message-Id: <20220512123816.24399-24-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 23/29] ltp-aiodio/dio_sparse,
 aiodio_sparse: Convert to runtime.
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
runtime allowed for the test.

For this to work we also have to:

- check the run_child in the io_read() in the inner loop otherwise the
  test will timeout while waiting for the children to finish

- run the AIO writer in a separate process and kill it when we are out
  of runtime in the aiodio_sparse

CC: Andrea Cervesato <andrea.cervesato@suse.de>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/io/ltp-aiodio/aiodio_sparse.c      | 26 ++++++++++++++++---
 testcases/kernel/io/ltp-aiodio/common.h       |  6 ++++-
 testcases/kernel/io/ltp-aiodio/dio_sparse.c   |  6 ++++-
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 2aa5662bb..d79933d9a 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -189,7 +189,7 @@ static void run(void)
 {
 	char *filename = "file.bin";
 	int status;
-	int i;
+	int i, pid;
 
 	*run_child = 1;
 
@@ -200,9 +200,27 @@ static void run(void)
 		}
 	}
 
-	tst_res(TINFO, "Parent create a sparse file");
+	pid = SAFE_FORK();
+	if (!pid) {
+		aiodio_sparse(filename, alignment, writesize, filesize, numaio);
+		return;
+	}
+
+	tst_res(TINFO, "Child %i creates a sparse file", pid);
+
+	for (;;) {
+		if (SAFE_WAITPID(pid, NULL, WNOHANG))
+			break;
 
-	aiodio_sparse(filename, alignment, writesize, filesize, numaio);
+		sleep(1);
+
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Test out of runtime, exitting");
+			kill(pid, SIGKILL);
+			SAFE_WAITPID(pid, NULL, 0);
+			break;
+		}
+	}
 
 	if (SAFE_WAITPID(-1, &status, WNOHANG))
 		tst_res(TFAIL, "Non zero bytes read");
@@ -229,7 +247,7 @@ static struct tst_test test = {
 		"tmpfs",
 		NULL
 	},
-	.timeout = 1800,
+	.max_runtime = 1800,
 };
 #else
 TST_TEST_TCONF("test requires libaio and its development packages");
diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index c27c3a0ad..0a242b91e 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -63,7 +63,7 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 
 	tst_res(TINFO, "child %i reading file", getpid());
 
-	while (*run_child) {
+	for (;;) {
 		off_t offset = 0;
 		char *bufoff;
 
@@ -80,9 +80,13 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 				}
 				offset += r;
 			}
+
+			if (!*run_child)
+				goto exit;
 		}
 	}
 
+exit:
 	SAFE_CLOSE(fd);
 }
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 0039daa8d..24cfc8f36 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -51,6 +51,10 @@ static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
 	SAFE_LSEEK(fd, off, SEEK_SET);
 
 	for (i = off; i < fs;) {
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Test runtime is over, exitting");
+			return;
+		}
 		w = SAFE_WRITE(0, fd, bufptr, ws);
 		i += w;
 	}
@@ -135,5 +139,5 @@ static struct tst_test test = {
 		"tmpfs",
 		NULL
 	},
-	.timeout = 1800,
+	.max_runtime = 1800,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
