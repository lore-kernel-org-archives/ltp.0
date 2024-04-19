Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF6C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713517230; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=02H53CpR0IzCRHf03c5BTltlOsDEkEgEH4yTnHV69po=;
 b=N2gRLZkdSi2ZXdtIDe2SRg90z/efwtnqvir7K5bQJDru1AnWxgWPmpjhgzMXyGS1+HjWj
 h5PBnJwXPjV+91yD2VxLcK+gRR7DWfOWsWZJdtuziT3W0nf1jQgZWAONMwLg0qbhC8grALf
 ORXw5KWOIKhKL8PLbkeacH2nMIDVvso=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77F003CFD75
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 11:00:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BE953CFBA7
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 11:00:08 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6CAF3601144
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 11:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713517208; x=1745053208;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ASPhN6XlU5zwf6d5Ab/FNzdfAjttxEm5cAtQ4oT8V2o=;
 b=c2HjXCn7/4jbGJfs/LWiYMsDLvf6qGEireTxtDYIwMPQzOFcCIAdM82C
 bkqIH1RvM09pQRg3rHfb9rw1vKOlIpEpYyOPwMU/hFO2mq7CtzV17AkaA
 /hxacBtV0coli9DbX6rr+ZqWuL2liAPMP5ISwqDkXfd6u34EXCCnLOSbf
 vTTSTeuxVhA1P8Zh/VPiBHFR/XCHqZr52gsMtgcPVaFhv5ZGI7ccrRS8Z
 LxRC30q3FARX7wgEaxFUmql7dmnWmy7ZTToSbzreq3vv479epovis6LzU
 1tcBcUk+i5zr8Gd8BDqawyiKXAhUBKs4yrXDgXW3SAoCP6FLQvSiCsRo0 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="135472289"
X-IronPort-AV: E=Sophos;i="6.07,213,1708354800"; d="scan'208";a="135472289"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 18:00:05 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 22C50D6861
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 18:00:02 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5096BD3F31
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 18:00:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BFC06223FC1
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 18:00:00 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5C4211A000A;
 Fri, 19 Apr 2024 17:00:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 04:25:49 -0400
Message-Id: <20240419082549.25476-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28330.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28330.006
X-TMASE-Result: 10--12.900700-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXRSuJfEWZSQfB1kSRHxj+Z5TJDl9FKHbrlgPgeggVwCFnU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoS1/NE2jc9NGGvtvwKw8+1BR+vpYbhOH1q/QNwZdfw3FX0tCKdnhB589yM15V5aWpj6C0
 ePs7A07fUrOTjR0Rj1JdFu2iuU7XrrQBhjZUQ2qDdlL4rXp7hTR25yp5PApX8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] gethostname: Add negative test for gethostname
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for gethostname(), when errno is ENAMETOOLONG

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/gethostname/.gitignore    |  1 +
 .../syscalls/gethostname/gethostname02.c      | 31 +++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 testcases/kernel/syscalls/gethostname/gethostname02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index de4f5a633..cc1e39c05 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -477,6 +477,7 @@ gethostbyname_r01 gethostbyname_r01
 gethostid01 gethostid01
 
 gethostname01 gethostname01
+gethostname02 gethostname02
 
 getitimer01 getitimer01
 getitimer02 getitimer02
diff --git a/testcases/kernel/syscalls/gethostname/.gitignore b/testcases/kernel/syscalls/gethostname/.gitignore
index d09d5d288..d6e4cffcb 100644
--- a/testcases/kernel/syscalls/gethostname/.gitignore
+++ b/testcases/kernel/syscalls/gethostname/.gitignore
@@ -1 +1,2 @@
 /gethostname01
+/gethostname02
diff --git a/testcases/kernel/syscalls/gethostname/gethostname02.c b/testcases/kernel/syscalls/gethostname/gethostname02.c
new file mode 100644
index 000000000..250e5f2fd
--- /dev/null
+++ b/testcases/kernel/syscalls/gethostname/gethostname02.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that gethostname(2) fails with
+ *
+ * - ENAMETOOLONG when len is smaller than the actual size
+ */
+
+#include "tst_test.h"
+
+static void verify_gethostname(void)
+{
+	char hostname[HOST_NAME_MAX];
+	int real_length;
+
+	SAFE_GETHOSTNAME(hostname, sizeof(hostname));
+	real_length = strlen(hostname);
+
+	TST_EXP_FAIL(gethostname(hostname, real_length - 1), ENAMETOOLONG,
+		"len is smaller than the actual size");
+}
+
+static struct tst_test test = {
+	.test_all = verify_gethostname,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
