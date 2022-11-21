Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E5BC4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 17:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A93B3CCC07
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 18:31:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E8703C0123
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 18:31:09 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id B03F66484CC
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 18:31:08 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5854F23A;
 Mon, 21 Nov 2022 09:31:13 -0800 (PST)
Received: from e129169.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 109C63F587;
 Mon, 21 Nov 2022 09:31:05 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 17:30:51 +0000
Message-Id: <20221121173052.346670-2-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121173052.346670-1-tudor.cretu@arm.com>
References: <20221121173052.346670-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/prctl02: Fix PR_CAP_AMBIENT testcases
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

Previously, the PR_CAP_AMBIENT testcase that expected EINVAL on nonzero
unused argument (i.e. arg3) was erring because it had an invalid arg2.
In this case, prctl still returns EINVAL, but the testcase description
doesn't match the cause. Fix the description of the testcase and add a
test that properly checks that prctl returns EINVAL on nonzero unused
argument.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/prctl/prctl02.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/prctl/prctl02.c b/testcases/kernel/syscalls/prctl/prctl02.c
index 81cd8f336..fa9206232 100644
--- a/testcases/kernel/syscalls/prctl/prctl02.c
+++ b/testcases/kernel/syscalls/prctl/prctl02.c
@@ -26,8 +26,9 @@
  * - EINVAL when options is PR_SET_THP_DISABLE & arg3, arg4, arg5 is non-zero.
  * - EINVAL when options is PR_GET_THP_DISABLE & arg2, arg3, arg4, or arg5 is
  *   nonzero
- * - EINVAL when options is PR_CAP_AMBIENT & an unused argument such as arg4
- *   is nonzero
+ * - EINVAL when options is PR_CAP_AMBIENT & arg2 has an invalid value
+ * - EINVAL when options is PR_CAP_AMBIENT & an unused argument such as arg4,
+ *   arg5, or, in the case of PR_CAP_AMBIENT_CLEAR_ALL, arg3 is nonzero
  * - EINVAL when option is PR_GET_SPECULATION_CTRL and unused arguments is
  *   nonzero
  * - EPERM when option is PR_SET_SECUREBITS and the caller does not have the
@@ -69,6 +70,7 @@ static unsigned long bad_addr;
 static unsigned long num_0;
 static unsigned long num_1 = 1;
 static unsigned long num_2 = 2;
+static unsigned long num_PR_CAP_AMBIENT_CLEAR_ALL = PR_CAP_AMBIENT_CLEAR_ALL;
 static unsigned long num_invalid = ULONG_MAX;
 static int seccomp_nsup;
 static int nonewprivs_nsup;
@@ -96,6 +98,7 @@ static struct tcase {
 	{PR_SET_THP_DISABLE, &num_0, &num_1, EINVAL, "PR_SET_THP_DISABLE"},
 	{PR_GET_THP_DISABLE, &num_1, &num_1, EINVAL, "PR_GET_THP_DISABLE"},
 	{PR_CAP_AMBIENT, &num_invalid, &num_0, EINVAL, "PR_CAP_AMBIENT"},
+	{PR_CAP_AMBIENT, &num_PR_CAP_AMBIENT_CLEAR_ALL, &num_1, EINVAL, "PR_CAP_AMBIENT"},
 	{PR_GET_SPECULATION_CTRL, &num_0, &num_invalid, EINVAL, "PR_GET_SPECULATION_CTRL"},
 	{PR_SET_SECUREBITS, &num_0, &num_0, EPERM, "PR_SET_SECUREBITS"},
 	{PR_CAPBSET_DROP, &num_1, &num_0, EPERM, "PR_CAPBSET_DROP"},
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
