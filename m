Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XFKMd-0003lJ-Rr
	for ltp-list@lists.sourceforge.net; Thu, 07 Aug 2014 09:52:03 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XFKMc-0003Ng-QP
	for ltp-list@lists.sourceforge.net; Thu, 07 Aug 2014 09:52:03 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s779prdM030252
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Aug 2014 17:51:53 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Thu, 7 Aug 2014 17:50:10 +0800
Message-ID: <1407405010-23077-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] run_memctl_test.sh: replace the former intercept
	method
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

In RHEL6.5GA and RHEL7.0GA, running run_memctl_test.sh outputs
"/opt/ltp/testcases/bin/run_memctl_test.sh: line 87: [: -lt:
unary operator expected" error. This is because $MEM_AVAIL
is empty here, which is caused by command "tr -s [:space:]" that
loses efficacy. Using "awk" replaces the former intercept method.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/controllers/memctl/run_memctl_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memctl/run_memctl_test.sh b/testcases/kernel/controllers/memctl/run_memctl_test.sh
index 66e8f4f..fe171df 100755
--- a/testcases/kernel/controllers/memctl/run_memctl_test.sh
+++ b/testcases/kernel/controllers/memctl/run_memctl_test.sh
@@ -83,7 +83,7 @@ cd $LTPROOT/testcases/bin/
 #################################################################################
 
 # First of all check if the system has sufficient memory
-MEM_AVAIL=`cat /proc/meminfo | grep MemTotal | tr -s [:space:] | cut -d" " -f2`;
+MEM_AVAIL=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`;
 if [ $MEM_AVAIL -lt 262144 ]	# 256MB(as test requires some ~200MB)
 then
 	echo System does not have sufficient free memory.;
-- 
1.9.3


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
