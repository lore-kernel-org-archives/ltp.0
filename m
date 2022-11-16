Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36DFC433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 05:27:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF3D23CBAE2
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 06:27:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 860053CBA0A
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 06:26:50 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 918F8200AF3
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 06:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1668576408; i=@fujitsu.com;
 bh=p3u2Fmsb6JIjJfE5NeOp83v081TuSW+O7v/K9kKcQQ8=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=VQvH7yia8enLh7YdqbThB7EHIfbkUsL6rrcA3EOTzqWkqmK20eO88pGpX/pAdFNSy
 48RGsn6Lsgy0bnATZAXJDnNbzrprDX5IXasoGVqnq4x3+HD4LEIftEi+QSkk/V1Uw9
 O4stPD/s67ZIlzcuLZ3HNBWHA70aCi/2WNUaKS4ztR64dnKb4ufu/YgYOhVknj5jd0
 JY6uxstO8g0xGXswZl9cnktg8TQ/bnGXw0y4woA8eVgDXG4LG5Z1uKJIo0VCMwCpF+
 hyuQVQSAkJRh6+XuCs26T9/tgJV4K5NVsmbA5ne5oqtSApuNr42J3t5uN5+LKd/mm8
 czAStmc3SiIvA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRWlGSWpSXmKPExsViZ8OxWXd6SUm
 ywY7XNhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa0bP7gtsBas4Kw48P8rWwPiLvYuRk0NI4BSj
 xOpPXF2MXED2HiaJOScWMUM5jBKbG18zglSxCWhKPOtcwAxiiwhISHQ0vAXrZhZQl1g+6RcTi
 C0sYCPx4/UCNhCbRUBV4sCuKWA2r4CHxLQTU8FqJAQUJKY8fM8MEReUODnzCQvEHAmJgy9eME
 PUKEpc6vjGCGFXSMya1QbVqyZx9dwm5gmM/LOQtM9C0r6AkWkVo1lxalFZapGuoYFeUlFmekZ
 JbmJmjl5ilW6iXmqpbnlqcYmuoV5iebFeanGxXnFlbnJOil5easkmRmAwphSzxO9gfLjsj94h
 RkkOJiVRXg634mQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKEry5c4FygkWp6akVaZk5wMiASUtw8
 CiJ8Mo1AKV5iwsSc4sz0yFSpxh1Oa5eubKXWYglLz8vVUqclw9khgBIUUZpHtwIWJReYpSVEu
 ZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMe3kG0BSezLwSuE2vgI5gAjrigF8RyBEliQgpqQamnol
 /6/66h7y/ljP/9TGjq5ZXS9efPPy32PdPjHGz0/HQD3FeSX5aWbPDawT3bEi0/rYt6NX0VgNH
 jtYN9rNF/CRObpJRXtQ7vV02oOxurunzTYos179rNv/wLbvbdqrK4J/5ml9q61ILG9b5Fsipc
 O5n3vJGqFRqif7s+6a9wpcPFk77dXtnnNuGt2siuI72xJ9/blzC4rc60zhrQbyqgG/Lkurr99
 7uz+R7I/eg5aJ11/MCVr7V5dOv5fHwvzHKmORcdjr6jqSr47bJ3R5XJF4EnL0+e//DBY4bFy/
 kfLsz8P3JSt0jvcGpuuoVl5q+vbxhcoKzJPruqzfMwufcXl+0mb3Qd6mY8OXAs+0PlViKMxIN
 tZiLihMBh4jABk0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-591.messagelabs.com!1668576407!1064596!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14227 invoked from network); 16 Nov 2022 05:26:47 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-5.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Nov 2022 05:26:47 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 9F551142
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 05:26:47 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 9312473
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 05:26:47 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 16 Nov 2022 05:26:46 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Nov 2022 14:26:43 +0800
Message-ID: <1668580004-2088-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] cgroup_core01: Use correct linux tag
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/controllers/cgroup/cgroup_core01.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
index 8b6243f7c..2e695deed 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
@@ -16,11 +16,11 @@
  *
  * It is a regression test for
  *
- * commit e57457641613fef0d147ede8bd6a3047df588b95
+ * commit 1756d7994ad85c2479af6ae5a9750b92324685af
  * Author: Tejun Heo <tj@kernel.org>
- * Date:   Thu Jan 6 11:02:29 2022 -1000
+ * Date:   Thu Jan 6 11:02:28 2022 -1000
  *
- * cgroup: Use open-time cgroup namespace for process migration perm checks
+ * cgroup: Use open-time credentials for process migraton perm checks
  */
 
 #include <stdlib.h>
@@ -101,7 +101,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
 	.tags = (const struct tst_tag[]) {
-		{"linux-git", "e57457641613"},
+		{"linux-git", "1756d7994ad8"},
 		{"CVE", "2021-4197"},
 		{}
 	},
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
