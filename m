Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0676FC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 14:37:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F0A61247
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63F0A61247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12803C89A9
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 16:37:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400653C4D45
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 16:37:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F7DB6010E9
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 16:37:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BCB68221AC
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631716624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/pVTm63YlEQkp3yXD1p7FPAQhqrw4rHdrEt0tJLeHM=;
 b=e4JIrlm5pzr/sUQBumqADXz5QWZ5S2l3WXZgp+rJOmltcHW7MbVHS5pajgajFH++w0RLbr
 2myXYysSbKESKn3bf7mZvWkWlebxTfypTnJ7Chq0EIDQ+g+IiwnGWPPD6XZxJ0S+jFMYUq
 DnJu77YJMwrN2LiUlRlusKEnZTGXiSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631716624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/pVTm63YlEQkp3yXD1p7FPAQhqrw4rHdrEt0tJLeHM=;
 b=G+51VRUj2TaES0OUbDBISRoPAY4WVgI/pgqvJggMN+KXBqMXm1tHX7XXyvuXts6EnyikD7
 U/1BWGUjr9sXzgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91BD113C5A
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 14:37:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RiTWKBAFQmGgBwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 14:37:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 15 Sep 2021 16:37:25 +0200
Message-ID: <20210915143725.13170-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210915143725.13170-1-chrubis@suse.cz>
References: <20210915143725.13170-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lib: tst_kconfig: Fix segfaults on variable value
 mismatch
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
Message-ID: <20210915143725.SXEQBKqcYRcYwBwTMSNtYaGwrqWC9iw3A4UqxXAaeIQ@z>

If we add CONFIG_FOO=value to the test .needs_kconfig while the kernel
config will not define the particular value we will blindly call
strlen() on the val->val and end up with SegFault. Fix this by checking
that the variable has value set first.

Also initialize the val->val to NULL so that we get segfaults 100% of
the time when we attempt to dereference the value when not defined.

+ Test

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/config07 | 5 +++++
 lib/tst_kconfig.c         | 4 ++++
 2 files changed, 9 insertions(+)
 create mode 100644 lib/newlib_tests/config07

diff --git a/lib/newlib_tests/config07 b/lib/newlib_tests/config07
new file mode 100644
index 000000000..dd67120f7
--- /dev/null
+++ b/lib/newlib_tests/config07
@@ -0,0 +1,5 @@
+# The default hostaname value mismatch
+CONFIG_MMU=y
+CONFIG_EXT4_FS=m
+CONFIG_PGTABLE_LEVELS=4
+CONFIG_DEFAULT_HOSTNAME=m
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index c9de3017b..5af67b0a5 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -392,6 +392,7 @@ static inline unsigned int populate_vars(struct tst_expr *exprs[],
 			strncpy(vars[cnt].id, j->tok, vars[cnt].id_len);
 			vars[cnt].id[vars[cnt].id_len] = 0;
 			vars[cnt].choice = 0;
+			vars[cnt].val = NULL;
 
 			var = find_var(vars, cnt, vars[cnt].id);
 
@@ -435,6 +436,9 @@ static int map(struct tst_expr_tok *expr)
 	if (choice != 'v')
 		return var->choice == choice;
 
+	if (var->choice != 'v')
+		return 0;
+
 	if (strlen(var->val) != len)
 		return 0;
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
