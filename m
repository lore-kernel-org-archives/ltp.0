Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1MlvQn-0003M6-2j
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 02:00:09 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MlvQa-0006sd-9D
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 02:00:04 +0000
Message-ID: <4AA9AF1A.5090505@redhat.com>
Date: Fri, 11 Sep 2009 09:59:54 +0800
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
Repost the multicast Makefile patch:
The Makefile of testcases/network/multicast/mc_commo and mc_member do not link binary file and config files to ../../../bin dirs.
This patch add the links.

Thanks&  Regards,
Hushan

---

network: Fix multicast testcases Makefile

Signed-off-by: Hushan Jia<hjia@redhat.com>



--- ltp/testcases/network/multicast/mc_commo/Makefile.orig	2009-09-09 19:00:32.000000000 +0800
+++ ltp/testcases/network/multicast/mc_commo/Makefile	2009-09-09 19:02:26.000000000 +0800
@@ -8,6 +8,8 @@ all: $(TARGETS)
 
 install:
 	ln -f mc_commo ../../../bin
+	ln -f mc_recv ../../../bin
+	ln -f mc_send ../../../bin
 
 clean:
 	rm -f $(TARGETS)
--- ltp/testcases/network/multicast/mc_member/Makefile.orig	2009-09-09 19:00:52.000000000 +0800
+++ ltp/testcases/network/multicast/mc_member/Makefile	2009-09-09 19:02:00.000000000 +0800
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
