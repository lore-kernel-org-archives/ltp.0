Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22736C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:18:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91A9A3CDE6C
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:18:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE22E3C0FBE
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 509276035F6
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBA841F8C4;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzrWvInCh61FwiyZVot96/S93WEOFLlda4g1a8Rvbtg=;
 b=fsYiFtYqYhSgOdczse/b+vCtZQLpNKMWynwiiAr4+y2RW6iS9thTvKXTqjIsWaCi8IVQrT
 2zixz8ZFjUK7l8awLuxcmQoiGWbQlh7+0cqGwHkQ1d3B1aONFto19Qdhn5aZd3ASXedjvM
 hKk1sUYLKn0pXuxwgppzfaMkQw3TJE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzrWvInCh61FwiyZVot96/S93WEOFLlda4g1a8Rvbtg=;
 b=hGFjp73ehruOT/obe9p5ga19QBRqu1bvI6a5ES3u4sh/Mat2g60TH8UiWXZJjuVZBnfmZy
 XCH7/bnWh7I2UJDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fsYiFtYq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hGFjp73e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzrWvInCh61FwiyZVot96/S93WEOFLlda4g1a8Rvbtg=;
 b=fsYiFtYqYhSgOdczse/b+vCtZQLpNKMWynwiiAr4+y2RW6iS9thTvKXTqjIsWaCi8IVQrT
 2zixz8ZFjUK7l8awLuxcmQoiGWbQlh7+0cqGwHkQ1d3B1aONFto19Qdhn5aZd3ASXedjvM
 hKk1sUYLKn0pXuxwgppzfaMkQw3TJE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzrWvInCh61FwiyZVot96/S93WEOFLlda4g1a8Rvbtg=;
 b=hGFjp73ehruOT/obe9p5ga19QBRqu1bvI6a5ES3u4sh/Mat2g60TH8UiWXZJjuVZBnfmZy
 XCH7/bnWh7I2UJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A7B4139E0;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oECII42/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:14 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-3-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2466;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=ykWuBdEgfNf7D56fkwQsx2Fd28bSbk9Xmt+WjsB/+7Q=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/E5CZUEG8zPKU6LFYRnojehgF8mVjp+1Mi
 ZJY5eYvuMGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 RrcYDACuyCADTZlIGPDzEb65oiHS1n8APHybgPQhTRrxN+R4fXovS5Y6kjKZ+GMPYZCLb7uYCdF
 AoUPKjUiBo70qIfTSSiE6Q8/vV/ndslWnDLR03j1tlWq2ieVT6GMqYL4qI2Ode6u/zdz7l/d/II
 WE0fj32WF9WUmClz/spadYuWfSqO+LM48+0H1+mngsl4Z4imJ7zLL4bS4c6kYrv2sSUmnNcnz0m
 3QI8kBsJRl2uuUsStr3ykGEbwlBizqJdM0BG9bP7dnAMvnrI9qPQJwml9KBv9g6tCcu9nvGOrnu
 SoC9STLjHz+OX/GORx4T2RvHPs6d40zlMpjSmcS0iKWFIVFcdQpSpmhVEuI9O1xC+ezs7DEB3gF
 nn/6wfq2A8yIOeFcNX7wlKeCeW0D/RFjr5HPUZ2DC9MZeuvhNM4A8CPdmcjHNhX3IQTrtGwiRl+
 ORt2PwnXaAdRBGYRM/Bv4gWqpAJIdxN20a178l6WEu/ddMH1S3e+5DJwKfU4EoWsmJR2U=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BBA841F8C4
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 03/11] Added three more SAFE_* macros for landlock
 sandbox:
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

- SAFE_LANDLOCK_CREATE_RULESET
- SAFE_LANDLOCK_ADD_RULE
- SAFE_LANDLOCK_RESTRICT_SELF

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/landlock.h | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
index 2ee51b340..6d85eb12e 100644
--- a/include/lapi/landlock.h
+++ b/include/lapi/landlock.h
@@ -12,6 +12,8 @@
 # include <linux/landlock.h>
 #endif
 
+#include "lapi/syscalls.h"
+
 #ifndef HAVE_STRUCT_LANDLOCK_RULESET_ATTR
 struct landlock_ruleset_attr
 {
@@ -120,4 +122,63 @@ struct landlock_net_port_attr
 # define LANDLOCK_ACCESS_NET_CONNECT_TCP	(1ULL << 1)
 #endif
 
+static inline int safe_landlock_create_ruleset(const char *file, const int lineno,
+	const struct landlock_ruleset_attr *attr,
+	size_t size , uint32_t flags)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_landlock_create_ruleset, attr, size, flags);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"landlock_create_ruleset(%p, %lu, %u)",
+			attr, size, flags);
+	}
+
+	return rval;
+}
+
+static inline int safe_landlock_add_rule(const char *file, const int lineno,
+	int ruleset_fd, enum landlock_rule_type rule_type,
+	const void *rule_attr, uint32_t flags)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_landlock_add_rule,
+		ruleset_fd, rule_type, rule_attr, flags);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"landlock_add_rule(%d, %d, %p, %u)",
+			ruleset_fd, rule_type, rule_attr, flags);
+	}
+
+	return rval;
+}
+
+static inline int safe_landlock_restrict_self(const char *file, const int lineno,
+	int ruleset_fd, int flags)
+{
+	int rval;
+
+	rval = tst_syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"landlock_restrict_self(%d, %u)",
+			ruleset_fd, flags);
+	}
+
+	return rval;
+}
+
+#define SAFE_LANDLOCK_CREATE_RULESET(attr, size, flags) \
+	safe_landlock_create_ruleset(__FILE__, __LINE__, (attr), (size), (flags))
+
+#define SAFE_LANDLOCK_ADD_RULE(ruleset_fd, rule_type, rule_attr, flags) \
+	safe_landlock_add_rule(__FILE__, __LINE__, \
+		(ruleset_fd), (rule_type), (rule_attr), (flags))
+
+#define SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, flags) \
+	safe_landlock_restrict_self(__FILE__, __LINE__, (ruleset_fd), (flags))
+
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
