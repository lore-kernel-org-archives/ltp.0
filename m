Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1Ol4mE-0001Qx-5D
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 18:51:18 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol4mD-00084f-7p
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 18:51:18 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7GIpBFo025395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 14:51:11 -0400
Received: from dmarlin.csb (dhcp-224-3.tha.redhat.com [10.15.224.3])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o7GIp8v4032541
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 14:51:09 -0400
Message-ID: <4C69889C.6040202@redhat.com>
Date: Mon, 16 Aug 2010 13:51:08 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080907090102070301000003"
Subject: [LTP] warning when building sighold02.c
Reply-To: dmarlin@redhat.com
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
To: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080907090102070301000003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The functions read_pipe and write_pipe in sighold02.c each expect a 
single file descriptor as arguments, however the function prototypes 
define no arguments.  Also, the function references to read_pipe pass 
two arguments, a file descriptor and '0'.  The second argument should 
not be passed, as it is not used.

Attached is a patch to make the function argument definitions and uses 
consistent within this testcase.


Signed-off-by: d.marlin <dmarlin@redhat.com>



--------------080907090102070301000003
Content-Type: text/x-patch;
 name="sighold02.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sighold02.c.patch"

--- testcases/kernel/syscalls/sighold/sighold02.c.orig	2010-04-01 01:23:11.000000000 -0500
+++ testcases/kernel/syscalls/sighold/sighold02.c	2010-07-07 19:41:26.323612559 -0500
@@ -145,8 +145,8 @@
 void cleanup();
 static void getout();
 static void timeout();
-static int read_pipe();
-static int write_pipe();
+static int read_pipe(int fd);
+static int write_pipe(int fd);
 static int setup_sigs(char *mesg);
 static void handle_sigs();
 static int set_timeout(char *mesg);
@@ -202,7 +202,7 @@
 			tst_sig(FORK, DEF_HANDLER, getout);
 
 			/* wait for "ready" message from child */
-			if (read_pipe(PARENTSREADFD, 0) != 0) {
+			if (read_pipe(PARENTSREADFD) != 0) {
 				/* read_pipe() failed. */
 				tst_brkm(TBROK, getout, "%s", p_p.mesg);
 			}
@@ -272,7 +272,7 @@
 			 * Get childs reply about received signals.
 			 */
 
-			if (read_pipe(PARENTSREADFD, 0) < 0) {
+			if (read_pipe(PARENTSREADFD) < 0) {
 				tst_brkm(TBROK, getout, "%s", p_p.mesg);
 			}
 
@@ -384,7 +384,7 @@
 	/*
 	 * Read pipe from parent, that will tell us that all signals were sent
 	 */
-	if (read_pipe(CHILDSREADFD, 0) != 0) {
+	if (read_pipe(CHILDSREADFD) != 0) {
 		p_p.result = TBROK;
 		strcpy(p_p.mesg, "read() pipe failed");
 	} else if (signals_received[0] == '\0') {


--------------080907090102070301000003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------080907090102070301000003
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080907090102070301000003--

