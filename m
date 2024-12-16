Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A111E7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 06:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734331212; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=T2CWQSqLAm/3FhEFu3Lj3/J+HPq5FqHnd2lvXp090tk=;
 b=QTXGUTpFxojFtbbk3JAhgnv27tS4+M2en3OXQsQRC25Opubdm/ynvq1rbWbxwFWCBDA/x
 Q+E85FD1utFoVmsaHU/XUmBCeJhhIi/8aqqcHdvu+E2oDAbKoRQa5e956/yAT3EVjb1Z2zZ
 Osx0XRnvbvcfMqliIheF63bn7+W7l10=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E33B3E29FE
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 07:40:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A11033E1330
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 07:39:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 921201028603
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 07:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734331191; x=1765867191;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qBVohaRzfRCiPJZX3OICV3mXhoWfR+HRE8t79sGT6mU=;
 b=o1yleXJykyUh9mXnVv/ORtq6lw1ClTej8vWAPd73vQe/zCwsZopBhWDR
 uIKrkEv7BAODL+3SckwezJQJcK9TzhmXZM86AGD7RYRlmPU30TiK4uETj
 L0kYSdfwobaD/n8xQr1QjAW8UjbX+JJjmVxfH65eX1y5MagTavATJjorY
 DkDej7AA/mFgPIoUbbVhZg4KoP6Fmgfhc1Lx0/BnWXT7xj8kO99kqRStq
 RfDV7GVbqNuPrWwGhP9Jz4XYNNfVOOOYFfq1RK17eXlQLZGqu6WtAqV0j
 ULgec092i8/F4pyvey+P2xUtOgwNdEIv0dXnfN5zH4LjCogYXG/wGG+lm w==;
X-CSE-ConnectionGUID: vC9YWeAeR6i7mRJg9zJ/xQ==
X-CSE-MsgGUID: CNkydcBoTyO9ACGtQLRoqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="183845880"
X-IronPort-AV: E=Sophos;i="6.12,237,1728918000"; d="scan'208";a="183845880"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 15:39:47 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 21A02D500F
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 15:39:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DDD5DD3F28
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 15:39:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 63A4E1EA702
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 15:39:44 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 91F761A000B;
 Mon, 16 Dec 2024 14:39:43 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 16 Dec 2024 14:38:25 +0800
Message-ID: <20241216063825.2890676-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28862.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28862.005
X-TMASE-Result: 10--5.816700-10.000000
X-TMASE-MatchedRID: 60gbRApQc+uhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmOEENgsUAuYqgN
 0Z4XHtao2Oo5Jf+VMsw4bJd2G5kbyZcFdomgH0lnFEUknJ/kEl6YwzE9E8g5OfoLR4+zsDTthUf
 R2rvBju7r5J4l7VAEfEYQVA68QFRgP+muRkDkQRgk3Z+nrcL+p1FRaxauD6pX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nanosleep04: Convert docs to docparse
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
 testcases/kernel/syscalls/nanosleep/nanosleep04.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep04.c b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
index 4eed9d0ce..3582a3fb2 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep04.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep04.c
@@ -7,13 +7,11 @@
  * 07/2019    Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
 
-/*
- * Test Description:
- *  Verify that nanosleep() will fail to suspend the execution
- *  of a process if the specified pause time is invalid.
+/*\
+ * [Description]
  *
- * Expected Result:
- *  nanosleep() should return with -1 value and sets errno to EINVAL.
+ * Verify that nanosleep() returns -1 and sets errno to EINVAL when failing to suspend the
+ * execution of a process if the specified pause time is invalid.
  */
 
 #include <errno.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
