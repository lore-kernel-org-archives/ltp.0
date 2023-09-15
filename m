Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A65EE6447
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:35:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A887C3CE6AD
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:35:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B7143C1BBF
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:35:40 +0200 (CEST)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 30F09618FC7
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:35:38 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="133668073"
X-IronPort-AV: E=Sophos;i="6.02,148,1688396400"; d="scan'208";a="133668073"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 18:35:36 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id F3728E445A
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:35:33 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3D6ACC4A16
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:35:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5465C8715F;
 Fri, 15 Sep 2023 18:35:32 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 17:35:06 +0800
Message-Id: <1694770506-9455-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27876.006
X-TMASE-Result: 10--2.623700-10.000000
X-TMASE-MatchedRID: UTto3H8lnnG1UOlz1sLXchF4zyLyne+ATJDl9FKHbrl0Tsch72XSbCRM
 9pS/s/NIv/nLHkYI1eMFTWZGRZVQe+UWmx8yAzoMxvp0tuDMx3mOQOsE4nDCdD19y/o3/Xfgo8W
 MkQWv6iV3LAytsQR4e42j49Ftap9ExlblqLlYqXKi7WryB6UwoQ0/XT2XuiZRvtCTDaMFivCIOo
 HnbLKbkyO3fiyGeGyYoU+At2iSYiuBHxuYHA3BG4FOeouMrEnz5Lohq3v3sbf+v9v52ZIoWjoAf
 389xF3XFSk9HhUZnw7OGIWnws4LoyHWPYzouJUy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ltp-pan.1/parse_ranges.3: fix typo
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/man1/ltp-pan.1      | 2 +-
 doc/man3/parse_ranges.3 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man1/ltp-pan.1 b/doc/man1/ltp-pan.1
index 3f6ddb925..5ffa57dba 100644
--- a/doc/man1/ltp-pan.1
+++ b/doc/man1/ltp-pan.1
@@ -161,7 +161,7 @@ signal is SIGUSR1 then ltp-pan will behave as if \fI-y\fP had not been specified
 
 .SH EXAMPLES
 
-In practice, the ZOO environment variable is generally prefered over the
+In practice, the ZOO environment variable is generally preferred over the
 \fI-a\fP option.  All examples assume this is being set.
 
 The following creates a ltp-pan named "ex1" with an active file in /tmp/active.
diff --git a/doc/man3/parse_ranges.3 b/doc/man3/parse_ranges.3
index 93bb412e3..d92e001f1 100644
--- a/doc/man3/parse_ranges.3
+++ b/doc/man3/parse_ranges.3
@@ -95,7 +95,7 @@ The function should return -1 if str cannot be parsed
 into an integer, or >= 0 if it was successfully
 parsed.  The resulting integer will be stored in
 *val.  If parse_func is NULL, parse_ranges will parse
-the tokens in a manner consistent with the the sscanf %i format.
+the tokens in a manner consistent with the sscanf %i format.
 .TP 1i
 \fIrange_ptr\fP
 A user-supplied char **, which will be set to point
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
