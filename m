Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919D3C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:39:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 427693E56A7
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:39:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28253C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0FED31A00655
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B2E777D8B;
 Tue, 14 Jul 2026 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt3UdwlE56ZNonYt3A8CmEDYZYJoHGPowhnUxacPRC4=;
 b=KL1AulhAK1e1RR6w5oz871RexIlUlKCihnxN57ivlR3H4cq49gMrQPvoVhKh75DE/RVFEV
 Z8q1Q8LdsjtlEYF3P9b/tzmr1ss/ZppWM7QWlgph7YTaIIkOy4uqlhzdkQ/m5F752nVO+a
 T3Ai1yuT7tpVGOujahE9nCLQ/JMPYf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt3UdwlE56ZNonYt3A8CmEDYZYJoHGPowhnUxacPRC4=;
 b=XG/91siik6bTgzUzBmfquxu0Rg/voPXHoYF2dTRgv5MVTouVDRWokfxSf3Q2GuBM8uN8l0
 dNGCrnRYdtRHJrDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt3UdwlE56ZNonYt3A8CmEDYZYJoHGPowhnUxacPRC4=;
 b=KL1AulhAK1e1RR6w5oz871RexIlUlKCihnxN57ivlR3H4cq49gMrQPvoVhKh75DE/RVFEV
 Z8q1Q8LdsjtlEYF3P9b/tzmr1ss/ZppWM7QWlgph7YTaIIkOy4uqlhzdkQ/m5F752nVO+a
 T3Ai1yuT7tpVGOujahE9nCLQ/JMPYf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rt3UdwlE56ZNonYt3A8CmEDYZYJoHGPowhnUxacPRC4=;
 b=XG/91siik6bTgzUzBmfquxu0Rg/voPXHoYF2dTRgv5MVTouVDRWokfxSf3Q2GuBM8uN8l0
 dNGCrnRYdtRHJrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6685A779AE;
 Tue, 14 Jul 2026 08:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gNNyFqT1VWo3OQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 08:39:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:39:00 +0200
MIME-Version: 1.0
Message-Id: <20260714-cve-2026-46331-v5-3-bab4ac23c1f7@suse.com>
References: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
In-Reply-To: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784018339; l=2490;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nmnmgJe8Z2CTN0+RPhyBFi8AAeP90CCO1Qw4PKMsnYM=;
 b=0aauz7MZBNnDEK5FveGi7lf6W4cg816YgBhr9YqMrdB/24xOh9wGWZYL/qF3e9SxpBT6Exusk
 LKHS0t4+yuwABFxEzQDghvDYVtpmifFv/q3S9iVxgWLPIjCJMpC5B9b
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, configure.ac:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/4] lapi: Add tc_pedit.h fallback
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
 configure.ac            |  6 ++++++
 include/lapi/tc_pedit.h | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3a1283ac3a30d85ca731ca54a281ed0c1d4bc06e..19fc5e1b8f5f5f94bd797ff2ba4275c29c20cb6c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,6 +190,12 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
 ])
 
 AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
+AC_CHECK_TYPES([enum pedit_header_type],,,[#include <linux/tc_act/tc_pedit.h>])
+AC_CHECK_TYPES([enum pedit_cmd],,,[#include <linux/tc_act/tc_pedit.h>])
+AC_CHECK_DECLS([TCA_PEDIT_PARMS_EX, TCA_PEDIT_KEYS_EX, TCA_PEDIT_KEY_EX,
+	TCA_PEDIT_KEY_EX_HTYPE, TCA_PEDIT_KEY_EX_CMD],,,[
+#include <linux/tc_act/tc_pedit.h>
+])
 AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct clone_args],,,[#include <sched.h>])
diff --git a/include/lapi/tc_pedit.h b/include/lapi/tc_pedit.h
new file mode 100644
index 0000000000000000000000000000000000000000..057d96efd3fb0f2556886c9774b0bd5682b14398
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
+#if !HAVE_DECL_TCA_PEDIT_PARMS_EX
+# define TCA_PEDIT_PARMS_EX		4
+#endif
+
+#if !HAVE_DECL_TCA_PEDIT_KEYS_EX
+# define TCA_PEDIT_KEYS_EX		5
+#endif
+
+#if !HAVE_DECL_TCA_PEDIT_KEY_EX
+# define TCA_PEDIT_KEY_EX		6
+#endif
+
+#if !HAVE_DECL_TCA_PEDIT_KEY_EX_HTYPE
+# define TCA_PEDIT_KEY_EX_HTYPE		1
+#endif
+
+#if !HAVE_DECL_TCA_PEDIT_KEY_EX_CMD
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
