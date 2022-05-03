Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9770C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:49:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 604EF3CACFD
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:49:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018263CA998
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9B1F0600739
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5815B210F4;
 Tue,  3 May 2022 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvzm7F5PerFcyr8liLtMYZDBSU+rTv7Z/fdBgnlR9Og=;
 b=YkJY479m9vLxsC5MnhjZ7JK/ctvnXSLtYf+oSm22PVcOxu+Rn9DsTMsw09dQiEeCIvjyUH
 lQnZI3zeTdiWk7vixT/2FanyZhjCPnUgTMUy4z5cMc48rkpvnIh0E3swuoViiAxZNLuAep
 TVLj8Z/AVM3qZbOamLj7jwwjMth4sX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvzm7F5PerFcyr8liLtMYZDBSU+rTv7Z/fdBgnlR9Og=;
 b=JVusruUZ/vDjx7de7Dw88Qr9Kxfh8w/g/bErYxXKtW+pbzs5IS5XoWIQTD7qzAY7Y1gTd8
 XbaUynlJZqZjzjBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45ECD13ABE;
 Tue,  3 May 2022 17:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tDroDytqcWIhPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:12 +0200
Message-Id: <20220503174718.21205-25-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 24/30] ltp-aiodio/dio_sparse,
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
index 2aa5662bb..d3c27646c 100644
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
+	.max_iteration_runtime = 1800,
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
index 0039daa8d..dac034158 100644
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
+	.max_iteration_runtime = 1800,
 };
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
