Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1N6Y7c-0008GQ-0V
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:21:36 +0000
Received: from xenotime.net ([72.52.64.118])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N6Y7V-0007an-UT
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:21:35 +0000
Message-ID: <4AF4B955.2080308@xenotime.net>
Date: Fri, 06 Nov 2009 16:03:33 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>	<87iqdn76jg.fsf@basil.nowhere.org>
	<364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
In-Reply-To: <364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
Subject: [LTP] [patch 2/2] INSTALL corrections & TODO
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Andi Kleen <andi@firstfloor.org>


"Configuration" section to match Makefile message.
How to use DESTDIR and --prefix together.

TODO:
"Quick Start" does not work.
"Not using autoconf:" does not work.

---
 INSTALL |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- ltp-full-20091031-auto.orig/INSTALL
+++ ltp-full-20091031-auto/INSTALL
@@ -29,7 +29,7 @@ downloaded from:
 - http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
 - http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz
 
-Configuring
+Configuration
 -------------------
 Using autoconf:
         $ make autotools # This must be run from "$TOP_SRCDIR!"
@@ -74,6 +74,13 @@ in the same directory where the source f
   sysroot, as opposed to the host system's sysroot.
 - Specify SKIP_IDCHECK=1 if and when you don't want to modify /etc/{group,passwd}
   on the target system's sysroot.
+- If you want to build and install ltp inside its source tree (e.g., in
+  $TOP_SRCDIR/ltpbin/), to support multiple versions of LTP on one system,
+  then use
+
+	$ cd $TOP_SRCDIR
+	$ mkdir ltpbin
+	$ ./configure DESTDIR=$PWD --prefix=$PWD/ltpbin
 
 If you get a build error, please report it to ltp-list@lists.sf.net with
 following information,

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
