Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1YfJdt-00052l-OE
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 02:53:33 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YfJdp-0002VO-44
	for ltp-list@lists.sourceforge.net; Tue, 07 Apr 2015 02:53:33 +0000
From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 7 Apr 2015 02:51:11 +0000
Message-ID: <1428375071-99253-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATH] gzip/gzip_tests.sh: remove the tmp dir of test02
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
Cc: , huawei.com.zhuyanpeng@huawei.com, zhanyongming@huawei.com.lijinyue

To clean up when test02 finished of gzip_tests.sh.
---
 testcases/commands/gzip/gzip_tests.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index 5f0725c..432f992 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -326,4 +326,6 @@ then
 	TFAILCNT=$(($TFAILCNT+1))
 fi
 
+rm -fr $LTPTMP/tst_gzip.*
+
 exit $TFAILCNT
-- 
1.6.0.2


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
