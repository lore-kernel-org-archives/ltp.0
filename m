Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832BAC54E67
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711615235; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=rigXjAaBre8zhv0GzTxgNpaLXCQwC4k6zviXjQP5adE=;
 b=kMznbeljYkZ55LYYbhe+w6acusVqfj3lVsW1gwpA55QAgdv5shJTqSJILj3Kd4u0Lhr+e
 BGA9PT6yXAquDvgb5/ClJy19ne4cOwhs6iSav1MelUdQYYMxb78NqewlRM+Uzf9y/7Courw
 fEV5c12AQcsE2jKEqEa0ixE15qB7L4I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6A73C19D9
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 09:40:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB2633C013E
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 09:40:13 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA014617610
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 09:40:09 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S8e5Rw091666
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 16:40:05 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 16:40:06 +0800
To: <ltp@lists.linux.it>
Date: Thu, 28 Mar 2024 16:40:00 +0800
Message-ID: <20240328084000.320291-1-minachou@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S8e5Rw091666
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] waitid10: Set the core dump file location to
 temporary directory
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
From: Hui Min Mina Chou via ltp <ltp@lists.linux.it>
Reply-To: Hui Min Mina Chou <minachou@andestech.com>
Cc: minachou@andestech.com, tim609@andestech.com, cynthia@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reference to madvise08, set the core dump file location to
temporary directory, and restore default value after testing.

 # ./waitid10
 tst_buffers.c:56: TINFO: Test is using guarded buffers
 tst_test.c:1709: TINFO: LTP version: 20240129-45-g69537563d16a
 tst_test.c:1593: TINFO: Timeout per run is 0h 05m 00s
 waitid10.c:60: TINFO: Temporary core pattern is '/tmp/LTP_waiTF0QR3/core'
 waitid10.c:73: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
 waitid10.c:38: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
 waitid10.c:39: TPASS: infop->si_pid == pidchild (304)
 waitid10.c:40: TPASS: infop->si_status == SIGFPE (8)
 waitid10.c:41: TPASS: infop->si_signo == SIGCHLD (17)
 waitid10.c:44: TPASS: infop->si_code == CLD_DUMPED (3)

Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
---
 testcases/kernel/syscalls/waitid/waitid10.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index e55e88c2325e..3e48f52d0ea8 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -16,6 +16,8 @@
 #include <sys/prctl.h>
 #include "tst_test.h"
 
+#define CORE_PATTERN "/proc/sys/kernel/core_pattern"
+
 static siginfo_t *infop;
 static int core_dumps = 1;
 
@@ -48,9 +50,16 @@ static void setup(void)
 {
 	struct rlimit rlim;
 	char c;
+	char cwd[1024];
+	char tmpcpattern[1048];
 
 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
-	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
+
+	SAFE_GETCWD(cwd, sizeof(cwd));
+	snprintf(tmpcpattern, sizeof(tmpcpattern), "%s/core", cwd);
+	tst_res(TINFO, "Temporary core pattern is '%s'", tmpcpattern);
+	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", tmpcpattern);
+	SAFE_FILE_SCANF(CORE_PATTERN, "%c", &c);
 
 	if (rlim.rlim_cur)
 		return;
@@ -76,4 +85,9 @@ static struct tst_test test = {
 		{&infop, .size = sizeof(*infop)},
 		{},
 	},
+	.needs_tmpdir = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{CORE_PATTERN, NULL, TST_SR_TCONF},
+		{}
+	},
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
