Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545AC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 11:59:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A5F53E9280
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:59:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7E3E3C198F
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 13:58:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C2FF41A00929
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 13:58:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACC2721BE7;
 Thu, 10 Sep 2026 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789041488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmjMgW6LqPYVLdRbO9nsnPCmSfR86QjBJqBcAp1WaCY=;
 b=n11fNg60dMCGD+DWF1w2tx10B97XrUAC6SLoEXATzxy1qwtrV34ulW+PFfFD7HF/law0P2
 xenTvvi+WEj6/2+ujVYtDqqGGKYzf+YuQgw1w1H8ibDZryJExi21XSvgF/ryPYATmiwN/V
 b/HuZsLq5WlkzRL277S+IAuV4dqz1Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789041488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmjMgW6LqPYVLdRbO9nsnPCmSfR86QjBJqBcAp1WaCY=;
 b=Zj+p4pOX/AkAqcUw9M8eBljG7WRvZQ4GNBJUx2gFBIGWwIX5oOjNqx1Uk83+gfS2b7K5E8
 p6TFZWly6QHB4eBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SMjM6zsY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P+CobeO8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789041484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmjMgW6LqPYVLdRbO9nsnPCmSfR86QjBJqBcAp1WaCY=;
 b=SMjM6zsYT7p5qP0MUigL7nNsThi+HYCa3jnnpf91QPP3BoRBrGvW4bDB4e9XjPv5oKYSe1
 VX20kG4xZi7WUh+eJDJgnAq5cpwt/zV/4/p6KDirGnhCmWxZPbYXDhCYd4ECKLtO2CRTP/
 WwWTM8Pmqftt+FrYr+gk17l2UPABGgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789041484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmjMgW6LqPYVLdRbO9nsnPCmSfR86QjBJqBcAp1WaCY=;
 b=P+CobeO8y3kr5923Qa74LfkfxoZeILpkOQbqQEo38XMtvr6TmdQ8vkw37c7miSGFbShuw2
 mgxRS+TxfMRu7hBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12BA113A5C;
 Thu, 10 Sep 2026 11:58:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDs+A0ybomq+LAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 11:58:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 13:57:56 +0200
MIME-Version: 1.0
Message-Id: <20260910-cve-ghostlock-v9-3-ff3c31791cd6@suse.com>
References: <20260910-cve-ghostlock-v9-0-ff3c31791cd6@suse.com>
In-Reply-To: <20260910-cve-ghostlock-v9-0-ff3c31791cd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789041483; l=3111;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1vzAEGDrHMHoCaBmAB4ZhEcRrVm01CdsjykiRkB2SNY=;
 b=dYBfNkv2sP9PM+q6lv8q5hgQqhOV0T+5yN0/mJmz2DkZzpOeKJppYB7ID9W3kzcjykyE/sn25
 GmB4eFe4lVeCOkahNFBBiNNxwCXS4ECoouE59hyUuyGZC39D348mwpD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ACC2721BE7
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 3/5] lapi/sched: add SAFE_SCHED_SETATTR()
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
 include/lapi/sched.h                               | 35 ++++++++++++++++++++++
 .../syscalls/sched_getattr/sched_getattr01.c       |  5 ++--
 .../syscalls/sched_setattr/sched_setattr01.c       |  2 +-
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..d623ea7cf 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -169,4 +169,39 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
 # define CLONE_INTO_CGROUP 0x200000000ULL
 #endif
 
+static inline int safe_sched_setattr(const char *file, const int lineno,
+				     pid_t pid, struct sched_attr *attr,
+				     unsigned int flags)
+{
+	int ret;
+
+	ret = sched_setattr(pid, attr, flags);
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
+ * Calls sched_setattr() and breaks the test with TBROK | TERRNO on failure.
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
