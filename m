Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF60C5CFCF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 02:32:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFC7A3E7435
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 04:32:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECDC03E18A9
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 04:32:31 +0200 (CEST)
Received: from mta0.migadu.com (out-128.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::80])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 219AA100078B
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 04:32:30 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=wQr+EryffIZYuJbLch0g3ZRQJjkXgmEqxD4xkWw2ZOM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786588350; v=1; x=1787193150;
 b=MYUtxfcEMz/eVOLh9is9U3BCpil9olwekLNMLRGVW5Sws3JOKmLxmmfTDW4PdfccL3T6NWSx
 LmlReSd7NDkLmSGL2oGiBdphVEJbG7tGo5Dt6hjbtTGytGbHYG5VsrB4alEmd/1OmQTys5wwyUF
 SiCMLJRV4F0uB2OOmWvc7Sx4=
X-Envelope-To: ltp@lists.linux.it
Received: from thoundrobot (2408:8409:18c0:1f4d:457:b937:2f7c:bd8c)
 by mta12.migadu.com with ESMTPS id 7a78d58f1c75341b;
 Thu, 13 Aug 2026 02:32:29 +0000
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu, 13 Aug 2026 10:32:16 +0800
Message-ID: <20260813023216.79848-1-li.wang@linux.dev>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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
Cc: Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Li Wang <liwang@hygon.cn>

Since commit d90d2004657b ("lib: Use backoff polling to wait for loop
device nodes") use TST_RETRY_FN_EXP_BACKOFF(), which calls tst_multiply_timeout().
That in turn reaches tst_has_slow_kconfig() -> tst_kconfig_read() ->
popen("zcat /proc/config.gz") to read the kernel config.

popen() forks a child, and that child exits the SIGCHLD is reported
as an unexpected signal by the tst_sig(NOFORK) handler:

  umount2_01    1  TBROK  :  tst_sig.c:232: unexpected signal SIGCHLD(17) received

Since these tests now genuinely fork (indirectly via popen), declaring
FORK matches their actual behavior and lets the handler tolerate the
child's SIGCHLD. This is a minimal fix that preserves the retry logic.

These are old-API tests that will eventually be converted to the new
tst_test API and this issue disappears entirely. The one-line FORK
change is a low-cost bridge until then.

Fixes: d90d2004657b ("lib: Use backoff polling to wait for loop device nodes")
Signed-off-by: Li Wang <liwang@hygon.cn>
---

Notes:
    This is a temporary solution for the regression, I will convert
    these old tests to the new API next few days.

 testcases/kernel/syscalls/linkat/linkat02.c     | 2 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c   | 2 +-
 testcases/kernel/syscalls/rename/rename11.c     | 2 +-
 testcases/kernel/syscalls/renameat/renameat01.c | 2 +-
 testcases/kernel/syscalls/umount2/umount2_01.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 273587271..6dfa7cfb5 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -140,7 +140,7 @@ static void setup(void)
 {
 	tst_require_root();
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index 2f7c56f00..89cfc5978 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -107,7 +107,7 @@ static void setup(void)
 
 	tst_require_root();
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 8ff9f7d38..26e324d64 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -90,7 +90,7 @@ static void setup(void)
 {
 	int i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_require_root();
 
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index 72e72b481..f9ed3a9a7 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -134,7 +134,7 @@ static void setup(void)
 
 	tst_require_root();
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 274409ef3..c6496e306 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -67,7 +67,7 @@ static void setup(void)
 {
 	tst_require_root();
 
-	tst_sig(NOFORK, DEF_HANDLER, NULL);
+	tst_sig(FORK, DEF_HANDLER, NULL);
 
 	tst_tmpdir();
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
