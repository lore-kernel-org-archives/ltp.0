Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1RNOi1-0006Ug-Ij
	for ltp-list@lists.sourceforge.net; Mon, 07 Nov 2011 12:53:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RNOhx-00089D-Kv
	for ltp-list@lists.sourceforge.net; Mon, 07 Nov 2011 12:53:53 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA7CrhnL010740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Nov 2011 07:53:43 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id pA7Crg3C010123
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Nov 2011 07:53:43 -0500
Message-ID: <4EB7D4D6.5000704@redhat.com>
Date: Mon, 07 Nov 2011 13:53:42 +0100
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060307020103050005020602"
Subject: [LTP] [PATCH] recvmsg01: kill child only if one was forked
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060307020103050005020602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


If start_server() fails, then pid will end up with -1 and
cleanup() will do kill(-1, SIGKILL), which kills everything
this process can kill.

Change the test to kill pid (child) only when it successfully
creates one.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/syscalls/recvmsg/recvmsg01.c |    5 +++--
  1 files changed, 3 insertions(+), 2 deletions(-)



--------------060307020103050005020602
Content-Type: text/x-patch;
	name="0001-recvmsg01-kill-child-only-if-one-was-forked.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-recvmsg01-kill-child-only-if-one-was-forked.patch"

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index ba3b0fd..41d0726 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -281,7 +281,8 @@ void setup(void)
 
 void cleanup(void)
 {
-	(void)kill(pid, SIGKILL);	/* kill server */
+	if (pid > 0)
+		(void)kill(pid, SIGKILL);	/* kill server */
 	if (tmpsunpath[0] != '\0')
 		(void)unlink(tmpsunpath);
 	TEST_CLEANUP;
@@ -528,4 +529,4 @@ void sender(int fd)
 	(void)sendmsg(fd, &mh, 0);
 	(void)close(tfd);
 	(void)unlink(tmpfn);
-}
\ No newline at end of file
+}


--------------060307020103050005020602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
--------------060307020103050005020602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060307020103050005020602--

