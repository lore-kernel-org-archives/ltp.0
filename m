Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A370C74A5B
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 16:05:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89C3B3CE2F8
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 17:05:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7BA93CE2E7
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:05:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 854FF200968
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:05:17 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 275F34B3
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:06:00 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.53.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B6A73F766
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:05:15 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 23 Mar 2023 16:05:08 +0000
Message-Id: <20230323160508.672397-2-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/sockioctl: Align buffer to struct ifreq
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

In setup3, the following line can lead to an undefined behavior:
  ifr = *(struct ifreq *)ifc.ifc_buf;

Indeed, at this point it can be assumed that ifc.ifc_buf is suitably
aligned for struct ifreq.
However, ifc.ifc_buf is assigned to buf which has no alignment
constraints. This means there exists cases where buf is not suitably
aligned to load a struct ifreq, which can generate a SIGBUS.

Force the alignment of buf to that of struct ifreq.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
CI Build: https://github.com/Teo-CD/ltp/actions/runs/4502204132

 testcases/kernel/syscalls/sockioctl/sockioctl01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 486236af9d6b..e63aa1921877 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -52,7 +52,13 @@ static struct ifreq ifr;
 static int sinlen;
 static int optval;
 
-static char buf[8192];
+/*
+ * buf has no alignment constraints by default. However, it is used to load
+ * a struct ifreq in setup3, which requires it to have an appropriate alignment
+ * to prevent a possible undefined behavior.
+ */
+static char buf[8192]
+	__attribute__((aligned(__alignof__(struct ifreq))));
 
 static void setup(void);
 static void setup0(void);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
