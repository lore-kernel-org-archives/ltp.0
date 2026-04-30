Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE4CD13D3
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB35B3E6C90
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 19:26:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC40A3E6CA4
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 19:25:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77991601403
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 19:25:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D37946A7DA;
 Thu, 30 Apr 2026 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777569930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se1LAEMQtEzNUPgG/AkcKNaW30iUlOUHrWY4GfiM/qk=;
 b=U65SXpYbI2dhPDuQsPDJN02u+LfRWIzAUObwe0YZYLvIBYpFZ46WL+AwZWjHRLt4BqI8gQ
 FmqqNRAYbS8Cr2ez8Fg6tLhYdImV4fXRQxkKXLbVL2Ju1wK3m7DnG0eR7vAd80ll86Vusv
 Fj+WQ8cjdiwjrTWL90J34bi42VU+bpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777569930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se1LAEMQtEzNUPgG/AkcKNaW30iUlOUHrWY4GfiM/qk=;
 b=FGMs12Zj19gTRJzLc8/dYzVFc+ckMJasUxKRPerd0+h0otA9McxRGH2ona5bp9ejuQOP+m
 HPlLOfZWMZ9j14Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777569930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se1LAEMQtEzNUPgG/AkcKNaW30iUlOUHrWY4GfiM/qk=;
 b=U65SXpYbI2dhPDuQsPDJN02u+LfRWIzAUObwe0YZYLvIBYpFZ46WL+AwZWjHRLt4BqI8gQ
 FmqqNRAYbS8Cr2ez8Fg6tLhYdImV4fXRQxkKXLbVL2Ju1wK3m7DnG0eR7vAd80ll86Vusv
 Fj+WQ8cjdiwjrTWL90J34bi42VU+bpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777569930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=se1LAEMQtEzNUPgG/AkcKNaW30iUlOUHrWY4GfiM/qk=;
 b=FGMs12Zj19gTRJzLc8/dYzVFc+ckMJasUxKRPerd0+h0otA9McxRGH2ona5bp9ejuQOP+m
 HPlLOfZWMZ9j14Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BADB4593B2;
 Thu, 30 Apr 2026 17:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wHXuK4qQ82kMIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Apr 2026 17:25:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 19:25:30 +0200
MIME-Version: 1.0
Message-Id: <20260430-safe_splice-v1-2-d1d919ff2a3a@suse.com>
References: <20260430-safe_splice-v1-0-d1d919ff2a3a@suse.com>
In-Reply-To: <20260430-safe_splice-v1-0-d1d919ff2a3a@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777569930; l=3692;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uDWFnnpZAVx7JYgujAotBUSjSCUQoumbX4pmce/tR0E=;
 b=GReNfeB3RDL1uMY3RDczhPMIuxXUILf+P7OnlJf1gIYCtNSoM1CcBIBDoKWcDI1ENOtmCkPxt
 klgDh8C1AXpDtvcTsql5QFcNXx52hj1w74mlCe4BNe85vc4M22Sekbt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tee01, vmsplice01, af_alg08: Use SAFE_SPLICE()
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

Replace raw splice() calls with manual error checking by
SAFE_SPLICE() in tests where splice is not the subject of
testing but just utility plumbing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/crypto/af_alg08.c              | 10 ++--------
 testcases/kernel/syscalls/tee/tee01.c           |  9 ++-------
 testcases/kernel/syscalls/vmsplice/vmsplice01.c |  6 +-----
 3 files changed, 5 insertions(+), 20 deletions(-)

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
