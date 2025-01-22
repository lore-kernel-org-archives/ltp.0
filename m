Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F3AC0218C
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:27:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 552D03C3047
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 14:27:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FCC73C300B
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:26:49 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 62B17142D4ED
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:26:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0161F7D3;
 Wed, 22 Jan 2025 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737552405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss/lEwBhok0G4NuGl9QJWn0UfCQ5Q9ocAEXbLBW9BMU=;
 b=xB9MEceCFHf+qsmfF2uOk/lhD9Xa2zCaLPbQ8/IuRXNsxbf9qH8/JdjuaftA5GG7nnVRVn
 f0ui8XFh7tRwgCIoZZGohdvxzwzzp8VA5qVLS2nO9AMblhuk04BPPN7Lve59UidWSOnfjc
 itMVMzEZq++6eub6VXy9KC+YajH17fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737552405;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss/lEwBhok0G4NuGl9QJWn0UfCQ5Q9ocAEXbLBW9BMU=;
 b=Kfz2KemRpZjcNF5AswBCjbPHc51jsOiTJdIxMTNuCmWZGqdKVnaxoz9YuCzYQXbhVxG46L
 H6QDfu/v6+8X6/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737552404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss/lEwBhok0G4NuGl9QJWn0UfCQ5Q9ocAEXbLBW9BMU=;
 b=JHQWeT4bWfI19EPS4CyJQtsuuO6tBh1RAAPxM4fJ+IIjqfdBAQ+k5q7gl+BO/4bt2LkTal
 oo/M3MqDQlnW/tX+NMXppNnV5izGNC7VzjoNVYhaebFM+eaMStYoIEuSSEV/OuO7TEPsYO
 nHuQa20z+w3MEDF77WFjeuZNJRdjgmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737552404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss/lEwBhok0G4NuGl9QJWn0UfCQ5Q9ocAEXbLBW9BMU=;
 b=qi7/xG9mgIxp7d+/7u3iIZUr2gYy6pyvuQvp37l0fNx/8ni+UEzMGbNXSKsPJXwtEBOPGP
 cqQx9i0C3ZPr4qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4A441397D;
 Wed, 22 Jan 2025 13:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YF2nMRPykGfwcwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 22 Jan 2025 13:26:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 22 Jan 2025 14:26:41 +0100
MIME-Version: 1.0
Message-Id: <20250122-cyril_script_update_timeouts-v2-2-c29846cc0925@suse.com>
References: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
In-Reply-To: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737552402; l=36772;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=S5GK19ZJPnzvlh7IEjGmdPV3KzXhaRObTEZNXoDfPzg=;
 b=MK2JshCCU4cVlPAZszfbSlUvtmq5FC6ENSwHkZ1WHliw7koO1quSDzaN4Aw1UEKOCve42gshS
 2BOem+vM+t6DKNZ8xWGQw1qrv2V5P3DUT693j7/iufM09CgJLHpYJq8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,calctimeouts.py:url];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls: Update test timeouts
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

From: Cyril Hrubis <chrubis@suse.cz>

This change was genered by:

- running syscalls via kirk on RPi zero and saving the json result

- running 'cd scripts && calctimeouts.py -l /opt/ltp -r results.json -p'

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
index 391c8d44bc7bd5af14713292da988138dec2a16a..1c32c6d046838a2459e9bad09bebde8987fabacc 100644
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
index 3abd58b833a4f0ac7653cd932f556012f736fc01..c9a2f840e5b97673212dac741f40b2b0b0be0262 100644
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
index 2eeb1c22f3e63cdb6e04d29d21d7306fcfef0050..82bff69cbfd968ec03351769930da0ac3616f8c3 100644
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
index 82c0d44bd2cc0271ea5164b533464a5a9b37e096..2cfa262076e69bbede892f3dd226ad5e86cc3c04 100644
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
index 64aed507dec7b042545e18fb2cddfbaa5becb1be..c04745f9dfb1ffc9e552f5df54a6161b6c9671bf 100644
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
index d8456e739a9460b7201c975cb01d53d1126d1f7e..2a46559dead7ae64d5b056a6c0b07f49d35bdb43 100644
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
index 08254ba8930d390b32bd6a525ceb9223036dba3a..0500817128315b333a8ec81cc535fd95e74c0904 100644
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
index cee9616cf34fedd32b0c492bc6151a52e088f6b0..87fdd806033a36162c2367eeaf005c2fa12e1df0 100644
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
index dab5bb8ad16c12b832efc28d9c75417a206a5902..29dfbf2cae4704b8c5a260f28eb5a504e0e3ea39 100644
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
index 2dca688854d8203886d724cf8d57bb04d9d0d325..22f0071d1e2b68f76986271da24f4501b8eac70b 100644
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
index a59494451a00c37207a6895771b189eb1a7a713f..7cef9897d416f24b39eebc3d53a0bb3a17007613 100644
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
index d50a8f50c6c3ccb600a3e91f8b128739f09eb7d5..1c1299332741ab90fa7de552187bc5dadbcbeb54 100644
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
index e623b4107c980b9e513f01f8acbf2d1e4e941021..4cd469dc277c66b316c9054a3f819270d0a520be 100644
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
index eef8a59921793bd2329097ab1a7d82c8dec1d92f..55e7b294ee8a33a8d63c8cbdb8287b76cbbe6f5c 100644
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
index f196a257c75b7c1e6b6264707ecefdd4dd8c36ca..692e63788e5cc25a90041d5d27ee725227622d2c 100644
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
index 110ffa9b795f2b4311824dd72ce46945deae3371..941f3e4038dfc5eb4ab771bdde69b6532943caed 100644
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
index e20214e243feded16c8cef57ca5b994f6d57e206..087b514bf48c800c2d47a978b38249dc25dd4c32 100644
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
index bf409943988bc90afff28643caa02f9321bc7dc0..32074a449ac3b74e4a696f5e75af667afd147140 100644
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
index a5d3740ac6fdb95381168ae00d859c6616e3d7c2..d1816577282532848d57452f312e968841d6db0c 100644
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
index d87d7446d187176740ad1e33a8ee2196f19bb097..530c7cc8903d7f809e6e9a91888654749dcb0c41 100644
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
index 057d83278af282c56ef93c375aeb05a20be48f0f..684f0d0c68c951f5d32cc33555834e860f5166bc 100644
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
index 7b285fb5d10ee45a49937cf3823c4ca9cd576f0d..3a8ea5fa75773d95b791d4f2f0e52232b218d406 100644
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
index 732a2f15da9f40bfe0f1ce151723023a896e9b24..f17cc993e3db992af5edce0a28aa30fa8eb7b87f 100644
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
index 5e1454c3022977ef904bc481dabd7941d6e3b800..0e1509ace625097929fd5e8dce471c78166e0821 100644
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
index 5d18fe8512529f348ab497cb463d221f4e8de902..c7e759166d1f5580e3eb482075db0d1e633f1cc1 100644
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
index 3ed78e5fab4fcb40603c1a49ec3f5a6cd6feda25..64c933c190081331b3705a7c9181fec836c774a1 100644
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
index 12c2408818dfcb10915c555ee4a9e8aeedcd8a5a..435a91c49312a879aeb15da05f6e9ea3da4be333 100644
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
index 8779e34d95dd704874b0711b256693e4c7c98d89..b4992afa0f95aba9e700f4723eb73db30df42fc1 100644
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
index 48b198b9415a0c875fb827bc5caf92d5f33adf97..45303c31e76ef6b66b0fbe7173ae3c8f05131e61 100644
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
index eedd1442f5a5860ba1bd4019110623e9ba55b3d7..23e9554b39da33533f4829c8a0e0fb3306119605 100644
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
index f026b18df570162ff720e6d54095ef44bb32d5d6..e58be31c42991bc8f9a67663d530eaa2d0afb697 100644
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
index 367701d68cac191a560aff5aade881b6f60c9eae..21dbede5c31f119542a7181d0e53730dfb103ba5 100644
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
index fabdbe90591bf1c0603f5053cb62f6f20b6e1f73..19a5a0303bf75435d1388f2bcafd02373c9b1253 100644
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
index 5f3e0c96f52ec44172c40e93af971556705c37b9..f1b5f0fb822cd137e0a0208696d2d1f49ddcdae1 100644
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
index 52e6e44ab8e3ce7f4ea6fad45ccf3d2a0a60eb45..eefddd829b474e0049779231b3fca6c10396ee4c 100644
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
index 907d210d1c3d2aa13ae2facc201b5030d5185894..aca2fce7c3d1d551166019a9c57c4a68e8cc4104 100644
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
index eb106a8fa1eca9af5e3f416cf962049e2083d3aa..78af8be326e6f05fe2ef02840a9cc76834896fac 100644
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
index a585daa6d6a714be7b97d6215700c142eed20fb1..678d21815c5c2c546e9deca77899f99852453060 100644
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
index 0ba5355d3a330ff9702e3348226729402ea85b9f..5037536360aecf64c98054489258ad0306a05f00 100644
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
index b65b27bdf9ac0774b5d9a61549c77389ac1f37e2..73e1fcfb7292c333e5c05a2e8dc2307e2146ea47 100644
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
index 5f755863f43aee0ee0988f72b4cbd2defcf49379..6dafe25a8fdaa2f71469dd81dd597d2b824053e5 100644
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
index a4f42dc188220a7f31807b5eb38563520e06f0aa..55f0e2f28d04938486d3a5855337e6312cfa45fd 100644
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
index c2c719c9678e5860303994a140d0b35146af0f62..9dd87b99f02771a9ce48e9ecce8e95cdf1474007 100644
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
index d3309a9124cbd538853e38a278ea2ece97cbcba7..d03cacd3d9b07a3c8c49d3664f014befbb0bea09 100644
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
index f9a3697c1f8f577b095b65d3156cdd8a572d168f..89bdd2cc81c51a43bb2106764575037d4de7f697 100644
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
index 9d3909aceda671a659a882467964d9a11d8e8d4c..044ab65488727dbd2384111411d00bbc1ecc743d 100644
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
index 072245fc83ca2bf8e39aa3e0827a3a724844c813..7ae5296c7cf251717cf66f8ee64ea91691b4efd6 100644
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
index 9aa1584c1f2b4c6d1e91b90282fa4ed840cfd247..f7553ff58029d1e5cf85132435763af931cdf894 100644
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
index 495002037380fa090585eccc9b001bcb9a5ad400..314c45d0948e8a025f478745577a021aec721e37 100644
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
index 5a84d876c5c00799ee04d74ba9134c6b16c1c569..593ad7b8c70e0680cd0908c7fa1fb8caccb32b7e 100644
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
index 1fe4ba48fc1001a840940a3d5730ff4afee35d5a..85f26402af2e3ff1c7e68de1e0dd11166b67fed9 100644
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
index ff025b36025988e8e22bc97abf3ef0294a996321..4ee5e9461356922902ccf4bffa8a726177fc7401 100644
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
index a1597217f581314efda1ada5404861e0ac573a88..38b30878c18be9816ef937cee9b4ad50393d1733 100644
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
index 08ea1e06aaa20ee1735efda8eb46628c2b55be49..bcfc569a8d0f2d65fb44f5a44e1d830c069479e5 100644
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
index 9c2ecdabdab633f2881681f643c5223eb8c18d0c..149a0a1f817d49322bc8f9ec9e388c74a40ff11c 100644
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
index 1630477fcc3b2753e02fc96c481d9ff4d5fab975..2e571f3a0c72adb71503e9cff3fad0ce2b608610 100644
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
index f3bfb239ab9eae620bf93de1dd4b8804312af082..9337da384ab16840a04224a9a4614061105759e3 100644
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
index 262c06e97f887fdb8767556f92fe9b518fb90616..f96b22f0ce83fb3ef5bba6d8164c8398fcdee991 100644
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
index 834c5ae7461db9864cbf0d64767399f7ebb9559e..14f9354c9b8afdc417498c7031c0b44442472a1a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -118,6 +118,7 @@ static void setup(void)
 
 
 static struct tst_test test = {
+	.timeout = 1,
 	.test = verify_ioctl,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 9c79210864b8e932f8d93fe7bc395d0eadddedb7..0d1f1072d3420e3f12677360da307cf78e79c57a 100644
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
index fab0daaeef32a1149d6356d9c583b9afd495e27c..e5d4be96f7b40f7132b6f210a1a542f2becddb95 100644
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
index f12c4e7fdb28cd59a34d2f0ce3c61fc168eae7dd..b0a0f8d63fdb222d6fd3bbcbb2fa4476d3b25033 100644
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
index 8fd1d299a4b2a061c9ea4c0f556f5be665497d10..70727076517cf73a2a61a21c24806632ba7fb529 100644
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
index eb941c3fc17ff445deba388e4b42ea4f7f6c58a8..cc1d0e031920df1836c79653c70aa3b724b483f5 100644
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
index e7b337e4acfef388d508f7a031809ffd53428291..c3fb9f583ffe98ab19d90dcebc2203d0cb6055e3 100644
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
