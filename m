Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NMvvE-0000RB-AM
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 04:00:32 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-4.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NMvv6-0004hd-Ig
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 04:00:32 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Dec 2009 13:00:16 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 22 Dec 2009 13:00:15 +0900
Message-ID: <000001ca82bb$44f78d90$cee6a8b0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "nm" testcase failed
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

Hi,

I found that "nm" testcase failed as follows:
------------
gcc: /opt/ltp/testcases/bin/nmfile1.c: No such file or directory
gcc: no input files
gcc: /opt/ltp/testcases/bin/nmfile2.c: No such file or directory
gcc: no input files
gcc: /opt/ltp/testcases/bin/nmfile3.c: No such file or directory
gcc: no input files
------------

This problem occurs because "nmfile1.c", "nmfile2.c" and "nmfile3.c" 
are not installed to execute directory (/opt/ltp/testcases/bin).

To solve this problem, I suggest to apply this patch to Makefile
("${LTPROOT}/testcases/commands/ade/nm/Makefile).

============
--- Makefile	2009-10-10 02:55:44.000000000 +0900
+++ Makefile.new	2009-12-22 10:22:31.000000000 +0900
@@ -24,7 +24,7 @@
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= nm01 nmfile.c
+INSTALL_TARGETS		:= nm01 nmfile.c nmfile1.c nmfile2.c
nmfile3.c
 
 MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard
$(abs_srcdir)/*.c))
 
============


Thank you--


-Tomonori MItani



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
