Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6071C0219D
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:34:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ECAF3C98AE
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:34:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8C6E3C79FA
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:12 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2026A231823
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B674210FB;
 Mon, 10 Feb 2025 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQK1e4lKb+KWZNdzlf2M94nUkfF4znUELPel8UREXww=;
 b=nZSBT1el6v2U6O6/eUAfo6OMo86FdcGhxrhgeRsGMeOrHw431bOSL1UFytK2pqBLN3J5gy
 WUeXOPzB1VUo7ZhD3LLPwHMe0cETCUTbkw4lKsdgZf4ogUXAJ+iw44lbgIBii2DHx1XHeY
 9xuyd57K4bbQzDKx6cjwHZ9itaX7Rvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQK1e4lKb+KWZNdzlf2M94nUkfF4znUELPel8UREXww=;
 b=EkbZjpyHiJP9yKpl4zhrr4FxkU91DB5PKrrkiGqdWKeTrKqV5UGSNCdzRLi1QFvR1RGC2M
 OiR1JBQymPitRvAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQK1e4lKb+KWZNdzlf2M94nUkfF4znUELPel8UREXww=;
 b=nZSBT1el6v2U6O6/eUAfo6OMo86FdcGhxrhgeRsGMeOrHw431bOSL1UFytK2pqBLN3J5gy
 WUeXOPzB1VUo7ZhD3LLPwHMe0cETCUTbkw4lKsdgZf4ogUXAJ+iw44lbgIBii2DHx1XHeY
 9xuyd57K4bbQzDKx6cjwHZ9itaX7Rvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQK1e4lKb+KWZNdzlf2M94nUkfF4znUELPel8UREXww=;
 b=EkbZjpyHiJP9yKpl4zhrr4FxkU91DB5PKrrkiGqdWKeTrKqV5UGSNCdzRLi1QFvR1RGC2M
 OiR1JBQymPitRvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B32513A62;
 Mon, 10 Feb 2025 11:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJqIAbvjqWfyYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:11 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:04 +0100
Message-ID: <20250210113212.29520-6-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/13] testcases/kernel/mem: Move update_shm_size()
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

Move update_shm_size() from the lib to the libhugetlb.c since the
function is used only by the hugetlb testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/hugetlb/lib/hugetlb.c | 11 +++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h |  3 +++
 testcases/kernel/mem/include/mem.h         |  2 --
 testcases/kernel/mem/lib/mem.c             | 13 -------------
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 43a677ce9..6a2976a53 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -130,3 +130,14 @@ int do_readback(void *p, size_t size, char *desc)
 	}
 	return 0;
 }
+
+void update_shm_size(size_t * shm_size)
+{
+	size_t shmmax;
+
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%zu", &shmmax);
+	if (*shm_size > shmmax) {
+		tst_res(TINFO, "Set shm_size to shmmax: %zu", shmmax);
+		*shm_size = shmmax;
+	}
+}
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index a694514d2..abc88e25e 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -56,4 +56,7 @@ int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
 int do_readback(void *p, size_t size, char *desc);
+
+void update_shm_size(size_t *shm_size);
+
 #endif /* hugetlb.h */
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 35a1f0834..03dbe91d7 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -68,6 +68,4 @@ void write_memcg(void);
 /* cpuset/memcg - include/tst_cgroup.h */
 void write_cpusets(const struct tst_cg_group *cg, long nd);
 
-void update_shm_size(size_t *shm_size);
-
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 06271f5d3..de9388a80 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -590,16 +590,3 @@ void write_cpusets(const struct tst_cg_group *cg, long nd)
 		SAFE_CG_PRINT(cg, "cpuset.cpus", "0");
 	}
 }
-
-/* shared */
-
-void update_shm_size(size_t * shm_size)
-{
-	size_t shmmax;
-
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%zu", &shmmax);
-	if (*shm_size > shmmax) {
-		tst_res(TINFO, "Set shm_size to shmmax: %zu", shmmax);
-		*shm_size = shmmax;
-	}
-}
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
