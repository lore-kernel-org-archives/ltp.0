Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MZ4Kq-0002er-Rh
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 14:52:52 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZ4Kl-0002p2-Rs
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 14:52:52 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1MZ4Kf-0001em-UJ
	for <ltp-list@lists.sourceforge.net>; Thu, 06 Aug 2009 15:52:41 +0100
Received: from [89.127.177.75] (helo=[10.55.1.180])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MZ4Kf-0007Pq-R3
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 15:52:41 +0100
Message-ID: <4A7AEE38.60101@canonical.com>
Date: Thu, 06 Aug 2009 09:52:40 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080503010107090308070801"
Subject: [LTP] fix lib6 test building
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

This is a multi-part message in MIME format.
--------------080503010107090308070801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The lib6 tests seem to fail the first pass through building for me
because ranlib does not seem to get set correctly at any point.  This
seems to fix it up for me.

Thanks,
Paul Larson




--------------080503010107090308070801
Content-Type: text/x-patch;
 name="lib6-makefix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lib6-makefix.patch"

Fix build problem with lib6 tests


Signed-off-by: Paul Larson <paul.larson@canonical.com>
---

diff --git a/testcases/network/lib6/Makefile b/testcases/network/lib6/Makefile
index 7c1784d..f622468 100644
--- a/testcases/network/lib6/Makefile
+++ b/testcases/network/lib6/Makefile
@@ -23,6 +23,10 @@
 CFLAGS+=	-I../../../include -g -D_GNU_SOURCE
 LOADLIBES+=	-L../../../lib runcc.a -lltp -lpthread
 
+ifeq ($(RANLIB),)
+RANLIB = ranlib
+endif
+
 SRCS=$(wildcard *.c)
 TARGETS= asapi_01 asapi_02 asapi_03 asapi_04 asapi_05 asapi_06 asapi_07 \
 	getaddrinfo_01 in6_01 in6_02

--------------080503010107090308070801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------080503010107090308070801
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080503010107090308070801--

