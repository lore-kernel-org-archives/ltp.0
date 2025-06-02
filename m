Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E89CC54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:44:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD82A3C9E68
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:44:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 064353C9DB1
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEF8D1000237
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 577381F799;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caFpR9v3tJu22cfrL3NyoJ8ltrFo5tmAD/Q+akkaNSI=;
 b=z+lWo8jggYUHAZwB4CxCGaew0PRlLQXs9+YzZNKuJnnDXJdxeyUjTxalb9vXVLRfwA2cC9
 +QbqO8J3qNZf1jofqOAECGmpPxB4wGkKw1xOQn4IUhZnZLEDZwulMNenfC6JS7W5srVYx/
 KJPkYSNJmPORWYjWfBADuCdpwqptY1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caFpR9v3tJu22cfrL3NyoJ8ltrFo5tmAD/Q+akkaNSI=;
 b=TIeTj296AuyUrlxj4Q6gyfmgF/PrHgt17NNHqbRI2P8jKPHqXWOZPVFSvgGVSu+qWBpSZ5
 t2CffTrCOyo8/gCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caFpR9v3tJu22cfrL3NyoJ8ltrFo5tmAD/Q+akkaNSI=;
 b=fnyDwfJ0RDsXFonj5m37I585zUyJQqeMdtxLtIBgQw5VYwgS6NKHUuUMWXDRKgAMEsiq+4
 eIhOxUfgs0nNcWJufOGqYsdR9z+MwQkaCOYzXTNvHicfhQGe8T7XIPiWxPZ3gRmI9Ii19J
 hTorvalV3RjJm4sjbB67e1tU8aOMJNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caFpR9v3tJu22cfrL3NyoJ8ltrFo5tmAD/Q+akkaNSI=;
 b=p7iPIArGhV7N9WgjwYysaR7e77fiE3OjzQ6Qjd1DORbJj7hiNUgpLuC+mVxVsR3VJ/GPU6
 TQ9ov85rfyhBNZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29D3413AE0;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6KpGCGHUPWgGFwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Jun 2025 16:42:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Jun 2025 18:41:24 +0200
MIME-Version: 1.0
Message-Id: <20250602-lsm-v5-1-5c0dd01df3c4@suse.com>
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
In-Reply-To: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748882528; l=5566;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=A9Eok+Y3FKDUOA0RJJ7NZfEENwU90yKiEYYClDQbGvk=;
 b=3xeL2KZZPX8eGePxHnDumwHPX2wQ6dp2+DYOvlG4Vc82W7rJ/57jDZ8EL/ZA0+AnmdZMuHY9Q
 kMUpcQ8cbb9AtC0rZXmskTdejG7G1gmldxVwjw8OQUtC5yY0di+/DWN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/7] Add fallback definitions of LSM syscalls
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac       |   3 +-
 include/lapi/lsm.h | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 7f475f6b6419ee14125dada3ddd7d9ea06eb6b48..9ff098b273b9298b4d0ddcd43fb6aefdddf44f0c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,6 +69,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/ioprio.h \
     linux/keyctl.h \
     linux/landlock.h \
+    linux/lsm.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/mount.h \
@@ -204,7 +205,7 @@ AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
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
index 0000000000000000000000000000000000000000..72ca85f784282190b1db9fac3da79a562f93f43a
--- /dev/null
+++ b/include/lapi/lsm.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
+#endif
+
+#include <stdint.h>
+#include "lapi/syscalls.h"
+
+#define CTX_DATA_SIZE 4096
+
+#define LSM_CTX_SIZE(x) (sizeof(struct lsm_ctx) + x)
+#define LSM_CTX_SIZE_DEFAULT LSM_CTX_SIZE(CTX_DATA_SIZE)
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
+	uint8_t ctx[];
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

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
