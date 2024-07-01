Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C46C2BD09
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 15:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FD613D3FDA
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 17:43:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47AAB3D0E3E
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:56 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B11071401117
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 785F421A62;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQXnUaAOe7pfbxG6gsWpsK5fDK8Ud/IvLVxn9g3lnMM=;
 b=NsszyqlmZvmw9h842U6lf5fE37h9b1JPPi2s9h2yRWsx73e+6wFJ2TuNDJX5hVP8wgLO8Q
 pMojfh49IAOtUERA5GQrLBwvYnma//MzHF1YoCAUUJZXo0MrmF9HPT98jLdLhYQ88pZ/tv
 e3Y/XVJ5vyXIUUHOyHojgxsVxf15wEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQXnUaAOe7pfbxG6gsWpsK5fDK8Ud/IvLVxn9g3lnMM=;
 b=Juh+PNs0vmKMSmDIxVl/uq32fUo4QIvv+Lz3E4OGSi5BWmRmZ7fjDh2AL9w+5swb6kPFdo
 GMWJBhm1Ve7Y/vCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQXnUaAOe7pfbxG6gsWpsK5fDK8Ud/IvLVxn9g3lnMM=;
 b=NsszyqlmZvmw9h842U6lf5fE37h9b1JPPi2s9h2yRWsx73e+6wFJ2TuNDJX5hVP8wgLO8Q
 pMojfh49IAOtUERA5GQrLBwvYnma//MzHF1YoCAUUJZXo0MrmF9HPT98jLdLhYQ88pZ/tv
 e3Y/XVJ5vyXIUUHOyHojgxsVxf15wEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQXnUaAOe7pfbxG6gsWpsK5fDK8Ud/IvLVxn9g3lnMM=;
 b=Juh+PNs0vmKMSmDIxVl/uq32fUo4QIvv+Lz3E4OGSi5BWmRmZ7fjDh2AL9w+5swb6kPFdo
 GMWJBhm1Ve7Y/vCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E1D913800;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sDEDEX7OgmZfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jul 2024 15:42:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jul 2024 17:42:08 +0200
MIME-Version: 1.0
Message-Id: <20240701-landlock-v1-3-58e9af649a72@suse.com>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-0-58e9af649a72@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=2UoUSa1uVa3/Bd6ki/TKmyPoazpmULBc4patfzKrnOQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmgs50WA7T/MT7grnuM5gjoD+rsAlpSyI4RMQth
 S602fSC0oiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoLOdAAKCRDLzBqyILPm
 RiZlDACkn6RY+TuT/4zO4O1Py6up/kMvQult1ZwCXb4uZXvj3BKrWlnPgqe+czQaHx9my7DAPAO
 xlsKjSzB2NRlvubXrg4W7ljRjrwgcr9TRuhXKh1CmgrQJ0OOMPJgIAwY2M8pLPdidudH8G/Hsyc
 8eRwlaxWB4JyXUH4t8dO0stc0kCo0E1XTBCCbiVCoTprTRnFAPLBx0l0bripZ76G3EkELa/x5Vv
 WZu62OKeOZOH6tAT7CfmAehq8wfEbcgVUYI91qKRjZ6gXvYRwLOAojGfAURE82GuGCQd+FEQt1R
 2oXwGmGazgHQZl7ibWEymypYdNGtCRzfqbNl8q3F6I0xCY7uHajOZPu5kpGi2RZwj59ycDqSMFQ
 KYqw1GsnoP9dwH6hxCuDtG8rDyqcfY2BPj4G9TK3QkC2tCTkVSqvt1nDsy+5nx6jC0pz7M/Mcf7
 jKsp93UzveJJDThmFbgrLeqf0sQ543MtWJjFwL4/edEXY7CvWOBpsifbLbv1srhvUVbBY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/10] Add landlock SAFE_* macros
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

Added three more SAFE_* macros for landlock sandbox:

- SAFE_LANDLOCK_CREATE_RULESET
- SAFE_LANDLOCK_ADD_RULE
- SAFE_LANDLOCK_RESTRICT_SELF

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_safe_macros.h | 19 ++++++++++++++++++
 lib/tst_safe_macros.c     | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 08b8e930a..7748bd34f 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -14,6 +14,7 @@
 #include <sys/stat.h>
 #include <sys/vfs.h>
 #include <sys/sysinfo.h>
+#include <linux/landlock.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <signal.h>
@@ -503,4 +504,22 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
 #define SAFE_SSCANF(buffer, format, ...) \
 	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
 
+int safe_landlock_create_ruleset(const char *file, const int lineno,
+	const struct landlock_ruleset_attr *attr,
+	size_t size , uint32_t flags);
+#define SAFE_LANDLOCK_CREATE_RULESET(attr, size, flags) \
+	safe_landlock_create_ruleset(__FILE__, __LINE__, (attr), (size), (flags))
+
+int safe_landlock_add_rule(const char *file, const int lineno,
+	int ruleset_fd, enum landlock_rule_type rule_type,
+	const void *rule_attr, uint32_t flags);
+#define SAFE_LANDLOCK_ADD_RULE(ruleset_fd, rule_type, rule_attr, flags) \
+	safe_landlock_add_rule(__FILE__, __LINE__, \
+		(ruleset_fd), (rule_type), (rule_attr), (flags))
+
+int safe_landlock_restrict_self(const char *file, const int lineno,
+	int ruleset_fd, int flags);
+#define SAFE_LANDLOCK_RESTRICT_SELF(ruleset_fd, flags) \
+	safe_landlock_restrict_self(__FILE__, __LINE__, (ruleset_fd), (flags))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 4e48c427b..ba997eb7c 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -710,3 +710,53 @@ int safe_mprotect(const char *file, const int lineno,
 
 	return rval;
 }
+
+
+int safe_landlock_create_ruleset(const char *file, const int lineno,
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
+int safe_landlock_add_rule(const char *file, const int lineno,
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
+int safe_landlock_restrict_self(const char *file, const int lineno,
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

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
