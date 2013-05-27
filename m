Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1Ugqx8-00084j-6r
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 06:30:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ugqx6-0003v1-Bz
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 06:30:42 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r4R6UXwf015384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 27 May 2013 06:30:34 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4R6UWw7024169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 27 May 2013 06:30:33 GMT
Received: from abhmt116.oracle.com (abhmt116.oracle.com [141.146.116.68])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4R6UWPo006136
	for <ltp-list@lists.sourceforge.net>; Mon, 27 May 2013 06:30:32 GMT
From: shuang.qiu@oracle.com
Date: Mon, 27 May 2013 14:29:42 +0800
Message-Id: <1369636182-4730-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP]  [PATCH] Unmap the mapped address region
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: Shuang Qiu <shuang.qiu@oracle.com>

It does not unmap the mapped address region,so we sometimes still get
such
warning when cleanup with nfs as TMPDIR although the file descriptor is
closed:
0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-MOeIFH7102/vma4FwRqb)
failed:
unlink(/mnt/nfsv3/ltp-MOeIFH7102/vma4FwRqb/.nfs000000000110cb3600000001)
failed; errno=16: Device or resource busy

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/mem/vma/vma03.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 54f605a..6af9960 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -101,8 +101,10 @@ int main(int argc, char *argv[])
 				tst_resm(TPASS, "mremap failed as expected.");
 			else
 				tst_resm(TFAIL | TERRNO, "mremap");
+			munmap(map, pgsz);
 		} else {
 			tst_resm(TFAIL, "mremap succeeded unexpectedly.");
+			munmap(remap, 2 * pgsz);
 		}
 
 		close(fd);
-- 
1.7.7


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
