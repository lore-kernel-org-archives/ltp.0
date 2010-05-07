Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <danms@us.ibm.com>) id 1OAOZg-0004Om-JL
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 14:30:44 +0000
Received: from gw0.danplanet.com ([71.245.107.82] helo=mail.danplanet.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OAOZe-0006bE-5v
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 14:30:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.danplanet.com (Postfix) with ESMTP id 5126A1C016
	for <ltp-list@lists.sourceforge.net>;
	Fri,  7 May 2010 07:31:23 -0700 (PDT)
Received: from mail.danplanet.com ([127.0.0.1])
	by localhost (imap.danplanet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4tlv+UNswY1 for <ltp-list@lists.sourceforge.net>;
	Fri,  7 May 2010 07:31:18 -0700 (PDT)
Received: from caffeine.danplanet.com (unknown [192.168.201.160])
	by mail.danplanet.com (Postfix) with ESMTP id 04E331C00E
	for <ltp-list@lists.sourceforge.net>;
	Fri,  7 May 2010 07:31:13 -0700 (PDT)
References: <1273081434-22034-1-git-send-email-danms@us.ibm.com>
	<1273225268.6042.8.camel@subratamodak.linux.ibm.com>
From: Dan Smith <danms@us.ibm.com>
Date: Fri, 07 May 2010 07:30:28 -0700
In-Reply-To: <1273225268.6042.8.camel@subratamodak.linux.ibm.com> (Subrata
	Modak's message of "Fri\, 07 May 2010 15\:11\:08 +0530")
Message-ID: <877hnfyebf.fsf@caffeine.danplanet.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] NetNS test fixes
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Serge Hallyn <serue@linux.vnet.ibm.com>

SM> Can you please ack this patch.

Ack the revised one below instead :)

By the way, these tests appear to start up sshd for no reason other
than possibly checking that basic sockets work in the netns.  Given
the frailty and required setup of the "ftp" test, I think it would be
better to replace it with a test using netcat and then yank the sshd
bits from the ping tests.

-- 
Dan Smith
IBM Linux Technology Center
email: danms@us.ibm.com

NetNS test fixes (v2)

This patch fixes a couple of netns test issues that cause invalid failures
relating to exiting with a status variable that doesn't exist.  It also
fixes an instance of inverted logic and a failure to exec sshd with the
full path (as required).

Additionally, it makes the common child exec function more descriptive of
what it tried to do and why it failed to ease debugging.

Changes in v2:
- Initialize status=0 at the top of child_1.sh to prevent overshadowing
  a (meaningless) sshd failure

Signed-off-by: Dan Smith <danms@us.ibm.com>

diff --git a/testcases/kernel/containers/netns/child_1.sh b/testcases/kernel/containers/netns/child_1.sh
index 1fa71a7..a63e834 100755
--- a/testcases/kernel/containers/netns/child_1.sh
+++ b/testcases/kernel/containers/netns/child_1.sh
@@ -30,6 +30,7 @@ export TST_COUNT
 export TST_TOTAL
 
 . initialize.sh
+status=0
 
     # Writing child PID number into /tmp/FIFO
     echo $$ > /tmp/FIFO2
diff --git a/testcases/kernel/containers/netns/childns.sh b/testcases/kernel/containers/netns/childns.sh
index 3634d81..16fc7e8 100755
--- a/testcases/kernel/containers/netns/childns.sh
+++ b/testcases/kernel/containers/netns/childns.sh
@@ -38,6 +38,8 @@ exists awk grep ip ping sshd
 . initialize.sh
 status=0
     
+SSHD=`which sshd`
+
 if [ $# -eq 1 ] ; then
     childscrpt=$1
     debug "INFO: The script to be executed in child NS is $childscrpt"
@@ -58,7 +60,7 @@ ifconfig lo up
 sleep 2
 
 #starting the sshd inside the child NS
-if ! sshd -p $PORT; then
+if $SSHD -p $PORT; then
     debug "INFO: started the sshd @ port no $PORT"
     sshpid=`ps -ef | grep "sshd -p $PORT" | grep -v grep | awk '{ print $2 ; exit 0} ' `
 else
diff --git a/testcases/kernel/containers/netns/common.c b/testcases/kernel/containers/netns/common.c
index 22d0e99..6d3b02e 100644
--- a/testcases/kernel/containers/netns/common.c
+++ b/testcases/kernel/containers/netns/common.c
@@ -48,8 +48,7 @@ int crtchild(char *s1 , char *s2)
 {
 	char *cmd[] = { "--", s1, s2, (char *)0 };
 	execve("/bin/sh", cmd, __environ);
-	printf("The code would not reach here on success\n");
-	perror("execve");
+	fprintf(stderr, "Failed to execve(%s, %s): %m\n", s1, s2);
 	return 1;
 }
 
diff --git a/testcases/kernel/containers/netns/par_ftp.sh b/testcases/kernel/containers/netns/par_ftp.sh
index 3bfb47b..bb65db4 100755
--- a/testcases/kernel/containers/netns/par_ftp.sh
+++ b/testcases/kernel/containers/netns/par_ftp.sh
@@ -37,6 +37,7 @@ export TST_TOTAL
     
     if [ $? = 0 ] ; then
         tst_resm TINFO "Pinging ChildNS from ParentNS"
+	status=0
     else
         tst_resm TFAIL "Error: Unable to ping ChildNS from ParentNS"
         status=-1
@@ -45,3 +46,5 @@ export TST_TOTAL
     if [ $stat != 0 ] ; then
         status=$stat
     fi
+
+    exit $status
diff --git a/testcases/kernel/containers/netns/parent_1.sh b/testcases/kernel/containers/netns/parent_1.sh
index 8577bf2..32f1a47 100755
--- a/testcases/kernel/containers/netns/parent_1.sh
+++ b/testcases/kernel/containers/netns/parent_1.sh
@@ -55,4 +55,4 @@ export TST_TOTAL
     echo $vnet1 > /tmp/FIFO1
 
     debug "INFO: PARENT_1: End of $0"
-    exit $status
+    exit 0
diff --git a/testcases/kernel/containers/netns/parent_2.sh b/testcases/kernel/containers/netns/parent_2.sh
index 57d3974..f72c16d 100755
--- a/testcases/kernel/containers/netns/parent_2.sh
+++ b/testcases/kernel/containers/netns/parent_2.sh
@@ -51,4 +51,4 @@ export TST_TOTAL
     echo $vnet3 > /tmp/FIFO3
 
     debug "INFO: PARENT-2: End of $0"
-    exit $status
+    exit 0

------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
