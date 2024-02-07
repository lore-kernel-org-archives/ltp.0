Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7422C4828F
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:07:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CD6B3CF5BA
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:07:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 964103CC54A
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:36 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B947D60072B
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BA461FBFA;
 Wed,  7 Feb 2024 16:06:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E408513931;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UKeLNoqqw2WRSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:06:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 17:06:28 +0100
Message-ID: <20240207160628.125908-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207160628.125908-1-pvorel@suse.cz>
References: <20240207160628.125908-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5BA461FBFA
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] lib: Improve doc related to $TMPDIR default value
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

Link C and shell API related parts to $TMPDIR.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_defaults.h    | 5 +++--
 testcases/lib/tst_test.sh | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/tst_defaults.h b/include/tst_defaults.h
index 083427b7e..e3eb6f587 100644
--- a/include/tst_defaults.h
+++ b/include/tst_defaults.h
@@ -7,9 +7,10 @@
 #define TST_DEFAULTS_H_
 
 /*
- * This is the default temporary directory used by tst_tmpdir().
+ * This is the default temporary directory used by tst_tmpdir(),
+ * used when TMPDIR env variable is not set.
  *
- * This is used when TMPDIR env variable is not set.
+ * If changed, update also shell API in tst_test.sh.
  */
 #define TEMPDIR	"/tmp"
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 20bf21660..760a49061 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -735,6 +735,8 @@ tst_run()
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
+			# default value if TMPDIR not set.
+			# If changed, update also C API in tst_defaults.h.
 			_tst_tmpdir="/tmp"
 			export TMPDIR="$_tst_tmpdir"
 		else
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
