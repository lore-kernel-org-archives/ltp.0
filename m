Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E55C624D4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 07:27:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D08783E93C4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:27:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E91F3E938F
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:26:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E759600957
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:26:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E3661FDB4;
 Thu,  3 Sep 2026 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788420401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwdLYpOltRCrKkBbChUHyiSIegVZZGhsbD5g59p8Um0=;
 b=CGnkFwi8dT9COsAJlSpFYty8e2txKcFeRBj4oeA6odtJhpVE+Z8Zz9JsHX84Ar/7wkarOi
 ngmnJf4VnTrR8fbZRc0h+QKHGfFThB1M+vERaQ05hV5ZuyD281xyixbE0irgZ61IEGMBmP
 h7NAfSIVuVKYv92eOWRDj6U2J7FKYE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788420401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwdLYpOltRCrKkBbChUHyiSIegVZZGhsbD5g59p8Um0=;
 b=H/oYw4vuCwmfjgBYbnFjOqrDEMfqFN2TwfHO3aadiRo1ZlOxV/GS5NueKQZlw69Eqb0g4K
 wGcdzVSC84J/GhCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788420397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwdLYpOltRCrKkBbChUHyiSIegVZZGhsbD5g59p8Um0=;
 b=TRBuJI6eyNdbRcf1syi1haZcC3GXi4kYNziPEylJ9TQ1ygS1uss92I/VLFt1QxoSaAppts
 bldRDRO9CkcHn55Dqx6rKuBpV3E1XEmQ9893yEO8NrzZLdr/xVeBwylMdjI1+BMx2wMSqm
 aOZdRUkNM9atS1gUHTqwXEZokDWimoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788420397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwdLYpOltRCrKkBbChUHyiSIegVZZGhsbD5g59p8Um0=;
 b=jbRnfltzLxazL1TXyFsgyyq2eWZ9K4pJsstqG7T0/31S4pCH3ldM0x5WEylSorFE15YEpK
 tUeZlFXeKBYds9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 613D913736;
 Thu,  3 Sep 2026 07:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eEQaFS0hmWqGaAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 07:26:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 09:26:35 +0200
MIME-Version: 1.0
Message-Id: <20260903-cve-ghostlock-v6-1-a3272bb81e4d@suse.com>
References: <20260903-cve-ghostlock-v6-0-a3272bb81e4d@suse.com>
In-Reply-To: <20260903-cve-ghostlock-v6-0-a3272bb81e4d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788420397; l=1853;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FIXuLR2RXIpuhp4SDYY5r3aVcvCLNzxtxmrrlu6lGro=;
 b=CoqJBbNnLLtf/mNqwKrbvmEZTQKsMCRZpvVq+HZD+EfwdhIb4tCQZrxVYOMI/Vsu+ROGY8N89
 zCYqBz9Wkh2DvVkqtUtswfY4iE9qWcNHyJhQDGFbG6+4jwcbHZFcVDo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] lapi/sched: add SAFE_SCHED_SETATTR()
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
on failure, so tests such as the CVE-2026-43499 reproducer do not have
to open-code the TEST() + tst_brk() error handling.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/sched.h | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..b068cecbb 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -34,7 +34,7 @@ struct sched_attr {
 	uint64_t sched_period;
 };
 
-static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+static inline int sched_setattr(pid_t pid, struct sched_attr *attr,
                                 unsigned int flags)
 {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
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

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
