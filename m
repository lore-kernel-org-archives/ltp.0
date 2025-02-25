Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C22C021B2
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740475325; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=EUYcKgDh+Et0qye/bi1uN2FceYtH7S5zheUR4P2tmrg=;
 b=QFAmTlpxMUmCCFYa08TdelYpS1FDCE7lFiCR4fxt+TYXKXHKLyyZWAG/HEZwqF/NxLsT6
 fTSimuLx0CeqTXy7rdDkbVzCbpPVuL1OL1Z9O4hnuLCSxZSL2fNp9cS2zaRdD+Lp2c3S3xW
 YG1gLwzqSM+tRAoGzBhNp/ugsfIqnGw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 997CD3C9B09
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 10:22:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C8A93C9A18
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 10:21:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D1220638414
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 10:21:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740475304; x=1772011304;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tSK4bfQTHDqi+HE4pTliY9FIwcMdvlDr5pR4vocW+Hc=;
 b=ExBdlTSXjEJQFho2zaGQURQ3UJNjdu/z76Vb6PGQGr32uTjxdFSObET/
 Tcwo4AC1CdIpNqUZThzHdBFrPti0tMRUzbAfvkEOZt/etK0nyNvNpbEOv
 Kqu/h735kLAYVBnF+JkhfrnRR7Da2I7rxUNMW0EndMoNXws7TEtzX2f7B
 Y7dFabPlSuc64c+2PHk2HhgXsMaqkClgkGTut6YhzroL46fTbdBxsywk6
 fjxfNccLctEc2CqZLAV6fcldyLdWmJDnR24swxwGwmaRLBNS0vdXVtKea
 I1GJeSLh7v+XAXFRmcl6f+EXHee2vJVmr5oi1IXH/u3KPEcBWwgD7SKVx Q==;
X-CSE-ConnectionGUID: cyxPxv+7TZGrZKUkapBStg==
X-CSE-MsgGUID: Re2iQ15YRsGJqUP+eqk34g==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="170575421"
X-IronPort-AV: E=Sophos;i="6.13,313,1732546800"; d="scan'208";a="170575421"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 18:21:42 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 37F9CD500F
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 18:21:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2444D509D
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 18:21:38 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 767861A000B;
 Tue, 25 Feb 2025 17:21:38 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 25 Feb 2025 17:21:10 +0800
Message-ID: <20250225092110.1481284-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mountns: Fix doc to fit RST format
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
 .../kernel/containers/mountns/mountns01.c     | 20 ++++++++++-------
 .../kernel/containers/mountns/mountns02.c     | 20 ++++++++++-------
 .../kernel/containers/mountns/mountns03.c     | 22 +++++++++++--------
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
index 2c1c978fd..749d554c1 100644
--- a/testcases/kernel/containers/mountns/mountns01.c
+++ b/testcases/kernel/containers/mountns/mountns01.c
@@ -17,14 +17,18 @@
  * - Makes directory DIR_A shared
  * - Clones a new child process with CLONE_NEWNS flag
  * - There are two test cases (where X is parent namespace and Y child namespace):
- *  1. First test case
- *   .. X: bind mounts DIR_B to DIR_A
- *   .. Y: must see DIR_A/"B"
- *   .. X: umounts DIR_A
- *  2. Second test case
- *   .. Y: bind mounts DIR_B to DIR_A
- *   .. X: must see DIR_A/"B"
- *   .. Y: umounts DIR_A
+ *
+ *   1. First test case
+ *
+ *     - X: bind mounts DIR_B to DIR_A
+ *     - Y: must see DIR_A/"B"
+ *     - X: umounts DIR_A
+ *
+ *   2. Second test case
+ *
+ *     - Y: bind mounts DIR_B to DIR_A
+ *     - X: must see DIR_A/"B"
+ *     - Y: umounts DIR_A
  */
 
 #include <sys/wait.h>
diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
index cdc36068d..0dda86f30 100644
--- a/testcases/kernel/containers/mountns/mountns02.c
+++ b/testcases/kernel/containers/mountns/mountns02.c
@@ -18,14 +18,18 @@
  * - Clones a new child process with CLONE_NEWNS flag
  * - There are two test cases (where X is parent namespace and Y child
  *   namespace):
- *  1. First test case
- *   .. X: bind mounts DIR_B to DIR_A
- *   .. Y: must see DIR_A/"A" and must not see DIR_A/"B"
- *   .. X: umounts DIR_A
- *  2. Second test case
- *   .. Y: bind mounts DIR_B to DIR_A
- *   .. X: must see DIR_A/"A" and must not see DIR_A/"B"
- *   .. Y: umounts DIRA
+ *
+ *   1. First test case
+ *
+ *     - X: bind mounts DIR_B to DIR_A
+ *     - Y: must see DIR_A/"A" and must not see DIR_A/"B"
+ *     - X: umounts DIR_A
+ *
+ *   2. Second test case
+ *
+ *     - Y: bind mounts DIR_B to DIR_A
+ *     - X: must see DIR_A/"A" and must not see DIR_A/"B"
+ *     - Y: umounts DIRA
  */
 
 #include <sys/wait.h>
diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
index 2debfd104..c8df17638 100644
--- a/testcases/kernel/containers/mountns/mountns03.c
+++ b/testcases/kernel/containers/mountns/mountns03.c
@@ -19,15 +19,19 @@
  *   mount
  * - There are two testcases (where X is parent namespace and Y child
  *   namespace):
- *  1. First test case
- *   .. X: bind mounts DIRB to DIRA
- *   .. Y: must see the file DIRA/"B"
- *   .. X: umounts DIRA
- *  2. Second test case
- *   .. Y: bind mounts DIRB to DIRA
- *   .. X: must see only the DIRA/"A" and must not see DIRA/"B" (as slave mount does
- *         not forward propagation)
- *   .. Y: umounts DIRA
+ *
+ *   1. First test case
+ *
+ *     - X: bind mounts DIRB to DIRA
+ *     - Y: must see the file DIRA/"B"
+ *     - X: umounts DIRA
+ *
+ *   2. Second test case
+ *
+ *     - Y: bind mounts DIRB to DIRA
+ *     - X: must see only the DIRA/"A" and must not see DIRA/"B" (as slave mount does
+ *          not forward propagation)
+ *     - Y: umounts DIRA
  */
 
 #include <sys/wait.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
