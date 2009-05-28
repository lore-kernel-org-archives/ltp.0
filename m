Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M9hpx-0006eJ-52
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2009 15:48:09 +0000
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 9809274609
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 May 2009 17:47:58 +0200 (CEST)
Date: Thu, 28 May 2009 17:47:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090528154758.GA29011@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Subject: [LTP]   [PATCH] Renaming binaries to avoid conflicts II
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I've missed these three in the first patch, here comes cosmetic changes.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--ZGiS0Q5IWpPtfppv
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="add_ltp_prefix_to_binaries_II.patch"

Index: ltp-full-20090430/INSTALL
===================================================================
--- ltp-full-20090430.orig/INSTALL
+++ ltp-full-20090430/INSTALL
@@ -74,7 +74,7 @@ contributions are welcome.
 
 4. You can run all of the tests sequentially by using the example test
    script runalltests.sh.  The script is there just to get you started.
-   See pan(1) for more information on the test driver we have provided.
+   See ltp-pan(1) for more information on the test driver we have provided.
    It is simple, but it can do a lot of stuff.
 
    NOTE: The diskio and network tests will NOT be run by the runalltests.sh
Index: ltp-full-20090430/README
===================================================================
--- ltp-full-20090430.orig/README
+++ ltp-full-20090430/README
@@ -65,11 +65,11 @@ testcases/*
 		 directory, which has hardlinks to all the test executables.
 
 runtest/*
-	It houses command lists that are used by pan for automated testing.
+	It houses command lists that are used by ltp-pan for automated testing.
 
 pan/*
-	The pan directory contains a simple, lightweight test harness.  pan
-	has the ability to run tests randomly and in parallel.  See pan's man
+	The pan directory contains a simple, lightweight test harness.  lpt-pan
+	has the ability to run tests randomly and in parallel.  See ltp-pan's man
 	page for more information.
 
 scratch/*
Index: ltp-full-20090430/README.ltp-devel
===================================================================
--- ltp-full-20090430.orig/README.ltp-devel
+++ ltp-full-20090430/README.ltp-devel
@@ -2,9 +2,9 @@ This is a README to describe the ltp-dev
 
 "make install" is to build and install:
 
-	/opt/ltp/bin/bump
-	/opt/ltp/bin/pan
-	/opt/ltp/bin/scanner
+	/opt/ltp/bin/ltp-bump
+	/opt/ltp/bin/ltp-pan
+	/opt/ltp/bin/ltp-scanner
 	/opt/ltp/lib/libltp.a
 	/usr/share/pkgconfig/ltp.pc
 	/opt/ltp/include/
@@ -24,7 +24,7 @@ To read manual pages, then the developer
 (Most Important man pages)
 
 	man usctest
-	man pan
+	man ltp-pan
 	man tst_res
 	man tst_sig
 	man tst_set_error
@@ -32,7 +32,7 @@ To read manual pages, then the developer
 	man parse_opts
 
 (Others)
-	man bump
+	man ltp-bump
 	man doio
 	man iogen
 	man forker

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--ZGiS0Q5IWpPtfppv--

