Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47931C43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 13:43:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 897EF3E5CF2
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 152963E5CF8
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 15:42:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6EE6A6008CC
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 15:42:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F296D75C76;
 Tue,  7 Jul 2026 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783431748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw6PtdpadSp/V2ieW7q+mbsYNPkb90nXp2Po/AKwQ14=;
 b=l09KQiAYRlTdnvbllCOT9zsLqPV2X+mLIuw8JKPMzvRMfdRN+1Q5sr8T+nKxkvCSKEF779
 qH8OcazY3U18dtNgCSjrdyi4ryUy7+0w6jwA0uysF6Poj1vd9zk1NnWNawtix9nQZyVkWZ
 wBqDEQGG6rkyP8V0rs/bmDEpCpGV6Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783431748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw6PtdpadSp/V2ieW7q+mbsYNPkb90nXp2Po/AKwQ14=;
 b=07kTIJQbHo38/83FLZfJs4T8IIej21n9XBBYkmZ6h9Hkkgv5TlZJD6D6X6vp7WQob0owGC
 qECGCKTGXoUVABCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783431747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw6PtdpadSp/V2ieW7q+mbsYNPkb90nXp2Po/AKwQ14=;
 b=Ncioym/x+RSiyekP1g63QDokFe6V+9YNA+pETOArgU1yFhbx+GEENCeLVpTyuLMQ2N0aZk
 SR3GT10As2x6FT/bZh1EfNrd8LlPKwr+M/gQYaYEAbl6RpXlhq+X6gZJql6FK8urQN3/Aj
 6tXFehHwP/VWUtUgIZNjYMDheX1UxsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783431747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw6PtdpadSp/V2ieW7q+mbsYNPkb90nXp2Po/AKwQ14=;
 b=E9xuB7wnoxx24vheNZkJVv1njgh2ILc8BFRTRDKt5UiWrxDHAbXoAJPTKUEmOO2nhnbmfm
 PaRuapy+b2tSmnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9BAC779AF;
 Tue,  7 Jul 2026 13:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KI/OLkMCTWr8OgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Jul 2026 13:42:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Jul 2026 15:42:27 +0200
MIME-Version: 1.0
Message-Id: <20260707-cve-2026-46331-v3-1-3f6f1d697eec@suse.com>
References: <20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com>
In-Reply-To: <20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783431747; l=793;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ZM+vHyVPQytkRKiLvYkIlOTrZMgEeSHrJzJGYWnE5To=;
 b=v+jyO/SsCObWGqL1HnG6q0/4zur+hbpgiuIBKnltIQICoqgx+3qywzsb/TqeH84QZ+djnL7I3
 dksODwiSbVoCjmIZ7F5HMr/mt+BuqfLtTesAoYlF3DVMrI3q/UR4JRG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] lapi: Add pkt_cls.h fallback
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
