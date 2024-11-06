Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3B2D44D4C
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:14:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F283F3D318F
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 12:14:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83173CBEF3
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:13:29 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DF2C31400970
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:13:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 612ED1F8B0;
 Wed,  6 Nov 2024 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730891607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O72kbPdLiwZtHo/s+2hSrT2JpLy8B7LkWEq0kfv+xeQ=;
 b=e7p1hJ+sRl/yDvWJmNUj6+quMIsWAQlWwbFVNLkgHqxifdY5j68O9n+1+PiJNaBlnO26M6
 eaJt0y6u1HGOvKpuYleK1uWw9RcvTXH/HhjfiCJEU49WR0cOr4m/yNcRfJWphWHrnHYtyM
 DS6djrq2ZHNIii3HZG5DgWJe6Zs1I5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730891607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O72kbPdLiwZtHo/s+2hSrT2JpLy8B7LkWEq0kfv+xeQ=;
 b=Qxvef5hRHOtaMDl926xxnRplhFQCF/EWCEOYYtlIhBVgqnTRBYpLtNyaZme0TmMzIDxO7w
 dIlt+m5KpZJYNdBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730891607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O72kbPdLiwZtHo/s+2hSrT2JpLy8B7LkWEq0kfv+xeQ=;
 b=e7p1hJ+sRl/yDvWJmNUj6+quMIsWAQlWwbFVNLkgHqxifdY5j68O9n+1+PiJNaBlnO26M6
 eaJt0y6u1HGOvKpuYleK1uWw9RcvTXH/HhjfiCJEU49WR0cOr4m/yNcRfJWphWHrnHYtyM
 DS6djrq2ZHNIii3HZG5DgWJe6Zs1I5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730891607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O72kbPdLiwZtHo/s+2hSrT2JpLy8B7LkWEq0kfv+xeQ=;
 b=Qxvef5hRHOtaMDl926xxnRplhFQCF/EWCEOYYtlIhBVgqnTRBYpLtNyaZme0TmMzIDxO7w
 dIlt+m5KpZJYNdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32D2613980;
 Wed,  6 Nov 2024 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLF6CldPK2eFdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 06 Nov 2024 11:13:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 06 Nov 2024 12:13:15 +0100
MIME-Version: 1.0
Message-Id: <20241106-landlock_network-v3-1-855b14df63c6@suse.com>
References: <20241106-landlock_network-v3-0-855b14df63c6@suse.com>
In-Reply-To: <20241106-landlock_network-v3-0-855b14df63c6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730891606; l=17668;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=DE/oUnbOZCszwO2AhnSP4/1zCNR53BqfHktVdDfCCTE=;
 b=WH8TyuU0UX7u3QBQxr6S2hkAq3R2lsKD645a7t1h0Qd1rqOQdst446FNrVtb/eyPKRUvfgTSX
 x3ZAqprMUxmDWWwg6XE09ZG0eq7GVVQIp0EwCrpsoWV3+SoIu5Z8ypt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] Fallback landlock network support
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
build landlock testing suite. For this reason, we introduce
tst_landlock_ruleset_attr_abi[14] struct(s) which fallback ABI v1 and v4
ruleset_attr definitions.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac                                       |  5 ++--
 include/lapi/capability.h                          |  4 ++++
 include/lapi/landlock.h                            | 28 ++++++++++++----------
 testcases/kernel/syscalls/landlock/landlock01.c    | 15 ++++--------
 testcases/kernel/syscalls/landlock/landlock02.c    |  8 +++----
 testcases/kernel/syscalls/landlock/landlock03.c    |  6 ++---
 testcases/kernel/syscalls/landlock/landlock04.c    |  6 ++---
 testcases/kernel/syscalls/landlock/landlock05.c    | 10 ++++----
 testcases/kernel/syscalls/landlock/landlock06.c    | 14 ++++-------
 testcases/kernel/syscalls/landlock/landlock07.c    |  6 ++---
 .../kernel/syscalls/landlock/landlock_common.h     | 12 ++++------
 11 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/configure.ac b/configure.ac
index cd1233d19fad376973fc880d6689859845613fb0..6992d75ca300ccc4cc21a45a916f6b3be1a3b8fe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -34,6 +34,8 @@ m4_ifndef([PKG_CHECK_EXISTS],
 AC_PREFIX_DEFAULT(/opt/ltp)
 
 AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
+AC_CHECK_DECLS([LANDLOCK_RULE_PATH_BENEATH],,,[#include <linux/landlock.h>])
+AC_CHECK_DECLS([LANDLOCK_RULE_NET_PORT],,,[#include <linux/landlock.h>])
 AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
 AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
 AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
@@ -158,7 +160,6 @@ AC_CHECK_FUNCS_ONCE([ \
 AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
-AC_CHECK_MEMBERS([struct landlock_ruleset_attr.handled_access_net],,,[#include <linux/landlock.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
 AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
@@ -172,7 +173,6 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 ])
 
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
-AC_CHECK_TYPES([enum landlock_rule_type],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
@@ -194,7 +194,6 @@ AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
 AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 AC_CHECK_TYPES([struct loop_config],,,[#include <linux/loop.h>])
-AC_CHECK_TYPES([struct landlock_ruleset_attr],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct landlock_path_beneath_attr],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include <linux/landlock.h>])
 
diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 0f317d6d770e86b399f0fed2de04c1dce6723eae..14d2d3c12c051006875f1f864ec58a88a3870ec0 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -20,6 +20,10 @@
 # endif
 #endif
 
+#ifndef CAP_NET_BIND_SERVICE
+# define CAP_NET_BIND_SERVICE 10
+#endif
+
 #ifndef CAP_NET_RAW
 # define CAP_NET_RAW          13
 #endif
diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index 211d171ebecd92d75224369dc7f1d5c5903c9ce7..b3c8c548e661680541cdf6e4a8fb68a3f5029fec 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -7,6 +7,7 @@
 #define LAPI_LANDLOCK_H__
 
 #include "config.h"
+#include <stdint.h>
 
 #ifdef HAVE_LINUX_LANDLOCK_H
 # include <linux/landlock.h>
@@ -14,13 +15,16 @@
 
 #include "lapi/syscalls.h"
 
-#ifndef HAVE_STRUCT_LANDLOCK_RULESET_ATTR
-struct landlock_ruleset_attr
+struct tst_landlock_ruleset_attr_abi1
+{
+	uint64_t handled_access_fs;
+};
+
+struct tst_landlock_ruleset_attr_abi4
 {
 	uint64_t handled_access_fs;
 	uint64_t handled_access_net;
 };
-#endif
 
 #ifndef HAVE_STRUCT_LANDLOCK_PATH_BENEATH_ATTR
 struct landlock_path_beneath_attr
@@ -30,12 +34,12 @@ struct landlock_path_beneath_attr
 } __attribute__((packed));
 #endif
 
-#ifndef HAVE_ENUM_LANDLOCK_RULE_TYPE
-enum landlock_rule_type
-{
-	LANDLOCK_RULE_PATH_BENEATH = 1,
-	LANDLOCK_RULE_NET_PORT,
-};
+#if !HAVE_DECL_LANDLOCK_RULE_PATH_BENEATH
+# define LANDLOCK_RULE_PATH_BENEATH 1
+#endif
+
+#if !HAVE_DECL_LANDLOCK_RULE_NET_PORT
+# define LANDLOCK_RULE_NET_PORT 2
 #endif
 
 #ifndef HAVE_STRUCT_LANDLOCK_NET_PORT_ATTR
@@ -123,8 +127,7 @@ struct landlock_net_port_attr
 #endif
 
 static inline int safe_landlock_create_ruleset(const char *file, const int lineno,
-	const struct landlock_ruleset_attr *attr,
-	size_t size , uint32_t flags)
+	const void *attr, size_t size , uint32_t flags)
 {
 	int rval;
 
@@ -143,8 +146,7 @@ static inline int safe_landlock_create_ruleset(const char *file, const int linen
 }
 
 static inline int safe_landlock_add_rule(const char *file, const int lineno,
-	int ruleset_fd, enum landlock_rule_type rule_type,
-	const void *rule_attr, uint32_t flags)
+	int ruleset_fd, int rule_type, const void *rule_attr, uint32_t flags)
 {
 	int rval;
 
diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
index 083685c64fa6d1c0caab887ee03594ea1426f62f..d0d68c8e4d905b8991527cc0c225d747601919a4 100644
--- a/testcases/kernel/syscalls/landlock/landlock01.c
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -17,14 +17,14 @@
 
 #include "landlock_common.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
-static struct landlock_ruleset_attr *null_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *null_attr;
 static size_t rule_size;
 static size_t rule_small_size;
 static size_t rule_big_size;
 
 static struct tcase {
-	struct landlock_ruleset_attr **attr;
+	struct tst_landlock_ruleset_attr_abi1 **attr;
 	uint64_t access_fs;
 	size_t *size;
 	uint32_t flags;
@@ -60,13 +60,8 @@ static void setup(void)
 {
 	verify_landlock_is_enabled();
 
-	rule_size = sizeof(struct landlock_ruleset_attr);
-
-#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
-	rule_small_size = rule_size - sizeof(uint64_t) - 1;
-#else
+	rule_size = sizeof(struct tst_landlock_ruleset_attr_abi1);
 	rule_small_size = rule_size - 1;
-#endif
 
 	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
 }
@@ -77,7 +72,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{},
 	},
 	.caps = (struct tst_cap []) {
diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index 1a3df69c9cc3eda98e28cfbfd1e12c57e26d0128..8566d407f6d17ab367695125f07d0a80cf4130e5 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -20,7 +20,7 @@
 
 #include "landlock_common.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static struct landlock_path_beneath_attr *rule_null;
 static int ruleset_fd;
@@ -93,7 +93,7 @@ static void run(unsigned int n)
 	}
 
 	TST_EXP_FAIL(tst_syscall(__NR_landlock_add_rule,
-			*tc->fd, tc->rule_type, *tc->attr, tc->flags),
+		*tc->fd, tc->rule_type, *tc->attr, tc->flags),
 		tc->exp_errno,
 		"%s",
 		tc->msg);
@@ -106,7 +106,7 @@ static void setup(void)
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0));
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
 }
 
 static void cleanup(void)
@@ -122,7 +122,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock03.c b/testcases/kernel/syscalls/landlock/landlock03.c
index 224482255b287cef64f579b5707a92a6b5908f8b..150c8cc4e50ee1b41af3c8c01771c51a8715746f 100644
--- a/testcases/kernel/syscalls/landlock/landlock03.c
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -21,7 +21,7 @@
 
 #define MAX_STACKED_RULESETS 16
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static int ruleset_fd = -1;
 static int ruleset_invalid = -1;
 static int file_fd = -1;
@@ -89,7 +89,7 @@ static void setup(void)
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0));
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
 
 	file_fd = SAFE_OPEN("junk.bin", O_CREAT, 0777);
 }
@@ -112,7 +112,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{},
 	},
 	.caps = (struct tst_cap []) {
diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
index e9dedd45091ecd15cdce2fa7227bbfceb14abb5e..2485591e2196072f81708fc10cebd382e536e2a9 100644
--- a/testcases/kernel/syscalls/landlock/landlock04.c
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -15,7 +15,7 @@
 #include "landlock_tester.h"
 #include "tst_safe_stdio.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static int ruleset_fd = -1;
 
@@ -153,7 +153,7 @@ static void setup(void)
 	ruleset_attr->handled_access_fs = tester_get_all_fs_rules();
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
 
 	/* since our binary is dynamically linked, we need to enable dependences
 	 * to be read and executed
@@ -192,7 +192,7 @@ static struct tst_test test = {
 		NULL,
 	},
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
index 703f7d81c336907f360acbe45b42720dc12bac23..3d5048f0ab51b2d7c3eedc82ef80c04935ac5d86 100644
--- a/testcases/kernel/syscalls/landlock/landlock05.c
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -28,7 +28,7 @@
 #define FILENAME2 DIR2"/file"
 #define FILENAME3 DIR3"/file"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 
 static void run(void)
@@ -68,15 +68,15 @@ static void setup(void)
 		LANDLOCK_ACCESS_FS_REFER;
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
 
-	apply_landlock_rule(
+	apply_landlock_fs_rule(
 		path_beneath_attr,
 		ruleset_fd,
 		LANDLOCK_ACCESS_FS_REFER,
 		DIR1);
 
-	apply_landlock_rule(
+	apply_landlock_fs_rule(
 		path_beneath_attr,
 		ruleset_fd,
 		LANDLOCK_ACCESS_FS_REFER,
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
index 1a6e59241557db23b23beabf9863a9c51353757a..74237d11657054985f06431467fbb161ded0c1b6 100644
--- a/testcases/kernel/syscalls/landlock/landlock06.c
+++ b/testcases/kernel/syscalls/landlock/landlock06.c
@@ -18,7 +18,7 @@
 #define MNTPOINT "sandbox"
 #define FILENAME MNTPOINT"/fifo"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static int file_fd = -1;
 static int dev_fd = -1;
@@ -42,8 +42,6 @@ static void run(void)
 
 static void setup(void)
 {
-	int ruleset_fd;
-
 	if (verify_landlock_is_enabled() < 5)
 		tst_brk(TCONF, "LANDLOCK_ACCESS_FS_IOCTL_DEV is not supported");
 
@@ -56,17 +54,13 @@ static void setup(void)
 
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
-	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
-
-	apply_landlock_layer(
+	apply_landlock_fs_layer(
 		ruleset_attr,
+		sizeof(struct tst_landlock_ruleset_attr_abi1),
 		path_beneath_attr,
 		MNTPOINT,
 		LANDLOCK_ACCESS_FS_IOCTL_DEV
 	);
-
-	SAFE_CLOSE(ruleset_fd);
 }
 
 static void cleanup(void)
@@ -85,7 +79,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{},
 	},
diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
index 6115ad53876209051952873679eb96014b4dd805..8ee614856312d55e573e18f88a6690b50497ee8b 100644
--- a/testcases/kernel/syscalls/landlock/landlock07.c
+++ b/testcases/kernel/syscalls/landlock/landlock07.c
@@ -25,7 +25,7 @@
 #include "lapi/prctl.h"
 #include "landlock_common.h"
 
-static struct landlock_ruleset_attr *ruleset_attr;
+static struct tst_landlock_ruleset_attr_abi1 *ruleset_attr;
 static int ruleset_fd;
 
 static pid_t spawn_houdini(void)
@@ -77,7 +77,7 @@ static void setup(void)
 	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_WRITE_FILE;
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
 		ruleset_attr,
-		sizeof(struct landlock_ruleset_attr),
+		sizeof(struct tst_landlock_ruleset_attr_abi1),
 		0);
 }
 
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
-		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&ruleset_attr, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{},
 	},
 	.caps = (struct tst_cap []) {
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
index da91daeab7b3def7184f611a90273419e4cfa6f2..f3096f4bf15f155f2a00b39c461d0805a76306e5 100644
--- a/testcases/kernel/syscalls/landlock/landlock_common.h
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -33,7 +33,7 @@ static inline int verify_landlock_is_enabled(void)
 	return abi;
 }
 
-static inline void apply_landlock_rule(
+static inline void apply_landlock_fs_rule(
 	struct landlock_path_beneath_attr *path_beneath_attr,
 	const int ruleset_fd,
 	const int access,
@@ -57,21 +57,19 @@ static inline void enforce_ruleset(const int ruleset_fd)
 	SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, 0);
 }
 
-static inline void apply_landlock_layer(
-	struct landlock_ruleset_attr *ruleset_attr,
+static inline void apply_landlock_fs_layer(
+	void *ruleset_attr, size_t attr_size,
 	struct landlock_path_beneath_attr *path_beneath_attr,
 	const char *path,
 	const int access)
 {
 	int ruleset_fd;
 
-	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
-		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr, attr_size, 0);
 
-	apply_landlock_rule(path_beneath_attr, ruleset_fd, access, path);
+	apply_landlock_fs_rule(path_beneath_attr, ruleset_fd, access, path);
 	enforce_ruleset(ruleset_fd);
 
 	SAFE_CLOSE(ruleset_fd);
 }
-
 #endif /* LANDLOCK_COMMON_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
