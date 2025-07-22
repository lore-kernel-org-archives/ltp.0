Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03806C83F1A
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:01:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80D213CCCCC
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 15:01:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B97BD3CCCF4
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CB4B600B55
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:59:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D26F219D4;
 Tue, 22 Jul 2025 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bv01NyEpmije6yikxtVGnGHGQ7mj3pok0t0aQsHGXKM=;
 b=h5kRfJkhuE4jy9soJqM09wBgrWRGwk9413yX+JxmwKQQOpPRBNSlkngN0GaB3w1iSPrSsL
 coMpXIBBfMk0dTIO+u68E6SsGLwE8m+AUREdG97Yy1eIBv1COjqu02ZiGc/3vkC45OrgYs
 v5oF3xf6tH7YCqOSX7nmJduz1PAIDXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bv01NyEpmije6yikxtVGnGHGQ7mj3pok0t0aQsHGXKM=;
 b=YTViN9ZdLl4hmrbwLMQDkWNgzDyYTWdhiOsVsYHlS8cQ/R750bAw54UQTi+ZPcN1T7FWeM
 kdsNwtnEnJvkrKDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753189169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bv01NyEpmije6yikxtVGnGHGQ7mj3pok0t0aQsHGXKM=;
 b=h5kRfJkhuE4jy9soJqM09wBgrWRGwk9413yX+JxmwKQQOpPRBNSlkngN0GaB3w1iSPrSsL
 coMpXIBBfMk0dTIO+u68E6SsGLwE8m+AUREdG97Yy1eIBv1COjqu02ZiGc/3vkC45OrgYs
 v5oF3xf6tH7YCqOSX7nmJduz1PAIDXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753189169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bv01NyEpmije6yikxtVGnGHGQ7mj3pok0t0aQsHGXKM=;
 b=YTViN9ZdLl4hmrbwLMQDkWNgzDyYTWdhiOsVsYHlS8cQ/R750bAw54UQTi+ZPcN1T7FWeM
 kdsNwtnEnJvkrKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1A5813A73;
 Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aOQYNjCLf2igZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:59:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Jul 2025 14:59:16 +0200
Message-ID: <20250722125916.74967-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722125916.74967-1-pvorel@suse.cz>
References: <20250722125916.74967-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/6] shell: Add shell_loader_setup_cleanup.sh test
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

 testcases/lib/run_tests.sh                    |  1 +
 .../lib/tests/shell_loader_setup_cleanup.sh   | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100755 testcases/lib/tests/shell_loader_setup_cleanup.sh

diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
index 128cee3377..5c309bbeb5 100755
--- a/testcases/lib/run_tests.sh
+++ b/testcases/lib/run_tests.sh
@@ -10,6 +10,7 @@ shell_loader_kconfigs.sh
 shell_loader_supported_archs.sh
 shell_loader_tcnt.sh
 shell_loader_cleanup.sh
+shell_loader_setup_cleanup.sh
 shell_test01
 shell_test02
 shell_test03
diff --git a/testcases/lib/tests/shell_loader_setup_cleanup.sh b/testcases/lib/tests/shell_loader_setup_cleanup.sh
new file mode 100755
index 0000000000..8184278313
--- /dev/null
+++ b/testcases/lib/tests/shell_loader_setup_cleanup.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+#
+# ---
+# env
+# {
+# }
+# ---
+
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+
+. tst_loader.sh
+
+setup()
+{
+	tst_res TINFO "setup executed"
+}
+
+cleanup()
+{
+	tst_res TINFO "Cleanup executed"
+}
+
+tst_test()
+{
+	tst_res TPASS "Test is executed"
+}
+
+. tst_run.sh
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
