Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E404FC88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CE5B3E922E
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:15:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1690F3E920B
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72FC71400DFF
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:14:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E10F81FEFA;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KI/HmNBtj/V+T8bYkyijHvh3mHFnrNEpJ0aHNmeoHRg=;
 b=MK6UEkLrVGvkW83UYDZ2L7+3XLvA0AWebsAnypqjQMh//OOmkswaT8NPgHhrkGkw5ruuXd
 4sqSwX4RcLF49s/nIIuxQUImXOaqw20knICB37XLWDWdDuOgKd+NSwa0f/S+3rhlwNLNzT
 2/DK3709NxMIYuNvwdXtUL8bfYv2xS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KI/HmNBtj/V+T8bYkyijHvh3mHFnrNEpJ0aHNmeoHRg=;
 b=M04WmqGmXi5iDgHtGvnPFgyEZxl9f8FqcFmPx57uMLssu3p+/qoX4A7obqBcHpB4cTjMWd
 t7mdli228F+nRvCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jyRlsI4I;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jreTZUzB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789132477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KI/HmNBtj/V+T8bYkyijHvh3mHFnrNEpJ0aHNmeoHRg=;
 b=jyRlsI4IUmN7cf/vPtogAuIVvubBu3P+dC4HAiDwFeLPL9qzh2jQJwA6sG8jCIIoYWvHyI
 YrX1NveAQVxxXLM2j2bekxXC/QKpE1oT3TXqOVmbeja1IccMsXJua0JY24PrNjmvsw4iFw
 r6BJn9sXAuz2Xx/FU2M0BuXvYZ9160c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789132477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KI/HmNBtj/V+T8bYkyijHvh3mHFnrNEpJ0aHNmeoHRg=;
 b=jreTZUzByCz66tQoTmXJTkgQPSMZuXxlv4M4v9vEoQXOjLliXAvqQpOztD858zUxWR65+q
 4geBQEpBAHl+6MCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0B8E137CA;
 Fri, 11 Sep 2026 13:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aGd+Jb3+o2qLLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 13:14:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 15:14:36 +0200
MIME-Version: 1.0
Message-Id: <20260911-cve-ghostlock-v10-3-817cfb0187eb@suse.com>
References: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
In-Reply-To: <20260911-cve-ghostlock-v10-0-817cfb0187eb@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132476; l=3188;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nhVFNaMO34ep85ugpt9a7PyXxtkKDjuWrY/9q29wlwU=;
 b=vU76ggO+HKqsFdpq7l0qcJ4zQ+5Jn67n/YKTjCfkd7Fc/GD/XQC/HaeE0uSPOnAhy+ZdXjvit
 48zzFaRAXB/DSvf6D7ml0dwplIac6ZZ8dm7U9KaCYBcHEvTNfFfqbbe
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E10F81FEFA
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.cz:email,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 3/5] lapi/sched: add SAFE_SCHED_SETATTR()
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

Add a safe variant of sched_setattr() that breaks the test with TBROK
on failure and use it in sched_setattr01 and sched_getattr01.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/sched.h                               | 36 ++++++++++++++++++++++
 .../syscalls/sched_getattr/sched_getattr01.c       |  5 ++-
 .../syscalls/sched_setattr/sched_setattr01.c       |  2 +-
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index d835537e7..c391c0d55 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -173,4 +173,40 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
 # define CLONE_INTO_CGROUP 0x200000000ULL
 #endif
 
+static inline int safe_sched_setattr(const char *file, const int lineno,
+				     pid_t pid, struct sched_attr *attr,
+				     unsigned int flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_sched_setattr, pid, attr, flags);
+
+	if (ret == -1) {
+		if (attr) {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				"sched_setattr(%i, {size=%u, policy=%u}, %u) failed",
+				pid, attr->size, attr->sched_policy, flags);
+		} else {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				"sched_setattr(%i, NULL, %u) failed", pid, flags);
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * SAFE_SCHED_SETATTR() - Safe wrapper for sched_setattr().
+ * @pid: Target process or thread ID (0 for caller).
+ * @attr: Pointer to a sched_attr structure.
+ * @flags: Flags modifying the scheduling behavior.
+ *
+ * Calls sched_setattr() via tst_syscall(). Reports TCONF if unavailable,
+ * otherwise breaks the test with TBROK | TERRNO on failure.
+ *
+ * Return: Zero on success.
+ */
+#define SAFE_SCHED_SETATTR(pid, attr, flags)\
+	safe_sched_setattr(__FILE__, __LINE__, (pid), (attr), (flags))
+
 #endif /* LAPI_SCHED_H__ */
diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
index 0edd9e47e..bd05164ca 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
@@ -34,7 +34,7 @@ static void reset_sched(void)
 		.sched_policy = SCHED_OTHER,
 	};
 
-	sched_setattr(0, &normal, 0);
+	SAFE_SCHED_SETATTR(0, &normal, 0);
 }
 
 static void run(void)
@@ -47,8 +47,7 @@ static void run(void)
 		.sched_period = PERIOD_VAL,
 	};
 
-	if (sched_setattr(0, &attr, 0) == -1)
-		tst_brk(TBROK | TERRNO, "sched_setattr() failed");
+	SAFE_SCHED_SETATTR(0, &attr, 0);
 
 	memset((void *)read_attr, 0, sizeof(*read_attr));
 
diff --git a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
index f89b829f4..93e532774 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -44,7 +44,7 @@ static void reset_sched(void)
 		.sched_policy = SCHED_OTHER,
 	};
 
-	sched_setattr(0, &normal, 0);
+	SAFE_SCHED_SETATTR(0, &normal, 0);
 }
 
 static void run(void)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
