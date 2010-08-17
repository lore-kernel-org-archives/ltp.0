Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlQvX-0001Ce-Fv
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 18:30:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlQvV-0005UT-7s
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 18:30:23 +0000
Received: from int-mx04.intmail.prod.int.phx2.redhat.com
	(int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7HIUFL9013131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Aug 2010 14:30:15 -0400
Received: from dmarlin.csb (dhcp-224-3.tha.redhat.com [10.15.224.3])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o7HIUDxF002428
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Aug 2010 14:30:14 -0400
Message-ID: <4C6AD534.2020109@redhat.com>
Date: Tue, 17 Aug 2010 13:30:12 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060305020001090102070503"
Subject: [LTP] problems building mallopt01.c for uClinux
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
--------------060305020001090102070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The testcase mallopt01 skips performing the test when UCLINUX=1, but the
mallinfo structure is defined outside the #if !defined(UCLINUX) block.

Attached is a patch to move the mallinfo structure definition inside the
#if !defined(UCLINUX) block.


Signed-off-by: d.marlin <dmarlin@redhat.com>




--------------060305020001090102070503
Content-Type: text/x-patch;
 name="mallopt01.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mallopt01.c.patch"

--- testcases/kernel/syscalls/mallopt/mallopt01.c.orig2	2010-08-13 10:28:12.318231000 -0500
+++ testcases/kernel/syscalls/mallopt/mallopt01.c	2010-08-13 10:44:06.279068760 -0500
@@ -56,10 +56,10 @@
 extern int Tst_COUNT;		/* Test Case counter for tst_routines */
 
 void printinfo();
-/*****	*	*	*****/
-struct mallinfo info;
 
 #if !defined(UCLINUX)
+/*****	*	*	*****/
+struct mallinfo info;
 
 /*--------------------------------------------------------------*/
 int main(int argc, char *argv[])

--------------060305020001090102070503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------060305020001090102070503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060305020001090102070503--

