Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE24C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7922E3D3883
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:03:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EA733D0B0F
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA37E60281D
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7747E1FCD9;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqaHv+Iv/WeXlJgg0aFzwOACzkQzBjwQLVzM9NfnMHQ=;
 b=shJB7srMLIDEnd+s9yvKiYaQ7uUTObF13jKiiEx2UQVa8/KaIpp8oG9vB0O5Q4qdJxQG0M
 pPDZpEh+rhgbqOopKRQ0tguFVfL85HUfi7qipKXuXNuJZ27+BjaxjrM0kuby9pReUMpPWV
 38yWvXofjBYiE1OgnIcSE4p1pZuihcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqaHv+Iv/WeXlJgg0aFzwOACzkQzBjwQLVzM9NfnMHQ=;
 b=JcILdc3WNfyWWN2D+M1PW7JTP4XwPWdYUJqVKMieywNL0eqQ5+HGAt7p9DZh2mGrrBN3tp
 f/ubbBlFrsrgYbBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=shJB7srM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JcILdc3W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqaHv+Iv/WeXlJgg0aFzwOACzkQzBjwQLVzM9NfnMHQ=;
 b=shJB7srMLIDEnd+s9yvKiYaQ7uUTObF13jKiiEx2UQVa8/KaIpp8oG9vB0O5Q4qdJxQG0M
 pPDZpEh+rhgbqOopKRQ0tguFVfL85HUfi7qipKXuXNuJZ27+BjaxjrM0kuby9pReUMpPWV
 38yWvXofjBYiE1OgnIcSE4p1pZuihcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqaHv+Iv/WeXlJgg0aFzwOACzkQzBjwQLVzM9NfnMHQ=;
 b=JcILdc3WNfyWWN2D+M1PW7JTP4XwPWdYUJqVKMieywNL0eqQ5+HGAt7p9DZh2mGrrBN3tp
 f/ubbBlFrsrgYbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AD3913942;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kH7mFKvMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:02:00 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-5-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6650;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=FZf2hhjKM8DtalE29v+BLL7XqC+LJQXVb38N+QYvZiY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsyeWzR08+0O5WcXel3Nf9hLcF6kaxUmYwxtI
 Hn1scYrfZ2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MngAKCRDLzBqyILPm
 Rs07C/4oPtF3xUCy6dVNdAXwVN2wsLXJnOjHpBVge4K/XzwpOb41UkgWfrnGBv6aXeqLi8fB37E
 PDc45nwSa+B3aoD3CDvSMSU7RadMkhvHcyIHdzHZwcXrkbeS4dO0/BCoqG6Rdh/Mb6oTSrZuB6a
 RvRRKJZeH+xayar92igAh+DIzOvTgIBPuba9mW74Y4wyez8NTdats0a6usQYcM6vh9SIjsZDvCq
 IJB9+eiT/sT4BL9BuxYyZvzrH4WqgrsPoRv139JRQpMRAbbH5r1TS6XwmatJfWfniGcxBI9n7FL
 5cLIm3UV1TMIjSPbXB/gPzA8w/2xjcb/21xst2+FWvxbmR+4H/jw6eW+L44eX1u6JT8Ou/IAr1l
 XSyQXVYBgft2sMS6DTtr4LZhNUBYOSNzSUp2lY8OBobNBjvuQ0yTVlgAt5X69braVj2jvc3bCKw
 zO2PANlrUU02HeI5l2vkfcU3EJBBohX15ZFDMWiY9cXN+HUKvpG1T6vwn5anyk9/TWnMg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7747E1FCD9
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/11] Add landlock01 test
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

This test verifies that landlock_create_ruleset syscall fails with the
right error codes:

- EINVAL Unknown flags, or unknown access, or too small size
- E2BIG size is too big
- EFAULT attr was not a valid address
- ENOMSG Empty accesses (i.e., attr->handled_access_fs is 0)

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  2 +
 testcases/kernel/syscalls/landlock/.gitignore      |  1 +
 testcases/kernel/syscalls/landlock/Makefile        |  7 ++
 testcases/kernel/syscalls/landlock/landlock01.c    | 92 ++++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     | 74 +++++++++++++++++
 5 files changed, 176 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b6cadb2df..667e419a3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -684,6 +684,8 @@ kill11 kill11
 kill12 kill12
 kill13 kill13
 
+landlock01 landlock01
+
 lchown01 lchown01
 lchown01_16 lchown01_16
 lchown02  lchown02
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
new file mode 100644
index 000000000..b69f9b94a
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -0,0 +1 @@
+landlock01
diff --git a/testcases/kernel/syscalls/landlock/Makefile b/testcases/kernel/syscalls/landlock/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
new file mode 100644
index 000000000..90f338fb0
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that landlock_create_ruleset syscall fails with the right
+ * error codes:
+ *
+ * - EINVAL Unknown flags, or unknown access, or too small size
+ * - E2BIG size is too big
+ * - EFAULT attr was not a valid address
+ * - ENOMSG Empty accesses (i.e., attr->handled_access_fs is 0)
+ */
+
+#include "landlock_common.h"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_ruleset_attr *null_attr;
+static size_t rule_size;
+static size_t rule_small_size;
+static size_t rule_big_size;
+
+static struct tcase {
+	struct landlock_ruleset_attr **attr;
+	uint64_t access_fs;
+	size_t *size;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{&ruleset_attr, -1, &rule_size, 0, EINVAL, "Unknown access"},
+	{&ruleset_attr, 0, &rule_small_size, 0, EINVAL, "Size is too small"},
+	{&ruleset_attr, 0, &rule_size, -1, EINVAL, "Unknown flags"},
+	{&ruleset_attr, 0, &rule_big_size, 0, E2BIG, "Size is too big"},
+	{&null_attr,    0, &rule_size, 0, EFAULT, "Invalid attr address"},
+	{&ruleset_attr, 0, &rule_size, 0, ENOMSG, "Empty accesses"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	if (*tc->attr)
+		(*tc->attr)->handled_access_fs = tc->access_fs;
+
+	TST_EXP_FAIL(tst_syscall(__NR_landlock_create_ruleset,
+			*tc->attr, *tc->size, tc->flags),
+		tc->exp_errno,
+		"%s",
+		tc->msg);
+
+	if (TST_RET >= 0)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void setup(void)
+{
+	verify_landlock_is_enabled();
+
+	rule_size = sizeof(struct landlock_ruleset_attr);
+
+#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
+	rule_small_size = rule_size - sizeof(uint64_t);
+#else
+	rule_small_size = rule_size - 1;
+#endif
+
+	rule_big_size = SAFE_SYSCONF(_SC_PAGESIZE) + 1;
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "5.13",
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		{}
+	},
+};
diff --git a/testcases/kernel/syscalls/landlock/landlock_common.h b/testcases/kernel/syscalls/landlock/landlock_common.h
new file mode 100644
index 000000000..66f8fd19a
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock_common.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LANDLOCK_COMMON_H
+
+#include "tst_test.h"
+#include "lapi/prctl.h"
+#include "lapi/fcntl.h"
+#include "lapi/landlock.h"
+
+static inline void verify_landlock_is_enabled(void)
+{
+	int abi;
+
+	abi = tst_syscall(__NR_landlock_create_ruleset,
+		NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+
+	if (abi < 0) {
+		if (errno == EOPNOTSUPP) {
+			tst_brk(TCONF, "Landlock is currently disabled. "
+				"Please enable it either via CONFIG_LSM or "
+				"'lsm' kernel parameter.");
+		}
+
+		tst_brk(TBROK | TERRNO, "landlock_create_ruleset error");
+	}
+
+	tst_res(TINFO, "Landlock ABI v%d", abi);
+}
+
+static inline void apply_landlock_rule(
+	struct landlock_path_beneath_attr *path_beneath_attr,
+	const int ruleset_fd,
+	const int access,
+	const char *path)
+{
+	path_beneath_attr->allowed_access = access;
+	path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
+
+	SAFE_LANDLOCK_ADD_RULE(
+		ruleset_fd,
+		LANDLOCK_RULE_PATH_BENEATH,
+		path_beneath_attr,
+		0);
+
+	SAFE_CLOSE(path_beneath_attr->parent_fd);
+}
+
+static inline void enforce_ruleset(const int ruleset_fd)
+{
+	SAFE_PRCTL(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, 0);
+}
+
+static inline void apply_landlock_layer(
+	struct landlock_ruleset_attr *ruleset_attr,
+	struct landlock_path_beneath_attr *path_beneath_attr,
+	const char *path,
+	const int access)
+{
+	int ruleset_fd;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	apply_landlock_rule(path_beneath_attr, ruleset_fd, access, path);
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
