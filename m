Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD146D39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:14:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61E973E2F3E
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 846A73E2F44
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 208C9200B76
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F2D15BDB1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbmxdaQTbThmsDUiN9e4Cd1ONuk/j7IUEpPn5vRaZxA=;
 b=cqQzUqnYDxmqftAD/sQNaUormeWAn+UTxCPViTDWRip/zshyByt3mMeHTZjP/NLkEC7TWm
 7icxCeTikKxsz4Q7oJFJkBGdKSoeBruQpwQs/Nnvn8ti8B+6G2q9rJX7ueRpmdtDviJb0w
 Nd/aTx4ErZYQyz8ztuUB5OWhVb74mB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbmxdaQTbThmsDUiN9e4Cd1ONuk/j7IUEpPn5vRaZxA=;
 b=SYp42VuDYwqYvCKf8XLfdENMoz7wPJ2TjuKS8YsAwO3sMc5aKpLfhXcV7ufj3AJ/9g4sDI
 E03qZQ6fZkAK6KBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbmxdaQTbThmsDUiN9e4Cd1ONuk/j7IUEpPn5vRaZxA=;
 b=cqQzUqnYDxmqftAD/sQNaUormeWAn+UTxCPViTDWRip/zshyByt3mMeHTZjP/NLkEC7TWm
 7icxCeTikKxsz4Q7oJFJkBGdKSoeBruQpwQs/Nnvn8ti8B+6G2q9rJX7ueRpmdtDviJb0w
 Nd/aTx4ErZYQyz8ztuUB5OWhVb74mB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cbmxdaQTbThmsDUiN9e4Cd1ONuk/j7IUEpPn5vRaZxA=;
 b=SYp42VuDYwqYvCKf8XLfdENMoz7wPJ2TjuKS8YsAwO3sMc5aKpLfhXcV7ufj3AJ/9g4sDI
 E03qZQ6fZkAK6KBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B1924A0B1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1QScBYVdzmmiDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:13:57 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:42 +0200
Message-ID: <20260402121356.31266-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/17] lib: tst_kernel: Add tst_check_module_driver()
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

This function allows us to check for presence of drivers build as
modules.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_kernel.h | 10 ++++++++++
 lib/tst_kernel.c     | 12 +++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 63ecb19a4..d5a4a9625 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -45,6 +45,16 @@ bool tst_abi_bits(int abi);
  */
 int tst_check_builtin_driver(const char *driver);
 
+/**
+ * tst_check_module_driver() - Check if the kernel module is present.
+ *
+ * @driver: the name of the driver.
+ *
+ * Return: 0 if module driver is present or -1 when driver is missing or config file not
+ * available. On Android *always* 0 (always expect the module is present).
+ */
+int tst_check_module_driver(const char *driver);
+
 /**
  * tst_check_driver() - Check support for the kernel module.
  *
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 8bb7e080a..8f7503c02 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -200,16 +200,18 @@ static int tst_search_driver(const char *driver, const char *file)
 
 int tst_check_builtin_driver(const char *driver)
 {
-	if (!tst_search_driver(driver, "modules.builtin"))
-		return 0;
+	return tst_search_driver(driver, "modules.builtin");
+}
 
-	return -1;
+int tst_check_module_driver(const char *driver)
+{
+	return tst_search_driver(driver, "modules.dep");
 }
 
 int tst_check_driver(const char *driver)
 {
-	if (!tst_search_driver(driver, "modules.dep") ||
-		!tst_check_builtin_driver(driver))
+	if (!tst_check_module_driver(driver) ||
+	    !tst_check_builtin_driver(driver))
 		return 0;
 
 	return -1;
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
