Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1Mw9cw-0003P1-Ac
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 07:10:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mw9cq-0003IQ-Rg
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 07:10:58 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 998DB170028
	for <ltp-list@lists.sourceforge.net>;
	Fri,  9 Oct 2009 15:10:43 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n997ADIq007691
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Oct 2009 15:10:13 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 8D3A6D42A3
	for <ltp-list@lists.sourceforge.net>;
	Fri,  9 Oct 2009 15:20:34 +0800 (CST)
Message-ID: <4ACEE1D4.5000202@cn.fujitsu.com>
Date: Fri, 09 Oct 2009 15:10:12 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] : fix memcg_function_test's bug
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

testcase_25() uses a wrong "$?" value ,
Now use "ret" to record the real "$?" 
value for test .


Signed-off-by: Liu Bo <liubo-fnst@cn.fujitsu.com>

---
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
index ea4c8a2..0f11835 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.sh
@@ -398,11 +398,12 @@ testcase_24()
 testcase_25()
 {
 	echo -1 > memory.limit_in_bytes 2> /dev/null
+	ret=$?
 	tst_kvercmp 2 6 31
 	if [ $? -eq 0 ]; then
-		result $(( !($? != 0) ))  "return value is $?"
+		result $(( !($ret != 0) ))  "return value is $ret"
        else
-		result $(( !($? == 0) ))  "return value is $?"
+		result $(( !($ret == 0) ))  "return value is $ret"
 	fi
 }
 

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
