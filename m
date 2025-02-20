Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343E3C021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740041490; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=N6Asvi1Cy5bFfKpUHjyaqyMwz06qQKtIlaF6L2w2ahU=;
 b=CDlO90sxt6FFBybODCbv9FtROhZnRMuiQp/UzgbrZVUQnnWJdh4NzpLbvOnjnxno27BPJ
 9+2M0Ynab2Q5Uz/h3LAlTCVeVWT7020IRyKWNzrRp81pRHY4ROWgbD+nuWtFTIXXzTFYjtz
 0dwwBfoDXTNSZSUsz6KzJzmif8inpfs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93B6C3C2F29
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 09:51:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B26FE3C2F29
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 09:51:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D600A22FDDA
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 09:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740041468; x=1771577468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+1r0b5fPOG34MSMOy2y/WuqcfQT3FV07/SXj6LCSzMw=;
 b=QAxomU6WuuBzH4nDpcmNrFhmXfJPr6sz6YHiIoXzlCMGtW5bGAZ6zKmO
 8W/cvZccGuoEogwKdhF9/+kcyBSDGox1Nl5F7vW8kZLOkb9P4pNc/c9X2
 bbmM2F7a8uffVAdJoNe7TWSSV44FR/lDQ23KUUyPIyVShrY4vCCQSv1Db
 GiKiTv1ZhGWbgbmXDsjboPe8c8Rt3z3NrMElDkKNn+6L8vb4tiEQgQI02
 7VRVt1yFivJmfQJWDNQosNhL1HhX+8qVQqksvLX19QTNqdoy9xO4Tg4ze
 Y7BOtyHSDXwnDaKe6cIgeUg5tD/08jLTj9mOKO7ZcQNqMLQUNvs5Be53c A==;
X-CSE-ConnectionGUID: a41dR+77RUWEbi7qab8i9w==
X-CSE-MsgGUID: 0HrXyArBR5SSRgpijxjazA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="190682286"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="190682286"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 17:51:06 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 58092D4F67
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:51:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1FF6CE6475
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:51:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 907691A0003;
 Thu, 20 Feb 2025 16:51:02 +0800 (CST)
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com
Date: Thu, 20 Feb 2025 16:50:49 +0800
Message-ID: <20250220085049.1128006-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250219085000.1038179-1-maxj.fnst@fujitsu.com>
References: <20250219085000.1038179-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] capset02: Fix the doc to fit RST format
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix the indent and change to bullet point lists.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/capset/capset02.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index 36d799663..f9d4d860b 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -6,20 +6,15 @@
  */
 
 /*\
- * Tests basic error handling of the capset syscall.
+ * Verify that, capset(2) fails and sets errno to
  *
- * 1. capset() fails with errno set to EFAULT if an invalid address
- * is given for header.
- * 2. capset() fails with errno set to EFAULT if an invalid address
- * is given for data.
- * 3. capset() fails with errno set to EINVAL if an invalid value
- * is given for header->version.
- * 4. capset() fails with errno set to EPERM if the new_Effective is
- * not a subset of the new_Permitted.
- * 5. capset() fails with errno set to EPERM if the new_Permitted is
- * not a subset of the old_Permitted.
- * 6. capset() fails with errno set ot EPERM if the new_Inheritable is
- * not a subset of  the old_Inheritable and bounding set.
+ * - EFAULT if an invalid address is given for header.
+ * - EFAULT if an invalid address is given for data.
+ * - EINVAL if an invalid value is given for header->version.
+ * - EPERM if the new_Effective is not a subset of the new_Permitted.
+ * - EPERM if the new_Permitted is not a subset of the old_Permitted.
+ * - EPERM if the new_Inheritable is not a subset of the
+ *   old_Inheritable and bounding set.
  */
 
 #include <stdlib.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
