Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB80C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:36:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6D7A3C7BCF
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:36:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FDE73C4D06
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:05 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3FB7063FB3E
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F48A1F798;
 Thu, 16 Jan 2025 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=RNErde+5xmhUKSeoyLXre1AvHkjyQpvTk+qlPFt+S0A+EsDSftinua8okq2+wzE/uvwCXH
 zGskpRVdkM3fNVNPh5SRd8XtNn58fiX4hqKhCzkHk0qVvQLePub3jlgIL5aeomA2M2jH00
 zU4PNnM7HRVvQ07i4+keXpx1Q7PphsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=vyUC3WxU4qdOLW9/OEsawv4F2m7QFLd3EKa9yjD1F0jUvLNx19TKWELjDbgtZ49UrIHXBH
 MUmTzoDSti7UuBDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=RNErde+5xmhUKSeoyLXre1AvHkjyQpvTk+qlPFt+S0A+EsDSftinua8okq2+wzE/uvwCXH
 zGskpRVdkM3fNVNPh5SRd8XtNn58fiX4hqKhCzkHk0qVvQLePub3jlgIL5aeomA2M2jH00
 zU4PNnM7HRVvQ07i4+keXpx1Q7PphsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYVSBUMX28aqh7I5zfU3eeday7L7osifNsxtslrwFoE=;
 b=vyUC3WxU4qdOLW9/OEsawv4F2m7QFLd3EKa9yjD1F0jUvLNx19TKWELjDbgtZ49UrIHXBH
 MUmTzoDSti7UuBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63C9D13332;
 Thu, 16 Jan 2025 11:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gL3VFCPviGdrOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Jan 2025 11:36:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jan 2025 12:36:01 +0100
MIME-Version: 1.0
Message-Id: <20250116-fix_setsid_tests-v4-2-910f062a7235@suse.com>
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
In-Reply-To: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737027362; l=1493;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MOW9g7ThrqyeXo3INqKzpNnj2Sx+zobF04WcJfdPnws=;
 b=TnuQELE7UirDmOQEwDuLBaNoe+9KiwtKcDgWxfCI0H4NwH4VCU4wEgofKy/+w8ccvHCuhaYSh
 clXTHeMuK4hCc+Ofg9Z/qsR2YXv/cU9y/wPct0rSx/wPIVOg7jI7X4e
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 02/12] Add SAFE_PTSNAME macro
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_safe_macros.h |  4 ++++
 lib/tst_safe_macros.c     | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index a9fa7dbe128f17eace381fdf9f2795684e55969b..6985aa4bd80af2ff8a7c606fdba9830bb5ccd195 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -528,4 +528,8 @@ ssize_t safe_writev(const char *file, const int lineno, char len_strict,
 	safe_writev(__FILE__, __LINE__, (len_strict), (fildes), \
 		(iov), (iovcnt))
 
+char *safe_ptsname(const char *const file, const int lineno, int masterfd);
+#define SAFE_PTSNAME(masterfd) \
+	safe_ptsname(__FILE__, __LINE__, (masterfd))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 633b00404a56aafce6322e43bd614070d085e643..ba095a6215a8a053ad7397b4a541b26f02439b0f 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -796,3 +796,17 @@ ssize_t safe_writev(const char *file, const int lineno, char len_strict,
 
 	return rval;
 }
+
+char *safe_ptsname(const char *const file, const int lineno, int masterfd)
+{
+	char *name;
+
+	name = ptsname(masterfd);
+
+	if (!name) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"ptsname(%d) failed", masterfd);
+	}
+
+	return name;
+}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
