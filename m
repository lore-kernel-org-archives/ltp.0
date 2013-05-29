Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UhZZU-0002uf-0m
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 06:09:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UhZZS-0002Vz-Gl
	for ltp-list@lists.sourceforge.net; Wed, 29 May 2013 06:09:15 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4T690fN011916
	for <ltp-list@lists.sourceforge.net>; Wed, 29 May 2013 14:09:05 +0800
Message-ID: <51A59AE7.60006@cn.fujitsu.com>
Date: Wed, 29 May 2013 14:06:31 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] su/su01_s1: fix mismatched double quotation marks
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
To: LTP list <ltp-list@lists.sourceforge.net>

Expect code
* spawn su -c "/bin/su root -c \"echo \"\\\$TEST_LINE > $TEST_ENV_FILE\"\""
will be translated to
* spawn su -c /bin/su root -c "echo "\$TEST_LINE > /tmp/TEST_ENV_FILE_ROOT""
which actually should be
* spawn su -c /bin/su root -c "echo \$TEST_LINE > /tmp/TEST_ENV_FILE_ROOT"


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/commands/su/su01_s1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/su/su01_s1 b/testcases/commands/su/su01_s1
index b50ebdf..fd2e485 100755
--- a/testcases/commands/su/su01_s1
+++ b/testcases/commands/su/su01_s1
@@ -145,7 +145,7 @@ set exit_code [lindex $codes 3]
 set i_have_env 0
 set test_env_var " "
 if { $i_am_root==1 } {
-	spawn su -c "/bin/su root -c \"echo \"\\\$TEST_LINE > $TEST_ENV_FILE\"\""
+	spawn su -c "/bin/su root -c \"echo \\\$TEST_LINE > $TEST_ENV_FILE\""
 	expect {
 		 "Password:" {
 			send "$PASSWD\r"
-- 
1.8.1

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
