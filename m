Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matt@apochromatic.org>) id 1MWQmv-000838-N3
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 08:14:57 +0000
Received: from cs20.apochromatic.org ([204.152.189.161])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWQmv-00068R-HB
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 08:14:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by cs20.apochromatic.org (Postfix) with ESMTP id BA196AD763
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 00:58:28 -0700 (PDT)
Date: Thu, 30 Jul 2009 08:58:02 +0100
From: Matt Fleming <matt@console-pimps.org>
Message-ID: <20090730075802.GE3058@console-pimps.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
Subject: [LTP] fcntl24,25,26 fail when run on tmpfs
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


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a patch to skip testcases fcntl24, fcntl25 and fcntl26 if
the host is running on tmpfs. The reason being that, as documented here
http://bugzilla.kernel.org/show_bug.cgi?id=13626, F_SETLEASE and F_WRLCK
cannot work on tmpfs.


--BXVAT5kNtrzKuDFl
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="ltp-F_SETLEASE-doesnt-work-on-tmpfs.patch"

Index: testcases/kernel/syscalls/fcntl/fcntl24.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl24.c,v
retrieving revision 1.11
diff -u -r1.11 fcntl24.c
--- testcases/kernel/syscalls/fcntl/fcntl24.c	23 Mar 2009 13:35:41 -0000	1.11
+++ testcases/kernel/syscalls/fcntl/fcntl24.c	29 Jul 2009 14:49:08 -0000
@@ -131,6 +131,14 @@
 			 "Cannot do fcntl on a file located on an NFS filesystem");
 	}
 
+	/*
+	 * check if the current filesystem is tmpfs
+	 */
+	if (tst_is_cwd_tmpfs()) {
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do fcntl on a file located on an TMPFS filesystem");
+	}
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
Index: testcases/kernel/syscalls/fcntl/fcntl25.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl25.c,v
retrieving revision 1.9
diff -u -r1.9 fcntl25.c
--- testcases/kernel/syscalls/fcntl/fcntl25.c	23 Mar 2009 13:35:41 -0000	1.9
+++ testcases/kernel/syscalls/fcntl/fcntl25.c	29 Jul 2009 14:49:08 -0000
@@ -132,6 +132,14 @@
 			 "Cannot do fcntl on a file located on an NFS filesystem");
 	}
 
+	/*
+	 * check if the current filesystem is tmpfs
+	 */
+	if (tst_is_cwd_tmpfs()) {
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do fcntl on a file located on an TMPFS filesystem");
+	}
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
Index: testcases/kernel/syscalls/fcntl/fcntl26.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl26.c,v
retrieving revision 1.9
diff -u -r1.9 fcntl26.c
--- testcases/kernel/syscalls/fcntl/fcntl26.c	23 Mar 2009 13:35:41 -0000	1.9
+++ testcases/kernel/syscalls/fcntl/fcntl26.c	29 Jul 2009 14:49:08 -0000
@@ -132,6 +132,14 @@
 			 "Cannot do fcntl on a file located on an NFS filesystem");
 	}
 
+	/*
+	 * check if the current filesystem is tmpfs
+	 */
+	if (tst_is_cwd_tmpfs()) {
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do fcntl on a file located on an TMPFS filesystem");
+	}
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--BXVAT5kNtrzKuDFl--

