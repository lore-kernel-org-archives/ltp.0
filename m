Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SSfkt-0002MR-Oa
	for ltp-list@lists.sourceforge.net; Fri, 11 May 2012 02:38:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SSfks-0008Vp-B9
	for ltp-list@lists.sourceforge.net; Fri, 11 May 2012 02:38:55 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q4B2ckqt021300
	for <ltp-list@lists.sourceforge.net>; Fri, 11 May 2012 10:38:47 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Fri, 11 May 2012 10:37:35 +0800
Message-Id: <1336703855-15408-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] logrotate01: fix a bug of config file's permission is
	wrong
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

config file's permission should be 644, please refer to:
https://fedorahosted.org/logrotate/changeset/302

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/commands/logrotate/logrotate_tests.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 827dd5f..55ef0b3 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -192,6 +192,7 @@ test01()
 		rm -f $files > /dev/null 2>&1
 	done
 
+	chmod 644 $LTPTMP/tst_logrotate.conf
 	logrotate -fv $LTPTMP/tst_logrotate.conf > $LTPTMP/tst_logrotate.out 2>&1 \
 		|| RC=$?
 	if [ $RC -eq 0 ]
-- 
1.7.10


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
