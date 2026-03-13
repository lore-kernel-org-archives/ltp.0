Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB4105F78C
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:49:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDC0D3C0372
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:48:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A66F53D0379
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB29B1A004D6
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE4EA5BD5B;
 Fri, 13 Mar 2026 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3t51JopTKKjq0tYKlFvVvhVDclv1FOiWVFxjl7cQTk=;
 b=rIBUuC36gxxVoasqFZXiHGf4MhymhHkdECTdm40rG+QqdOTbNv/R6O5eT/M8JXlanx+GYy
 kipK3Gt8ai2JliFPEJXu/UpEmoZWKuHGflzcbMr74nCyEDWj2bbDsYH3as8JhiTO2k68kg
 UIAtyinlpWPHnzimJiwxppkhtZed2UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3t51JopTKKjq0tYKlFvVvhVDclv1FOiWVFxjl7cQTk=;
 b=ZWz0mTVnxx55ZXhzQ8jOxXZ+AL2rEczgykvfw2q3sxqsAQrBgGMaEDdZk7T/JBPbkkN3x8
 MHh1HJ0QCBQ4aeBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gGkdU+2D;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vfOm7ZPa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3t51JopTKKjq0tYKlFvVvhVDclv1FOiWVFxjl7cQTk=;
 b=gGkdU+2DGrkEPYsKSbGgnhSTmFKfrw3pD1FQ11jHAFVzzz0xi3HeFDnM0TWhrzaO8HGgzs
 h4s7Ybx5T+Ct6/HcAzSS+iDPizhh5c9gLK5ZtA9TnbGVOl6h/ViBgtfMNAOAnfplld6VyM
 mESbeS4qZs+6KtjYcYnw7gscsW2j8Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3t51JopTKKjq0tYKlFvVvhVDclv1FOiWVFxjl7cQTk=;
 b=vfOm7ZPa/UO+e69uzAaBRFYp+hVhWnqXRyrpD4nipi1E+r5e2clvcYCuGZYzdnW/IfnzYQ
 336quMHVb4A/1ODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA83404E9;
 Fri, 13 Mar 2026 11:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cBsDMIT5s2lZGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:48:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:48:20 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v2-2-38384fae9b1f@suse.com>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
In-Reply-To: <20260313-listns-v2-0-38384fae9b1f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773402500; l=1287;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=AjcLmnHiPrV19z7JPdestYgUKl8Z5IC5R9XpnTEaPPw=;
 b=EW8/sQca/QFtBi2NNIjGyeYPzIveAkqvDq7P8P5UAVPL1vD5FJvMJ0s+3c/46MbUYFXPsHrMY
 s1tS2IBMUjFDh+iVITD1SpTK3Yt5OfY3zCrQgO7ZKH0lFKLO0KU0b1Z
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EE4EA5BD5B
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] Add listns fallback header
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

Create include/lapi/listns.h header file for listns syscall related
definitions.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/listns.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/lapi/listns.h b/include/lapi/listns.h
new file mode 100644
index 0000000000000000000000000000000000000000..d242d3340ee4286fb8621b1633061c8087c54e7c
--- /dev/null
+++ b/include/lapi/listns.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Linux Test Project
+ */
+
+#ifndef LAPI_LISTNS_H__
+#define LAPI_LISTNS_H__
+
+#include <stdint.h>
+#include "lapi/syscalls.h"
+#include "lapi/sched.h"
+
+#ifndef NS_ID_REQ_SIZE_VER0
+#define NS_ID_REQ_SIZE_VER0 32
+#endif
+
+#ifndef LISTNS_CURRENT_USER
+#define LISTNS_CURRENT_USER 0xffffffffffffffffULL
+#endif
+
+struct listns_req {
+	uint32_t size;
+	uint32_t spare;
+	uint64_t ns_id;
+	uint32_t ns_type;
+	uint32_t spare2;
+	uint64_t user_ns_id;
+};
+
+static inline int listns(struct listns_req *req, uint64_t *ns_ids,
+			 size_t nr_ns_ids, unsigned int flags)
+{
+	return tst_syscall(__NR_listns, req, ns_ids, nr_ns_ids, flags);
+}
+
+#endif /* LAPI_LISTNS_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
