Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MDYDr-00043E-4m
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 06:20:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDYDp-0007oK-AA
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 06:20:43 +0000
Message-ID: <4A2CACC5.6080601@cn.fujitsu.com>
Date: Mon, 08 Jun 2009 14:16:37 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <4A2CABFB.3010207@cn.fujitsu.com>
In-Reply-To: <4A2CABFB.3010207@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] chmod05: fix the effective user when do cleanup
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net

The TESTDIR is created by root user, but when we do cleanup, the effective
user had been changed to nobody, so the cleanup will be failed when the
TESTDIR is removed.

  chmod05     0  WARN  :  tst_rmdir(): rmobj(/tmp/chmOpEdLA) failed: \
  remove(/tmp/chmOpEdLA) failed; errno=1: Operation not permitted

This patch fixed the problem by reset the effective user to root.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chmod/chmod05.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index c6f1225..252f14e 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -266,6 +266,9 @@ void cleanup()
 	 */
 	TEST_CLEANUP;
 
+	setegid(0);
+	seteuid(0);
+
 	/* Remove tmp dir and all files in it */
 	tst_rmdir();
 
-- 
1.6.0.2.530.g67faa





------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
