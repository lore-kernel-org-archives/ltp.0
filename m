Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE8C021B0
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739956941; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=D6WQAvBAe73ZEULjVZ82zjwMapQI7DQ8EyKyzhuN8AQ=;
 b=K8aEhfT1CsXkYPJGMeNkN5t/f351aqVXJSmwuRycykTNpNT6BGJJaeKdpUyoekv7KlS6N
 SRklQ3qGJoMSP0aRgjh5bk7GpVcm27/Ub9tarbZEINLf8OFDbPcyrLCqdH4vWYnO3Yp1urh
 jKZAPEpL549WMxBOAgPrGjx0pt+UGZo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FBDD3C29B6
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:22:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 179403C249C
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:22:00 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76EBB103405E
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739956919; x=1771492919;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xh1au/7gGmUs15RfbbSqXwaezzCmHmEc4sD9idbLSwU=;
 b=aFZHKtfu3bPFx4xASperrQ9FZ0g20YoCwlLWjU7wiuWyKv4cfix1Tvgh
 2CHLCgzivTsgy+tjthSb7m1xMv2ZF1OEB9QZxzI4EM6kfaiPmlLpY5wby
 cbbXCzVOWrtyCOhieZ8l8H0u7KvD1AwUKnr3TH9WQAo2Lq1NND6vOKGZP
 2/B65EVXfz9JIbZy1et8bQDT1DMsjEHLPQk39msSP+uINKUq12BD9OzY1
 Oa71L2wKbjD8y4l8li/Mdt4IZ7h1EIOf+8824HkSu48+tn5vV74+Tyfit
 oRrGASYuSysc9wqW8x9gpuXAOuu1CPTddy+j6uANv3TvcZ5k+NF8dtEyU w==;
X-CSE-ConnectionGUID: TLvHObw2R96v1wtiLkFkNQ==
X-CSE-MsgGUID: tBoNofktSumyDO3vO3tM9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="169422668"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="169422668"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:21:57 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 78038D4807
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:21:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 36F0CBDB6D
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:21:55 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9A8DB1A0003;
 Wed, 19 Feb 2025 17:21:54 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:21:55 +0800
Message-ID: <20250219092155.1046238-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fchownat03: Fix comment indentation to fit RST format
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

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 .../kernel/syscalls/fchownat/fchownat03.c     | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
index 5219ca655..93ec5007d 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat03.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
@@ -5,26 +5,19 @@
  */
 
 /*\
- * Verify that,
- * - fchownat() returns -1 and sets errno to EACCES if there is no permission
-     to access to the file.
- * - fchownat() returns -1 and sets errno to EBADF if the file descriptor
- *   of the specified file is not valid.
- * - fchownat() returns -1 and sets errno to EFAULT if the filename points
-     outside of accessable address space.
- * - fchownat() returns -1 and sets errno to EINVAL if the flag is invalid.
- * - fchownat() returns -1 and sets errno to ELOOP if too many symbolic links
- *   were encountered in resolving filename.
- * - fchownat() returns -1 and sets errno to ENAMETOOLONG if the filename is
-     too long.
- * - fchownat() returns -1 and sets errno to ENOENT if the specified file does
- *   not exist.
- * - fchownat() returns -1 and sets errno to ENOTDIR if the file descriptor is
- *   a file.
- * - fchownat() returns -1 and sets errno to EPERM if the effective user id
- *   of process does not match the owner of the file and the process is not
- *   super user.
- * - fchownat() returns -1 and sets errno to EROFS if the file is readonly.
+ * Verify that fchownat(2) returns -1 and sets errno to:
+ *
+ * - EACCES if there is no permission to access to the file.
+ * - EBADF if the file descriptor of the specified file is not valid.
+ * - EFAULT if the filename points outside of accessable address space.
+ * - EINVAL if the flag is invalid.
+ * - ELOOP if too many symbolic links were encountered in resolving filename.
+ * - ENAMETOOLONG if the filename is too long.
+ * - ENOENT if the specified file does not exist.
+ * - ENOTDIR if the file descriptor is a file.
+ * - EPERM if the effective user id of process does not match the owner of
+ *   the file and the process is not super user.
+ * - EROFS if the file is readonly.
  */
 
 #define _GNU_SOURCE
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
