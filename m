Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SzLLY-0003kM-CP
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 05:31:48 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzLLV-00075r-2O
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 05:31:48 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q795VbYm022663
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Aug 2012 13:31:37 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Thu, 9 Aug 2012 13:31:14 +0800
Message-Id: <1344490274-19671-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] syslog07: fix a bug of -o
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

Add missing -o.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/syslog/syslog07 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog07 b/testcases/kernel/syscalls/syslog/syslog07
index a477cce..0212efb 100755
--- a/testcases/kernel/syscalls/syslog/syslog07
+++ b/testcases/kernel/syscalls/syslog/syslog07
@@ -116,7 +116,7 @@ syslog_case7()
 	notice=$(( $notice_new - $notice_old ))
 	info=$(( $info_new - $info_old ))
 
-	if [ $emerg -ne 1 -o $alert -ne 1 -o $crit -ne 1 -o $err -ne 1 \
+	if [ $emerg -ne 1 -o $alert -ne 1 -o $crit -ne 1 -o $err -ne 1 -o \
 	     $warning -ne 1 -o $notice -ne 1 -o $info -ne 1 -o \
 	     $info -ne 1 ]; then
 		status_flag=1
-- 
1.7.11.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
