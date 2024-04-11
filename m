Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC2CC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 968343CF830
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:31:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC8C53C0F55
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C663601BBE
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 292DB5CD1D;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0Vre6LZKovncAeHCNdJvZqinHkqSj/6058CpSG4ilY=;
 b=Sv2bdmXAo3c4/l9fk3u6vV0RRY5ENHRya/JgtD9Hy+dcxZ2iOnb4GQNmms9/6mM3dAoU7P
 /gKM3334H5AMiRG2MZ/i3sDMWLQBXuyJeiCmIPVdxhIJBcxbFIe84XCn2MKeum8DctC3t5
 IuxE0yP5Y7Z8ZnkD31IqV5sUf6XMjoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0Vre6LZKovncAeHCNdJvZqinHkqSj/6058CpSG4ilY=;
 b=vv7BPVfLIZ73Jc5C0RRCsFSrcWsMD0tAj7jTmSCnO1ck9QftraPvmMcB7Pi3ciY0/siMEe
 j0brpdovlYof0pCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0Vre6LZKovncAeHCNdJvZqinHkqSj/6058CpSG4ilY=;
 b=Sv2bdmXAo3c4/l9fk3u6vV0RRY5ENHRya/JgtD9Hy+dcxZ2iOnb4GQNmms9/6mM3dAoU7P
 /gKM3334H5AMiRG2MZ/i3sDMWLQBXuyJeiCmIPVdxhIJBcxbFIe84XCn2MKeum8DctC3t5
 IuxE0yP5Y7Z8ZnkD31IqV5sUf6XMjoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0Vre6LZKovncAeHCNdJvZqinHkqSj/6058CpSG4ilY=;
 b=vv7BPVfLIZ73Jc5C0RRCsFSrcWsMD0tAj7jTmSCnO1ck9QftraPvmMcB7Pi3ciY0/siMEe
 j0brpdovlYof0pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0628413888;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YBR3AAb0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:29:58 +0200
Message-ID: <20240411143025.352507-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/31] test.h: Remove MAP_PRIVATE_EXCEPT_UCLINUX
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

Replace it with MAP_PRIVATE.
It was defined only to support UCLINUX.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/old/test.h                          | 5 -----
 testcases/kernel/syscalls/munmap/munmap03.c | 3 +--
 testcases/kernel/syscalls/writev/writev02.c | 3 +--
 testcases/kernel/syscalls/writev/writev05.c | 3 +--
 testcases/kernel/syscalls/writev/writev06.c | 8 ++++----
 5 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/include/old/test.h b/include/old/test.h
index b17fbf856..8ccd5f5e8 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -68,18 +68,13 @@
 /*
  * fork() can't be used on uClinux systems, so use FORK_OR_VFORK instead,
  * which will run vfork() on uClinux.
- * mmap() doesn't support MAP_PRIVATE on uClinux systems, so use
- * MAP_PRIVATE_EXCEPT_UCLINUX instead, which will skip the option on uClinux.
- * If MAP_PRIVATE really is required, the test can not be run on uClinux.
  */
 #ifdef UCLINUX
 # define FORK_OR_VFORK			tst_vfork
-# define MAP_PRIVATE_EXCEPT_UCLINUX	0
 /* tst_old_flush() + vfork() */
 pid_t tst_vfork(void);
 #else
 # define FORK_OR_VFORK			tst_fork
-# define MAP_PRIVATE_EXCEPT_UCLINUX	MAP_PRIVATE
 #endif
 
 /*
diff --git a/testcases/kernel/syscalls/munmap/munmap03.c b/testcases/kernel/syscalls/munmap/munmap03.c
index 23875e7b3..60bcb93b0 100644
--- a/testcases/kernel/syscalls/munmap/munmap03.c
+++ b/testcases/kernel/syscalls/munmap/munmap03.c
@@ -87,8 +87,7 @@ static void setup(void)
 
 	global_maplen = page_sz * 2;
 	global_addr = SAFE_MMAP(cleanup, NULL, global_maplen, PROT_READ |
-				PROT_WRITE, MAP_PRIVATE_EXCEPT_UCLINUX |
-				MAP_ANONYMOUS, -1, 0);
+				PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 }
 
 static void check_and_print(int expected_errno)
diff --git a/testcases/kernel/syscalls/writev/writev02.c b/testcases/kernel/syscalls/writev/writev02.c
index 005f37a14..a7d11de30 100644
--- a/testcases/kernel/syscalls/writev/writev02.c
+++ b/testcases/kernel/syscalls/writev/writev02.c
@@ -179,8 +179,7 @@ void setup(void)
 	strcpy(name, DATA_FILE);
 	sprintf(f_name, "%s.%d", name, getpid());
 
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr == MAP_FAILED)
 		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
 	wr_iovec[0].iov_base = bad_addr;
diff --git a/testcases/kernel/syscalls/writev/writev05.c b/testcases/kernel/syscalls/writev/writev05.c
index c939e7de0..6add2bcd4 100644
--- a/testcases/kernel/syscalls/writev/writev05.c
+++ b/testcases/kernel/syscalls/writev/writev05.c
@@ -210,8 +210,7 @@ void setup(void)
 	strcpy(name, DATA_FILE);
 	sprintf(f_name, "%s.%d", name, getpid());
 
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+	bad_addr = mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr == MAP_FAILED) {
 		printf("mmap failed\n");
 	}
diff --git a/testcases/kernel/syscalls/writev/writev06.c b/testcases/kernel/syscalls/writev/writev06.c
index e97ae6f21..b60c727b6 100644
--- a/testcases/kernel/syscalls/writev/writev06.c
+++ b/testcases/kernel/syscalls/writev/writev06.c
@@ -162,22 +162,22 @@ void setup(void)
 	/* Crate two readable and writeble mappings with non reabable
 	 * mapping around */
 	bad_addr[0] = mmap(NULL, page_size * 3, PROT_NONE,
-			   MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+			   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr[0] == MAP_FAILED)
 		tst_brkm(TBROK, cleanup, "mmap failed for bad_addr[0]");
 
 	good_addr[0] = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (good_addr[0] == MAP_FAILED)
 		tst_brkm(TBROK, cleanup, "mmap failed for good_addr[0]");
 
 	bad_addr[1] = mmap(NULL, page_size * 3, PROT_NONE,
-			   MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+			   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (bad_addr[1] == MAP_FAILED)
 		tst_brkm(TBROK, cleanup, "mmap failed for bad_addr[1]");
 
 	good_addr[1] = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
+			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (good_addr[1] == MAP_FAILED)
 		tst_brkm(TBROK, cleanup, "mmap failed for good_addr[1]");
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
