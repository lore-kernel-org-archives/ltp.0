Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D696FC3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 11:00:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D61B3D1F55
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 13:00:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7AA73D1F1D
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:14 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FF06600870
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FDC41FB58;
 Fri,  2 Aug 2024 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPZ/ZdT04Wlgf569BwNSTYOFFaF1FOiOrN5IbAOPV7A=;
 b=rN+QFbyyT/r9rDJMG0qKA+ZNX38up2TgZ7NUwNJvs0c5a6bN9OkAcWMQ+XsgMIAxR7rQDY
 5w3QOHAAHZHv8FKIhyJmhgLXxxVl6teOWsqeVKdEEfKC3WbdFyXOqr6Q3eD7+KBWWR1/r9
 AMW/F26pzH5fBrzl623cw/XgO4UGpjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPZ/ZdT04Wlgf569BwNSTYOFFaF1FOiOrN5IbAOPV7A=;
 b=efDE29dn9dxD9xNeEr/1inpxNU/km1R2XZW6qbLqZtXjllQzA6VOypwOZfJvp5yQUB3PIn
 95y5GzzULdiR9oBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPZ/ZdT04Wlgf569BwNSTYOFFaF1FOiOrN5IbAOPV7A=;
 b=rN+QFbyyT/r9rDJMG0qKA+ZNX38up2TgZ7NUwNJvs0c5a6bN9OkAcWMQ+XsgMIAxR7rQDY
 5w3QOHAAHZHv8FKIhyJmhgLXxxVl6teOWsqeVKdEEfKC3WbdFyXOqr6Q3eD7+KBWWR1/r9
 AMW/F26pzH5fBrzl623cw/XgO4UGpjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPZ/ZdT04Wlgf569BwNSTYOFFaF1FOiOrN5IbAOPV7A=;
 b=efDE29dn9dxD9xNeEr/1inpxNU/km1R2XZW6qbLqZtXjllQzA6VOypwOZfJvp5yQUB3PIn
 95y5GzzULdiR9oBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4B213AED;
 Fri,  2 Aug 2024 10:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KHI7LwC8rGbRQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 10:59:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 12:59:06 +0200
MIME-Version: 1.0
Message-Id: <20240802-fchmodat2-v6-3-dcb0293979b3@suse.com>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
In-Reply-To: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=IHat8/asU20kNDIoaOQn49cBYgH2dcsMelN233FCSY8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrLv962Dtm7NIvESV4k0lj6DYHw86B2BkGzcw2
 oJVf41aLCOJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqy7/QAKCRDLzBqyILPm
 RhbLDACnz/xhBYwZiT4SVant+wZPTGcZ+t+9cfcP7TA4tTbXqPo+hQKKS+M+uSugegNCEUcavVq
 +FeD7Lw2eee+24xzVxhxOc7gun/oUrbcULKLmUWfZdPiUHn0k10pNKN+WX9IXSYVfw/LQbgMRn7
 IJbOOSy8Vdsn95vU74HpIOvKxB2pYsLJXWr4cnrCao7s0UcEiFlnyHkVWNbD3w6Fq6nyoUHOuie
 wyAl4cGTEfEPt96/r1iwDb/F+UlyouRpPeXpNYV5I33Ks+Y399ERkv7iUkCAkdOGkNCzCdYJmWv
 q3BPE2nIQOXPFEzbgyLJuipRMFHem6A+EMBOZd1gAEWW4FKnmRTbkSJyzMbcvuiTOQajJnaJoYp
 oa9gpGOPwmcwEFG6pIOCvDe5ecRW4QBHZbe3b6isnYYVewUz2CWliB3HzWlR0Xi0RchY8ZJ/JlV
 H3XU1QBUMFLuYS7aW6MsouhSbeJLyKie2nHWMI50vRQdWk4Ilag38oXOuZddEpRwOb3sc=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/5] Add fchmodat2 fallback definition
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/stat.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 3606c9eb0..8e38ecfef 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -229,4 +229,20 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
+#define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
+	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
+
+static inline int safe_fchmodat2(const char *file, const int lineno,
+		int dfd, const char *filename, mode_t mode, int flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
+	if (ret == -1)
+		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
+			__func__, dfd, filename, mode, flags);
+
+	return ret;
+}
+
 #endif /* LAPI_STAT_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
