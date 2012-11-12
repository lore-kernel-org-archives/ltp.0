Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TXoXC-0007Xk-Bo
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 07:34:18 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TXoXB-0000X8-EY
	for ltp-list@lists.sourceforge.net; Mon, 12 Nov 2012 07:34:18 +0000
From: <jin.li@windriver.com>
Date: Mon, 12 Nov 2012 15:34:01 +0800
Message-ID: <1352705641-27644-4-git-send-email-jin.li@windriver.com>
In-Reply-To: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
References: <1352705641-27644-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] Fix cpuhotplug test case cpuhotplug05
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
To: jin.li@windriver.com, gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net

From: Jin Li <jin.li@windriver.com>

Check whether sar is available befor run test

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
index ad57efe..e64b91c 100755
--- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
+++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
@@ -27,6 +27,11 @@ Desc:   Does sar behave properly during CPU hotplug events?
 
 EOF
 
+which sar > /dev/null 2>&1 || {
+        tst_resm TCONF "sar does not exist"
+        exit_clean 1
+}
+
 # Verify the specified CPU is available
 if ! cpu_is_valid "${CPU_TO_TEST}" ; then
 	tst_resm TBROK"CPU${CPU_TO_TEST} not found"
-- 
1.7.11


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
