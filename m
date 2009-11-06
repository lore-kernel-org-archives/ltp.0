Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1N6Ext-0004pb-8P
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 02:54:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6Exm-000352-4B
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 02:54:17 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id EB2A517011A
	for <ltp-list@lists.sourceforge.net>;
	Fri,  6 Nov 2009 09:36:43 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id nA61ZpSv001083
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 09:35:51 +0800
Received: from [10.167.141.106] (unknown [10.167.141.106])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 61C42D43BB
	for <ltp-list@lists.sourceforge.net>;
	Fri,  6 Nov 2009 09:36:14 +0800 (CST)
Message-ID: <4AF37D4F.1020909@cn.fujitsu.com>
Date: Fri, 06 Nov 2009 09:35:11 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix build failure in cgroup_fj testcase
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

The following build failure occured on my x86 box.
-------------------------------------------------------
# uname -a
Linux F8-i386 2.6.32-rc5-tipshiwh+ #3 SMP Wed Oct 21 15:14:54 EDT 2009 i686 i686 i386 GNU/Linux
# cat /etc/issue
Fedora release 8 (Werewolf)
Kernel \r on an \m

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/shiwh/ltp-full-20091031/testcases/kernel/include -I/home/shiwh/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj/../libcontrollers -Wall -O2 -Wextra -I../../../../include -I../../../../include   -L/home/shiwh/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj/../libcontrollers -L../../../../lib  cgroup_fj_proc.c   -lltp -lcontrollers -o cgroup_fj_proc
/usr/bin/ld: cannot find -lcontrollers
collect2: ld returned 1 exit status
make[4]: *** [cgroup_fj_proc] Error 1
make[4]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases/kernel/controllers/cgroup_fj'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases/kernel/controllers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/shiwh/ltp-full-20091031/testcases'
make: *** [testcases-all] Error 2
-------------------------------------------------------

But the case "cgroup_fj" does not need "-lcontrollers" when building.
So in my patch, i deleted "-lcontrollers" in testcases/kernel/controllers/Makefile.inc 
and added it to testcases/kernel/controllers/memctl/Makefile because the case "memctl" 
need it. 
All other cases in testcases/kernel/controllers/ build well too when my patch merged.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
diff -urpN ltp-full-20091031.orig/testcases/kernel/controllers/Makefile.inc ltp-full-20091031/testcases/kernel/controllers/Makefile.inc
--- ltp-full-20091031.orig/testcases/kernel/controllers/Makefile.inc	2009-11-02 04:07:13.000000000 -0500
+++ ltp-full-20091031/testcases/kernel/controllers/Makefile.inc	2009-11-05 08:54:06.000000000 -0500
@@ -39,8 +39,6 @@ CPPFLAGS		+= -I$(abs_srcdir)/../$(LIBDIR
 
 LDFLAGS			+= -L$(abs_builddir)/../$(LIBDIR)
 
-LDLIBS			+= -lcontrollers
-
 INSTALL_TARGETS		?= *.sh
 
 # vim: syntax=make
diff -urpN ltp-full-20091031.orig/testcases/kernel/controllers/memctl/Makefile ltp-full-20091031/testcases/kernel/controllers/memctl/Makefile
--- ltp-full-20091031.orig/testcases/kernel/controllers/memctl/Makefile	2009-11-02 04:07:14.000000000 -0500
+++ ltp-full-20091031/testcases/kernel/controllers/memctl/Makefile	2009-11-06 04:13:49.000000000 -0500
@@ -27,4 +27,6 @@ include $(abs_srcdir)/../Makefile.inc
 
 INSTALL_TARGETS		:= *.sh
 
+LDLIBS			+= -lcontrollers
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
