Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE5C61D90
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 15:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E2413CC553
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 16:43:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E60813C8206
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 16:42:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 26E991A01060
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 16:42:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E72A521958;
 Tue, 21 Nov 2023 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700581355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3ahNXXyTkE8mGm9ZmGxuV+vA1arJZMBjM2Pl/Svaa4=;
 b=hOMcnUHpM4mt82FzewgAxYnLOoss932mhDPvo/qMFVQaBlfIBD9X6mDMkV/E2NYwV6BP55
 C94b+l1mcFny5Z8I21/2lgmg/mB0IrlTf74fLewM2yhIMohPdt8G7M3yrzv8lfWTDfIyna
 g+NO1tK+vMk352yRSdu5u74LcfdCJ1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700581355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3ahNXXyTkE8mGm9ZmGxuV+vA1arJZMBjM2Pl/Svaa4=;
 b=c7m1kE+1FEW3ibVsFsfcFTKznYJ+c86kMyDkZrHLX2pknMy3vR3p5Wgvcaf48aJWNGVP/m
 vAGSlxZCTBk4prAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C20FC13A6F;
 Tue, 21 Nov 2023 15:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sLliLuvPXGX+fQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 21 Nov 2023 15:42:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Nov 2023 16:42:25 +0100
Message-ID: <20231121154234.24668-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121154234.24668-1-mdoucha@suse.cz>
References: <20231121154234.24668-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.51)[80.16%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] Add lapi/nf_tables.h
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---

Changes since v2: New patch
Changes since v3: Fixed copyright header

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
index 000000000..9feb3a60e
--- /dev/null
+++ b/include/lapi/nf_tables.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 SUSE LLC <mdoucha@suse.cz>
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
