Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D3FC021B0
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739958844; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=FSJ2FJhton3vM2i1k5pgrhGyNDAeAsNJtW10wef+r78=;
 b=SwQCqoM8S7V/8LvNrI+4YpbfhXxI3A/bkbk4pFXbYXLL5A6ZAIhdm/dR/7tUHOlO/41DR
 5wf88/WD+xLPLdTgRkIW5EUojjXn4O5vKTVzaUDCFEBo64RzImCe0uCbLkcSL8800XaJgt4
 mGgtsYgQJaSv3Q6ygpjr8baVLJTRRMY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09D313C29D8
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:54:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C3F3C25C7
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:53:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B73931035C60
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:53:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739958821; x=1771494821;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PLc3lOkh6h2rNdEaMdWFL/oZio9aPmwSHhci/nHa6cY=;
 b=ETlkDx0b0jj3cenp9JM6zM2vxFU5Fu5xzKh/E0fOhuCr4X1Lo0CfETrA
 +GHKqct+aeTIFg6XbfmaoThewQ8ak5RqTcBOZt6wXGDbOWGO59c8Bq5HH
 OgVW37oAajRhuFNSslLk2RsVjeMVny3yCT718IbzPwpuig1N/weHzvpmE
 gd7juUbxewpuDlzjpDY6fnO+AClPuJRU9iO+lCoTNpC0l1GrafPcEfhT+
 5tzn/LjfY+QcyOR283nKKnKrR5fQ3gMY+91b1UKD4IHjCsHxWoLy5kKRJ
 XeRTeQwzlw+9HB2M0jMbtWmOZq6Z+CG+pstZEIfT67h9kpNqIEX9UoYqH A==;
X-CSE-ConnectionGUID: mgqAGNy1Suuoyv2kddv8zw==
X-CSE-MsgGUID: +DaFKDItTJa/LFMEsFoIRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="177851654"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="177851654"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:53:39 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4762FC3F9A
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:53:37 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F1CC17CCD
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:53:37 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6D6511A0003;
 Wed, 19 Feb 2025 17:53:36 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 17:53:36 +0800
Message-ID: <20250219095336.1048675-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getxattr02: Fix comment indentation to fit RST format
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
 testcases/kernel/syscalls/getxattr/getxattr02.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index 7bc3bf22a..245e5b007 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -13,13 +13,13 @@
  * There are 4 test cases:
  *
  * - Get attribute from a FIFO, setxattr(2) should return -1 and
- *    set errno to ENODATA
+ *   set errno to ENODATA
  * - Get attribute from a char special file, setxattr(2) should
- *    return -1 and set errno to ENODATA
+ *   return -1 and set errno to ENODATA
  * - Get attribute from a block special file, setxattr(2) should
- *    return -1 and set errno to ENODATA
+ *   return -1 and set errno to ENODATA
  * - Get attribute from a UNIX domain socket, setxattr(2) should
- *    return -1 and set errno to ENODATA
+ *   return -1 and set errno to ENODATA
  */
 
 #include <sys/types.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
