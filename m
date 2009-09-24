Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1Mqjbj-0002ef-N1
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 08:23:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mqjbe-0001SX-Qs
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 08:23:19 +0000
Message-ID: <4ABB2C98.4090403@redhat.com>
Date: Thu, 24 Sep 2009 16:23:52 +0800
From: Hushan Jia <hjia@redhat.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] network: fix nfs testcases Makefile error
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

The nfslock01 and nfsstress testcases' Makefile does not link excutables to testcase/bin
directory, and nfslock01 does not build nfs_flock_dgen excutables, which will cause test fail.
This patch add the links and build the nfs_flock_dgen.

Thanks & Regards,
Hushan

---

network: fix nfslock01 and nfsstress Makefile error

Signed-off-by: Hushan Jia <hjia@redhat.com>

--- ltp/testcases/network/nfs/nfslock01/Makefile.orig	2009-09-24 15:54:24.000000000 +0800
+++ ltp/testcases/network/nfs/nfslock01/Makefile	2009-09-24 15:58:31.000000000 +0800
@@ -5,6 +5,7 @@ all: $(TESTS)
 
 install:
 	ln -f nfslock01 ../../../bin
+	ln -f $(TESTS) ../../../bin
 
 nfs_flock:
 	$(CC) $(CFLAGS) $(LDFLAGS) -o nfs_flock nfs_flock.c nfs_flock_func.c
@@ -12,6 +13,9 @@ nfs_flock:
 nfs_flock_frk:
 	$(CC) $(CFLAGS) $(LDFLAGS) -o nfs_flock_frk nfs_flock_frk.c
 
+nfs_flock_dgen:
+	$(CC) $(CFLAGS) $(LDFLAGS) -o nfs_flock_dgen nfs_flock_dgen.c
+
 clean:
 	rm -f $(TESTS)
 
--- ltp/testcases/network/nfs/nfsstress/Makefile.orig	2009-09-24 15:54:12.000000000 +0800
+++ ltp/testcases/network/nfs/nfsstress/Makefile	2009-09-24 15:59:58.000000000 +0800
@@ -8,6 +8,7 @@ all: $(TARGETS)
 
 install:
 	ln -f nfsstress ../../../bin
+	ln -f $(TARGETS) ../../../bin
 
 clean:
 	rm -f $(TARGETS)

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
