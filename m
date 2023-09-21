Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64058E71076
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 14:06:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04EAA3CDE9A
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 16:06:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAF4C3CDE89
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 16:06:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96F001BB8523
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 16:06:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C95AC338AC
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695305194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lc0yvfqmvmsW5hIehrMRGqwYUJJn5nMLP/ATWq5p9mw=;
 b=oLt9OyBU3IDZ+oXWxfJ2Jlw3LMh+ZVo7jaPOphejdH5qFfCpCn0mIvCsITv2qTaaQ7fbia
 CK2FuNPjvWT0kd2ZGoqJvRa6jSEUmpME1swIcRIPH/lKTgl2NuW4CnRQB2hijGEBh79LTP
 LHKpFp9HATAb/MzG6LlkpmRl9y/N5O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695305194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lc0yvfqmvmsW5hIehrMRGqwYUJJn5nMLP/ATWq5p9mw=;
 b=q2JhxKEpJeotr0Cd1/SCzTtQEYIpO75MqMAjUm4iMvdwSWdrBg+rwvY+QY0FnNNqTc++WP
 iIR+Dh2HbhlaH/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B291D13513
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UFXqKepNDGWKTAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:06:34 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 21 Sep 2023 16:07:21 +0200
Message-ID: <20230921140721.11382-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: tst_test: Fix lockdown detection on missing
 sysfs
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

The lockdown detection function reports -1 when secure boot sysfs file
is not present, which is later mistakenly interpreted as secure boot
enabled in tst_test.c.

This causes regression in *_module sycall tests executed on systems when
secureboot is not compiled-in or supported at all.

Check properly if secure boot is enabled by checking that the return
value from these functions is positive.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2e58cad33..e2c195645 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1163,10 +1163,10 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
 
-	if (tst_test->skip_in_lockdown && tst_lockdown_enabled())
+	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
 		tst_brk(TCONF, "Kernel is locked down, skipping test");
 
-	if (tst_test->skip_in_secureboot && tst_secureboot_enabled())
+	if (tst_test->skip_in_secureboot && tst_secureboot_enabled() > 0)
 		tst_brk(TCONF, "SecureBoot enabled, skipping test");
 
 	if (tst_test->skip_in_compat && TST_ABI != tst_kernel_bits())
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
