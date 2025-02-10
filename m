Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47392C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:33:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2CB53C98AA
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:33:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 046C73C984C
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D43B141784E
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD78321153;
 Mon, 10 Feb 2025 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRnShiqe9uOFooJYHYbcS4Jkzv+0Lu7hJwtWZHxJTZ4=;
 b=vp9dYTtar6DsIgj2pngFeiLkSwzRgqo4RtHMRFTCkZu1+ANyhlLadHaIqR3s/uXrxB4Rjd
 31JVWVouDUTBNRAVBb0Glrpw2xeTQOwFFO88LxkKZcpKka1uyrQJK5xOtMVJHDMveOyZVo
 7R+BMm0Ujt2mR1QSnWqHS25MEwqw3bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRnShiqe9uOFooJYHYbcS4Jkzv+0Lu7hJwtWZHxJTZ4=;
 b=xywAexrIbI/fMkqk3LekmLQ3Dqh7EJdETVuEsJ1MG9f9d8rlJ9qaGqSeqo39n/UZmrTTnp
 tQRuxJcXX1SWgYDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRnShiqe9uOFooJYHYbcS4Jkzv+0Lu7hJwtWZHxJTZ4=;
 b=vp9dYTtar6DsIgj2pngFeiLkSwzRgqo4RtHMRFTCkZu1+ANyhlLadHaIqR3s/uXrxB4Rjd
 31JVWVouDUTBNRAVBb0Glrpw2xeTQOwFFO88LxkKZcpKka1uyrQJK5xOtMVJHDMveOyZVo
 7R+BMm0Ujt2mR1QSnWqHS25MEwqw3bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRnShiqe9uOFooJYHYbcS4Jkzv+0Lu7hJwtWZHxJTZ4=;
 b=xywAexrIbI/fMkqk3LekmLQ3Dqh7EJdETVuEsJ1MG9f9d8rlJ9qaGqSeqo39n/UZmrTTnp
 tQRuxJcXX1SWgYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8D313A62;
 Mon, 10 Feb 2025 11:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9/d+JbrjqWfwYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:10 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:03 +0100
Message-ID: <20250210113212.29520-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/13] testcases/kernel/mem: Move get_a_numa_node()
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
