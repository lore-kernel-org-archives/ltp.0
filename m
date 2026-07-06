Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2266C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 12:56:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB0C83E2CD8
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 14:56:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5648B3C2324
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 14:56:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D4E3140015A
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 14:56:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA14175853;
 Mon,  6 Jul 2026 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783342570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1K6D/C/mQFtBQjlUS9ePn5wESCITUL0IYWVkZIB4IJs=;
 b=RXdgXxlev/JNxEmgTdpuWZVks0Ua6qr5nhhqVj7fdIuOdJyCOX2drfvvOsKQ+xY1gFnn5l
 2lMXmuLtq3mdns4UgQM1io+2roto6fDi0qi+nr+IQWwFy5EAZVEFYyGr6GjpWL31EdDkWW
 ObRirYZ9ZGELjWIb4ii/ke6xHcV787Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783342570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1K6D/C/mQFtBQjlUS9ePn5wESCITUL0IYWVkZIB4IJs=;
 b=yLUgaHW6pfckEVuHVlBF79HUA9qXT3Lz961oRm3Mxrdx1bdlEI2g/as5lPWD2HoGpifLeT
 VjL/8tZb0/Kb4PAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RXdgXxle;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yLUgaHW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783342570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1K6D/C/mQFtBQjlUS9ePn5wESCITUL0IYWVkZIB4IJs=;
 b=RXdgXxlev/JNxEmgTdpuWZVks0Ua6qr5nhhqVj7fdIuOdJyCOX2drfvvOsKQ+xY1gFnn5l
 2lMXmuLtq3mdns4UgQM1io+2roto6fDi0qi+nr+IQWwFy5EAZVEFYyGr6GjpWL31EdDkWW
 ObRirYZ9ZGELjWIb4ii/ke6xHcV787Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783342570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1K6D/C/mQFtBQjlUS9ePn5wESCITUL0IYWVkZIB4IJs=;
 b=yLUgaHW6pfckEVuHVlBF79HUA9qXT3Lz961oRm3Mxrdx1bdlEI2g/as5lPWD2HoGpifLeT
 VjL/8tZb0/Kb4PAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C17C1779AC;
 Mon,  6 Jul 2026 12:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QHutLeqlS2rfLAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Jul 2026 12:56:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jul 2026 14:56:10 +0200
MIME-Version: 1.0
Message-Id: <20260706-cve-2026-46331-v1-1-c55d45f022d1@suse.com>
References: <20260706-cve-2026-46331-v1-0-c55d45f022d1@suse.com>
In-Reply-To: <20260706-cve-2026-46331-v1-0-c55d45f022d1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783342570; l=1662;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wAanXy+qmBPWCmVEltoIwixEtSjat7KtrRlYrWYb4nk=;
 b=EZ11uRFrfjrCez9BmFim5owrd9kG1+1wZ2rNKi15H0BYgdyxpOKrDq8c3x3zQd31b9teurznn
 sUQ4f8uaMLaBaVYMMqTn1pUdxrmANfmA2paY0YDag/d7t/23CFVXoo/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DA14175853
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi: Add pkt_sched.h and pkt_cls.h fallbacks
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

Add lapi wrappers for <linux/pkt_sched.h> and
<linux/pkt_cls.h> with fallback defines for
TC_H_CLSACT, TC_H_MIN_EGRESS, TC_ACT_PIPE and
TCA_MATCHALL_ACT.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/pkt_cls.h   | 19 +++++++++++++++++++
 include/lapi/pkt_sched.h | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/lapi/pkt_cls.h b/include/lapi/pkt_cls.h
new file mode 100644
index 0000000000000000000000000000000000000000..b7a6278f07e6fcedcb7c412e833cb01170f24f74
--- /dev/null
+++ b/include/lapi/pkt_cls.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_PKT_CLS_H__
+#define LAPI_PKT_CLS_H__
+
+#include <linux/pkt_cls.h>
+
+#ifndef TC_ACT_PIPE
+# define TC_ACT_PIPE	3
+#endif
+
+#ifndef TCA_MATCHALL_ACT
+# define TCA_MATCHALL_ACT	2
+#endif
+
+#endif /* LAPI_PKT_CLS_H__ */
diff --git a/include/lapi/pkt_sched.h b/include/lapi/pkt_sched.h
new file mode 100644
index 0000000000000000000000000000000000000000..4d7b2860df4a478214385f248995361f6f1cf282
--- /dev/null
+++ b/include/lapi/pkt_sched.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LAPI_PKT_SCHED_H__
+#define LAPI_PKT_SCHED_H__
+
+#include <linux/pkt_sched.h>
+
+#ifndef TC_H_CLSACT
+# define TC_H_CLSACT	TC_H_INGRESS
+#endif
+
+#ifndef TC_H_MIN_EGRESS
+# define TC_H_MIN_EGRESS	0xFFF3U
+#endif
+
+#endif /* LAPI_PKT_SCHED_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
