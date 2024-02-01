Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C57C4828D
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 15:14:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E62CB3CF908
	for <ltp@archiver.kernel.org>; Thu,  1 Feb 2024 16:14:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8CAD3CF907
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 16:14:02 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05ECA140170A
 for <ltp@lists.linux.it>; Thu,  1 Feb 2024 16:14:01 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35E6321EB8;
 Thu,  1 Feb 2024 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706800441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0ye+gU0/0X3spjB8AEwkFyZEee/GhO72XahineM/QbM=;
 b=NzzFa+f88EFp9QG8X2bvtlhwECVlGJY9t33B7UACTD+HMdBx+9MTLtp2PYC7o+Up/An2Rn
 A72DmmLo/aNvqDhuK6CCrhoM7902b4FUP0HhcK6/hOGIKuAghYX1GM0OlLZKD82yK+FuXA
 5AUSYCt4q47yGrxJQqL5sgF7qWC1neo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706800441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0ye+gU0/0X3spjB8AEwkFyZEee/GhO72XahineM/QbM=;
 b=xKHVgGbKUHhDxvlXjYhd1W1RSidAMeo/e0pvkbHXcs0XziDTDMgF+ULn8jodFnkT7GhCZB
 WJZDNhm4urlVMTDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706800441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0ye+gU0/0X3spjB8AEwkFyZEee/GhO72XahineM/QbM=;
 b=NzzFa+f88EFp9QG8X2bvtlhwECVlGJY9t33B7UACTD+HMdBx+9MTLtp2PYC7o+Up/An2Rn
 A72DmmLo/aNvqDhuK6CCrhoM7902b4FUP0HhcK6/hOGIKuAghYX1GM0OlLZKD82yK+FuXA
 5AUSYCt4q47yGrxJQqL5sgF7qWC1neo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706800441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0ye+gU0/0X3spjB8AEwkFyZEee/GhO72XahineM/QbM=;
 b=xKHVgGbKUHhDxvlXjYhd1W1RSidAMeo/e0pvkbHXcs0XziDTDMgF+ULn8jodFnkT7GhCZB
 WJZDNhm4urlVMTDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB1791329F;
 Thu,  1 Feb 2024 15:14:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id cWZgLTi1u2XQKQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 01 Feb 2024 15:14:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  1 Feb 2024 16:13:57 +0100
Message-ID: <20240201151357.110769-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tree: Use TST_EXP_FAIL2() for wait{,id}
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

Both wait() and waitid() returns PID, therefore (similarly as for file
descriptor) pass condition is >= 0, which is in TST_EXP_FAIL2().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/pidfd_open/pidfd_open04.c | 2 +-
 testcases/kernel/syscalls/wait/wait01.c             | 2 +-
 testcases/kernel/syscalls/waitid/waitid02.c         | 2 +-
 testcases/kernel/syscalls/waitid/waitid03.c         | 2 +-
 testcases/kernel/syscalls/waitid/waitid05.c         | 2 +-
 testcases/kernel/syscalls/waitid/waitid06.c         | 2 +-
 testcases/kernel/syscalls/waitid/waitid09.c         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
index 0e8ab6956..9f83d2b72 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
@@ -45,7 +45,7 @@ static void run(void)
 
 	tst_res(TPASS, "pidfd_open(%d, O_NONBLOCK) sets O_NONBLOCK flag", pid);
 
-	TST_EXP_FAIL(waitid(P_PIDFD, pidfd, &info, WEXITED), EAGAIN,
+	TST_EXP_FAIL2(waitid(P_PIDFD, pidfd, &info, WEXITED), EAGAIN,
 			"waitid(P_PIDFD,...,WEXITED)");
 
 	TST_CHECKPOINT_WAKE(0);
diff --git a/testcases/kernel/syscalls/wait/wait01.c b/testcases/kernel/syscalls/wait/wait01.c
index aec91b911..8245898dd 100644
--- a/testcases/kernel/syscalls/wait/wait01.c
+++ b/testcases/kernel/syscalls/wait/wait01.c
@@ -16,7 +16,7 @@
 
 static void verify_wait(void)
 {
-	TST_EXP_FAIL(wait(NULL), ECHILD);
+	TST_EXP_FAIL2(wait(NULL), ECHILD);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index f13a4ed00..c5b27939b 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -18,7 +18,7 @@ static siginfo_t *infop;
 
 static void run(void)
 {
-	TST_EXP_FAIL(waitid(P_ALL, 0, infop, WNOHANG), EINVAL);
+	TST_EXP_FAIL2(waitid(P_ALL, 0, infop, WNOHANG), EINVAL);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/waitid/waitid03.c b/testcases/kernel/syscalls/waitid/waitid03.c
index ef3fd7376..a44a030df 100644
--- a/testcases/kernel/syscalls/waitid/waitid03.c
+++ b/testcases/kernel/syscalls/waitid/waitid03.c
@@ -19,7 +19,7 @@ static siginfo_t *infop;
 
 static void run(void)
 {
-	TST_EXP_FAIL(waitid(P_ALL, 0, infop, WNOHANG | WEXITED), ECHILD);
+	TST_EXP_FAIL2(waitid(P_ALL, 0, infop, WNOHANG | WEXITED), ECHILD);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/waitid/waitid05.c b/testcases/kernel/syscalls/waitid/waitid05.c
index 1b9186dc1..004d48b97 100644
--- a/testcases/kernel/syscalls/waitid/waitid05.c
+++ b/testcases/kernel/syscalls/waitid/waitid05.c
@@ -31,7 +31,7 @@ static void run(void)
 
 	pid_group = getpgid(0);
 
-	TST_EXP_FAIL(waitid(P_PGID, pid_group+1, infop, WEXITED), ECHILD);
+	TST_EXP_FAIL2(waitid(P_PGID, pid_group+1, infop, WEXITED), ECHILD);
 
 	memset(infop, 0, sizeof(*infop));
 	TST_EXP_PASS(waitid(P_PGID, pid_group, infop, WEXITED));
diff --git a/testcases/kernel/syscalls/waitid/waitid06.c b/testcases/kernel/syscalls/waitid/waitid06.c
index 5f51c81c8..003d10d6e 100644
--- a/testcases/kernel/syscalls/waitid/waitid06.c
+++ b/testcases/kernel/syscalls/waitid/waitid06.c
@@ -28,7 +28,7 @@ static void run(void)
 	if (!pid_child)
 		exit(0);
 
-	TST_EXP_FAIL(waitid(P_PID, pid_child+1, infop, WEXITED), ECHILD);
+	TST_EXP_FAIL2(waitid(P_PID, pid_child+1, infop, WEXITED), ECHILD);
 
 	memset(infop, 0, sizeof(*infop));
 	TST_EXP_PASS(waitid(P_PID, pid_child, infop, WEXITED));
diff --git a/testcases/kernel/syscalls/waitid/waitid09.c b/testcases/kernel/syscalls/waitid/waitid09.c
index 115c2e672..935c1754c 100644
--- a/testcases/kernel/syscalls/waitid/waitid09.c
+++ b/testcases/kernel/syscalls/waitid/waitid09.c
@@ -24,7 +24,7 @@ static void run(void)
 	if (!SAFE_FORK())
 		exit(0);
 
-	TST_EXP_FAIL(waitid(P_PID, 1, infop, WEXITED), ECHILD);
+	TST_EXP_FAIL2(waitid(P_PID, 1, infop, WEXITED), ECHILD);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
