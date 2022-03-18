Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74407C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 06:56:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBEBF3C9450
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:56:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CE143C9447
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:56:40 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8AEF71A00CBA
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 07:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1647586598; i=@fujitsu.com;
 bh=ZG1gJ2Xb7fDfCXzFKHArQ7kw/GNB+O9b77oIftJZscI=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=fzwexO5Va34ZYzUbguv3A1vtvX77CaENBn0src0F/ki7FlB5woVbnxRa98DS4Zu2u
 97Xy81y0g6PwlQlDDyVBzL/80PbaTqapxESxU2ftUgk/ULWxInNkhjqozDZQd2jlbb
 qAQL06Yd1PV+C4rZssjHQ4nfDnPGV5gbKKIBi7PlwhwbM2DISYdXlGDSSePSCGNMQL
 s3kD7UH1gO4kNaTgXYbwSHRSor9lM6OOSysoyY983mXCrJCeuQuYrhvsDlMdPZA6Tl
 PYT2WBsj2p7kXVFwcd2ZCMVKi7HVQPuIbtJSkA6l2jVtn+POO97PxWIf2yNfypy2Nj
 1m3fI42bOb9Qw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsViZ8MxSVdN1yT
 JYOEVRosV33cwOjB67Pu9jjWAMYo1My8pvyKBNePZkl7Wgk7uiolXZ7I1MG7g7GLk4hASOMso
 cXfFJFYIZyeTxMSWX1DOfkaJTw/+M3cxcnKwCWhIXHvcDmaLCMhL7J3QDGYzC9hI7Ls6AcwWF
 tCV+PSojxXEZhFQlZg8cyJTFyMHB6+Am8S8GYogYQkBBYkpD98zg4Q5BbQlLl40BQkLCWhJrN
 r4gxHE5hUQlDg58wkLxHQJiYMvXjBDtCpK7N+7kRHCrpCYMWMbG4StJnH13CbmCYyCs5C0z0L
 SvoCRaRWjbVJRZnpGSW5iZo6uoYGBrqGhqa6ZBZDSS6zSTdRLLdVNTs0rKUoEyuollhfrpRYX
 6xVX5ibnpOjlpZZsYgQGckqxC/cOxjt9P/UOMUpyMCmJ8i5TN0kS4kvKT6nMSCzOiC8qzUktP
 sQow8GhJMGbog2UEyxKTU+tSMvMAUYVTFqCg0dJhLddFSjNW1yQmFucmQ6ROsWoKCXO2wfSJw
 CSyCjNg2uDRfIlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8e0Cm8GTmlcBNfwW0mAlocaO
 AEcjikkSElFQDk5Gl8rfgGXY/314sy35ztOyD9a8gjaTMc7Oe7L010d0+W3Dq7nadlqnpkzfz
 R18O888/WW788Sqbk5Jz/AbvQ3zSM70CMrKTp0cqiAmnb7NZpyu37qjMiwc3X/hs+fpL/qFx3
 8rG+74rsubta+Bz/xeZtjXVr/TCR5sVc2Ol7YTurZtf1WjU/Ceg+dCfNL6t667M1sza3b9Gpv
 9gXV5t+qzp30K/sK5dOPdw6EpNvoZAt2ytow+nzVndOOFP4rK1q7753py87MDcZX9qjbjO3O7
 jeeT5IdecPdxaYdbqHdfqQ4SaGBgLvauVwtM2m5+cwWZ1R2eB4VQJReu2Fqak3UzP/z9Qvz1t
 76b3gfaVYkosxRmJhlrMRcWJALbrzqZfAwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-18.tower-532.messagelabs.com!1647586597!254!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20646 invoked from network); 18 Mar 2022 06:56:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-18.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Mar 2022 06:56:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 8093C100463
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:56:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 72080100446
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 06:56:37 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 18 Mar 2022 06:56:15 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <xuyang2018.jy@fujitsu.com>
Date: Fri, 18 Mar 2022 14:55:45 -0400
Message-ID: <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <623414B7.6060004@fujitsu.com>
References: <623414B7.6060004@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] Add SAFE_ACCESS macro
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 include/tst_safe_macros.h |  5 +++++
 lib/tst_safe_macros.c     | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 9a543e4..81c4b08 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -24,6 +24,11 @@
 #include "safe_macros_fn.h"
 #include "tst_cmd.h"
 
+int safe_access(const char *filename, const int lineno, const char *pathname,
+		   int mode);
+#define SAFE_ACCESS(path, mode) \
+	safe_access(__FILE__, __LINE__, (path), (mode))
+
 #define SAFE_BASENAME(path) \
 	safe_basename(__FILE__, __LINE__, NULL, (path))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index a9f6aeb..c4cdc87 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -20,6 +20,25 @@
 #include "lapi/personality.h"
 #include "lapi/pidfd.h"
 
+int safe_access(const char *file, const int lineno,
+	    const char *pathname, int mode)
+{
+	int rval;
+
+	rval = access(pathname, mode);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"access(%s,%d) failed", pathname, mode);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid access(%s,%d) return value %d", pathname,
+			mode, rval);
+	}
+
+	return rval;
+}
+
 int safe_setpgid(const char *file, const int lineno, pid_t pid, pid_t pgid)
 {
 	int rval;
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
