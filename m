Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1TLPKx-0008Sj-If
	for ltp-list@lists.sourceforge.net; Tue, 09 Oct 2012 02:14:23 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TLPKw-0004ee-RV
	for ltp-list@lists.sourceforge.net; Tue, 09 Oct 2012 02:14:23 +0000
Received: by mail-pb0-f47.google.com with SMTP id ro12so4681972pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Oct 2012 19:14:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Sun,  9 Oct 2011 10:14:09 +0800
Message-Id: <1318126449-3660-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] net: Install the missing file in network stress test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

Some network stress test (dns, ftp, http) will lost local scripts while
install. Remove the "-" in makefile fixed this issue.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/network/stress/dns/Makefile  |    2 +-
 testcases/network/stress/ftp/Makefile  |    2 +-
 testcases/network/stress/http/Makefile |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/stress/dns/Makefile b/testcases/network/stress/dns/Makefile
index a627839..d15ce29 100644
--- a/testcases/network/stress/dns/Makefile
+++ b/testcases/network/stress/dns/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= dns-*
+INSTALL_TARGETS		:= dns*
 
 MAKE_TARGETS		:=
 
diff --git a/testcases/network/stress/ftp/Makefile b/testcases/network/stress/ftp/Makefile
index a1a5224..1a1e9f4 100644
--- a/testcases/network/stress/ftp/Makefile
+++ b/testcases/network/stress/ftp/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= ftp-*
+INSTALL_TARGETS		:= ftp*
 
 MAKE_TARGETS		:=
 
diff --git a/testcases/network/stress/http/Makefile b/testcases/network/stress/http/Makefile
index 35d9e5f..0523238 100644
--- a/testcases/network/stress/http/Makefile
+++ b/testcases/network/stress/http/Makefile
@@ -24,7 +24,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= http-*
+INSTALL_TARGETS		:= http*
 
 MAKE_TARGETS		:=
 
-- 
1.7.7.6


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
