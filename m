Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788DFC25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:30:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BCBF3CF95E
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:30:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2FA73CF95E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:37 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE809200ACA
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E85575C34B
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47WgTMA+5HOSGmUE9o0FaeTrAdNzXpfho0PY50pB6ws=;
 b=Cl4pF4uDzjtnuZ0RsHgn/56N4sAZ1pZtNW0meVkosUXOEtTscZMsBkcPpIhfJM3OnQEGgy
 ZTcMB6ko686dJvY82rHg/jsj67EcG/42aoDHAocx5E/DxwJGqOvm8wvYeQcWuZau59KJMJ
 sqfKZyT85loLIjt13Zqyk9ZZIYbSR40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47WgTMA+5HOSGmUE9o0FaeTrAdNzXpfho0PY50pB6ws=;
 b=qzJo7msG0eLU1gun7s/OyW3/Ru/EbCBbqEpdc8Zbza8GbE18FItNLMSJo+j9Qw4BXIQC76
 0x3DQpEZnoIvoQBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tm/r5muL";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lQCPfSba
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47WgTMA+5HOSGmUE9o0FaeTrAdNzXpfho0PY50pB6ws=;
 b=tm/r5muLtMz7SazOVejZ25RI/xjCmYgLouOb9rdP9N9sFXRy//HQ0x7VX0OA+6BgwPe9F0
 japwmRvLgs5rTAt43aZmC9GNVMZIlhTLw/67YLPVig/scU5HaIcWhoTlBbk4DyxO4dfNW2
 Dbu63ul8dfhlyAmXZ2cMjXACgvCccmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47WgTMA+5HOSGmUE9o0FaeTrAdNzXpfho0PY50pB6ws=;
 b=lQCPfSbaaLpPK8yjmOyX8NKgK+zeOlearM5ifW3i9gnqOk68lV3C1FdWkIlsqXbMfXa4Gl
 EMVb7ftPBnMGTGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44A113991
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MKeWMi78RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:09 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-1-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=+hTltiI4dIoQVZxGiGcMdIRIdVpi+1cKDHmfRdGJ9b4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwtpOmC1CFIs1UgTd0vjjA/qEeksance/BUc
 USzCIhEd4mJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LQAKCRDLzBqyILPm
 Rt6PDACfJOVQ+TSYXrX7sOb257JrnC9JxQMMYuijE+aRDh1uI25oJJX2xh3NLUPEfC3/Yh6oOXO
 kGGSs248wR+wgprwPHlAiRtfw5IZLqtSfDc7SsFFy43UfCqyFH29AzqQhXW4DfCPb+nDukvhNFC
 asgyTW2UZwyK4N7nMUatZxQ69rZOEi1DAFG1dTO+OBXJIlSYROjHVbQScID25YPgogBED0rZCPs
 9/b6m3xlHTzqaK89nPkFN+Vu2ksGM0Ca5gHMWkD3HO6UkhFXLxUSVkmz3M5VAEuEaw1GdhSCFlp
 6QWg4MQitKJ7xoiO6tK14FSHxounwERAzMP/lW+6YoRn6Cd6ytxtn0MKoMjIZ11I0XlPbYgBWyq
 0SZUwKD5+oGpA2qgPEEveCU2yF2uFv6Y33BWfbDvR2+QdEr6svDQtwR/1RrOrsGzE7hRcXzdFGh
 Qs29zQrfNmHfMYQZRmQ7uvt9QY2sH1GSGko/mULmw40NqMqd4TGJw/NAtFOoEP4VB0Dg8=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E85575C34B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/11] Add SAFE_STATX macro
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

---
 include/tst_safe_macros.h |  7 +++++++
 lib/tst_safe_macros.c     | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 8de8ef106..43ff50a33 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -503,4 +503,11 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
 #define SAFE_SSCANF(buffer, format, ...) \
 	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
 
+struct statx;
+int safe_statx(const char *file, const int lineno,
+	int dirfd, const char *pathname, int flags, unsigned int mask,
+	struct statx *buf);
+#define SAFE_STATX(dirfd, pathname, flags, mask, buf) \
+	safe_statx(__FILE__, __LINE__, (dirfd), (pathname), (flags), (mask), (buf))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 39b8cc924..f50a7bcc2 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -20,6 +20,7 @@
 #include "tst_safe_macros.h"
 #include "lapi/personality.h"
 #include "lapi/pidfd.h"
+#include "lapi/stat.h"
 
 int safe_access(const char *file, const int lineno,
 	    const char *pathname, int mode)
@@ -710,3 +711,24 @@ int safe_mprotect(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_statx(const char *file, const int lineno,
+	int dirfd, const char *pathname, int flags, unsigned int mask,
+	struct statx *buf)
+{
+	int rval;
+
+	rval = statx(dirfd, pathname, flags, mask, buf);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"statx(%d,%s,%d,%u,%p) failed", dirfd, pathname, flags, mask, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid statx(%d,%s,%d,%u,%p) return value %d",
+			dirfd, pathname, flags, mask, buf,
+			rval);
+	}
+
+	return rval;
+}

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
