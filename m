Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35F9E7719C
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:57:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73A1A3C30FE
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:57:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5CB3C308D
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8331765178B
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C1FF2117C;
 Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2J0l7Hscn2Uk4kWEje2ADucJPsmQZPLCz21kiPiGVA=;
 b=I96h2DdgoEIZucOcz/mYcHGcOIXwuALAjPMcjnZhKLCYm46ofRZBJQnamZVdfga7sgTm0b
 e6bUU2+3y1tSLYJmQ0UTORA+f5l/VskFCn5KmNXYTT6G7zXGHPQc8O265CX1nuU4S3WxMF
 ibHdb+hGOrNnBgowutW1kUpsEsXDQRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2J0l7Hscn2Uk4kWEje2ADucJPsmQZPLCz21kiPiGVA=;
 b=vJPu0Q4ft4Uev98bL1nI8QqrxqNSoZn3Mxpah+D+uNOIm2tK0XQKYMEBnz2EDmN3DM+old
 Ysu6HWDkDNlt/yDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I96h2Ddg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vJPu0Q4f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2J0l7Hscn2Uk4kWEje2ADucJPsmQZPLCz21kiPiGVA=;
 b=I96h2DdgoEIZucOcz/mYcHGcOIXwuALAjPMcjnZhKLCYm46ofRZBJQnamZVdfga7sgTm0b
 e6bUU2+3y1tSLYJmQ0UTORA+f5l/VskFCn5KmNXYTT6G7zXGHPQc8O265CX1nuU4S3WxMF
 ibHdb+hGOrNnBgowutW1kUpsEsXDQRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2J0l7Hscn2Uk4kWEje2ADucJPsmQZPLCz21kiPiGVA=;
 b=vJPu0Q4ft4Uev98bL1nI8QqrxqNSoZn3Mxpah+D+uNOIm2tK0XQKYMEBnz2EDmN3DM+old
 Ysu6HWDkDNlt/yDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B06513A86;
 Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJ6tCM8YgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 10 Jan 2025 12:55:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:40 +0100
MIME-Version: 1.0
Message-Id: <20250110-lsm-v2-1-bd38035f86bc@suse.com>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
In-Reply-To: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=5381;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=lZK0gf+epWuXt0vfHbOWJQfYm2VO5JhAToNtmnOpsRg=;
 b=o1i9sYUzIyFU4mK8ZDEWW0xS6k2ZSqh1q2yDbg5CtXZHE/2xOeJv8l2x+CoPrP06qWlYr1edb
 Az309WUPyAzDFIkX4httwlE6NDL9iM0jH5HeUPYop//nvWvW485fr1x
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 4C1FF2117C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/7] Add fallback definitions of LSM syscalls
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

Fallback definition for the following syscalls:

- lsm_get_self_attr
- lsm_set_self_attr
- lsm_list_modules

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac       |   3 +-
 include/lapi/lsm.h | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6992d75ca300ccc4cc21a45a916f6b3be1a3b8fe..99c00d1b9b4cda48cb0ce07af03b97855dcdfd36 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/ioprio.h \
     linux/keyctl.h \
     linux/landlock.h \
+    linux/lsm.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/mount.h \
@@ -196,7 +197,7 @@ AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 AC_CHECK_TYPES([struct loop_config],,,[#include <linux/loop.h>])
 AC_CHECK_TYPES([struct landlock_path_beneath_attr],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include <linux/landlock.h>])
-
+AC_CHECK_TYPES([struct lsm_ctx],,,[#include <linux/lsm.h>])
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
 #include <sys/types.h>
diff --git a/include/lapi/lsm.h b/include/lapi/lsm.h
new file mode 100644
index 0000000000000000000000000000000000000000..a4be4f40c1c7a2e76349a27a0dfdd43d159058c5
--- /dev/null
+++ b/include/lapi/lsm.h
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_LSM_H__
+#define LAPI_LSM_H__
+
+#include "config.h"
+
+#ifdef HAVE_LINUX_LSM_H
+#include <linux/lsm.h>
+#else
+
+#include <stdint.h>
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_STRUCT_LSM_CTX
+
+/**
+ * struct lsm_ctx - LSM context information
+ * @id: the LSM id number, see LSM_ID_XXX
+ * @flags: LSM specific flags
+ * @len: length of the lsm_ctx struct, @ctx and any other data or padding
+ * @ctx_len: the size of @ctx
+ * @ctx: the LSM context value
+ *
+ * The @len field MUST be equal to the size of the lsm_ctx struct
+ * plus any additional padding and/or data placed after @ctx.
+ *
+ * In all cases @ctx_len MUST be equal to the length of @ctx.
+ * If @ctx is a string value it should be nul terminated with
+ * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
+ * supported.
+ *
+ * The @flags and @ctx fields SHOULD only be interpreted by the
+ * LSM specified by @id; they MUST be set to zero/0 when not used.
+ */
+struct lsm_ctx {
+	uint64_t id;
+	uint64_t flags;
+	uint64_t len;
+	uint64_t ctx_len;
+	uint8_t ctx[4096];
+};
+#endif
+
+/*
+ * ID tokens to identify Linux Security Modules (LSMs)
+ *
+ * These token values are used to uniquely identify specific LSMs
+ * in the kernel as well as in the kernel's LSM userspace API.
+ */
+#ifndef LSM_ID_UNDEF
+# define LSM_ID_UNDEF		0
+#endif
+
+#ifndef LSM_ID_CAPABILITY
+# define LSM_ID_CAPABILITY	100
+#endif
+
+#ifndef LSM_ID_SELINUX
+# define LSM_ID_SELINUX		101
+#endif
+
+#ifndef LSM_ID_SMACK
+# define LSM_ID_SMACK		102
+#endif
+
+#ifndef LSM_ID_TOMOYO
+# define LSM_ID_TOMOYO		103
+#endif
+
+#ifndef LSM_ID_APPARMOR
+# define LSM_ID_APPARMOR	104
+#endif
+
+#ifndef LSM_ID_YAMA
+# define LSM_ID_YAMA		105
+#endif
+
+#ifndef LSM_ID_LOADPIN
+# define LSM_ID_LOADPIN		106
+#endif
+
+#ifndef LSM_ID_SAFESETID
+# define LSM_ID_SAFESETID	107
+#endif
+
+#ifndef LSM_ID_LOCKDOWN
+# define LSM_ID_LOCKDOWN	108
+#endif
+
+#ifndef LSM_ID_BPF
+# define LSM_ID_BPF		109
+#endif
+
+#ifndef LSM_ID_LANDLOCK
+# define LSM_ID_LANDLOCK	110
+#endif
+
+#ifndef LSM_ID_IMA
+# define LSM_ID_IMA		111
+#endif
+
+#ifndef LSM_ID_EVM
+# define LSM_ID_EVM		112
+#endif
+
+#ifndef LSM_ID_IPE
+# define LSM_ID_IPE		113
+#endif
+
+/*
+ * LSM_ATTR_XXX definitions identify different LSM attributes
+ * which are used in the kernel's LSM userspace API. Support
+ * for these attributes vary across the different LSMs. None
+ * are required.
+ */
+#ifndef LSM_ATTR_UNDEF
+# define LSM_ATTR_UNDEF		0
+#endif
+
+#ifndef LSM_ATTR_CURRENT
+# define LSM_ATTR_CURRENT	100
+#endif
+
+#ifndef LSM_ATTR_EXEC
+# define LSM_ATTR_EXEC		101
+#endif
+
+#ifndef LSM_ATTR_FSCREATE
+# define LSM_ATTR_FSCREATE	102
+#endif
+
+#ifndef LSM_ATTR_KEYCREATE
+# define LSM_ATTR_KEYCREATE	103
+#endif
+
+#ifndef LSM_ATTR_PREV
+# define LSM_ATTR_PREV		104
+#endif
+
+#ifndef LSM_ATTR_SOCKCREATE
+# define LSM_ATTR_SOCKCREATE	105
+#endif
+
+/*
+ * LSM_FLAG_XXX definitions identify special handling instructions
+ * for the API.
+ */
+#ifndef LSM_FLAG_SINGLE
+# define LSM_FLAG_SINGLE	0x0001
+#endif
+
+static inline int lsm_get_self_attr(uint32_t attr, struct lsm_ctx *ctx,
+				    uint32_t *size, uint32_t flags)
+{
+	return tst_syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
+}
+
+static inline int lsm_set_self_attr(uint32_t attr, struct lsm_ctx *ctx,
+				    uint32_t size, uint32_t flags)
+{
+	return tst_syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
+}
+
+static inline int lsm_list_modules(uint64_t *ids, uint32_t *size, uint32_t flags)
+{
+	return tst_syscall(__NR_lsm_list_modules, ids, size, flags);
+}
+#endif
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
