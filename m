Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85BCC7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 10:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 401243C694C
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 12:29:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FCEA3C79FA
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:29:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84C5420096C
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:29:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05E3721180
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751020157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L9aTg6M3sQye/IoUurhZDCYDHFly5Brm7zhE+Ni6bxE=;
 b=PK0jjzA8wx3BIRKCtdldBYWVoimFPIJwNQES0lFMUfzwqBzyn4UlWZDWxNGdiUUvDtT3gT
 BTM0Py93uG0PGAoUApXO73dBbnkpp0en04UMDKNgsFV5lE122tS8QAiOjKLCHMRIIp7RpS
 BrIVfM3OnvMOIIpvBrg4Y/MUVcxzIQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751020157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L9aTg6M3sQye/IoUurhZDCYDHFly5Brm7zhE+Ni6bxE=;
 b=D3Zdeq1aSwpNtNI4XjBGGjb6/r8PqwXZNKph2A2RSaqxqrgyI6i8QPy8Kfam/mVGUngz6H
 WVguyJftcnB5QnCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751020157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L9aTg6M3sQye/IoUurhZDCYDHFly5Brm7zhE+Ni6bxE=;
 b=PK0jjzA8wx3BIRKCtdldBYWVoimFPIJwNQES0lFMUfzwqBzyn4UlWZDWxNGdiUUvDtT3gT
 BTM0Py93uG0PGAoUApXO73dBbnkpp0en04UMDKNgsFV5lE122tS8QAiOjKLCHMRIIp7RpS
 BrIVfM3OnvMOIIpvBrg4Y/MUVcxzIQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751020157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=L9aTg6M3sQye/IoUurhZDCYDHFly5Brm7zhE+Ni6bxE=;
 b=D3Zdeq1aSwpNtNI4XjBGGjb6/r8PqwXZNKph2A2RSaqxqrgyI6i8QPy8Kfam/mVGUngz6H
 WVguyJftcnB5QnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C6A13A9C
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 10:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7I2uM3xyXmgQAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 10:29:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Jun 2025 12:29:56 +0200
Message-ID: <20250627102957.4165-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: tst_test: Make IPC magic spells 'LTPM'
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

Since the 'LTPM' string is encoded in an integer the order of the
letters depends on machine endianity. On little endian it was actually
spelled backwards i.e. 'MPTL'.

This patch fixes that by making sure that the bytes are in the right
order.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 495e022f7..17ce91932 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -52,7 +52,13 @@ const char *TCID __attribute__((weak));
 #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
 
 #define DEFAULT_TIMEOUT 30
-#define LTP_MAGIC 0x4C54504D /* Magic number is "LTPM" */
+
+/* Magic number is "LTPM" */
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+# define LTP_MAGIC 0x4C54504D
+#else
+# define LTP_MAGIC 0x4D50544C
+#endif
 
 struct tst_test *tst_test;
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
