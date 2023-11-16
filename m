Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51679C197A0
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 16:48:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABD283CE3D7
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 17:47:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14CEA3CC1C9
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C20A01A01062
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C358220502
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700153245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AedkLVkPohIZLOpObu0QOz8eFv5xtpxfyTIwUmYPSQg=;
 b=kQOyoSLbAmBm7mq1F7q5maIOLBPo42j8iAN9kgjNQ2LnojgRdiDdp12/sePw8lkMeZr07Q
 sVkxNkEPCcv5Y+xlPXiNOVmEB7wzVhwyp+T7ijNnrPFJJirhVBbqMNOpHGwbWIOy8A2uIO
 iEgPJk+AxyFFlRt5SCw/ri/Ikw/Idj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700153245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AedkLVkPohIZLOpObu0QOz8eFv5xtpxfyTIwUmYPSQg=;
 b=4a1Y5FSfur0by9Eb0nMYxMjP2zdrMu0WJrG/Qb61vDN2D9snPFcwC5hk0b9WyZQsesQyls
 0oHPSYeTxLmEmWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0A4A13AE3
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eFRAKp1HVmVtAwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Nov 2023 17:46:56 +0100
Message-ID: <20231116164723.4012-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231116164723.4012-1-mdoucha@suse.cz>
References: <20231116164723.4012-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.42 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.972]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.29)[74.54%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] Add lapi/nf_tables.h
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v2: New patch

 configure.ac             |  1 +
 include/lapi/nf_tables.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/lapi/nf_tables.h

diff --git a/configure.ac b/configure.ac
index 3fa350f9e..e1a10a10e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,7 @@ AC_PREFIX_DEFAULT(/opt/ltp)
 
 AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
 AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
+AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
 AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
 AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
 
diff --git a/include/lapi/nf_tables.h b/include/lapi/nf_tables.h
new file mode 100644
index 000000000..6b751f9cc
--- /dev/null
+++ b/include/lapi/nf_tables.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2021 Petr Vorel <petr.vorel@gmail.com>
+ */
+
+#ifndef LAPI_NF_TABLES_H__
+#define LAPI_NF_TABLES_H__
+
+#include <linux/netfilter/nf_tables.h>
+
+#ifndef HAVE_DECL_NFTA_CHAIN_ID
+# define NFTA_CHAIN_ID 11
+#endif
+
+#ifndef HAVE_DECL_NFTA_VERDICT_CHAIN_ID
+# define NFTA_VERDICT_CHAIN_ID 3
+#endif
+
+#endif /* LAPI_NF_TABLES_H__ */
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
