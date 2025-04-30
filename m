Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C85C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 13:06:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC3453C1B04
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 15:05:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EAF03CBC88
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9DA42009A2
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 15:04:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3D11121964;
 Wed, 30 Apr 2025 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdMdGcbXXMyZUnlN4Tdc+5eWsoSzbnIxCRjkITViUAU=;
 b=yHuc0ONzPDMI3dCf37qckGYu5ljqqTkFFRJTgaEtfgaAf6ZoAr7KQyNxOf56k/PlJJcKg+
 CxBRbb0oWOQNIUwUieAtK7LfSZ7vDhp6Flx2PuJjAoHpUEYlXk7CaH7SzOtVFzXRp3KygR
 1bGfhgbA1Y8NbmjbIN7seJfC8bLMt64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdMdGcbXXMyZUnlN4Tdc+5eWsoSzbnIxCRjkITViUAU=;
 b=V7jareKVuqoUqKJZ1XksnPDH10oXpg0taGj/khtWz88vFlABkeCoav/nKWgZGem3pX3PAo
 pi5Hk3OoQE9pWhBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746018262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdMdGcbXXMyZUnlN4Tdc+5eWsoSzbnIxCRjkITViUAU=;
 b=yHuc0ONzPDMI3dCf37qckGYu5ljqqTkFFRJTgaEtfgaAf6ZoAr7KQyNxOf56k/PlJJcKg+
 CxBRbb0oWOQNIUwUieAtK7LfSZ7vDhp6Flx2PuJjAoHpUEYlXk7CaH7SzOtVFzXRp3KygR
 1bGfhgbA1Y8NbmjbIN7seJfC8bLMt64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746018262;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdMdGcbXXMyZUnlN4Tdc+5eWsoSzbnIxCRjkITViUAU=;
 b=V7jareKVuqoUqKJZ1XksnPDH10oXpg0taGj/khtWz88vFlABkeCoav/nKWgZGem3pX3PAo
 pi5Hk3OoQE9pWhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14FED13ABF;
 Wed, 30 Apr 2025 13:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qKTIA9YfEmhRawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Apr 2025 13:04:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 30 Apr 2025 15:04:17 +0200
Message-ID: <20250430130417.43523-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430130417.43523-1-pvorel@suse.cz>
References: <20250430130417.43523-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] shell: Add shell_loader_setup_cleanup.sh test
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
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
index 0000000000..fd149cedb0
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
+. tst_env.sh
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
+. tst_loader.sh
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
