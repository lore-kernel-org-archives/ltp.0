Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87540C28B28
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07F543CA4EA
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 10:17:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82EBD3CA504
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:16:01 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22DE4200906
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:16:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 969F021192;
 Thu, 13 Mar 2025 09:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741857350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ4QVP/d6B9J8K0gaSqCwmZBUVwxf/LJ5wmSzLjnt2M=;
 b=I/IB7iTrjebz26PJIC6TKkNSgMDdTrA1ZI5UpzfzLVBF6SB6tiQCJVpmcPMIJURkeDJWA/
 plhyhPtWDVPc4m1J5Toy1x1H8acMDPa7+pPcf3oZLMI2XiujdLZqT3xufnjm2m74Z2akrb
 DgKpU93wJoJXM8fh+fZn31B1DNN9RNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741857350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ4QVP/d6B9J8K0gaSqCwmZBUVwxf/LJ5wmSzLjnt2M=;
 b=p3GKDEW4N3RcR4nV+CFqJApc4c7GBrM04StCdv+it6R2p8JFpAIU+76DpODcQPoDqgQyN+
 lzMSp7CR+sjhelCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741857350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ4QVP/d6B9J8K0gaSqCwmZBUVwxf/LJ5wmSzLjnt2M=;
 b=I/IB7iTrjebz26PJIC6TKkNSgMDdTrA1ZI5UpzfzLVBF6SB6tiQCJVpmcPMIJURkeDJWA/
 plhyhPtWDVPc4m1J5Toy1x1H8acMDPa7+pPcf3oZLMI2XiujdLZqT3xufnjm2m74Z2akrb
 DgKpU93wJoJXM8fh+fZn31B1DNN9RNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741857350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ4QVP/d6B9J8K0gaSqCwmZBUVwxf/LJ5wmSzLjnt2M=;
 b=p3GKDEW4N3RcR4nV+CFqJApc4c7GBrM04StCdv+it6R2p8JFpAIU+76DpODcQPoDqgQyN+
 lzMSp7CR+sjhelCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70E4A137BA;
 Thu, 13 Mar 2025 09:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MJo9G0ai0mczNQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 13 Mar 2025 09:15:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 13 Mar 2025 10:15:37 +0100
MIME-Version: 1.0
Message-Id: <20250313-mmap_suite_refactoring-v3-4-eb9172686230@suse.com>
References: <20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com>
In-Reply-To: <20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741857349; l=3127;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Vlhlo+VoStKrLvCA8Ousvd+7gNRlolx+gzqXKma4Gfs=;
 b=vQM4Bvs85RnTQZAfYcT4UyujvnT7Ovvv5+OpKyms02FDBwaSKK/MudxmOSYuZ8jR3X1iO4z7B
 h4q8g5RaO1jA+OLAlXpTEBCWa70C+bNL4FlCrLIN/Podhn6l+xpEXDf
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/8] Cleanup mmap17 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap17.c | 52 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap17.c b/testcases/kernel/syscalls/mmap/mmap17.c
index 39703fbd397d33fe549b1c9a52db62f763e146dd..c7b12f0fe9607afed7a934cceff1a8f643757b54 100644
--- a/testcases/kernel/syscalls/mmap/mmap17.c
+++ b/testcases/kernel/syscalls/mmap/mmap17.c
@@ -1,73 +1,63 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
- * Email: code@zilogic.com
+ *	Email: code@zilogic.com
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Test mmap with MAP_FIXED_NOREPLACE flag
- *
- * We are testing the MAP_FIXED_NOREPLACE flag of mmap() syscall. To check
+/*\
+ * Verify MAP_FIXED_NOREPLACE flag for the mmap() syscall and check
  * if an attempt to mmap at an exisiting mapping fails with EEXIST.
+ *
+ * [Algorithm]
+ *
  * The code allocates a free address by passing NULL to first mmap call
- * Then tries to mmap with the same address using MAP_FIXED_NOREPLACE flag
+ * then tries to mmap with the same address using MAP_FIXED_NOREPLACE flag
  * and the mapping fails as expected.
  */
 
-#include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include "lapi/mmap.h"
 #include "tst_test.h"
 
 static int fd_file1;
 static int fd_file2;
 static void *mapped_address;
-static const char str[] = "Writing to mapped file";
+static const char msg[] = "Writing to mapped file";
+static int msg_len;
 
 #define FNAME1 "file1_to_mmap"
 #define FNAME2 "file2_to_mmap"
 
 static void setup(void)
 {
+	msg_len = strlen(msg);
+
 	fd_file1 = SAFE_OPEN(FNAME1, O_CREAT | O_RDWR, 0600);
 	fd_file2 = SAFE_OPEN(FNAME2, O_CREAT | O_RDWR, 0600);
+
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file1, msg, msg_len);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file2, msg, msg_len);
+
+	mapped_address = SAFE_MMAP(NULL, msg_len,
+		PROT_WRITE, MAP_PRIVATE, fd_file1, 0);
 }
 
 static void cleanup(void)
 {
-	int str_len;
-
-	str_len = strlen(str);
-
 	if (fd_file2 > 0)
 		SAFE_CLOSE(fd_file2);
 	if (fd_file1 > 0)
 		SAFE_CLOSE(fd_file1);
 	if (mapped_address)
-		SAFE_MUNMAP(mapped_address, str_len);
+		SAFE_MUNMAP(mapped_address, msg_len);
 }
 
 static void test_mmap(void)
 {
-	int str_len;
 	void *address;
 
-	str_len = strlen(str);
-
-	SAFE_WRITE(SAFE_WRITE_ALL, fd_file1, str, str_len);
-	mapped_address = SAFE_MMAP(NULL, str_len, PROT_WRITE,
-				   MAP_PRIVATE, fd_file1, 0);
-
-	SAFE_WRITE(SAFE_WRITE_ALL, fd_file2, str, str_len);
-
-	address = mmap(mapped_address, str_len, PROT_WRITE,
+	address = mmap(mapped_address, msg_len, PROT_WRITE,
 		  MAP_PRIVATE | MAP_FIXED_NOREPLACE, fd_file2, 0);
+
 	if (address == MAP_FAILED && errno == EEXIST)
 		tst_res(TPASS, "mmap set errno to EEXIST as expected");
 	else

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
