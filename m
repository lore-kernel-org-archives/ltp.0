Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlOYW-0001Jo-4k
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 15:58:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlOYV-0004Sr-7R
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 15:58:28 +0000
Received: from int-mx08.intmail.prod.int.phx2.redhat.com
	(int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7HFwL2U015140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Aug 2010 11:58:21 -0400
Received: from dmarlin.csb (dhcp-224-3.tha.redhat.com [10.15.224.3])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o7HFwJZu017247
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Aug 2010 11:58:20 -0400
Message-ID: <4C6AB19B.6060706@redhat.com>
Date: Tue, 17 Aug 2010 10:58:19 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
Subject: [LTP] running LTP on uClinux
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>


I was building LTP to test a uClinux system, but encountered some
problems.  As far as I could tell UCLINUX=1 is not being passed to all
testcases when defined at the top level before running make.

   export UCLINUX=1
   make


I modified the following file and the build proceeded as expected:

--- include/mk/testcases.mk.orig     2010-04-01 01:23:08.000000000 -0500
+++ include/mk/testcases.mk     2010-07-01 17:38:10.240628708 -0500
@@ -53,3 +53,8 @@

  $(APICMDS_DIR) $(LIBLTP_DIR) $(abs_top_builddir)/$(TKI_DIR): %:
         mkdir -p "$@"
+
+ifeq ($(UCLINUX),1)
+CFLAGS                  += -D__UCLIBC__ -DUCLINUX
+endif


Has anyone else had to make similar changes in order to build LTP for
uClinux?


d.marlin



------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
