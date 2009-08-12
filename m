Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbL8S-0005bb-1t
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:13:28 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbL8K-0007sH-CV
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:13:27 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1MbL8E-0002iY-5I
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 22:13:14 +0100
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbL8D-0006E4-Uk
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 22:13:14 +0100
Message-ID: <4A833067.2000204@canonical.com>
Date: Wed, 12 Aug 2009 16:13:11 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060804080609040206070006"
Subject: [LTP] fix file_test.sh for systems without rpm installed
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060804080609040206070006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If you run file_test.sh on a system without rpm installed, it should
return tconf instead of tfail.

Signed-off-by: Paul Larson <paul.larson@canonical.com>
---


--------------060804080609040206070006
Content-Type: text/x-patch;
 name="file_test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="file_test.patch"

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
index 4fc9dec..0225b56 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -472,6 +472,8 @@ export TCID=file09
 export TST_COUNT=9
 
 $LTPBIN/tst_resm TINFO "TEST #9: file command recognizes RPM files"
+`which rpm`
+if [ $? = 0 ]; then
 if [ -f /etc/redhat-release ]; then
 	bDIR=/usr/src/redhat
 	bCMD=rpmbuild
@@ -574,6 +576,9 @@ else
     $LTPBIN/tst_resm TFAIL "file: Failed to recognize RPM file"
     TFAILCNT=$(( $TFAILCNT+1 ))
 fi
+else
+    $LTPBIN/tst_resm TCONF "rpm not installed"
+fi
 
 
 # TEST #10
@@ -582,11 +587,7 @@ fi
 export TCID=file10
 export TST_COUNT=10
 
-if [ -f /etc/redhat-release ]; then
-   KERNEL=vmlinuz
-else
-   KERNEL=vmlinux
-fi
+KERNEL=vmlinu
 
 $LTPBIN/tst_resm TINFO "TEST #10: file command recognizes $KERNEL file"
 

--------------060804080609040206070006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------060804080609040206070006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060804080609040206070006--

