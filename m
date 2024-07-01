Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD41C2BD09
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 15:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8ECF3D3FE9
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 17:43:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13ACD3D0E3E
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5FEED1401102
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 458E61FB52;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dN/WA9W+/Kdn1esLn/xmNoGL8phVxiE/3+JFK4pDbc=;
 b=08UV5SeG3Y5kriPe5PMHsFxkoKnL2juLyVNWGoQO93vfC6EQl1jUc8R2KhVw4tZnXLewhV
 J1qxsnW/AizUU0InE9LkhohOJHr+Igzwvi92gX9q+8AvkUngVj308EKAN+4b7qsMGp2FP0
 Xcn3rpCgedyGrCFdIH4CIpitnU7l1Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dN/WA9W+/Kdn1esLn/xmNoGL8phVxiE/3+JFK4pDbc=;
 b=yjqXHJeSvnl+Pc5ekzYcvDoVR6W3fdQE1VTfTSYkZNF89Xi/ohmn1Dj3I6bGvjSsOmYIA9
 fJlveBC0Ncv1v+Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=08UV5SeG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yjqXHJeS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dN/WA9W+/Kdn1esLn/xmNoGL8phVxiE/3+JFK4pDbc=;
 b=08UV5SeG3Y5kriPe5PMHsFxkoKnL2juLyVNWGoQO93vfC6EQl1jUc8R2KhVw4tZnXLewhV
 J1qxsnW/AizUU0InE9LkhohOJHr+Igzwvi92gX9q+8AvkUngVj308EKAN+4b7qsMGp2FP0
 Xcn3rpCgedyGrCFdIH4CIpitnU7l1Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dN/WA9W+/Kdn1esLn/xmNoGL8phVxiE/3+JFK4pDbc=;
 b=yjqXHJeSvnl+Pc5ekzYcvDoVR6W3fdQE1VTfTSYkZNF89Xi/ohmn1Dj3I6bGvjSsOmYIA9
 fJlveBC0Ncv1v+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22D7A13AA4;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WFBlBn7OgmZfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jul 2024 15:42:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jul 2024 17:42:07 +0200
MIME-Version: 1.0
Message-Id: <20240701-landlock-v1-2-58e9af649a72@suse.com>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-0-58e9af649a72@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5007;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=lajnZbrFF5H3nnNmTc3UFvzTlSXFNArLCb6hiRCLg48=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmgs50BhkQbOgylhVXT+8fW/QXyA27v14e/93rD
 FL7hrOFTSqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoLOdAAKCRDLzBqyILPm
 Rp/mC/9jefMzheSYts9eWg7vXV+H2ojx+T+V/T/x/E95SYwu99rC91qE/2tALBGzqqdK7ot9oJU
 7cYnz7v+RT6Svwvr6T0QpOB3S6O21+CjoNkjHmWzfUGCowlWHNH+NsRgDAZEmMGwp8MJA2y+MFm
 1pp2F3XowJE+Z6zd6NtxunIo10VHlY4foBKpdMQbVq4YSBHHZd56xEOpOZhadDKWek2RO6m4bgH
 GPEmhgWL5jIWu7l34ER89YhGPxIn2uI5r16et16J/eEjYQSgsYQuJ7uZpYwueOWonD9SB6vt5bg
 XRVVDc2CCcYGf0/I0aNKRLwcGAgFhwS2fSVQ/806aeQDkWsoVX4voqNeGseHbpddwZttx1pEgik
 y6gXMMAUjEnf013ynFpLuHLJbvFG6N+3SAZOg4GcqQ6tGm+YER2M99M+nQmek3HsHMps7DIEHY7
 S/nSpVYT6Sob0GrtKZxEprqAxoFpXQjfnuFS+nHvzvdKivmEmoQk1TSDnneto9Jx256dQ=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 458E61FB52
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/10] Add lapi/landlock.h fallback
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
 configure.ac            |   5 ++
 include/lapi/landlock.h | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/configure.ac b/configure.ac
index 82969b8d3..e5f0c9f77 100644
--- a/configure.ac
+++ b/configure.ac
@@ -157,6 +157,7 @@ AC_CHECK_FUNCS_ONCE([ \
 AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
 
 AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
+AC_CHECK_MEMBERS([struct landlock_ruleset_attr.handled_access_net],,,[#include <linux/landlock.h>])
 AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
 AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
 AC_CHECK_MEMBERS([struct statx.stx_mnt_id, struct statx.stx_dio_mem_align],,,[
@@ -170,6 +171,7 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 ])
 
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
+AC_CHECK_TYPES([enum landlock_rule_type],,,[#include <linux/landlock.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
@@ -190,6 +192,9 @@ AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
 AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
 AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
 AC_CHECK_TYPES([struct loop_config],,,[#include <linux/loop.h>])
+AC_CHECK_TYPES([struct landlock_ruleset_attr],,,[#include <linux/landlock.h>])
+AC_CHECK_TYPES([struct landlock_path_beneath_attr],,,[#include <linux/landlock.h>])
+AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include <linux/landlock.h])
 
 AC_CHECK_TYPES([struct mmsghdr],,,[
 #define _GNU_SOURCE
diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
new file mode 100644
index 000000000..634da3bbb
--- /dev/null
+++ b/include/lapi/landlock.h
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_LANDLOCK_H__
+#define LAPI_LANDLOCK_H__
+
+#include "config.h"
+#include "lapi/syscalls.h"
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
