Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Tbm2B-0002T3-Du
	for ltp-list@lists.sourceforge.net; Fri, 23 Nov 2012 05:42:39 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tbm29-0002lT-5I
	for ltp-list@lists.sourceforge.net; Fri, 23 Nov 2012 05:42:39 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.2.2/Sentrion-MTA-4.2.2) with
	ESMTP id qAN5gUxS010184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Nov 2012 05:42:31 GMT
Received: from acsmt358.oracle.com (acsmt358.oracle.com [141.146.40.158])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	qAN5gTc4025817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Nov 2012 05:42:30 GMT
Received: from abhmt106.oracle.com (abhmt106.oracle.com [141.146.116.58])
	by acsmt358.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id
	qAN5gT5N029510
	for <ltp-list@lists.sourceforge.net>; Thu, 22 Nov 2012 23:42:29 -0600
From: Simon Xu <xu.simon@oracle.com>
Date: Fri, 23 Nov 2012 13:42:20 +0800
Message-Id: <1353649340-678-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] numa01.sh: fix error in getting number of CPUs
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

test04 in numa01.sh is using a wrong method to get the number of CPUs.
This results in:

numactl: cpu argument 9 is out of range

awk: cmd. line:1: fatal: cannot open file `/proc/4116/stat' for reading
(No such file or directory)
/opt/ltp/testcases/bin/numa01.sh: line 475: [: =: unary operator expected
awk: cmd. line:1: fatal: cannot open file `/proc/4116/stat' for reading
(No such file or directory)
/opt/ltp/testcases/bin/numa01.sh: line 481: [: -ne: unary operator expected
/opt/ltp/testcases/bin/numa01.sh: line 488: kill: (4116) - No such process
numa04      4  TBROK  :  Kill on process 4116 fails

Fix it by getting number of CPUs by grepping /proc/cpuinfo.
---
 testcases/kernel/numa/numa01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 3ea7950..8d0808a 100644
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -466,7 +466,7 @@ test04()
     run_on_cpu=0
     running_on_cpu=0
 
-    no_of_cpus=$(ls /sys/devices/system/cpu/ | wc -w)
+    no_of_cpus=$(grep "^processor"  /proc/cpuinfo | wc -l)
     # not sure whether cpu's can't be in odd number
     run_on_cpu=$[$[$no_of_cpus+1]/2]
     numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits for sigint
-- 
1.8.0


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
