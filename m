Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1Mkyfb-0006N1-3x
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 11:15:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MkyfV-0005f6-Oi
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2009 11:15:31 +0000
Received: from int-mx03.intmail.prod.int.phx2.redhat.com
	(int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n88BFIA8019096
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Sep 2009 07:15:18 -0400
Message-ID: <4AA63CD6.2000300@redhat.com>
Date: Tue, 08 Sep 2009 19:15:34 +0800
From: Hushan Jia <hjia@redhat.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] network: fix multicast testcases Makefile
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
The Makefile of testcases/network/multicast/mc_commo and mc_member do not link binary file and config files to ../../../bin dirs.
This patch add the links.

Thanks&  Regards,
Hushan

---

network: Fix multicast testcases Makefile

Signed-off-by: Hushan Jia<hjia@redhat.com>

diff -Nrup ltp-full-20090831.orig/testcases/network/multicast/mc_commo/Makefile ltp-full-20090831/testcases/network/multicast/mc_commo/Makefile
--- ltp-full-20090831.orig/testcases/network/multicast/mc_commo/Makefile	2009-08-31 13:16:03.000000000 +0800
+++ ltp-full-20090831/testcases/network/multicast/mc_commo/Makefile	2009-09-08 18:45:37.000000000 +0800
@@ -8,6 +8,8 @@ all: $(TARGETS)

  install:
  	ln -f mc_commo ../../../bin
+	ln -f mc_recv ../../../bin
+	ln -f mc_send ../../../bin

  clean:
  	rm -f $(TARGETS)
diff -Nrup ltp-full-20090831.orig/testcases/network/multicast/mc_member/Makefile ltp-full-20090831/testcases/network/multicast/mc_member/Makefile
--- ltp-full-20090831.orig/testcases/network/multicast/mc_member/Makefile	2009-08-31 13:16:03.000000000 +0800
+++ ltp-full-20090831/testcases/network/multicast/mc_member/Makefile	2009-09-08 19:04:40.000000000 +0800
@@ -8,6 +8,9 @@ all: $(TARGETS)

  install:
  	ln -f mc_member ../../../bin
+	ln -f member ../../../bin
+	ln -f ManyGroups ../../../bin
+	ln -f TooManyGroups ../../../bin

  clean:
  	rm -f $(TARGETS)



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
