Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Barry.Song@csr.com>) id 1TW3Dx-0005o7-02
	for Ltp-list@lists.sourceforge.net; Wed, 07 Nov 2012 10:51:09 +0000
Received: from cluster-g.mailcontrol.com ([208.87.233.190])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TW3Dr-0006tB-52
	for Ltp-list@lists.sourceforge.net; Wed, 07 Nov 2012 10:51:08 +0000
Received: from SHAASIEXC02.ASIA.ROOT.PRI ([210.13.83.101])
	by rly33g.srv.mailcontrol.com (MailControl) with ESMTP id
	qA7A3a1D030650
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <Ltp-list@lists.sourceforge.net>; Wed, 7 Nov 2012 10:03:42 GMT
From: Barry Song <Barry.Song@csr.com>
Date: Wed, 7 Nov 2012 18:03:21 +0800
Message-ID: <1352282601-7377-1-git-send-email-Barry.Song@csr.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] thp01: make "true" applet foundable for busybox
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
To: Ltp-list@lists.sourceforge.net
Cc: workgroup.linux@csr.com

Many embedded systems use busybox. busybox only has one binary, so it depends
on argv[0] as the applet name to execute right command. in thp01 case, it is
"true" command.
this fixes the issue thp01 case always reports "applet not found" for embedded
systems and make the case pass on those systems using busybox.
At the same time, this fix doesn't destory the validation of the test case.

Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 testcases/kernel/mem/thp/thp01.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/thp01.c
index dec6c24..fbb814e 100644
--- a/testcases/kernel/mem/thp/thp01.c
+++ b/testcases/kernel/mem/thp/thp01.c
@@ -81,7 +81,8 @@ int main(int argc, char **argv)
 		case 0:
 			memset(arg, 'c', length - 1);
 			arg[length - 1] = '\0';
-			for (i = 0; i < ARRAY_SZ - 1; i++)
+			array[0] = "true";
+			for (i = 1; i < ARRAY_SZ - 1; i++)
 				array[i] = arg;
 			array[ARRAY_SZ - 1] = NULL;
 			if (setrlimit(RLIMIT_STACK, &rl) == -1) {
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog

------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
