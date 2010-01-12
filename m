Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NUWB3-0001ZW-10
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 02:08:13 +0000
Received: from out04.sjc.mx.trendmicro.com ([216.99.131.8])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUWB1-0002PP-Kw
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 02:08:12 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.6])
	by out04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1E8D258C5CB
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 02:08:04 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 5D11195835
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 02:08:03 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Jan 2010 11:08:00 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 12 Jan 2010 11:08:00 +0900
Message-ID: <000301ca932c$10f42400$32dc6c00$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "make clean" has problem?
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

There is a problem about "make clean"(./Makefile), I think.
Before the following fix added at 12/11/2009, "/opt/ltp/" directory 
was deleted by "make clean":
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/Makefile?r1=1.53&r2=1.54
But after this fix, "make clean" could not remove "/opt/ltp/" directory.

If we test new release cvs and there are fixes about permissions 
in new cvs, we can't do the test correctly.
Because, if "/opt/ltp/" directory remained and new cvs's file
has same time-stamp and different permissions from old cvs's file,
the install ended with "make: Nothing to be done for `install'." 
message and this new file can't be installed.
Then test cases that fixed about permissions ended in "FAIL".
In recent cvs, To test correctly, we must remove "/opt/ltp/" directory
by manual operation before trying "make install".

I think that it is right specification to remove "/opt/ltp/" directory
when "make clean" is executed.


This problem occurred because "INSTALL_IN_BUILD_TREE := 1" is defined
in "./include/mk/env_pre.mk" included in "${LTPROOT}/Makefile", I think.
"$(prefix)" of a judgment of "ifeq ($(strip $(DESTDIR)$(prefix)),)"
doesn't have value, therefor the result of the judgment becomes "true",
and "INSTALL_IN_BUILD_TREE := 1" was defined.

So, it is neccessary to define "$(prefix)" by including "./include/mk/
config.mk" before including "./include/mk/env_pre.mk", isn't it?


The following patch can fix this problem:
============
--- Makefile.orig	2010-01-09 17:37:04.000000000 +0900
+++ Makefile	2010-01-12 09:49:29.000000000 +0900
@@ -27,6 +27,7 @@
 
 top_srcdir		?= $(CURDIR)
 
+include $(top_srcdir)/include/mk/config.mk
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/automake.mk
 
============


Thank you--


-Tomonori Mitani



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
