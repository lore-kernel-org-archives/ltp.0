Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF93C0218B
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 12:35:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 445513C2731
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 13:35:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35EAA3C2621
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:34:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DA29C1037B61
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 13:34:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 895FB211C9
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737462891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0686Mk2g58rEARq6QviOIxP/WA1BoZbhyKyviZ6/S4=;
 b=TTpGPc7mNf9vxPh6rCBg03oJSv+BhOzadb/Jsam9uJa+yVw/kLjoSO+w1MjGHl2FbP1Cvd
 E29pcIizPVQphF9H3NyejBmWU/4YePeAGZGg74DZDxMW22HvLCEmPM8HuxqfpisKzZ7mkT
 645ct70ELhfPfDZ3h1dwlU1q9EX9CUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737462891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0686Mk2g58rEARq6QviOIxP/WA1BoZbhyKyviZ6/S4=;
 b=rOGgWPcpSUVUX9m0/zmtEduC7nG22w385wGBPeWz5TPnLpGdL4fFlTj/LQ9Dw0R1giZiN9
 KmFuG0VlKl2p8iCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TTpGPc7m;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rOGgWPcp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737462891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0686Mk2g58rEARq6QviOIxP/WA1BoZbhyKyviZ6/S4=;
 b=TTpGPc7mNf9vxPh6rCBg03oJSv+BhOzadb/Jsam9uJa+yVw/kLjoSO+w1MjGHl2FbP1Cvd
 E29pcIizPVQphF9H3NyejBmWU/4YePeAGZGg74DZDxMW22HvLCEmPM8HuxqfpisKzZ7mkT
 645ct70ELhfPfDZ3h1dwlU1q9EX9CUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737462891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0686Mk2g58rEARq6QviOIxP/WA1BoZbhyKyviZ6/S4=;
 b=rOGgWPcpSUVUX9m0/zmtEduC7nG22w385wGBPeWz5TPnLpGdL4fFlTj/LQ9Dw0R1giZiN9
 KmFuG0VlKl2p8iCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA881387C
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YKg8GmuUj2dmVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:34:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Jan 2025 13:34:44 +0100
Message-ID: <20250121123444.5380-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250121123444.5380-1-chrubis@suse.cz>
References: <20250121123444.5380-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 895FB211C9
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls: Update test timeouts
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

This change was genered by:

- runnning syscalls via kirk on RPi zero and saving the json result

- running 'cd scripts && calc_timeouts.py -p results.json'

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/access/access01.c                   | 1 +
 testcases/kernel/syscalls/add_key/add_key05.c                 | 1 +
 testcases/kernel/syscalls/alarm/alarm05.c                     | 1 +
 testcases/kernel/syscalls/alarm/alarm06.c                     | 1 +
 testcases/kernel/syscalls/alarm/alarm07.c                     | 1 +
 testcases/kernel/syscalls/bind/bind04.c                       | 1 +
 testcases/kernel/syscalls/bpf/bpf_prog05.c                    | 1 +
 testcases/kernel/syscalls/bpf/bpf_prog06.c                    | 1 +
 testcases/kernel/syscalls/bpf/bpf_prog07.c                    | 1 +
 testcases/kernel/syscalls/cachestat/cachestat01.c             | 1 +
 testcases/kernel/syscalls/cachestat/cachestat04.c             | 1 +
 testcases/kernel/syscalls/chdir/chdir01.c                     | 1 +
 testcases/kernel/syscalls/clock_gettime/leapsec01.c           | 1 +
 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c | 1 +
 testcases/kernel/syscalls/clock_settime/clock_settime03.c     | 1 +
 testcases/kernel/syscalls/close_range/close_range01.c         | 1 +
 testcases/kernel/syscalls/connect/connect02.c                 | 1 +
 testcases/kernel/syscalls/creat/creat05.c                     | 1 +
 testcases/kernel/syscalls/creat/creat09.c                     | 1 +
 testcases/kernel/syscalls/execve/execve05.c                   | 1 +
 testcases/kernel/syscalls/execveat/execveat03.c               | 1 +
 testcases/kernel/syscalls/fallocate/fallocate04.c             | 1 +
 testcases/kernel/syscalls/fallocate/fallocate05.c             | 1 +
 testcases/kernel/syscalls/fallocate/fallocate06.c             | 2 +-
 testcases/kernel/syscalls/fanotify/fanotify01.c               | 1 +
 testcases/kernel/syscalls/fanotify/fanotify03.c               | 1 +
 testcases/kernel/syscalls/fanotify/fanotify05.c               | 1 +
 testcases/kernel/syscalls/fanotify/fanotify06.c               | 1 +
 testcases/kernel/syscalls/fanotify/fanotify09.c               | 1 +
 testcases/kernel/syscalls/fanotify/fanotify10.c               | 1 +
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c            | 1 +
 testcases/kernel/syscalls/fcntl/fcntl14.c                     | 1 +
 testcases/kernel/syscalls/fcntl/fcntl36.c                     | 1 +
 testcases/kernel/syscalls/fdatasync/fdatasync03.c             | 1 +
 testcases/kernel/syscalls/fgetxattr/fgetxattr01.c             | 1 +
 testcases/kernel/syscalls/fremovexattr/fremovexattr01.c       | 1 +
 testcases/kernel/syscalls/fremovexattr/fremovexattr02.c       | 1 +
 testcases/kernel/syscalls/fsconfig/fsconfig01.c               | 1 +
 testcases/kernel/syscalls/fsconfig/fsconfig03.c               | 1 +
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c             | 1 +
 testcases/kernel/syscalls/fsmount/fsmount01.c                 | 1 +
 testcases/kernel/syscalls/fsmount/fsmount02.c                 | 1 +
 testcases/kernel/syscalls/fsopen/fsopen01.c                   | 1 +
 testcases/kernel/syscalls/fspick/fspick01.c                   | 1 +
 testcases/kernel/syscalls/fspick/fspick02.c                   | 1 +
 testcases/kernel/syscalls/fstatfs/fstatfs01.c                 | 1 +
 testcases/kernel/syscalls/fsync/fsync01.c                     | 1 +
 testcases/kernel/syscalls/fsync/fsync04.c                     | 1 +
 testcases/kernel/syscalls/getpid/getpid01.c                   | 1 +
 testcases/kernel/syscalls/getxattr/getxattr02.c               | 1 +
 testcases/kernel/syscalls/getxattr/getxattr03.c               | 1 +
 testcases/kernel/syscalls/inotify/inotify03.c                 | 1 +
 testcases/kernel/syscalls/inotify/inotify05.c                 | 1 +
 testcases/kernel/syscalls/inotify/inotify07.c                 | 1 +
 testcases/kernel/syscalls/inotify/inotify08.c                 | 1 +
 testcases/kernel/syscalls/inotify/inotify11.c                 | 1 +
 testcases/kernel/syscalls/ioctl/ioctl02.c                     | 1 +
 testcases/kernel/syscalls/ioctl/ioctl04.c                     | 1 +
 testcases/kernel/syscalls/ioctl/ioctl08.c                     | 1 +
 testcases/kernel/syscalls/ioctl/ioctl09.c                     | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c             | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c             | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c        | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c        | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c                | 1 +
 65 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 391c8d44b..1c32c6d04 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -314,6 +314,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 3abd58b83..c9a2f840e 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -212,6 +212,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 2,
 	.test = do_test,
 	.tcnt = 2,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/alarm/alarm05.c b/testcases/kernel/syscalls/alarm/alarm05.c
index 2eeb1c22f..82bff69cb 100644
--- a/testcases/kernel/syscalls/alarm/alarm05.c
+++ b/testcases/kernel/syscalls/alarm/alarm05.c
@@ -44,6 +44,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 2,
 	.test_all = run,
 	.setup = setup,
 };
diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index 82c0d44bd..2cfa26207 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -41,6 +41,7 @@ static void verify_alarm(void)
 }
 
 static struct tst_test test = {
+	.timeout = 4,
 	.setup = setup,
 	.test_all = verify_alarm,
 };
diff --git a/testcases/kernel/syscalls/alarm/alarm07.c b/testcases/kernel/syscalls/alarm/alarm07.c
index 64aed507d..c04745f9d 100644
--- a/testcases/kernel/syscalls/alarm/alarm07.c
+++ b/testcases/kernel/syscalls/alarm/alarm07.c
@@ -47,6 +47,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 4,
 	.test_all = verify_alarm,
 	.setup = setup,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/bind/bind04.c b/testcases/kernel/syscalls/bind/bind04.c
index d8456e739..2a46559de 100644
--- a/testcases/kernel/syscalls/bind/bind04.c
+++ b/testcases/kernel/syscalls/bind/bind04.c
@@ -161,6 +161,7 @@ static void test_bind(unsigned int n)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = test_bind,
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog05.c b/testcases/kernel/syscalls/bpf/bpf_prog05.c
index 08254ba89..050081712 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -190,6 +190,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 20,
 	.setup = setup,
 	.test_all = run,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog06.c b/testcases/kernel/syscalls/bpf/bpf_prog06.c
index cee9616cf..87fdd8060 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog06.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog06.c
@@ -131,6 +131,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 20,
 	.setup = setup,
 	.test_all = run,
 	.min_kver = "5.8",
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog07.c b/testcases/kernel/syscalls/bpf/bpf_prog07.c
index dab5bb8ad..29dfbf2ca 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog07.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog07.c
@@ -139,6 +139,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 20,
 	.setup = setup,
 	.test_all = run,
 	.min_kver = "5.8",
diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index 2dca68885..22f0071d1 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -85,6 +85,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 13,
 	.test = run,
 	.tcnt = 2,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/cachestat/cachestat04.c b/testcases/kernel/syscalls/cachestat/cachestat04.c
index a59494451..7cef9897d 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat04.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat04.c
@@ -47,6 +47,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 2,
 	.test_all = run,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index d50a8f50c..1c1299332 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -149,6 +149,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/clock_gettime/leapsec01.c b/testcases/kernel/syscalls/clock_gettime/leapsec01.c
index e623b4107..4cd469dc2 100644
--- a/testcases/kernel/syscalls/clock_gettime/leapsec01.c
+++ b/testcases/kernel/syscalls/clock_gettime/leapsec01.c
@@ -196,6 +196,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 40,
 	.test_all = run_leapsec,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index eef8a5992..55e7b294e 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -219,6 +219,7 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
+	.timeout = 3,
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
 	.test_variants = ARRAY_SIZE(variants),
diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime03.c b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
index f196a257c..692e63788 100644
--- a/testcases/kernel/syscalls/clock_settime/clock_settime03.c
+++ b/testcases/kernel/syscalls/clock_settime/clock_settime03.c
@@ -104,6 +104,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 4,
 	.test_all = run,
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 110ffa9b7..941f3e403 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -191,6 +191,7 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.tcnt = 4,
 	.forks_child = 1,
 	.mount_device = 1,
diff --git a/testcases/kernel/syscalls/connect/connect02.c b/testcases/kernel/syscalls/connect/connect02.c
index e20214e24..087b514bf 100644
--- a/testcases/kernel/syscalls/connect/connect02.c
+++ b/testcases/kernel/syscalls/connect/connect02.c
@@ -126,6 +126,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 3,
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/creat/creat05.c b/testcases/kernel/syscalls/creat/creat05.c
index bf4099439..32074a449 100644
--- a/testcases/kernel/syscalls/creat/creat05.c
+++ b/testcases/kernel/syscalls/creat/creat05.c
@@ -74,6 +74,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test_all = verify_creat,
 	.needs_tmpdir = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index a5d3740ac..d18165772 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -138,6 +138,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index d87d7446d..530c7cc89 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -62,6 +62,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 3,
 	.test_all = verify_execve,
 	.options = (struct tst_option[]) {
 		{"n:", &opt_nchild, "Numbers of children"},
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 057d83278..684f0d0c6 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -68,6 +68,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.needs_overlay = 1,
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 7b285fb5d..3a8ea5fa7 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -282,6 +282,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.options = (struct tst_option[]) {
 		{"v", &verbose, "Turns on verbose mode"},
 		{}
diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 732a2f15d..f17cc993e 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -172,6 +172,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 42,
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 5e1454c30..0e1509ace 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -261,7 +261,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.needs_root = 1,
 	.dev_min_size = 1024,
-	.timeout = 120,
+	.timeout = 150,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 5d18fe851..c7e759166 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -387,6 +387,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 3ed78e5fa..64c933c19 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -343,6 +343,7 @@ static const char *const resource_files[] = {
 };
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 12c240881..435a91c49 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -208,6 +208,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 13,
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index 8779e34d9..b4992afa0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -236,6 +236,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 48b198b94..45303c31e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -507,6 +507,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index eedd1442f..23e9554b3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -959,6 +959,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.test = test_fanotify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test_variants = 2,
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
index f026b18df..e58be31c4 100644
--- a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -104,6 +104,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 367701d68..21dbede5c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -263,6 +263,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 8,
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index fabdbe905..19a5a0303 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -387,6 +387,7 @@ static void tests(unsigned int i)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.needs_tmpdir = 1,
 	.test = tests,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync03.c b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
index 5f3e0c96f..f1b5f0fb8 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync03.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync03.c
@@ -53,6 +53,7 @@ static void verify_fdatasync(void)
 }
 
 static struct tst_test test = {
+	.timeout = 15,
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
index 52e6e44ab..eefddd829 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr01.c
@@ -134,6 +134,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.setup = setup,
 	.test = verify_fgetxattr,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
index 907d210d1..aca2fce7c 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
@@ -83,6 +83,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 12,
 	.setup = setup,
 	.test_all = verify_fremovexattr,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
index eb106a8fa..78af8be32 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
@@ -105,6 +105,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.setup = setup,
 	.test = verify_fremovexattr,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
index a585daa6d..678d21815 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -82,6 +82,7 @@ static void run(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.test_all = run,
 	.setup = fsopen_supported_by_kernel,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index 0ba5355d3..503753636 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -80,6 +80,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
index b65b27bdf..73e1fcfb7 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr01.c
@@ -214,6 +214,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.setup = setup,
 	.test = verify_fsetxattr,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 5f755863f..6dafe25a8 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -88,6 +88,7 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = fsopen_supported_by_kernel,
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index a4f42dc18..55f0e2f28 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -68,6 +68,7 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
index c2c719c96..9dd87b99f 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen01.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -69,6 +69,7 @@ out:
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = fsopen_supported_by_kernel,
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d3309a912..d03cacd3d 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -56,6 +56,7 @@ out:
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = fsopen_supported_by_kernel,
diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
index f9a3697c1..89bdd2cc8 100644
--- a/testcases/kernel/syscalls/fspick/fspick02.c
+++ b/testcases/kernel/syscalls/fspick/fspick02.c
@@ -43,6 +43,7 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.setup = fsopen_supported_by_kernel,
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index 9d3909ace..044ab6548 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -56,6 +56,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.setup = setup,
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/fsync/fsync01.c b/testcases/kernel/syscalls/fsync/fsync01.c
index 072245fc8..7ae5296c7 100644
--- a/testcases/kernel/syscalls/fsync/fsync01.c
+++ b/testcases/kernel/syscalls/fsync/fsync01.c
@@ -44,6 +44,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.cleanup = cleanup,
 	.setup = setup,
 	.test_all = verify_fsync,
diff --git a/testcases/kernel/syscalls/fsync/fsync04.c b/testcases/kernel/syscalls/fsync/fsync04.c
index 9aa1584c1..f7553ff58 100644
--- a/testcases/kernel/syscalls/fsync/fsync04.c
+++ b/testcases/kernel/syscalls/fsync/fsync04.c
@@ -53,6 +53,7 @@ static void verify_fsync(void)
 }
 
 static struct tst_test test = {
+	.timeout = 17,
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 495002037..314c45d09 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -43,6 +43,7 @@ static void verify_getpid(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.setup = setup,
 	.forks_child = 1,
 	.test_all = verify_getpid,
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 5a84d876c..593ad7b8c 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -105,6 +105,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 1fe4ba48f..85f26402a 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -37,6 +37,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 14,
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.mntpoint = MNTPOINT,
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index ff025b360..4ee5e9461 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -166,6 +166,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.needs_root = 1,
 	.format_device = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index a1597217f..38b30878c 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -148,6 +148,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 08ea1e06a..bcfc569a8 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -182,6 +182,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.needs_overlay = 1,
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index 9c2ecdabd..149a0a1f8 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -176,6 +176,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.needs_root = 1,
 	.mount_device = 1,
 	.needs_overlay = 1,
diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
index 1630477fc..2e571f3a0 100644
--- a/testcases/kernel/syscalls/inotify/inotify11.c
+++ b/testcases/kernel/syscalls/inotify/inotify11.c
@@ -119,6 +119,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 12,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index f3bfb239a..9337da384 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -242,6 +242,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 9,
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl04.c b/testcases/kernel/syscalls/ioctl/ioctl04.c
index 262c06e97..f96b22f0c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl04.c
@@ -84,6 +84,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.format_device = 1,
 	.needs_root = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 834c5ae74..14f9354c9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -118,6 +118,7 @@ static void setup(void)
 
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = verify_ioctl,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 9c7921086..0d1f1072d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -110,6 +110,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_ioctl,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index fab0daaee..e5d4be96f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -51,6 +51,7 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 10,
 	.test_all = run,
 	.setup = setup,
 	.min_kver = "4.5",
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
index f12c4e7fd..b0a0f8d63 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -101,6 +101,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
index 8fd1d299a..707270765 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange01.c
@@ -137,6 +137,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
index eb941c3fc..cc1d0e031 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlonerange02.c
@@ -74,6 +74,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 4,
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index e7b337e4a..c3fb9f583 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -140,6 +140,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	.timeout = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_ioctl_loop,
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
