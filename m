Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sukadev@linux.vnet.ibm.com>) id 1Ognfa-0006iM-B8
	for ltp-list@lists.sourceforge.net; Wed, 04 Aug 2010 23:46:46 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OgnfZ-0004O4-6a
	for ltp-list@lists.sourceforge.net; Wed, 04 Aug 2010 23:46:46 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o74Nihpu019213
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Aug 2010 17:44:43 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o74NkXJ1045040
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Aug 2010 17:46:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o74NkXjv018520
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Aug 2010 17:46:33 -0600
Date: Wed, 4 Aug 2010 16:52:06 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Message-ID: <20100804235206.GA1388@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] pidns31: fix EACCESS error in mq_open()
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
Cc: ltp-list@lists.sourceforge.net


pidns31: mq_open() fails with EACCESS.

pidns31 test case fails with EACCESS - due to the leading '/' in
mqname. See comments in the patch below for details.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Index: testcases/kernel/containers/pidns/pidns31.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/containers/pidns/pidns31.c,v
retrieving revision 1.6
diff -u -p -r1.6 pidns31.c
--- testcases/kernel/containers/pidns/pidns31.c	14 Nov 2009 23:58:26 -0000	1.6
+++ testcases/kernel/containers/pidns/pidns31.c	4 Aug 2010 23:24:54 -0000
@@ -61,7 +61,14 @@
 char *TCID = "pidns31";
 int TST_TOTAL = 1;
 
-char *mqname = "/mq1";
+
+/*
+ * NOTE: The mq_open() interface in glibc requires mqname to start with a '/' 
+ * 	 and the glibc call skips the leading '/' when invoking the system
+ * 	 call. Since we bypass the glibc mq_open() (and use syscall()) we
+ * 	 define mqname without the leading '/'.
+ */
+char *mqname = "mq1";
 int result = TFAIL;
 
 int errno;
@@ -264,6 +271,7 @@ int main(int argc, char *argv[])
 	}
 
 	syscall(__NR_mq_unlink, mqname);
+
 	mqd = syscall(__NR_mq_open, mqname, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
 	if (mqd == (mqd_t)-1) {
 		tst_resm(TBROK, "parent: mq_open() failed (%s)",

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
