Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1UfPf5-0002Yh-NF
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 07:10:07 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UfPf4-00022F-Nb
	for ltp-list@lists.sourceforge.net; Thu, 23 May 2013 07:10:07 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r4N79wHZ032615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 May 2013 07:09:59 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4N79xsl021461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 May 2013 07:09:59 GMT
Received: from abhmt119.oracle.com (abhmt119.oracle.com [141.146.116.71])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r4N79xVn000939
	for <ltp-list@lists.sourceforge.net>; Thu, 23 May 2013 07:09:59 GMT
From: shuang.qiu@oracle.com
Date: Thu, 23 May 2013 15:09:07 +0800
Message-Id: <1369292947-20445-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] dup07:Close the file before unlink it.
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

When unlink() a file in nfs environment,it will rename the file to a
.nfs<xxxxx> file if any process still has that file open.And this file
could not be deleted until it is closed.So we always get the following
warning which makes testcase "dup07" failed:
0  TWARN  :  tst_rmdir: rmobj(/mnt/nfsv3/ltp-ZtzSE27611/dupKuEr3H)
failed:
unlink(/mnt/nfsv3/ltp-ZtzSE27611/dupKuEr3H/.nfs000000000110cb3800000066)
failed; errno=16: Device or resource busy

Close the created/dup file before unlink() it to fix this issue.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/syscalls/dup/dup07.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup07.c b/testcases/kernel/syscalls/dup/dup07.c
index 03b0ba4..19cd751 100644
--- a/testcases/kernel/syscalls/dup/dup07.c
+++ b/testcases/kernel/syscalls/dup/dup07.c
@@ -80,6 +80,10 @@ int main(int ac, char **av)
 			}
 		}
 
+		if (duprdo != -1)
+			close(duprdo);
+		if (rdoret != -1)
+			close(rdoret);
 		unlink(testfile);
 		
 		if ((wroret = creat(testfile, 0222)) == -1) {
@@ -100,6 +104,10 @@ int main(int ac, char **av)
 			}
 		}
 
+		if (dupwro != -1)
+			close(dupwro);
+		if (wroret != -1)
+			close(wroret);
 		unlink(testfile);
 
 		if ((rdwret = creat(testfile, 0666)) == -1) {
@@ -120,6 +128,10 @@ int main(int ac, char **av)
 			}
 		}
 		
+		if (duprdwr != -1)
+			close(duprdwr);
+		if (rdwret != -1)
+			close(rdwret);
 		unlink(testfile);
 	}
 
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
