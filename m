Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE554CCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:47:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2858E3CE226
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:47:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F04B63CE2C6
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 88E3064787E
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5B401F7A2;
 Tue,  7 Oct 2025 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T457ECOyFH9FGPlpeq6ng/WILkC+Gc18DwyIXtktEKI=;
 b=sden8rZCxUADyh8pK7yGCeLRZB/+ymPUrmYzRvAHoHP09rQi8118P0x+7XimJRmg+nleZF
 4+TUTHIqEbspPs//dsCnyHCXimwJ5afF8VLcjsMMZ/UNbZYAvcxIouxWRtdocUHd1Gwfbt
 kWDX7xDGKFfgS2z1u4l/7CaXCsS/hZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T457ECOyFH9FGPlpeq6ng/WILkC+Gc18DwyIXtktEKI=;
 b=ZjgUszVNtuSbeG9WRRVdVJdIkiMSyZAzp+J9NaLh+Wp+5emNXiRoE3Dx/rxuBmpq1SLRhY
 RplyxkJ4w2svbjAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zKy4paDK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=412Ud6NI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T457ECOyFH9FGPlpeq6ng/WILkC+Gc18DwyIXtktEKI=;
 b=zKy4paDKvYISRmdnU/oTug5PtuFTpiPwGKj7XL6aU6pXaGpEFTB6U7MspYl01Ie3K8LpXg
 EFI3WG06g0FmPGv+NUq7b1J3DPPQcajUmMFfx7g7UJSN0GFY9lXOMeNMFXkmhp3+RRmUd2
 QkkpchomDz/6UdtSeSFjhANyB1P2zjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T457ECOyFH9FGPlpeq6ng/WILkC+Gc18DwyIXtktEKI=;
 b=412Ud6NIKw8Tp5I17km1rfEOlCLvj1b4uV14RyiOm2wUHe/6eZ2sjLRzBZZhsGXAyqlkRW
 wBz326MTUL9YS5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43F3413AAC;
 Tue,  7 Oct 2025 06:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oCNEAmy35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:53 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-1-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=1792;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=7RPPbMhhtkTtCTsNOZsZEmqHQTa2qMO0g3hV2ZnisyM=;
 b=yehifjnQzSwTH8TwM4kfZkhgN6maxiMl7X+ICNQkS6+pE9x9jNws/C2NXWJ2KBXZuIzaHA40E
 So+Mp7hJj6KCWWXv8llQOVLGmQJ+pTKTMQpGRTHm7NvBm7n1IEwjW+v
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E5B401F7A2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 01/10] lapi: add struct xattr_args fallback
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
 configure.ac         |  2 ++
 include/lapi/xattr.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/configure.ac b/configure.ac
index 0480f46ca..c32d9992c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,6 +83,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/tty.h \
     linux/types.h \
     linux/userfaultfd.h \
+    linux/xattr.h \
     netinet/sctp.h \
     pthread.h \
     sys/epoll.h \
@@ -266,6 +267,7 @@ AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
 AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
 AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
 #include <linux/mount.h>])
+AC_CHECK_TYPES([struct xattr_args],,,[#include <linux/xattr.h>])
 
 AC_CHECK_TYPES([struct pidfd_info],,,[#include <sys/pidfd.h>])
 AC_CHECK_TYPES([struct file_attr],,,[#include <linux/fs.h>])
diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
new file mode 100644
index 000000000..8bd2d45e4
--- /dev/null
+++ b/include/lapi/xattr.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Linux Test Project
+ */
+
+#ifndef LAPI_XATTR_H__
+#define LAPI_XATTR_H__
+
+#include <stdint.h>
+#include "config.h"
+
+#ifdef HAVE_LINUX_XATTR_H
+# include <linux/xattr.h>
+#endif
+
+#ifndef XATTR_CREATE
+# define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
+#endif
+
+#ifndef XATTR_REPLACE
+# define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
+#endif
+
+#ifndef HAVE_STRUCT_XATTR_ARGS
+struct xattr_args {
+	uint64_t value;
+	uint32_t size;
+	uint32_t flags;
+};
+#endif
+
+#endif /* LAPI_XATTR_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
