Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250A4C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 12:37:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 312373E7D4A
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:37:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64B863E2A3D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:37:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB10910006A6
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:37:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DDE43E20;
 Mon, 13 Jul 2026 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783946228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=Wi9r1G8tbw26RT609vlFofRsFifHTb1CuezS6StMpBKEXc9rnuqjyDxPHmY6sDKkqykGSk
 J+Dtx0bVVbfugUWYT17bp3iN/rt0TOiU0umdAZ0m6sqqhthZ2WFFKH8fY8CasfbyIXQz4V
 7EvErjFsOOrubZIf0SN7DCSe68l+dkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783946228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=2y3hrFJB2HCn4upx6CaYZEMy5iPRlOs+SJvppJOHdZe8QSFD6JSw6BVTBnDf3jGTIvE+Qc
 937obbkYxyjIQ6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783946228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=Wi9r1G8tbw26RT609vlFofRsFifHTb1CuezS6StMpBKEXc9rnuqjyDxPHmY6sDKkqykGSk
 J+Dtx0bVVbfugUWYT17bp3iN/rt0TOiU0umdAZ0m6sqqhthZ2WFFKH8fY8CasfbyIXQz4V
 7EvErjFsOOrubZIf0SN7DCSe68l+dkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783946228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgbfLxxAWF9YuzLBT1BFBCORcDqGrB2dN32YxwV8rdk=;
 b=2y3hrFJB2HCn4upx6CaYZEMy5iPRlOs+SJvppJOHdZe8QSFD6JSw6BVTBnDf3jGTIvE+Qc
 937obbkYxyjIQ6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0CC0779B0;
 Mon, 13 Jul 2026 12:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QPH+OPPbVGp+OQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jul 2026 12:37:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 14:37:07 +0200
MIME-Version: 1.0
Message-Id: <20260713-cve-2026-46331-v4-1-0089fd01ce62@suse.com>
References: <20260713-cve-2026-46331-v4-0-0089fd01ce62@suse.com>
In-Reply-To: <20260713-cve-2026-46331-v4-0-0089fd01ce62@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783946227; l=835;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=rDmYVzFJAfqTON111E0jOWBzVZXDu66ynX6Rw5PC++U=;
 b=bK+p8RvAZfIkG3/3UbIOlYqb6MoCNGTWq3ewBiMQPC6n9lSYcjaZk2/DuGAAQMdmchX0aVi9+
 CFhwJV8S1RPDcy0qwWsYM6zniu5i3RpBcKPi0OseRDTHGQpvtX4GIg1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] lapi: Add pkt_cls.h fallback
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
