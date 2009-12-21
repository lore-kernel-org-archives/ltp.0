Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NMZoB-0006Zs-Fo
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 04:23:47 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NMZo3-0006y2-5y
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 04:23:47 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Dec 2009 13:23:20 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 21 Dec 2009 13:23:20 +0900
Message-ID: <000001ca81f5$53bbaee0$fb330ca0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "unzip01" testcase failed.
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

I found that "unzip01" testcase failed as follows.
----------
unzip01     1  TFAIL  :  Test #1: unzip output differs from expected output.
Details
----------

The above error's "expected output" and "output" are :
  - "tst_unzip.out.exp" file ("expected output") : 
      In "${LTPROOT}/testcases/bin/unzip_tests.sh", the contents of the
      "tst_unzip.dir" directory are expected to output into this file.
  - "tst_unzip.out" file (actual "output") :
      A all contents of the "/opt/LTP/testcases/bin" directory are 
      logged to this file.

This problem occurs because "tst_unzip.dir" directory is not created.

Why does "DIR" become "/opt/ltp/testcases/bin" set 
though "DIR := tst_unzip.dir" is defined 
in "${LTPROOT}/testcases/commands/unzip/Makefile"?

To solve this problem, it is necessary to apply the following patche
to "${LTPROOT}/testcases/commands/unzip/Makefile" for creating 
"tst_unzip.dir" directory, I think.
============
--- Makefile	2009-12-18 17:48:40.000000000 +0900
+++ Makefile.new	2009-12-18 17:38:00.000000000 +0900
@@ -27,8 +27,6 @@
 # Only build and install if we have the zip command.
 HAVE_ZIPTOOLS		:= $(shell if which zip >/dev/null; then echo yes;
else echo no; fi)
 
-DIR			:= tst_unzip.dir
-
 RM			+= -r
 
 TESTCASES_DATA_DIR	:= $(DESTDIR)/$(prefix)/testcases/data
@@ -36,7 +34,7 @@
 ZIPFILE			:= $(TESTCASES_DATA_DIR)/tst_unzip_file.zip
 
 ifeq ($(HAVE_ZIPTOOLS),yes)
-CLEAN_TARGETS		:= $(DIR) $(ZIPFILE)
+CLEAN_TARGETS		:= tst_unzip.dir $(ZIPFILE)
 INSTALL_TARGETS		:= unzip_tests.sh
 endif
 
@@ -45,13 +43,14 @@
 $(TESTCASES_DATA_DIR):
 	mkdir -p "$@"
 
-$(ZIPFILE): | $(TESTCASES_DATA_DIR) $(DIR)
-	zip -r "$@" $(DIR)
+$(ZIPFILE): | $(TESTCASES_DATA_DIR) tst_unzip.dir
+	zip -r "$@" tst_unzip.dir
 	chmod 00666 "$@"
 
 # This target should be auto-removed by Make
-$(DIR): $(abs_srcdir)/unzip_genfile.sh
-	$(SHELL) "$^" $(DIR)
+.INTERMEDIATE: tst_unzip.dir
+tst_unzip.dir: $(abs_srcdir)/unzip_genfile.sh
+	$(SHELL) "$^" tst_unzip.dir
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
============


Regards--


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
