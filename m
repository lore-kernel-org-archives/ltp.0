Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E7C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:39:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8331B3DCD69
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:39:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A9B53E56A2
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FFAE200049
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 170303E5E;
 Tue, 14 Jul 2026 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=yWdF+Crj58qn3FB0do4h2nrwLID3SPiph+/i+36aultaqlwXlDSgOqO2B86rG0GGatt2Vu
 h9ktabfML9GgPN06qL5xWYON7SGj+8pYgPaJRK+vG7iq9cZpA0BZq2q7Ct6ep1b6hVSVMU
 b6QC4o3K0+A8/30WJpOPcSUILrXWcWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=toJvvE7GFmDGjZhqAS9HKrgpwsPqaznv1VjvoJLlouin1etC5PMMYVCI4K0A8gfaxutmUN
 IBBGoEiqcrI6snBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yWdF+Crj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=toJvvE7G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=yWdF+Crj58qn3FB0do4h2nrwLID3SPiph+/i+36aultaqlwXlDSgOqO2B86rG0GGatt2Vu
 h9ktabfML9GgPN06qL5xWYON7SGj+8pYgPaJRK+vG7iq9cZpA0BZq2q7Ct6ep1b6hVSVMU
 b6QC4o3K0+A8/30WJpOPcSUILrXWcWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=toJvvE7GFmDGjZhqAS9HKrgpwsPqaznv1VjvoJLlouin1etC5PMMYVCI4K0A8gfaxutmUN
 IBBGoEiqcrI6snBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5536779AF;
 Tue, 14 Jul 2026 08:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEh5MaP1VWo3OQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 08:38:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:38:58 +0200
MIME-Version: 1.0
Message-Id: <20260714-cve-2026-46331-v5-1-bab4ac23c1f7@suse.com>
References: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
In-Reply-To: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784018339; l=835;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rDmYVzFJAfqTON111E0jOWBzVZXDu66ynX6Rw5PC++U=;
 b=PPR683UEWQOwKivChdg+CjWMfhYgNsXKyqMXjCuacmQ/eIQKo5eEPCK1CPEPe/hZSWMmoeO6Y
 eCf/RJOSm0hAvBA8/xp7QnELODP3b2ATBR2h990jXcfdHr925PtlTa5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 170303E5E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/4] lapi: Add pkt_cls.h fallback
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/pkt_cls.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

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

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
