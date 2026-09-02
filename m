Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ABCC61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 21:26:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AD763E9475
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 23:26:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510A23E2D93
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 23:26:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE6F81A007FD
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 23:25:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B84DA21C83;
 Wed,  2 Sep 2026 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788384354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djHo/MMA6E2BraQSvofMYmatdxQnaqC9xGxxePMIHwg=;
 b=Ohprv3hF9dsdCUmQDAy13pgqkEzFI/LnQDJ78oPyDmyGAudvJzxS+tkD2RVGkFEcyNCqSY
 WcLXUI7mv69bgbxRT1TBSsARPt5Q5jdU/YiNuinfFpxL8ZqQ8ZW61CARCDY8Pa7ogVtznJ
 cD2uNhNf5cnPbuNMc8769briY/jyCgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788384354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djHo/MMA6E2BraQSvofMYmatdxQnaqC9xGxxePMIHwg=;
 b=2hvTUZcCcxUoi7k3LJcni3yfOhCZD5jwh7cLQNyG59BFwZWwA+Tj6O9CeINW4X5PWwvGSC
 9kSWd8Oj7q2WcQAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F48sWeQk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qhEhnaaH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788384350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djHo/MMA6E2BraQSvofMYmatdxQnaqC9xGxxePMIHwg=;
 b=F48sWeQk/TpbSWCB9GO/AihL1NsLcj8qBHGll40inLsHQJ3w198Ls9Wb5qdxDAp/ePWQoK
 UNkgLF0l9HjpY7l9yGtVq1aqW0whWSo9s2k9Ruk0UEHNtAgE7bwXwj3b7jowuEvlpPk1BZ
 95M6sSogn14pQcj5oSEjg6sFqEIuRPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788384350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djHo/MMA6E2BraQSvofMYmatdxQnaqC9xGxxePMIHwg=;
 b=qhEhnaaH8zHHMtBe7L7Zu1yQDyNPBmwMfNjklirV1K/E2v/+8DxzyIu5WGv5K08kWEI0ZJ
 oc7VVvxMRMvtIrBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C97913736;
 Wed,  2 Sep 2026 21:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKDTG16UmGpbMAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 21:25:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 23:25:48 +0200
MIME-Version: 1.0
Message-Id: <20260902-cve-ghostlock-v5-1-569b9eb37941@suse.com>
References: <20260902-cve-ghostlock-v5-0-569b9eb37941@suse.com>
In-Reply-To: <20260902-cve-ghostlock-v5-0-569b9eb37941@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788384350; l=1149;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=XHOFdmVNDORhbG4sdfOvHVJg9JXgwVznPPn3i3D6WXs=;
 b=VhIKei7M5AcpIwONLfxLB1NgHtsyDQE/srIAFjseWa73bWBS//qyn1BfiLqfn9t2Xf73m7hwZ
 JAhNZ6oHU2IDIgOzLOOCelaEvvpqUbEEF65YkydvT3Z5aEZJRV+sPsq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: B84DA21C83
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] lapi/sched: add SAFE_SCHED_SETATTR()
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
 include/lapi/sched.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 05b322c1c..6b49a1cda 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -169,4 +169,23 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
 # define CLONE_INTO_CGROUP 0x200000000ULL
 #endif
 
+static inline int safe_sched_setattr(const char *file, const int lineno,
+				     pid_t pid, const struct sched_attr *attr,
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
+#define SAFE_SCHED_SETATTR(pid, attr, flags)\
+	safe_sched_setattr(__FILE__, __LINE__, (pid), (attr), (flags))
+
 #endif /* LAPI_SCHED_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
