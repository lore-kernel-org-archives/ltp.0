Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B861C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0650B3D38E3
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:02:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAAA23D073A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:20 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E95561A0199B
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2083D21BEC;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=YQacwYVKa9CQiaLPM/76qSPdvuSH6fjmtNCHwscP3BqTh/BvOXwsTyhz0yMYmDkclKVnrQ
 ohoWw4ADPf1HCrrkY9QnukKgx/qSWwWUPDJps5AbPCnxhJl3fwzAobkii5xIEJAX5BphVq
 6BmdsJ2kqxRvXAbvoE05gLC/NTLpyXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=F8fRfjb6ubQB1+mSSgGXcHCnqwENIjZhWiXmNrxBkJUQJbYYo22oTtRsCpC5ItR/dXUZx/
 mxN2wPdWXb1670Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=YQacwYVKa9CQiaLPM/76qSPdvuSH6fjmtNCHwscP3BqTh/BvOXwsTyhz0yMYmDkclKVnrQ
 ohoWw4ADPf1HCrrkY9QnukKgx/qSWwWUPDJps5AbPCnxhJl3fwzAobkii5xIEJAX5BphVq
 6BmdsJ2kqxRvXAbvoE05gLC/NTLpyXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=F8fRfjb6ubQB1+mSSgGXcHCnqwENIjZhWiXmNrxBkJUQJbYYo22oTtRsCpC5ItR/dXUZx/
 mxN2wPdWXb1670Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06E8A13A7F;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wGpmAKvMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:01:57 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-2-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5266;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=PIlr3YNUI4JK/TLFWWC7ua6B3VDbex9F79cx4cd/XY8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsydA0OlmTPR6n2TCMw+piZrcqvFf4d6dg0Oz
 5/WkGC1ZM+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MnQAKCRDLzBqyILPm
 RtolC/9zyMnDiA3NotRy6ptj6jj6wUgRYoenRz4YezLP5XzfFxbks4YPQeTapm5Y7+zsw0BCWx7
 X4UyoaAQEP1eTMVzlSIaxvzGs9ExkDQ2NSks5eZt3JgMHGoTPCmYpmCEj32FT2uPcy6eMsaeJ6O
 vqZXa2x8FQtUo1e15KVySVHSAoQ8inVL85kvk19Je+DztJ9GRuuaJLnMh7W4or1btmwrdqICbHU
 sMNNBbBezs6APTAI4HBZCpZV8V1aNP4d4iLZgJnbfzqUVyaeuMlh+M5QT1v0DprzCdONctX3V3u
 xw8Qh+EDlejrsVlX5Y2V9SGIUxCEq3RIEFXvEGmndypSiFRErI2wVkIMy1GhT+tb1ooG8SO3gCv
 mMBya14SPCOUD1SGtlx+ux5rI6sdkh5bb31dfUqOPV6S3DGdKzzg1x8Cand0TGg/d+d5+shXhbY
 o1HNIj+6GtQY08n9oyC2X6PQSBxBQnaAtZ7+VDrEr3U96U40lzbcKxahcMy+p88/KkV44=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/11] Add lapi/landlock.h fallback
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac            |   6 +++
 include/lapi/landlock.h | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/configure.ac b/configure.ac
index 82969b8d3..1f8796c87 100644
--- a/configure.ac
+++ b/configure.ac
@@ -60,6 +60,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/io_uring.h \
     linux/ioprio.h \
     linux/keyctl.h \
+    linux/landlock.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/mount.h \
@@ -157,6 +158,7 @@ AC_CHECK_FUNCS_ONCE([ \
 AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
+AC_CHECK_MEMBERS([struct landlock_ruleset_attr.handled_access_net],,,[#include <linux/landlock.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
 AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
@@ -170,6 +172,7 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 ])
 
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
+AC_CHECK_TYPES([enum landlock_rule_type],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
@@ -190,6 +193,9 @@ AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
 AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 AC_CHECK_TYPES([struct loop_config],,,[#include <linux/loop.h>])
+AC_CHECK_TYPES([struct landlock_ruleset_attr],,,[#include <linux/landlock.h>])
+AC_CHECK_TYPES([struct landlock_path_beneath_attr],,,[#include <linux/landlock.h>])
+AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include <linux/landlock.h>])
 
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
new file mode 100644
index 000000000..2ee51b340
--- /dev/null
+++ b/include/lapi/landlock.h
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_LANDLOCK_H__
+#define LAPI_LANDLOCK_H__
+
+#include "config.h"
+
+#ifdef HAVE_LINUX_LANDLOCK_H
+# include <linux/landlock.h>
+#endif
+
+#ifndef HAVE_STRUCT_LANDLOCK_RULESET_ATTR
+struct landlock_ruleset_attr
+{
+	uint64_t handled_access_fs;
+	uint64_t handled_access_net;
+};
+#endif
+
+#ifndef HAVE_STRUCT_LANDLOCK_PATH_BENEATH_ATTR
+struct landlock_path_beneath_attr
+{
+	uint64_t allowed_access;
+	int32_t parent_fd;
+} __attribute__((packed));
+#endif
+
+#ifndef HAVE_ENUM_LANDLOCK_RULE_TYPE
+enum landlock_rule_type
+{
+	LANDLOCK_RULE_PATH_BENEATH = 1,
+	LANDLOCK_RULE_NET_PORT,
+};
+#endif
+
+#ifndef HAVE_STRUCT_LANDLOCK_NET_PORT_ATTR
+struct landlock_net_port_attr
+{
+	uint64_t allowed_access;
+	uint64_t port;
+};
+#endif
+
+#ifndef LANDLOCK_CREATE_RULESET_VERSION
+# define LANDLOCK_CREATE_RULESET_VERSION	(1U << 0)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_EXECUTE
+# define LANDLOCK_ACCESS_FS_EXECUTE			(1ULL << 0)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_WRITE_FILE
+# define LANDLOCK_ACCESS_FS_WRITE_FILE		(1ULL << 1)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_READ_FILE
+# define LANDLOCK_ACCESS_FS_READ_FILE		(1ULL << 2)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_READ_DIR
+# define LANDLOCK_ACCESS_FS_READ_DIR		(1ULL << 3)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_REMOVE_DIR
+# define LANDLOCK_ACCESS_FS_REMOVE_DIR		(1ULL << 4)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_REMOVE_FILE
+# define LANDLOCK_ACCESS_FS_REMOVE_FILE		(1ULL << 5)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_CHAR
+# define LANDLOCK_ACCESS_FS_MAKE_CHAR		(1ULL << 6)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_DIR
+# define LANDLOCK_ACCESS_FS_MAKE_DIR		(1ULL << 7)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_REG
+# define LANDLOCK_ACCESS_FS_MAKE_REG		(1ULL << 8)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_SOCK
+# define LANDLOCK_ACCESS_FS_MAKE_SOCK		(1ULL << 9)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_FIFO
+# define LANDLOCK_ACCESS_FS_MAKE_FIFO		(1ULL << 10)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_BLOCK
+# define LANDLOCK_ACCESS_FS_MAKE_BLOCK		(1ULL << 11)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_MAKE_SYM
+# define LANDLOCK_ACCESS_FS_MAKE_SYM		(1ULL << 12)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_REFER
+# define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_TRUNCATE
+# define LANDLOCK_ACCESS_FS_TRUNCATE		(1ULL << 14)
+#endif
+
+#ifndef LANDLOCK_ACCESS_FS_IOCTL_DEV
+# define LANDLOCK_ACCESS_FS_IOCTL_DEV		(1ULL << 15)
+#endif
+
+#ifndef LANDLOCK_ACCESS_NET_BIND_TCP
+# define LANDLOCK_ACCESS_NET_BIND_TCP		(1ULL << 0)
+#endif
+
+#ifndef LANDLOCK_ACCESS_NET_CONNECT_TCP
+# define LANDLOCK_ACCESS_NET_CONNECT_TCP	(1ULL << 1)
+#endif
+
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
