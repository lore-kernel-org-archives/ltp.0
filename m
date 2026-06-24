Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9449CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:22:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDCF3C0302
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:22:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06D83E61F6
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C39A1400BF9
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CAE271444
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHKgw0vllaVP+OJAg1tHDA+kNgYJPbHzBwBW4vrmt/s=;
 b=KCtfCOOTMmuTNuWNr0c8uVvLFX2PCTHjZM1UCloculfTYksXeYr1YQ/uMLzIRjEJXRr/5d
 DOKys/p+YRK7XiBZuMVv7SkHamhoPB29cwgEWHtE3ZwkTSyiyuuOr71udq90g9HdAKU53X
 uJIhWTC/AEkkW3xynPk07mWq8yPKsAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHKgw0vllaVP+OJAg1tHDA+kNgYJPbHzBwBW4vrmt/s=;
 b=u6xl6UPgC0m/4rxH4HGdAujvAx1Zcg7NvyyMGIaAZtFRa7axP8bAg4B/pcCkM4Y0mpfEKc
 KEPnIw6jdc23xuBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DUbYHvWR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zqxyfZsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHKgw0vllaVP+OJAg1tHDA+kNgYJPbHzBwBW4vrmt/s=;
 b=DUbYHvWR1wrNoILsthmi2YsiDmq7Le1778inaY2krg+uHzumlwlnOyqLyApDcC+fFjXVNl
 s7sA+sr+Cql1EQOf7FaQ2Quin9nZgydusB3p7aCw4v8RbMlf45OSZdLPV2SoK99Q2tHA9J
 WubjIyHkyrC0AEoeLF3X5iXOQWIRXzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHKgw0vllaVP+OJAg1tHDA+kNgYJPbHzBwBW4vrmt/s=;
 b=zqxyfZsMFDsa9HSbhykGEyyEPDhVuUZ1BUqD78NMHAZXbHaVRbgvona1enQXgY76PZ22lV
 P1+vVSsWX3yeemBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE1D779AB
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bCInBgWhO2pEAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:48 +0200
Message-ID: <20260624091900.4107041-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2CAE271444
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 01/13] tst_test: Add may_kmemleak flag and annotate
 tests
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

This information was so far recoded only in the comment in the cve
runtest file. Move it to the test so that it appears in the metadata.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                                          | 6 +++++-
 metadata/metaparse.c                                        | 1 +
 testcases/cve/cve-2022-4378.c                               | 1 +
 testcases/cve/cve-2025-21756.c                              | 1 +
 testcases/cve/cve-2025-38236.c                              | 1 +
 testcases/kernel/crypto/af_alg08.c                          | 1 +
 testcases/kernel/syscalls/fsconfig/fsconfig03.c             | 1 +
 testcases/kernel/syscalls/io_uring/io_uring04.c             | 1 +
 .../kernel/syscalls/perf_event_open/perf_event_open03.c     | 1 +
 testcases/network/sockets/xfrm01.c                          | 1 +
 testcases/network/sockets/xfrm02.c                          | 1 +
 testcases/network/sockets/xfrm03.c                          | 1 +
 12 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index c69362485..4afe4cbe0 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -353,6 +353,10 @@ struct tst_fs {
  *               needed for tests that need to create device files since tmpfs
  *               at /tmp is usually mounted with 'nodev' option.
  *
+ * @may_kmemleak: If set the test may cause a kernel memory leak. If such test
+ *                fails it's a good idea to reboot before continuing with
+ *                subsequent testcases.
+ *
  * @restore_wallclock: Saves wall clock at the start of the test and restores
  *                     it at the end with the help of monotonic timers.
  *                     Testcases that modify system wallclock use this to
@@ -575,7 +579,7 @@ struct tst_fs {
 	unsigned int skip_in_lockdown:1;
 	unsigned int skip_in_secureboot:1;
 	unsigned int skip_in_compat:1;
-
+	unsigned int may_kmemleak:1;
 
 	int needs_abi_bits;
 
diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index a0f94511d..532cbe405 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -1141,6 +1141,7 @@ static struct typemap tst_test_typemap[] = {
 	{.id = "needs_hugetlbfs", .type = DATA_BOOL},
 	{.id = "needs_cgroup_nsdelegate", .type = DATA_BOOL},
 	{.id = "needs_cmds", .child = needs_cmds_typemap},
+	{.id = "may_kmemleak", .type = DATA_BOOL},
 	{}
 };
 
diff --git a/testcases/cve/cve-2022-4378.c b/testcases/cve/cve-2022-4378.c
index 1cb8ea76c..8213d1b20 100644
--- a/testcases/cve/cve-2022-4378.c
+++ b/testcases/cve/cve-2022-4378.c
@@ -86,6 +86,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.setup = setup,
 	.cleanup = cleanup,
+	.may_kmemleak = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
index 80fb84c47..edc6b2aa5 100644
--- a/testcases/cve/cve-2025-21756.c
+++ b/testcases/cve/cve-2025-21756.c
@@ -87,6 +87,7 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.may_kmemleak = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "fcdd2242c023"},
 		{"CVE", "2025-21756"},
diff --git a/testcases/cve/cve-2025-38236.c b/testcases/cve/cve-2025-38236.c
index 16582fe64..f6199c06b 100644
--- a/testcases/cve/cve-2025-38236.c
+++ b/testcases/cve/cve-2025-38236.c
@@ -88,6 +88,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.may_kmemleak = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_AF_UNIX_OOB=y",
 		NULL
diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 937ab1758..2de7aba97 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -159,6 +159,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.may_kmemleak = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a664bf3d603d"},
 		{"CVE", "2026-31431"},
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index 43fd4c4a8..68f073836 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -88,6 +88,7 @@ static struct tst_test test = {
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
+	.may_kmemleak = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.skip_filesystems = (const char *const []){"fuse", NULL},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/io_uring/io_uring04.c b/testcases/kernel/syscalls/io_uring/io_uring04.c
index 026caf334..f3b44749e 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring04.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring04.c
@@ -344,6 +344,7 @@ static struct tst_test test = {
 	.timeout = 60,
 	.forks_child = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.may_kmemleak = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_RDS",
 		"CONFIG_RDS_TCP",
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index 389cc3511..cfd563d81 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -127,6 +127,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.may_kmemleak = 1,
 	.runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "7bdb157cdebb"},
diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
index 2ca77c40f..33905f2a6 100644
--- a/testcases/network/sockets/xfrm01.c
+++ b/testcases/network/sockets/xfrm01.c
@@ -261,6 +261,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
+	.may_kmemleak = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
index cef9e7060..f99b7b53a 100644
--- a/testcases/network/sockets/xfrm02.c
+++ b/testcases/network/sockets/xfrm02.c
@@ -251,6 +251,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.may_kmemleak = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
index 676c76e2b..2c83e3ae3 100644
--- a/testcases/network/sockets/xfrm03.c
+++ b/testcases/network/sockets/xfrm03.c
@@ -342,6 +342,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
+	.may_kmemleak = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
