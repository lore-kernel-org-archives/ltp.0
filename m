Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B813C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 10:52:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95E6E3E71D5
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:52:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EEB83E71D8
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:51:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F28601400DFE
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:51:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF934093;
 Fri, 31 Jul 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C69E779D8;
 Fri, 31 Jul 2026 10:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4AgkAj9+bGoTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 10:51:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 12:51:32 +0200
Message-ID: <20260731105132.187177-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731105132.187177-1-pvorel@suse.cz>
References: <20260731105132.187177-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 6BF934093
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/5] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify_init() used to reject FAN_REPORT_PIDFD combined with
FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
reporting pidfds for thread IDs, so this combination is expected to
succeed.

The test that these flag combinations are allowed:
                FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
			   FAN_REPORT_DFID_NAME),

Because the above flag combinations are already "tested" by the tests
that use them and we don't have any tests that >= 5.10 has support for
FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

Reported-by: AnonymeMeow <anonymemeow@gmail.com>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v2.

 testcases/kernel/syscalls/fanotify/fanotify20.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa3..db4a5ba63b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -15,6 +15,9 @@
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ *
+ * NOTE: since v7.2, fanotify supports reporting pidfds for thread IDs => skip
+ * the test.
  */
 
 #define _GNU_SOURCE
@@ -75,6 +78,7 @@ static void do_cleanup(void)
 
 static struct tst_test test = {
 	.setup = do_setup,
+	.max_kver = "7.1",
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
 	.cleanup = do_cleanup,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
