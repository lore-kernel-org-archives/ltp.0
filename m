Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4F4C7619A
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 11:03:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 158173CCB47
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 13:02:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC36D3CC9D0
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 13:02:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id CB8FB20075A
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 13:02:41 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B6F94B3;
 Mon, 27 Mar 2023 04:03:24 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.54.115])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 642B93F663;
 Mon, 27 Mar 2023 04:02:39 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Mon, 27 Mar 2023 12:02:34 +0100
Message-Id: <20230327110234.266785-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/sockioctl: Make buf a struct ifreq array
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
However, ifc.ifc_buf is assigned to buf, a char array, which has no
alignment constraints. This means there exists cases where buf is not
suitably aligned to load a struct ifreq, which can generate a SIGBUS.

Change buf from a char to a struct ifreq array, as it isn't used for
anything else in this test.
This guarantees that buff will be properly aligned.

Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
---
I changed the cast from Cyril suggestion from (void*) to (char*) just
to be consistent with the type of (struct ifconf).ifc_buf.
From my understanding this should be equivalent.

v2:
  - As per Cyril comments, make buf a struct ifreq array rather than
    align it with __attribute__
  - Update commit message accordingly

CI Build: https://github.com/Teo-CD/ltp/actions/runs/4531482995

 testcases/kernel/syscalls/sockioctl/sockioctl01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 51dac9c16309..ff3738f327ef 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -52,7 +52,7 @@ static struct ifreq ifr;
 static int sinlen;
 static int optval;
 
-static char buf[8192];
+static struct ifreq buf[200];
 
 static void setup(void);
 static void setup0(void);
@@ -218,7 +218,7 @@ static void setup2(void)
 	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
 			tdat[testno].proto);
 	ifc.ifc_len = sizeof(buf);
-	ifc.ifc_buf = buf;
+	ifc.ifc_buf = (char *)buf;
 }
 
 static void setup3(void)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
