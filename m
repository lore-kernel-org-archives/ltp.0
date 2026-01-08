Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E092D1D478
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767889369; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=DsDtPq7fgEIN+twDsjZgwd4ZXV6cHeUOdrBV0SbKdg4=;
 b=HjZt+rU+mr/0EYkAu3nyfn+Y7mjjK6ubcdumKsUNVhQvZeYoBZ/5X1GYlCdtf2on5tWTe
 3O16c9MgyJLC70rSaXdP3TmVlfwpXYSOlsYmrJVupuNHtZiSv6VxKyavOihyjGQy3Runv3g
 2w5lruT5my1aYItQwC+boDID4lZff9Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E31F53C66BB
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 17:22:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1ACD3C2789
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 17:22:24 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E436A1000923
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 17:22:23 +0100 (CET)
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 14F3E409DF; 
 Thu,  8 Jan 2026 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767889343;
 bh=f3uRwE5F2gF7BWLAAGN8WOtEe65hXKSPqjjuBKj4ScU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hbLGOiOXGRLX9VwW90VaMJsywe3DuXYPaR/3iAigvLOoP19aS3gsMeLjV+/kwPHt7
 Suy3BUFkuN98S7NOf42uLbML3p/ulUaIhC0S6Av9yBgwUNgoLIT7/BocgPZofJLKo/
 A8q+9NjorfJV8/YwgkACweXKW2EhQKekUmd92KMboEUB5N6gRXtPTjyWnIraCjyYH2
 ebXS3G+PNpbo1KfYd/J0b3O3g0XBXb/HSzwpfpynhvK0+yZP4RkWOTb3L7Qsf/p60U
 +wijp2xefPgqjy4Nax73QBY1eVHvcDe/BXbpTJG+XZbimqM4Xu01tss/xBjdlQCDCV
 CMJ7PKD8IEHrYH5IadMFHK3DX2r2Ol6Dg1kzy0RH9aJd3cVQnlv/LU2zTGDHMMANPB
 p9UKMYzzPJX/c+jBw2Eid13dFDCBxO5aujsdgmd1q/yvdMQjI/0DUBVTn7nKrYGzMb
 gLvdFec2XjRSapClfPsN/HAEAOi4yy5tPoTCBMSbGBlyG4zmEoC5wQsuIchnGS25DA
 jdjIy5sM/AUakn7d1uj5WQN36CK2nvu4uLisLQpHfyL7CLPM8eXWwD9MOGDk0s5yOj
 vux2xjJKxTFY5Hcxwet2DJIb/gZUFSkJC/N6aDzYaa46xTijFn37diwx40t5wHuE/x
 oM8cxtyS28ngC9SpMfLKiRUc=
To: ltp@lists.linux.it
Date: Fri,  9 Jan 2026 00:21:52 +0800
Message-ID: <20260108162152.104192-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCHv4] listmount04.c: update struct mnt_id_req support to
 kernel >= 6.17.9
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: po-hsu.lin@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The kernel change 78f0e33cd6c93 ("fs/namespace: correctly handle errors
returned by grab_requested_mnt_ns") from 6.18 has been ported to upstream
6.17.9 [1][2].

Therefore change the expectation from >= 6.18 to >= 6.17 accodingly.

[1] https://lwn.net/Articles/1047684/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.17.9&id=8ff97ade

v2: add comments for this change into the code.
v3: correct the RST syntax and move comment as suggested by Petr Vorel.
v4: correct the patch title.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 .../kernel/syscalls/listmount/listmount04.c   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 2b8b49101..919f4c854 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -7,6 +7,7 @@
  * Verify that listmount() raises the correct errors according with
  * invalid data:
  *
+ * - EBADF: invalid mnt_ns_fd
  * - EFAULT: req or mnt_id are unaccessible memories
  * - EINVAL: invalid flags or mnt_id request
  * - ENOENT: non-existent mount point
@@ -20,8 +21,12 @@
 #include "lapi/syscalls.h"
 
 #define MNT_SIZE 32
-#define BEFORE_6_18 1
-#define AFTER_6_18 2
+/*
+ * For commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
+ * by grab_requested_mnt_ns") from v6.18-rc7 backported to v6.17.9.
+ */
+#define BEFORE_6_17_9 1
+#define AFTER_6_17_9 2
 
 static mnt_id_req *request;
 static uint64_t mnt_ids[MNT_SIZE];
@@ -84,7 +89,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EINVAL,
 		.msg = "invalid mnt_id_req.spare",
-		.kver = BEFORE_6_18,
+		.kver = BEFORE_6_17_9,
 	},
 	{
 		.req_usage = 1,
@@ -95,7 +100,7 @@ static struct tcase {
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = EBADF,
 		.msg = "invalid mnt_id_req.mnt_ns_fd",
-		.kver = AFTER_6_18,
+		.kver = AFTER_6_17_9,
 	},
 	{
 		.req_usage = 1,
@@ -154,10 +159,10 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
-	if (tst_kvercmp(6, 18, 0) >= 0)
-		kver = AFTER_6_18;
+	if (tst_kvercmp(6, 17, 9) >= 0)
+		kver = AFTER_6_17_9;
 	else
-		kver = BEFORE_6_18;
+		kver = BEFORE_6_17_9;
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
