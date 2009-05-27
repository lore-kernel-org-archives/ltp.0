Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1M9A6T-0006b0-Qt
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 03:46:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9A6N-0004A2-9S
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 03:46:52 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 372CE17012D
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 May 2009 11:58:40 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n4R3n3hr005636
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 11:49:03 +0800
Received: from [10.167.141.76] (unknown [10.167.141.76])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id 73B47D401A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 May 2009 11:47:52 +0800 (CST)
Message-ID: <4A1CB6C7.6070302@cn.fujitsu.com>
Date: Wed, 27 May 2009 11:43:03 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ltp: fix typo in
	testcases/kernel/syscalls/chown/chown03.c
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

Fix typo in testcases/kernel/syscalls/chown/chown03.c,
which use ltpuser->pw_uid in call to setegid() should
be ltpuser->pw_gid.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chown/chown03.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index fde107a..f27cb6f 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -213,9 +213,9 @@ void setup()
 	}
 
 	ltpuser = getpwnam(nobody_uid);
-	if (setegid(ltpuser->pw_uid) == -1) {
+	if (setegid(ltpuser->pw_gid) == -1) {
 		tst_resm(TINFO, "setegid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
+			 "to set the effective uid to %d", ltpuser->pw_gid);
 		perror("setegid");
 	}
 	if (seteuid(ltpuser->pw_uid) == -1) {
-- 
1.6.0.2.530.g67faa




------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
