Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB7DCE8D72
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 10:25:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C0783C2FBD
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:25:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1E673C2F65
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:20 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 935DD1416723
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B91DC208AD
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WigQYNlNGdd76dVYZeORjz450TANJiwq1rJsO8HQqsQ=;
 b=wJSbSrLa3n2TbcBf9umA772BzGowkY6Vu+7Zns6N9C119l9c+C8Gyd33APRmEO9JvyfFNW
 exJjXZ2KD+OPwFZqz2Zsbxw5Cza57Ct0S9ToaITtPJH404hlUGJXg0WrprugD7IIgujz6H
 SKFkulpZcTXEK0UhYtxR0TrkwjFS8mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WigQYNlNGdd76dVYZeORjz450TANJiwq1rJsO8HQqsQ=;
 b=NOoIxF+T3RndjjFnQb6kxNN2knwWq3hNiopjc5/VpRwMmXJe+qu7g3Kc4ZKeJ7leSYGGEy
 iT6p7QcyO+7ffdCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wJSbSrLa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NOoIxF+T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WigQYNlNGdd76dVYZeORjz450TANJiwq1rJsO8HQqsQ=;
 b=wJSbSrLa3n2TbcBf9umA772BzGowkY6Vu+7Zns6N9C119l9c+C8Gyd33APRmEO9JvyfFNW
 exJjXZ2KD+OPwFZqz2Zsbxw5Cza57Ct0S9ToaITtPJH404hlUGJXg0WrprugD7IIgujz6H
 SKFkulpZcTXEK0UhYtxR0TrkwjFS8mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WigQYNlNGdd76dVYZeORjz450TANJiwq1rJsO8HQqsQ=;
 b=NOoIxF+T3RndjjFnQb6kxNN2knwWq3hNiopjc5/VpRwMmXJe+qu7g3Kc4ZKeJ7leSYGGEy
 iT6p7QcyO+7ffdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95F9A13AA7
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CHs2I5X762ZkBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Sep 2024 12:23:07 +0200
MIME-Version: 1.0
Message-Id: <20240919-landlock_network-v1-1-9c997f03bd0a@suse.com>
References: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
In-Reply-To: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726741397; l=15651;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=CMSATFfz32bGQp3pGL0W3Q5Z4S13YfTaY7IHF+l6hNo=;
 b=O8mfDeHi4IAMt+23KD4aijy2bncIKMrGmyI6mx7Mvujt6CTtFleWkTWVGK2lU35sC7aDQrvtT
 7sQRBL6uap6Dkrezw+k20l5IhmcltujZWhQ3u5l+Z8EzvnsZwQzW/yG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: B91DC208AD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_ONE(0.00)[1];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,configure.ac:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] Fallback landlock network support
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

Landlock network support has been added in the ABI v4, adding features
for bind() and connect() syscalls. It also defined one more member in
the landlock_ruleset_attr struct, breaking our LTP fallbacks, used to
build landlock testing suite. For this reason, we introduce a
tst_landlock_ruleset_attr struct that wraps the base struct definition
and it adds the handled_access_net member.
This struct is then passed to the SAFE_LANDLOCK_CREATE_RULESET in order
to create our ruleset.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac                                       |  1 -
 include/lapi/landlock.h                            | 39 +++++++++++++++-------
 testcases/kernel/syscalls/landlock/landlock01.c    | 18 +++++-----
 testcases/kernel/syscalls/landlock/landlock02.c    | 10 +++---
 testcases/kernel/syscalls/landlock/landlock03.c    |  8 ++---
 testcases/kernel/syscalls/landlock/landlock04.c    |  8 ++---
 testcases/kernel/syscalls/landlock/landlock05.c    |  8 ++---
 testcases/kernel/syscalls/landlock/landlock06.c    |  8 ++---
 testcases/kernel/syscalls/landlock/landlock07.c    |  8 ++---
 .../kernel/syscalls/landlock/landlock_common.h     |  4 +--
 10 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/configure.ac b/configure.ac
index ebbf49e28..52860ecdc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -172,7 +172,6 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 ])
 
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
-AC_CHECK_TYPES([enum landlock_rule_type],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index 211d171eb..326e9c7b6 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -7,6 +7,7 @@
 #define LAPI_LANDLOCK_H__
 
 #include "config.h"
+#include <stdint.h>
 
 #ifdef HAVE_LINUX_LANDLOCK_H
 # include <linux/landlock.h>
@@ -14,13 +15,27 @@
 
 #include "lapi/syscalls.h"
 
-#ifndef HAVE_STRUCT_LANDLOCK_RULESET_ATTR
-struct landlock_ruleset_attr
+/*
+ * This is a complete fallback struct for the landlock_ruleset_attr struct
+ */
+struct tst_landlock_ruleset_attr_fallback
 {
 	uint64_t handled_access_fs;
 	uint64_t handled_access_net;
 };
-#endif
+
+struct tst_landlock_ruleset_attr
+{
+	union {
+#if !defined(HAVE_STRUCT_LANDLOCK_RULESET_ATTR) || \
+	!defined(HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET)
+		struct tst_landlock_ruleset_attr_fallback base;
+#else
+		struct landlock_ruleset_attr base;
+#endif
+		struct tst_landlock_ruleset_attr_fallback data;
+	};
+};
 
 #ifndef HAVE_STRUCT_LANDLOCK_PATH_BENEATH_ATTR
 struct landlock_path_beneath_attr
@@ -30,12 +45,12 @@ struct landlock_path_beneath_attr
 } __attribute__((packed));
 #endif
 
-#ifndef HAVE_ENUM_LANDLOCK_RULE_TYPE
-enum landlock_rule_type
-{
-	LANDLOCK_RULE_PATH_BENEATH = 1,
-	LANDLOCK_RULE_NET_PORT,
-};
+#ifndef LANDLOCK_RULE_PATH_BENEATH
+# define LANDLOCK_RULE_PATH_BENEATH 1
+#endif
+
+#ifndef LANDLOCK_RULE_NET_PORT
+# define LANDLOCK_RULE_NET_PORT 2
 #endif
 
 #ifndef HAVE_STRUCT_LANDLOCK_NET_PORT_ATTR
@@ -123,12 +138,12 @@ struct landlock_net_port_attr
 #endif
 
 static inline int safe_landlock_create_ruleset(const char *file, const int lineno,
-	const struct landlock_ruleset_attr *attr,
+	const struct tst_landlock_ruleset_attr *attr,
 	size_t size , uint32_t flags)
 {
 	int rval;
 
-	rval = tst_syscall(__NR_landlock_create_ruleset, attr, size, flags);
+	rval = tst_syscall(__NR_landlock_create_ruleset, &attr->base, size, flags);
 	if (rval == -1) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"landlock_create_ruleset(%p, %zi, %u)",
@@ -143,7 +158,7 @@ static inline int safe_landlock_create_ruleset(const char *file, const int linen
 }
 
 static inline int safe_landlock_add_rule(const char *file, const int lineno,
-	int ruleset_fd, enum landlock_rule_type rule_type,
+	int ruleset_fd, int rule_type,
 	const void *rule_attr, uint32_t flags)
 {
 	int rval;
diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
index 083685c64..7f767c007 100644
--- a/testcases/kernel/syscalls/landlock/landlock01.c
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -17,14 +17,14 @@
 
 #include "landlock_common.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
-static struct landlock_ruleset_attr *null_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *null_attr;
 static size_t rule_size;
 static size_t rule_small_size;
 static size_t rule_big_size;
 
 static struct tcase {
-	struct landlock_ruleset_attr **attr;
+	struct tst_landlock_ruleset_attr **attr;
 	uint64_t access_fs;
 	size_t *size;
 	uint32_t flags;
@@ -44,10 +44,10 @@ static void run(unsigned int n)
 	struct tcase *tc = &tcases[n];
 
 	if (*tc->attr)
-		(*tc->attr)->handled_access_fs = tc->access_fs;
+		(*tc->attr)->base.handled_access_fs = tc->access_fs;
 
 	TST_EXP_FAIL(tst_syscall(__NR_landlock_create_ruleset,
-			*tc->attr, *tc->size, tc->flags),
+			&(*tc->attr)->base, *tc->size, tc->flags),
 		tc->exp_errno,
 		"%s",
 		tc->msg);
@@ -60,12 +60,12 @@ static void setup(void)
 {
 	verify_landlock_is_enabled();
 
-	rule_size = sizeof(struct landlock_ruleset_attr);
+	rule_size = sizeof(struct tst_landlock_ruleset_attr);
 
 #ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
-	rule_small_size = rule_size - sizeof(uint64_t) - 1;
+	rule_small_size = rule_size - 2*sizeof(uint64_t) - 1;
 #else
-	rule_small_size = rule_size - 1;
+	rule_small_size = rule_size - sizeof(uint64_t) - 1;
 #endif
 
 	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
@@ -77,7 +77,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{},
 	},
 	.caps = (struct tst_cap []) {
diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index 1a3df69c9..bdef57b55 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -20,7 +20,7 @@
 
 #include "landlock_common.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static struct landlock_path_beneath_attr *rule_null;
 static int ruleset_fd;
@@ -28,7 +28,7 @@ static int invalid_fd = -1;
 
 static struct tcase {
 	int *fd;
-	enum landlock_rule_type rule_type;
+	int rule_type;
 	struct landlock_path_beneath_attr **attr;
 	int access;
 	int parent_fd;
@@ -103,10 +103,10 @@ static void setup(void)
 {
 	verify_landlock_is_enabled();
 
-	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+	ruleset_attr->base.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0));
+		&ruleset_attr->base, sizeof(struct tst_landlock_ruleset_attr), 0));
 }
 
 static void cleanup(void)
@@ -122,7 +122,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock03.c b/testcases/kernel/syscalls/landlock/landlock03.c
index 224482255..15ed9bca0 100644
--- a/testcases/kernel/syscalls/landlock/landlock03.c
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -21,7 +21,7 @@
 
 #define MAX_STACKED_RULESETS 16
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
 static int ruleset_fd = -1;
 static int ruleset_invalid = -1;
 static int file_fd = -1;
@@ -86,10 +86,10 @@ static void setup(void)
 {
 	verify_landlock_is_enabled();
 
-	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+	ruleset_attr->base.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0));
+		&ruleset_attr->base, sizeof(struct tst_landlock_ruleset_attr), 0));
 
 	file_fd = SAFE_OPEN("junk.bin", O_CREAT, 0777);
 }
@@ -112,7 +112,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{},
 	},
 	.caps = (struct tst_cap []) {
diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
index e9dedd450..c0644f4d6 100644
--- a/testcases/kernel/syscalls/landlock/landlock04.c
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -15,7 +15,7 @@
 #include "landlock_tester.h"
 #include "tst_safe_stdio.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static int ruleset_fd = -1;
 
@@ -150,10 +150,10 @@ static void setup(void)
 
 	tst_res(TINFO, "Testing %s", variant.desc);
 
-	ruleset_attr->handled_access_fs = tester_get_all_fs_rules();
+	ruleset_attr->data.handled_access_fs = tester_get_all_fs_rules();
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
 	/* since our binary is dynamically linked, we need to enable dependences
 	 * to be read and executed
@@ -192,7 +192,7 @@ static struct tst_test test = {
 		NULL,
 	},
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
index 703f7d81c..4efe19eb5 100644
--- a/testcases/kernel/syscalls/landlock/landlock05.c
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -28,7 +28,7 @@
 #define FILENAME2 DIR2"/file"
 #define FILENAME3 DIR3"/file"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 
 static void run(void)
@@ -62,13 +62,13 @@ static void setup(void)
 
 	tst_res(TINFO, "Applying LANDLOCK_ACCESS_FS_REFER");
 
-	ruleset_attr->handled_access_fs =
+	ruleset_attr->data.handled_access_fs =
 		LANDLOCK_ACCESS_FS_READ_FILE |
 		LANDLOCK_ACCESS_FS_WRITE_FILE |
 		LANDLOCK_ACCESS_FS_REFER;
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
 	apply_landlock_rule(
 		path_beneath_attr,
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
index 1a6e59241..39e0856e3 100644
--- a/testcases/kernel/syscalls/landlock/landlock06.c
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -18,7 +18,7 @@
 #define MNTPOINT "sandbox"
 #define FILENAME MNTPOINT"/fifo"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static int file_fd = -1;
 static int dev_fd = -1;
@@ -54,10 +54,10 @@ static void setup(void)
 
 	tst_res(TINFO, "Applying LANDLOCK_ACCESS_FS_IOCTL_DEV");
 
-	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV;
+	ruleset_attr->data.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
 	apply_landlock_layer(
 		ruleset_attr,
@@ -85,7 +85,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
index 6115ad538..bb9f22df7 100644
--- a/testcases/kernel/syscalls/landlock/landlock07.c
+++ b/testcases/kernel/syscalls/landlock/landlock07.c
@@ -25,7 +25,7 @@
 #include "lapi/prctl.h"
 #include "landlock_common.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr *ruleset_attr;
 static int ruleset_fd;
 
 static pid_t spawn_houdini(void)
@@ -74,10 +74,10 @@ static void setup(void)
 {
 	verify_landlock_is_enabled();
 
-	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE;
+	ruleset_attr->data.handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE;
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
 		ruleset_attr,
-		sizeof(struct landlock_ruleset_attr),
+		sizeof(struct tst_landlock_ruleset_attr),
 		0);
 }
 
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr)},
 		{},
 	},
 	.caps = (struct tst_cap []) {
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index da91daeab..c0bf88e4c 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -58,7 +58,7 @@ static inline void enforce_ruleset(const int ruleset_fd)
 }
 
 static inline void apply_landlock_layer(
-	struct landlock_ruleset_attr *ruleset_attr,
+	struct tst_landlock_ruleset_attr *ruleset_attr,
 	struct landlock_path_beneath_attr *path_beneath_attr,
 	const char *path,
 	const int access)
@@ -66,7 +66,7 @@ static inline void apply_landlock_layer(
 	int ruleset_fd;
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr), 0);
 
 	apply_landlock_rule(path_beneath_attr, ruleset_fd, access, path);
 	enforce_ruleset(ruleset_fd);

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
