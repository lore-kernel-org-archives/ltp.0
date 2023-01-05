Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC4CC3DA7D
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 16:29:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7925D3CB662
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 17:29:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 641D53C88EF
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 17:29:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE2F01A0065A
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 17:29:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A7F55C95E;
 Thu,  5 Jan 2023 16:29:30 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0923E13338;
 Thu,  5 Jan 2023 16:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u+9mAer6tmPpSQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 05 Jan 2023 16:29:30 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
	ltp@lists.linux.it
Date: Thu,  5 Jan 2023 17:29:29 +0100
Message-Id: <20230105162929.16047-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ltp-aiodio.part4: Run DIT000 with only 1 reader
 process
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

New changes in real-time kernel patchset give high priority to direct I/O
readers and may cause writes to block indefinitely if there are too many
reader processes running in parallel. Reduce the number of reader processes
in DIT000 to 1 which was the dio_truncate default before rewrite to new API.

Also add warning to dio_truncate if CONFIG_PREEMPT_RT is enabled and
the number of reader processes is too high.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Change since v1:
- Added warning to dio_trunc

I'll leave up for discussion whether to merge this patch or v1.


 runtest/ltp-aiodio.part4                      | 2 +-
 testcases/kernel/io/ltp-aiodio/dio_truncate.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index d88c27a83..c31bef934 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -56,7 +56,7 @@ ADI007 dio_append
 ADI008 dio_append
 ADI009 dio_append
 #Running dio_truncate
-DIT000 dio_truncate
+DIT000 dio_truncate -n 1
 DIT001 dio_truncate
 DIT002 dio_truncate
 #Running dio_read
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index e5c0933e9..de1e3524e 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -31,6 +31,7 @@
 #include <sys/types.h>
 #include <fcntl.h>
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "common.h"
 
 static volatile int *run_child;
@@ -86,6 +87,7 @@ static void dio_read(const char *filename, long long align, size_t bs)
 static void setup(void)
 {
 	struct stat sb;
+	const char *kconf_rt[] = {"CONFIG_PREEMPT_RT", NULL};
 
 	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
 		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
@@ -103,6 +105,11 @@ static void setup(void)
 	alignment = sb.st_blksize;
 
 	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	if (numchildren > 2 && !tst_kconfig_check(kconf_rt)) {
+		tst_res(TINFO, "Warning: This test may deadlock on RT kernels");
+		tst_res(TINFO, "If it does, reduce number of threads to 2");
+	}
 }
 
 static void cleanup(void)
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
