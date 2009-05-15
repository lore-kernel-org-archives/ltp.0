Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guixh@cn.fujitsu.com>) id 1M4rXR-0001pM-E9
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:09:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4rXH-0005ZT-88
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 07:09:01 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 3D183170133
	for <ltp-list@lists.sourceforge.net>;
	Fri, 15 May 2009 15:11:36 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n4F79fts013065
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2009 15:09:41 +0800
Received: from [127.0.0.1] (unknown [10.167.141.161])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id A09C4291CF9
	for <ltp-list@lists.sourceforge.net>;
	Fri, 15 May 2009 15:18:17 +0800 (CST)
Message-ID: <4A0D13F2.8030804@cn.fujitsu.com>
Date: Fri, 15 May 2009 15:04:18 +0800
From: Gui Xiaohua <guixh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Synchronization between two processes
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

The child-process wait SIGUSR1 which would be sended by parent-process,
if the child-process execute sigtimedwait() after parent-process send 
the signal, it would never receive the SIGUSR1 from parent-process.
I cann't make sure the SIGUSR1 be sended after child-process execute 
sigtimedwait() with 100 percent, and i try my best.

Signed-off-by: Gui Xiaohua <guixh@cn.fujitsu.com>
--- testcases/kernel/containers/pidns/pidns12-old.c	2009-05-14 17:00:20.000000000 +0800
+++ testcases/kernel/containers/pidns/pidns12.c	2009-05-15 15:15:22.000000000 +0800
@@ -109,7 +109,7 @@ int child_fn(void *arg)
 	}
 
 	/* Set timeout for sigtimedwait */
-	timeout.tv_sec = 3;
+	timeout.tv_sec = 10;
 	timeout.tv_nsec = 0;
 
 	/* Set mask to wait for SIGUSR1 signal */
@@ -182,6 +182,9 @@ int main(int argc, char *argv[])
 		cleanup();
 	}
 
+	/*Try best to make sure the SIGUSR1 be sended after child-process execute sigtimedwait*/
+	sleep(5);
+
 	/* Send SIGUSR1 to container init */
 	if (kill(cpid, SIGUSR1) == -1) {
 		tst_resm(TBROK, "parent: kill() failed(%s).", strerror(errno));


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
