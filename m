Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCA1FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:52:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5421D3E4986
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:52:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BF373E6202
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:51:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89D2F60035F
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:51:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DF415C22A;
 Mon,  4 May 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777888265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SpRQ4qpNPy0kvh3ohCifi35j0wJQC/8cs2SjjAhawg=;
 b=MeXenIqzK8ZUn0wcPMHECGl6jg1KpRYqo+//XrGZmd5gA6XVwSJ/WadzdBH1nKtUkVOKbZ
 POkgPgNzsvS6X3u2e1Pc+KJxmkiKuMOZoVhdhbzmcTsn4z3YPvFFU0hFp8iwWY3rlhLnNB
 SRfmJUnsX/c6G+xkAlxn8SfjyU9o9UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777888265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SpRQ4qpNPy0kvh3ohCifi35j0wJQC/8cs2SjjAhawg=;
 b=ZOPx902mMo1KF+rOupmPabwWf0ntCqKzcWCF+JKY1fa9dzUER98S4OubZIV9fL8fcD0qkh
 6nujwSCf/vVFyNAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777888265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SpRQ4qpNPy0kvh3ohCifi35j0wJQC/8cs2SjjAhawg=;
 b=MeXenIqzK8ZUn0wcPMHECGl6jg1KpRYqo+//XrGZmd5gA6XVwSJ/WadzdBH1nKtUkVOKbZ
 POkgPgNzsvS6X3u2e1Pc+KJxmkiKuMOZoVhdhbzmcTsn4z3YPvFFU0hFp8iwWY3rlhLnNB
 SRfmJUnsX/c6G+xkAlxn8SfjyU9o9UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777888265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SpRQ4qpNPy0kvh3ohCifi35j0wJQC/8cs2SjjAhawg=;
 b=ZOPx902mMo1KF+rOupmPabwWf0ntCqKzcWCF+JKY1fa9dzUER98S4OubZIV9fL8fcD0qkh
 6nujwSCf/vVFyNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EC18593A7;
 Mon,  4 May 2026 09:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KDrgHAls+GkOOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 09:51:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 11:51:01 +0200
MIME-Version: 1.0
Message-Id: <20260504-safe_splice-v3-2-e5acf4c9193b@suse.com>
References: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
In-Reply-To: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888265; l=3135;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QyWpNceZhIXG0vSHJXxO1KOLkeq+codbGWmzquD+9Mg=;
 b=/1gbtpXeZf0Id91ObC/op51j9PNjsSJzGnNM/ZkU4HWBmmXNUj5wMQbp03ke5GxpXcJr+ZrDa
 uGngEsI3SyfBX1I4aCMV7Od2KVdwrpQ2aRCJFO1AT/LrFQkgN2HKZp4
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] tee01, vmsplice01, af_alg08: Use SAFE_SPLICE()
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

Replace raw splice() calls with SAFE_SPLICE() in tests where splice is
utility plumbing, not the subject of testing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/crypto/af_alg08.c              | 9 ++-------
 testcases/kernel/syscalls/tee/tee01.c           | 8 ++------
 testcases/kernel/syscalls/vmsplice/vmsplice01.c | 5 +----
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 7b95984448bdc5afd3b995a98c3d81ef12e37067..5e04b579c1db464fc5b4f33fd4e13a29709bba79 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -96,13 +96,8 @@ static void try_corrupt(void)
 
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
index d1489d0453f11faab41ab6e8e2dabbb372566f60..436c52a201689e4ffa97f217fd3b1d14e6b6ec36 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -58,17 +58,13 @@ static void tee_test(void)
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
index 17486179baa2a897c2efbf0d2b4d39273788aadc..64eed8391797fb01b14c548ebcfe390a403da5ec 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -50,7 +50,6 @@ static void vmsplice_test(void)
 {
 	int pipes[2];
 	long written;
-	int ret;
 	int fd_out;
 	struct iovec v;
 	loff_t offset;
@@ -85,9 +84,7 @@ static void vmsplice_test(void)
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
