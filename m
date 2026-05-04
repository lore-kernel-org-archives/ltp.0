Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A86FFF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 08:07:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 895903E2C6F
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:07:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 527C13E499A
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:06:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D9CBD200743
 for <ltp@lists.linux.it>; Mon,  4 May 2026 10:06:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 106836A94C;
 Mon,  4 May 2026 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqkBW6GXA1W6WtB7W9wd8leXV/nI1Hn1E6Dv9t/QJBE=;
 b=S7tvr4jzssGgW88E88Qj1xbEjG1g536cSJVrCtCD/wOQuVSSCHGGhj4zpeGFXZHyyAchlC
 xjDqUUA19RXuAzwOgp4Q0fEkHjLEGWtm5jPuq2L9WOOnh9wOgPUYros7g6H0dwlPisoh5w
 miNc4ic1jJaiKpOrLmD2SblrcAqY0d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqkBW6GXA1W6WtB7W9wd8leXV/nI1Hn1E6Dv9t/QJBE=;
 b=IiaHERk5y6H2UVSAau+6QpaP8QH1aGg3bczA69gcOwZUbYb1Aw9urvJtlGoKIBezSXO5yM
 RdEZ0Xwx+eCDU9DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S7tvr4jz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IiaHERk5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777882001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqkBW6GXA1W6WtB7W9wd8leXV/nI1Hn1E6Dv9t/QJBE=;
 b=S7tvr4jzssGgW88E88Qj1xbEjG1g536cSJVrCtCD/wOQuVSSCHGGhj4zpeGFXZHyyAchlC
 xjDqUUA19RXuAzwOgp4Q0fEkHjLEGWtm5jPuq2L9WOOnh9wOgPUYros7g6H0dwlPisoh5w
 miNc4ic1jJaiKpOrLmD2SblrcAqY0d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777882001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqkBW6GXA1W6WtB7W9wd8leXV/nI1Hn1E6Dv9t/QJBE=;
 b=IiaHERk5y6H2UVSAau+6QpaP8QH1aGg3bczA69gcOwZUbYb1Aw9urvJtlGoKIBezSXO5yM
 RdEZ0Xwx+eCDU9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC30C593A6;
 Mon,  4 May 2026 08:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aB4tOJBT+GktTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 08:06:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 10:04:54 +0200
MIME-Version: 1.0
Message-Id: <20260504-safe_splice-v2-1-aa7eaa6b5ed7@suse.com>
References: <20260504-safe_splice-v2-0-aa7eaa6b5ed7@suse.com>
In-Reply-To: <20260504-safe_splice-v2-0-aa7eaa6b5ed7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777882000; l=4835;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ScscZW9jT+X8ndZi9P/s5HcJfWUD/Qt2mAKOTu7vl+4=;
 b=3sGY2cFHy40B8L+rD5OQU3Hu3KAbRGyD1Z1SQ6t910EOPS27siHExeUydrSIeRiA/dLEXWzx8
 Cy3au7VGv3xBKQOFQ6c51YTA7I5jJeHZixUvfnNRQbJ1WPzqiStYyqS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 106836A94C
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: Add SAFE_SPLICE() macro
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add new SAFE_SPLIT() in lapi/splice.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/splice.h                           | 28 +++++++++++++++++++++++++
 testcases/kernel/crypto/af_alg08.c              | 10 ++-------
 testcases/kernel/syscalls/tee/tee01.c           |  9 ++------
 testcases/kernel/syscalls/vmsplice/vmsplice01.c |  6 +-----
 4 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index 191b22d2d6397d1efad5e2025be5a2c4370724dc..e346e5cca9f44bd8421c6b99f84cd4646269ac1f 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -7,6 +7,13 @@
 #ifndef LAPI_SPLICE_H__
 #define LAPI_SPLICE_H__
 
+#ifndef _GNU_SOURCE
+# define _GNU_SOURCE
+#endif
+
+#include <fcntl.h>
+#include <sys/types.h>
+
 #include "config.h"
 #include "lapi/syscalls.h"
 
@@ -19,4 +26,25 @@ static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
 }
 #endif
 
+static inline ssize_t safe_splice(const char *file, const int lineno,
+				   int fd_in, loff_t *off_in,
+				   int fd_out, loff_t *off_out,
+				   size_t len, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = splice(fd_in, off_in, fd_out, off_out, len, flags);
+
+	if (ret < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"splice(%d, %d, %zu) failed", fd_in, fd_out, len);
+	}
+
+	return ret;
+}
+
+#define SAFE_SPLICE(fd_in, off_in, fd_out, off_out, len, flags) \
+	safe_splice(__FILE__, __LINE__, (fd_in), (off_in), (fd_out), \
+		    (off_out), (len), (flags))
+
 #endif /* LAPI_SPLICE_H__ */
diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 4f27f3c9da7cc277926c6fe3eee1a4649a483763..05f17eea4797b7575c97e194e34c0390c6d6be22 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -27,7 +27,6 @@
 #include "tst_test.h"
 #include "tst_af_alg.h"
 #include "lapi/socket.h"
-#include "lapi/splice.h"
 
 #define TESTFILE "copy_fail"
 #define OVERWRITE_SIZE 4
@@ -92,13 +91,8 @@ static void try_corrupt(void)
 
 	SAFE_PIPE(pipefd);
 
-	TEST(splice(file_fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "splice(file -> pipe)");
-
-	TEST(splice(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0));
-	if (TST_RET < 0)
-		tst_brk(TBROK | TTERRNO, "splice(pipe -> AF_ALG)");
+	SAFE_SPLICE(file_fd, &off_in, pipefd[1], NULL, OVERWRITE_SIZE, 0);
+	SAFE_SPLICE(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0);
 
 	/* Expected to fail (invalid ciphertext); triggers the scratch write */
 	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index d1489d0453f11faab41ab6e8e2dabbb372566f60..680793eb2b21cfd2609492d3be3bef10abb25acf 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -15,7 +15,6 @@
 #include "tst_test.h"
 #include "lapi/fcntl.h"
 #include "lapi/tee.h"
-#include "lapi/splice.h"
 
 #define TEST_BLOCK_SIZE 1024
 
@@ -58,17 +57,13 @@ static void tee_test(void)
 	SAFE_PIPE(pipe1);
 	SAFE_PIPE(pipe2);
 
-	ret = splice(fd_in, NULL, pipe1[1], NULL, TEST_BLOCK_SIZE, 0);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe1) failed");
+	SAFE_SPLICE(fd_in, NULL, pipe1[1], NULL, TEST_BLOCK_SIZE, 0);
 
 	ret = tee(pipe1[0], pipe2[1], TEST_BLOCK_SIZE, SPLICE_F_NONBLOCK);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "tee() failed");
 
-	ret = splice(pipe2[0], NULL, fd_out, NULL, TEST_BLOCK_SIZE, 0);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "splice(pipe2, fd_out) failed");
+	SAFE_SPLICE(pipe2[0], NULL, fd_out, NULL, TEST_BLOCK_SIZE, 0);
 
 	SAFE_CLOSE(pipe2[0]);
 	SAFE_CLOSE(pipe2[1]);
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 17486179baa2a897c2efbf0d2b4d39273788aadc..7b55e66a373d2d72824fbb9146b2af353a5ff1c9 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -15,7 +15,6 @@
 
 #include "tst_test.h"
 #include "lapi/fcntl.h"
-#include "lapi/splice.h"
 #include "lapi/vmsplice.h"
 
 #define TEST_BLOCK_SIZE (1<<17)	/* 128K */
@@ -50,7 +49,6 @@ static void vmsplice_test(void)
 {
 	int pipes[2];
 	long written;
-	int ret;
 	int fd_out;
 	struct iovec v;
 	loff_t offset;
@@ -85,9 +83,7 @@ static void vmsplice_test(void)
 			}
 		}
 
-		ret = splice(pipes[0], NULL, fd_out, &offset, written, 0);
-		if (ret < 0)
-			tst_brk(TBROK | TERRNO, "splice() failed");
+		SAFE_SPLICE(pipes[0], NULL, fd_out, &offset, written, 0);
 		//printf("offset = %lld\n", (long long)offset);
 	}
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
