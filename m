Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8E1C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 20:12:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A248E3CF4DE
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 22:12:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C8CE3CEC85
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:11:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFB59601330
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 22:11:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7A601FEB2;
 Tue, 24 Oct 2023 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698178299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UeDkOfeEMZs+oOMXEOdndalOZ9pOlHSWU1sAU4ijvQ=;
 b=dYCUBDr/E0NmjwMerykgBtyshqmcfC3+GSk3os0OMYxqoXrcHMwWVQCGaCQv1DRIEI87AU
 xuwc9TSdHEvs2igbX19rGqCMykPyTbmE/uWliWDW9Th/QNg2bRPp9w01L5AyJbbtDXK/VU
 ZrtE2Sge2n60XDdJmgDDGXeWpjtEfko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698178299;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UeDkOfeEMZs+oOMXEOdndalOZ9pOlHSWU1sAU4ijvQ=;
 b=9cMgceq3r2RAuLGMwxKwNwVEj+LadVwSMfFo6yCwflBsrJGVObrSfM6sTOVgA2KvRyWrc+
 2jyrayIfOG1l8fBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38F2413A96;
 Tue, 24 Oct 2023 20:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sP/VC/skOGVmVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 20:11:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Oct 2023 22:11:34 +0200
Message-ID: <20231024201135.264768-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024201135.264768-1-pvorel@suse.cz>
References: <20231024201135.264768-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi: Add uinput.h
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

With the only definition UI_GET_SYSNAME, which was added in kernel 3.15,
but we 3.10 (CentOS 7).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac          |  1 +
 include/lapi/uinput.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 include/lapi/uinput.h

diff --git a/configure.ac b/configure.ac
index e40a18fa0..6d3620c57 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/tls.h \
     linux/tty.h \
     linux/types.h \
+    linux/uinput.h \
     linux/userfaultfd.h \
     netinet/sctp.h \
     pthread.h \
diff --git a/include/lapi/uinput.h b/include/lapi/uinput.h
new file mode 100644
index 000000000..bdd6f466f
--- /dev/null
+++ b/include/lapi/uinput.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+ */
+
+#ifndef LAPI_UINPUT_H__
+#define LAPI_UINPUT_H__
+
+#include <linux/uinput.h>
+
+#ifndef UI_GET_SYSNAME
+# define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 44, len)
+#endif
+
+#endif	/* LAPI_UINPUT_H__ */
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
