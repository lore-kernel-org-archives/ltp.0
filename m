Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB2FC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:53:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94AAF3E9A79
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:53:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A83C3E9A79
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:52:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B3C6200AE2
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:52:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E07FB1FE2B;
 Thu,  3 Sep 2026 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788439924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH7DGf0aqzIuJvH7GFUcZtDbUhKLj0ldYvRtJjs6rA4=;
 b=PK71taL71ILWO78iZM3b18hLfBFx8VJ21S8v5v0PY/ySihtbQIDQWqkeFQ7QWrFck5y49e
 z4WMZTIL3u/hKlahfxeel5/AvIRgpFBBpdsBkGx+wFun+FSvfsqL7n5mwfprMSS4B7XbQD
 iuFqGvY4WiNoJmgh/70Ym/cv8taoZ2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788439924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH7DGf0aqzIuJvH7GFUcZtDbUhKLj0ldYvRtJjs6rA4=;
 b=1O/rX+96akmpr4/HkFabMXwrnR34oTUWSSqkGYA6qPrurYoophCs/g+QHA9brqxEsHlKkw
 he7JzlnlWMqagdAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="r/1WgASP";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ANOG6xXC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788439919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH7DGf0aqzIuJvH7GFUcZtDbUhKLj0ldYvRtJjs6rA4=;
 b=r/1WgASPfKUO2Fuz4CRRKgfLDFD4xDqwLD5CWjkc3JPsD8q7O6EhYasDtHHiqtAC2iFC7j
 PF+BczijDGltHHHgbxsh13B9PqRq/mGFupaOfFnY7FkPUCnrX6A6LobZPiTHbl5wUebkpo
 /TC7HgMZt8TeqUcxSTq8SzkLvTN/g9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788439919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH7DGf0aqzIuJvH7GFUcZtDbUhKLj0ldYvRtJjs6rA4=;
 b=ANOG6xXCuGjcLYGcPEpKjJjJYiw50+Jqui74aet9SJiFizSz6ls3wc4UjO/P/TtZE7gzAN
 DIp9fRT2wPY3o3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E48613869;
 Thu,  3 Sep 2026 12:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPQkHG9tmWr7MgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 12:51:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 14:51:57 +0200
MIME-Version: 1.0
Message-Id: <20260903-cve-ghostlock-v7-3-771e99aa3057@suse.com>
References: <20260903-cve-ghostlock-v7-0-771e99aa3057@suse.com>
In-Reply-To: <20260903-cve-ghostlock-v7-0-771e99aa3057@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788439918; l=2886;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=y9d9josT3h9ixKPrnx3v7RCAXAhCRULCCJbMwXyWvZk=;
 b=mynHk2OgowEgFROhRIJnsCmfRsqmlBKxT+l8vPfcdT3tqZcL23jJIG4AKabE10HKispgHQZyh
 Mf9gbeF2pe2AadAFiE0Z9JRxSj4WShFWRZyEgitsu199kNqo+pnGmdw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E07FB1FE2B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/5] lapi/sched: add SAFE_SCHED_SETATTR()
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/sched.h                               | 29 ++++++++++++++++++++++
 .../syscalls/sched_getattr/sched_getattr01.c       |  5 ++--
 .../syscalls/sched_setattr/sched_setattr01.c       |  2 +-
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..22cd27e6d 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -169,4 +169,33 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
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
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"sched_setattr(%i) failed", pid);
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
index 721620850..9d121327b 100644
--- a/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
+++ b/testcases/kernel/syscalls/sched_setattr/sched_setattr01.c
@@ -130,7 +130,7 @@ static void reset_sched(void)
 		.sched_policy = SCHED_OTHER,
 	};
 
-	sched_setattr(0, &normal, 0);
+	SAFE_SCHED_SETATTR(0, &normal, 0);
 }
 
 static void verify_sched_setattr(unsigned int n)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
