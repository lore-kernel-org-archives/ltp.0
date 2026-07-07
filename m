Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAB8C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 13:43:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86F543E5CF5
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B78E3E5D45
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 15:42:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82A68140076E
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 15:42:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6258D75D9B;
 Tue,  7 Jul 2026 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783431748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+r99laCOe3uhm6XzL67T/3BotwIpignjO/y9vEYcL/Y=;
 b=OIwQAoEZR7D2eJ2z8LjqUT6gD1vV0lPs2HoU5GQbXYYJ8ujiCId339YxTwnqWiSQtOxx8y
 myA0ZZAU8v4XqaNdJrFJeBGrDpvJFUvWMufGO1kfIHp5MPrRp0cDf64aj9oGs+DG0wa5Yb
 aFlyB5C1nYqsYM3YWL57jh0BuBD9Gps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783431748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+r99laCOe3uhm6XzL67T/3BotwIpignjO/y9vEYcL/Y=;
 b=/tJfINIh8xIfGrhVAjuNIk0wmjO92BCM0psGNnuWS2GSrtE3rUgzwDzxDZF8G6mtbkdMCT
 KeCu+0AGzpnkFkAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OIwQAoEZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/tJfINIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783431748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+r99laCOe3uhm6XzL67T/3BotwIpignjO/y9vEYcL/Y=;
 b=OIwQAoEZR7D2eJ2z8LjqUT6gD1vV0lPs2HoU5GQbXYYJ8ujiCId339YxTwnqWiSQtOxx8y
 myA0ZZAU8v4XqaNdJrFJeBGrDpvJFUvWMufGO1kfIHp5MPrRp0cDf64aj9oGs+DG0wa5Yb
 aFlyB5C1nYqsYM3YWL57jh0BuBD9Gps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783431748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+r99laCOe3uhm6XzL67T/3BotwIpignjO/y9vEYcL/Y=;
 b=/tJfINIh8xIfGrhVAjuNIk0wmjO92BCM0psGNnuWS2GSrtE3rUgzwDzxDZF8G6mtbkdMCT
 KeCu+0AGzpnkFkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EE4F779AF;
 Tue,  7 Jul 2026 13:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AK2qDEQCTWr8OgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Jul 2026 13:42:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Jul 2026 15:42:29 +0200
MIME-Version: 1.0
Message-Id: <20260707-cve-2026-46331-v3-3-3f6f1d697eec@suse.com>
References: <20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com>
In-Reply-To: <20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783431747; l=2280;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=oqbhDsc4PW+zCAsER1WR7lzTgPYMioryW5VMcwWKy3E=;
 b=981Z/7CWcRbzzJRMQLX+S7DKscgNK+9d7ChL7WS4wydxG4tWezhlY0yW5lFd0Hc/M5BAMsD8Q
 xQXA7pfLieaAYS96g5XTQHdpbAPuhsxtguqtIIb5Sap/6nH87Ctpq+y
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,configure.ac:url,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6258D75D9B
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] lapi: Add tc_pedit.h fallback
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
 configure.ac            |  2 ++
 include/lapi/tc_pedit.h | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3a1283ac3a30d85ca731ca54a281ed0c1d4bc06e..428a0096c5bab983dd78002980ab1c861e222e94 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,6 +190,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 ])
 
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
+AC_CHECK_TYPES([enum pedit_header_type],,,[#include <linux/tc_act/tc_pedit.h>])
+AC_CHECK_TYPES([enum pedit_cmd],,,[#include <linux/tc_act/tc_pedit.h>])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct clone_args],,,[#include <sched.h>])
diff --git a/include/lapi/tc_pedit.h b/include/lapi/tc_pedit.h
new file mode 100644
index 0000000000000000000000000000000000000000..811ce0cab49357e662c35fff49e8a08346ed82f4
--- /dev/null
+++ b/include/lapi/tc_pedit.h
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_TC_PEDIT_H__
+#define LAPI_TC_PEDIT_H__
+
+#include "config.h"
+#include <linux/tc_act/tc_pedit.h>
+
+#ifndef TCA_PEDIT_PARMS_EX
+# define TCA_PEDIT_PARMS_EX		4
+#endif
+
+#ifndef TCA_PEDIT_KEYS_EX
+# define TCA_PEDIT_KEYS_EX		5
+#endif
+
+#ifndef TCA_PEDIT_KEY_EX
+# define TCA_PEDIT_KEY_EX		3
+#endif
+
+#ifndef TCA_PEDIT_KEY_EX_HTYPE
+# define TCA_PEDIT_KEY_EX_HTYPE		1
+#endif
+
+#ifndef TCA_PEDIT_KEY_EX_CMD
+# define TCA_PEDIT_KEY_EX_CMD		2
+#endif
+
+#ifndef HAVE_ENUM_PEDIT_HEADER_TYPE
+enum pedit_header_type {
+	TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK = 0,
+	TCA_PEDIT_KEY_EX_HDR_TYPE_ETH,
+	TCA_PEDIT_KEY_EX_HDR_TYPE_IP4,
+	TCA_PEDIT_KEY_EX_HDR_TYPE_IP6,
+	TCA_PEDIT_KEY_EX_HDR_TYPE_TCP,
+	TCA_PEDIT_KEY_EX_HDR_TYPE_UDP,
+	__PEDIT_HDR_TYPE_MAX,
+};
+#endif
+
+#ifndef HAVE_ENUM_PEDIT_CMD
+enum pedit_cmd {
+	TCA_PEDIT_KEY_EX_CMD_SET = 0,
+	TCA_PEDIT_KEY_EX_CMD_ADD,
+	__PEDIT_CMD_MAX,
+};
+#endif
+
+#endif /* LAPI_TC_PEDIT_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
