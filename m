Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC81BE77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:46:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 756223ED622
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:46:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EF163EBA21
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:20 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F8CF63006F
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6132921164;
 Wed, 18 Dec 2024 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cxhl837/hk70TsoGXM2gGAfBqi/PRQiUuaYZoyrthi4=;
 b=eZ1aa4OSVn/0rDOMl/xPomOAUTBhF086wJlQrR6wj7A1j2wrLB/fcE+uni+6jqpglQzMxa
 pnfEYUICJVBRvdwyBXWYZEbEHqEKtlKLu15C0zN8OzSlcp0lX0XQGXs0Ma7lE5dYEEdolq
 1vQF0kjYS1SYiceIRdKsF/AtWT3Q2rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cxhl837/hk70TsoGXM2gGAfBqi/PRQiUuaYZoyrthi4=;
 b=gi9xSwnJiKGUCXKk6qKTi9V+ZOwi7FbRK9xFjRRQBolIhp39wnCI07ADlNqUME6YvhMO+9
 Tr54ahUZBaQ3iMAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eZ1aa4OS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gi9xSwnJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cxhl837/hk70TsoGXM2gGAfBqi/PRQiUuaYZoyrthi4=;
 b=eZ1aa4OSVn/0rDOMl/xPomOAUTBhF086wJlQrR6wj7A1j2wrLB/fcE+uni+6jqpglQzMxa
 pnfEYUICJVBRvdwyBXWYZEbEHqEKtlKLu15C0zN8OzSlcp0lX0XQGXs0Ma7lE5dYEEdolq
 1vQF0kjYS1SYiceIRdKsF/AtWT3Q2rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cxhl837/hk70TsoGXM2gGAfBqi/PRQiUuaYZoyrthi4=;
 b=gi9xSwnJiKGUCXKk6qKTi9V+ZOwi7FbRK9xFjRRQBolIhp39wnCI07ADlNqUME6YvhMO+9
 Tr54ahUZBaQ3iMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EF23137CF;
 Wed, 18 Dec 2024 18:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n/n+ET8YY2dqcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 18:45:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 19:45:09 +0100
Message-ID: <20241218184518.16190-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218184518.16190-1-chrubis@suse.cz>
References: <20241218184518.16190-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6132921164
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/13] testcases/kernel/mem: Move get_a_numa_node()
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

Move get_a_numa_node() from the library to the ksm_common.h since the
function is used only by the ksm testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/include/mem.h    |  3 ---
 testcases/kernel/mem/ksm/ksm_common.h | 35 +++++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c        | 33 -------------------------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 7251a8839..35a1f0834 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -68,9 +68,6 @@ void write_memcg(void);
 /* cpuset/memcg - include/tst_cgroup.h */
 void write_cpusets(const struct tst_cg_group *cg, long nd);
 
-/* shared */
-unsigned int get_a_numa_node(void);
-
 void update_shm_size(size_t *shm_size);
 
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index 489d34ae0..43ea8f8c2 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -11,6 +11,7 @@
 #define KSM_COMMON_H__
 
 #include "tst_test.h"
+#include "numa_helper.h"
 
 #define DEFAULT_MEMSIZE 128
 
@@ -33,4 +34,38 @@ static inline void parse_ksm_options(char *str_size, int *size,
 		tst_brk(TBROK, "the remainder of division of size by unit is not zero.");
 }
 
+/* Warning: *DO NOT* use this function in child */
+static inline unsigned int get_a_numa_node(void)
+{
+	unsigned int nd1, nd2;
+	int ret;
+
+	ret = get_allowed_nodes(0, 2, &nd1, &nd2);
+	switch (ret) {
+	case 0:
+		break;
+	case -3:
+		tst_brk(TCONF, "requires a NUMA system.");
+	default:
+		tst_brk(TBROK | TERRNO, "1st get_allowed_nodes");
+	}
+
+	ret = get_allowed_nodes(NH_MEMS | NH_CPUS, 1, &nd1);
+	switch (ret) {
+	case 0:
+		tst_res(TINFO, "get node%u.", nd1);
+		return nd1;
+	case -3:
+		tst_brk(TCONF, "requires a NUMA system that has "
+			 "at least one node with both memory and CPU "
+			 "available.");
+	default:
+		tst_brk(TBROK | TERRNO, "2nd get_allowed_nodes");
+	}
+
+	/* not reached */
+	abort();
+}
+
+
 #endif /* KSM_COMMON_H__ */
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 16eb39cba..06271f5d3 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -593,39 +593,6 @@ void write_cpusets(const struct tst_cg_group *cg, long nd)
 
 /* shared */
 
-/* Warning: *DO NOT* use this function in child */
-unsigned int get_a_numa_node(void)
-{
-	unsigned int nd1, nd2;
-	int ret;
-
-	ret = get_allowed_nodes(0, 2, &nd1, &nd2);
-	switch (ret) {
-	case 0:
-		break;
-	case -3:
-		tst_brk(TCONF, "requires a NUMA system.");
-	default:
-		tst_brk(TBROK | TERRNO, "1st get_allowed_nodes");
-	}
-
-	ret = get_allowed_nodes(NH_MEMS | NH_CPUS, 1, &nd1);
-	switch (ret) {
-	case 0:
-		tst_res(TINFO, "get node%u.", nd1);
-		return nd1;
-	case -3:
-		tst_brk(TCONF, "requires a NUMA system that has "
-			 "at least one node with both memory and CPU "
-			 "available.");
-	default:
-		tst_brk(TBROK | TERRNO, "2nd get_allowed_nodes");
-	}
-
-	/* not reached */
-	abort();
-}
-
 void update_shm_size(size_t * shm_size)
 {
 	size_t shmmax;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
