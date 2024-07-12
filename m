Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797FFC3DA49
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 02:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720752754; h=to : date :
 message-id : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=Wg/iPO0+tRioBugWQile08X+RQ2YvQVircIfrfBgLxc=;
 b=EX3LLQircu/Fq7f5l4l+0wlzC7J82QTk4yhg541BGyG7mVMmVAbX+X/Z26opZ52CDvCL2
 X56YWxmVConSnZ2/MezLC2o49Ha2o6S1fYqjTIroH/jmu56CSw3gXTJ8lnfPeVCR80pOAtj
 EnNB4vGG9DnMITEC/JPYF2XE8yywseg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F6663D1962
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 04:52:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FEA63C2220
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 04:52:12 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D412B200BA4
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 04:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1720752731; x=1752288731;
 h=from:to:cc:subject:date:message-id;
 bh=kJUBmND1UM4yxH96/nZ5FqYy0Jm/LHPmHKiMy/zCI90=;
 b=DoY4UEoXyLEXuNGCDDspujjfzB0o4cC/iYieGramlvmSZLYPVgQd7E5k
 oqt3ZxjeePd1O6ws5cuagG5xRkqTamtLC/Pnn+IFJl17XVZeOn/AkZ85L
 Pn52D4kAABM9xYHt/Qz1+9B4Q7GhjJ1zdG3Mgp6tRtKpRE2ITA7L8X7D5
 nOFkc7lEps9FFnzihj+KEiSjR1cPZq1u+2LzeTgICfEqwKXm4zwDhEOa1
 yUfSdaPQZG8hS17HUgtZUSrOTcDT0jKN6yDG6O5uxX4pIUretH/OGCEu5
 +0MqWjlZsOfrJG3BfxXT549WmgUrcukBg3JOeUjhqyeGvuB+1jyYF6ahZ w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="166711981"
X-IronPort-AV: E=Sophos;i="6.09,202,1716217200"; d="scan'208";a="166711981"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2024 11:52:08 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id ED9C1D922F
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:52:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 490ADD8C9D
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:52:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D56021D6D6
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:52:04 +0900 (JST)
Received: from localhost (unknown [10.167.226.69])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A50E01A000A;
 Fri, 12 Jul 2024 10:52:03 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 12 Jul 2024 10:51:49 +0800
Message-Id: <20240712025149.11527-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.18.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28524.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28524.004
X-TMASE-Result: 10--2.368400-10.000000
X-TMASE-MatchedRID: ntF4Soh351DlWiNI/3lAD07nLUqYrlslFIuBIWrdOeOjEIt+uIPPOLiR
 FJnWDxklfgsc3BsCzVgSJVWAqoVeTh8TzIzimOwPFQ98tXLWB2EZsIdvLTjL2Ms6r5Re2rBYC24
 oEZ6SpSmcfuxsiY4QFD8QJ9K8WPd3omTkQrXg7jMX212i0aDp7YolcsF7qkwa0KRWEdfXnBAZlE
 xejPEQjUSNkw/lLj8SRLVBLiHTb0P/VGvjDO+Pvux9n1XpDqsJmC9SiJioatWbjnu8jwgbwH9ji
 cWwFYB0PpCuffGH9zI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] utimensat: Convert docs to docparse
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/utimensat/utimensat01.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index efcb5c7a4..0f2dd2e92 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -3,6 +3,12 @@
  * Copyright (c) 2008 Michael Kerrisk <mtk.manpages@gmail.com>
  * Copyright (c) 2008 Subrata Modak <subrata@linux.vnet.ibm.com>
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ * Copyright (c) Linux Test Project, 2020-2024
+ *
+ */
+
+/*\
+ * [Description]
  *
  * Basic utimnsat() test.
  */
-- 
2.18.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
