Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YpbiL-0003A8-Ip
	for ltp-list@lists.sourceforge.net; Tue, 05 May 2015 12:12:41 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YpbiG-0000vA-Bx
	for ltp-list@lists.sourceforge.net; Tue, 05 May 2015 12:12:41 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 5 May 2015 12:12:13 +0000
Message-ID: <1430827933-219682-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] commands/logrotate:run the case once again will failed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: zhuyanpeng@huawei.com, zhanyongming@huawei.com

For the first time,case do 'logrotate -fv tst_logrotate.conf' that will
create the 'half-rotated' file(messages-20150416.gz). When run case again,
the case will fail:
'error: destination /var/log/messages-20150416.gz already exists,skipping
rotation'

'Logrotate' does't expect to find an already existing "half-rotated" file
(http://centos.1050465.n5.nabble.com/CentOS-Logrotate-errors-td5725868.html).
Clean the "half-rotated" file,and the case will pass all the time.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/commands/logrotate/logrotate_tests.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/commands/logrotate/logrotate_tests.sh
index 2a793cc..5b14ca0 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -191,6 +191,7 @@ test01()
 	do
 		rm -f $files > /dev/null 2>&1
 	done
+	rm -f /var/log/*`date '+%Y%m%d'`* > /dev/null 2>&1
 
 	chmod 644 $LTPTMP/tst_logrotate.conf
 	logrotate -fv $LTPTMP/tst_logrotate.conf > $LTPTMP/tst_logrotate.out 2>&1 \
-- 
1.6.0.2


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
