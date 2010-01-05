Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NS4It-0007gI-2F
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 07:58:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NS4Ir-0004xl-Hb
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 07:58:10 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 471E717010C
	for <ltp-list@lists.sourceforge.net>;
	Tue,  5 Jan 2010 15:57:57 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o057veFB016184
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 15:57:40 +0800
Received: from [10.167.141.106] (unknown [10.167.141.106])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 217F2D46B5
	for <ltp-list@lists.sourceforge.net>;
	Tue,  5 Jan 2010 15:58:43 +0800 (CST)
Message-ID: <4B42F101.2070009@cn.fujitsu.com>
Date: Tue, 05 Jan 2010 15:57:53 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuset: fix a lost compile target in Makefile
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
To: ltp-list <ltp-list@lists.sourceforge.net>

In latest ltp version, the following message occured when run the case of cpuset.
-----
./cpuset_hotplug_test.sh: line 39: ./cpuset_list_compute: No such file or directory
./cpuset_hotplug_test.sh: line 227: ./cpuset_list_compute: No such file or directory
-----

The reason is that cpuset_list_compute.c(in testcases/kernel/controllers/cpuset/
cpuset_hotplug_test/) has not been compiled.
This patch fix it.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
--- ltp-intermediate-20091209.orig/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile	2009-12-09 02:48:49.000000000 -0500
+++ ltp-intermediate-20091209/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile	2010-01-05 10:53:55.000000000 -0500
@@ -25,6 +25,6 @@ top_srcdir              ?= ../../../../.
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 
-MAKE_TARGETS		:=
+LDLIBS		+= -lpthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk


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
