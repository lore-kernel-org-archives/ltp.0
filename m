Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6AAC3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:19:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B54F3CF470
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 623EB3C81C3
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A4FDF1400E49
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 949221F8C3;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=fRf/+1Lzga/fyfE6tCnSEAdq8p/aG/qQ2zlWHwFEWm1PF6S8P9wKYGGSbdO9HSCL/23zoO
 gUM0ti5SUcflWJxbFi1pbp4vQK1XnpqktuR/5VlzwqUNxEOCGwwahDIitRT8J0CRlnQld3
 MQ/teXhcr8/5h9gceh4qB7XVStm1quw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=Ak6RNAsBOg731yUWhtg6fsufAqqrOuMXCqGDBwKpzcDa2I5BTvhhsmckiECuugCeZ7ORmq
 ZzcVaeusejHmPsCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=fRf/+1Lzga/fyfE6tCnSEAdq8p/aG/qQ2zlWHwFEWm1PF6S8P9wKYGGSbdO9HSCL/23zoO
 gUM0ti5SUcflWJxbFi1pbp4vQK1XnpqktuR/5VlzwqUNxEOCGwwahDIitRT8J0CRlnQld3
 MQ/teXhcr8/5h9gceh4qB7XVStm1quw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vm2AJvkraYOL74Iwtnjcb+jGQdkRSLGhlPZebJXMEhY=;
 b=Ak6RNAsBOg731yUWhtg6fsufAqqrOuMXCqGDBwKpzcDa2I5BTvhhsmckiECuugCeZ7ORmq
 ZzcVaeusejHmPsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7062B13A63;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ODd8GY2/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:13 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-2-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5266;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=PIlr3YNUI4JK/TLFWWC7ua6B3VDbex9F79cx4cd/XY8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/7InOVsgqABk2QUbCXP4hTPXcTDqwtkEb6
 GzBjQH+iXiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 RnhLDACYT9XHmRQwiE4sttymaTH3CWaUgDJmUpSM4MiTZp48uZ3KauUWF9SB82V+rbURoC7fXSH
 LAOOtq0WIsXxVve3ng8ll/IQWHjGrtZG2GwtstsHdg7z/RF83G4TxKvRxNn8mOeM8Jidvx/0hm7
 lGbtw/wEZbgU6YpUDxNTTNw3oWC7Ip5I4Dw4ninwazRBOebgcRpXovXD5n3/u+yzGSuUceGb72Y
 0AW1M0GNhcq4V73Y7eNotah1QLGcbFhutNofwFEX3iCTVAc14CMvotPXI20JkCnFwd1SfPxrkAG
 08mASN9LPafyJQe0OMeJn/NYpWvuvYEDM/DyV9X4pplClQyzBvIsOqzZZibYlK97yqbZPnwR+yb
 0aXQYHc3vMAONYZb2VXAPM71Z9m2xWSFc6aGJ0C/twRyJhr6mj5zgld3i4SaAS6YVJKXBBISQtL
 8MvvaISmP+DShtU486R9Iwu+9/qlT8l/J2ZOUHpijrq7f8OHg8DlZsCxWutev3ltysmBw=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/11] Add lapi/landlock.h fallback
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
