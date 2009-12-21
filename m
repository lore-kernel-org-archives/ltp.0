Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NMb5T-0007qx-O6
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 05:45:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NMb5N-0007QQ-CH
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 05:45:43 +0000
Date: Mon, 21 Dec 2009 00:45:29 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1964681948.618501261374329418.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1713808934.618481261374276809.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24971_1010644075.1261374329417"
Subject: Re: [LTP] "unzip01" testcase failed.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

------=_Part_24971_1010644075.1261374329417
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
> 
> I'm not convinced that this is the right solution because most of
> what's done here just replaced $(DIR)'s value with the bareword
> value.
> .INTERMEDIATE may be the only piece of value here, but I was avoiding
> it because it's a 3.81-ism I thought...

How about this one (see the attachment)?

Thanks,
Caspar
> 
> Thanks,
> -Garrett

------=_Part_24971_1010644075.1261374329417
Content-Type: application/octet-stream; name=commands-unzip01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=commands-unzip01.patch

diff -Naur a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
--- a/include/mk/generic_leaf_target.inc	2009-12-01 17:57:15.000000000 +0800
+++ b/include/mk/generic_leaf_target.inc	2009-12-11 12:33:01.716202544 +0800
@@ -97,7 +97,7 @@
 all: $(MAKE_TARGETS)
 
 clean:: $(CLEAN_DEPS)
-	-$(RM) -f $(CLEAN_TARGETS)
+	-$(RM) -rf $(CLEAN_TARGETS)
 
 $(INSTALL_FILES): | $(INSTALL_DEPS)
 
diff -Naur a/runtest/commands b/runtest/commands
--- a/runtest/commands	2009-02-26 21:10:54.000000000 +0800
+++ b/runtest/commands	2009-12-11 12:55:07.386077960 +0800
@@ -10,7 +10,7 @@
 logrotate export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
 mail export TCdat=$LTPROOT/testcases/bin; mail_tests.sh
 cpio export TCdat=$LTPROOT/testcases/bin; cpio_tests.sh
-unzip01 unzip_tests.sh $LTPROOT/testcases/commands/unzip/tst_unzip_file.zip
+unzip01 unzip_tests.sh $LTPROOT/testcases/bin/tst_unzip_file.zip
 gzip01 gzip_tests.sh
 cp_tests01 cp_tests.sh
 ln_tests01 ln_tests.sh
diff -Naur a/testcases/commands/unzip/Makefile b/testcases/commands/unzip/Makefile
--- a/testcases/commands/unzip/Makefile	2009-10-10 01:55:45.000000000 +0800
+++ b/testcases/commands/unzip/Makefile	2009-12-11 12:37:12.397202792 +0800
@@ -27,13 +27,13 @@
 # Only build and install if we have the zip command.
 HAVE_ZIPTOOLS		:= $(shell if which zip >/dev/null; then echo yes; else echo no; fi)
 
+ZIP			:= zip
 DIR			:= tst_unzip.dir
-
-MAKE_TARGETS		:=
+ZIPFILE			:= tst_unzip_file.zip
+MAKE_TARGETS		:= $(ZIPFILE)
 
 ifeq ($(HAVE_ZIPTOOLS),yes)
-INSTALL_TARGETS		:= unzip_tests.sh
-$(INSTALL_TARGETS): $(ZIPFILE)
+INSTALL_TARGETS		:= unzip_tests.sh $(ZIPFILE)
 endif
 
 $(ZIPFILE): $(DIR)

------=_Part_24971_1010644075.1261374329417
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
------=_Part_24971_1010644075.1261374329417
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24971_1010644075.1261374329417--

