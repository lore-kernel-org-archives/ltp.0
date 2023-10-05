Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE57E9370C
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 13:49:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD99F3CF791
	for <ltp@archiver.kernel.org>; Thu,  5 Oct 2023 15:49:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4FE13CDA8C
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 15:49:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F967601236
 for <ltp@lists.linux.it>; Thu,  5 Oct 2023 15:49:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4A251F894;
 Thu,  5 Oct 2023 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696513752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usZ31iyOfSJ1E2ErgWEWrERHmewIk1mPi/7j3pp8eio=;
 b=nn2odY6Pkqm43ljpneca2K1km+PA6qHzE8GBi3pqVbfHvUSIeE7a6FzVDMo+q0cSjGrvd2
 HBgM0Qir8aa2rvw9yqfY7uSB2wHDMH9kCAaWvRZlSJ3/iw9unNxtFJE8YrpcFPJFF8y87g
 wlu8BW0ETm8hMvnMXSpDJ5BOv8W9OyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696513752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usZ31iyOfSJ1E2ErgWEWrERHmewIk1mPi/7j3pp8eio=;
 b=MZzMGTISoXF0JuNFGHE9TlGDonry5xc3CxEpN5S7OkFfVtPdNA47C8IMPCm1NP0lm+iWOB
 tgvpkxKo+Q6WHDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4DB5139C2;
 Thu,  5 Oct 2023 13:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yAaULti+HmWBGQAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Thu, 05 Oct 2023 13:49:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu,  5 Oct 2023 15:49:10 +0200
Message-Id: <20231005134911.26758-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231005134911.26758-1-andrea.cervesato@suse.de>
References: <20231005134911.26758-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Rewrite gettid01 test
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

The old test wasn't doing anything meaningful, but just checking that
__NR_gettid syscall is working. In this test we check that
tid == pid, in the case we are not inside a thread.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Check if we are inside a thread
Make use of tst_syscall

 testcases/kernel/syscalls/gettid/gettid01.c | 105 ++++----------------
 1 file changed, 20 insertions(+), 85 deletions(-)

diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
index 7e5b6b175..5f9623e9a 100644
--- a/testcases/kernel/syscalls/gettid/gettid01.c
+++ b/testcases/kernel/syscalls/gettid/gettid01.c
@@ -1,96 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Crackerjack Project
- *
- * Copyright (C) 2007-2008, Hitachi, Ltd.
- * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
- *            Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
- *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- *
- * $Id: gettid01.c,v 1.5 2009/10/26 14:55:47 subrata_modak Exp $
+ * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+/*\
+ * [Description]
  *
+ * This test checks if parent pid is equal to tid in single-threaded
+ * application.
  */
 
-/* Porting from Crackerjack to LTP is done
-   by Masatake YAMATO <yamato@redhat.com> */
-
-#include <sys/types.h>
-#include <linux/unistd.h>
-#include <errno.h>
-
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "gettid01";
-
-int TST_TOTAL = 1;
-
-pid_t my_gettid(void)
-{
-	return (pid_t) syscall(__NR_gettid);
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	/*
-	 * The following loop checks looping state if -c option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-		tst_count = 0;
-
-		TEST(my_gettid());
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "gettid() Failed, errno=%d: %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "gettid() returned %ld",
-				 TEST_RETURN);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
+static void run(void)
 {
+	long pid, tid;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "Pid: %ld", &pid);
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "Tgid: %ld", &tid);
 
-	TEST_PAUSE;
+	if (pid != tid)
+		tst_brk(TBROK, "Test function has been moved inside a thread?");
 
+	TST_EXP_EQ_LI(tst_syscall(__NR_gettid), tst_syscall(__NR_getpid));
+	TST_EXP_EQ_LI(tst_syscall(__NR_gettid), pid);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
