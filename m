Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1N1Jlv-0005si-Ep
	for ltp-list@lists.sourceforge.net; Fri, 23 Oct 2009 13:01:35 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N1Jlr-0005YF-AJ
	for ltp-list@lists.sourceforge.net; Fri, 23 Oct 2009 13:01:35 +0000
Message-ID: <4AE19E86.8070100@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2009 17:46:06 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080301020602060307050709"
Subject: [LTP] [PATCH] realtime: fix broken build configuration files and
	warnings
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--------------080301020602060307050709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrata,
Please accept the patch below.

Thanks,
Gowri
--
[PATCH] realtime: fix broken build configuration files and warnings

Patch below fixes the recent changes applied over realtime tests
build structure. These changes left the realtime tests in broken
state with missing includes and libraries. Now tests can be built
just like other tests in LTP.

Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
Acked-by: Sripathi Kodi <sripathik@in.ibm.com>
--

--------------080301020602060307050709
Content-Type: text/x-patch;
 name="build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="build.patch"

Index: ltp.tmp/testcases/realtime/Makefile
===================================================================
--- ltp.tmp.orig/testcases/realtime/Makefile	2009-10-22 20:43:55.000000000 +0530
+++ ltp.tmp/testcases/realtime/Makefile	2009-10-22 23:11:31.000000000 +0530
@@ -24,4 +24,22 @@
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/config.mk
+
+LIBDIR			:= lib
+FILTER_OUT_DIRS 	:= $(LIBDIR)
+LIB			:= $(LIBDIR)/librealtime.a
+
+$(LIBDIR):
+	mkdir -p "$@"
+
+$(LIB): $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$(LIBDIR)/Makefile" all
+
+trunk-all: $(LIB)
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$(LIBDIR)/Makefile" clean
+
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
Index: ltp.tmp/testcases/realtime/lib/Makefile
===================================================================
--- ltp.tmp.orig/testcases/realtime/lib/Makefile	2009-10-22 20:45:49.000000000 +0530
+++ ltp.tmp/testcases/realtime/lib/Makefile	2009-10-22 20:51:10.000000000 +0530
@@ -23,7 +23,8 @@
 top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
+include ../config.mk
 
 LIB			:= librealtime.a
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/lib.mk
Index: ltp.tmp/testcases/realtime/config.mk
===================================================================
--- ltp.tmp.orig/testcases/realtime/config.mk	2009-10-22 21:40:42.000000000 +0530
+++ ltp.tmp/testcases/realtime/config.mk	2009-10-22 22:57:20.000000000 +0530
@@ -20,9 +20,25 @@
 # Garrett Cooper, September 2009
 #
 
+# Check kernel/glibc support for PI and Robust mutexes and cache
+# the result.
 
-# Default stuff common to all testcases
+realtimedir = $(abs_top_srcdir)/testcases/realtime
+
+ifeq ($(shell [ -e $(realtimedir)/.config ] && echo yes), yes)
+	HAVE_PI_MUTEX := $(shell grep HAVE_PI_MUTEX $(realtimedir)/.config | \
+				 awk '{print $$2}')
+	HAVE_ROBUST_MUTEX := $(shell grep HAVE_ROBUST_MUTEX $(realtimedir)/.config | \
+				     awk '{print $$2}')
+else
+	HAVE_PI_MUTEX := $(shell sh $(realtimedir)/scripts/check_pi.sh)
+	HAVE_ROBUST_MUTEX:= $(shell sh $(realtimedir)/scripts/check_robust.sh)
+	dummy := $(shell echo "HAVE_PI_MUTEX $(HAVE_PI_MUTEX)" > $(realtimedir)/.config; \
+		 echo "HAVE_ROBUST_MUTEX $(HAVE_ROBUST_MUTEX)" >> $(realtimedir)/.config)
+endif
 
-CPPFLAGS += -I$(abs_top_srcdir)/testcases/realtime/include -D_GNU_SOURCE
+# Default stuff common to all testcases
+CPPFLAGS += -I$(realtimedir)/include -D_GNU_SOURCE
 CFLAGS   += -Wall
-LDLIBS   += -lrealtime -lpthread -lrt -lm
+LDLIBS   += -L$(realtimedir)/lib -lrealtime -lpthread -lrt -lm
+
Index: ltp.tmp/testcases/realtime/func/pi-tests/Makefile
===================================================================
--- ltp.tmp.orig/testcases/realtime/func/pi-tests/Makefile	2009-10-22 21:19:51.000000000 +0530
+++ ltp.tmp/testcases/realtime/func/pi-tests/Makefile	2009-10-22 21:43:33.000000000 +0530
@@ -24,4 +24,19 @@
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
+
+TARGETS = testpi-0
+
+ifeq ($(HAVE_PI_MUTEX), yes)
+	TARGETS += testpi-1 testpi-2 testpi-4 testpi-5 testpi-7
+endif
+
+ifeq ($(HAVE_ROBUST_MUTEX), yes)
+	TARGETS += testpi-6 sbrk_mutex
+endif
+
+MAKE_TARGETS = $(TARGETS)
+CLEAN_TARGETS = $(TARGETS)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
Index: ltp.tmp/testcases/realtime/perf/Makefile
===================================================================
--- ltp.tmp.orig/testcases/realtime/perf/Makefile	2009-10-22 22:03:44.000000000 +0530
+++ ltp.tmp/testcases/realtime/perf/Makefile	2009-10-22 22:03:50.000000000 +0530
@@ -20,7 +20,7 @@
 # Garrett Cooper, September 2009
 #
 
-top_srcdir		?= ../../../..
+top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../config.mk
Index: ltp.tmp/testcases/realtime/stress/Makefile
===================================================================
--- ltp.tmp.orig/testcases/realtime/stress/Makefile	2009-10-22 22:04:15.000000000 +0530
+++ ltp.tmp/testcases/realtime/stress/Makefile	2009-10-22 22:04:28.000000000 +0530
@@ -20,7 +20,7 @@
 # Garrett Cooper, September 2009
 #
 
-top_srcdir		?= ../../../..
+top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../config.mk
Index: ltp.tmp/testcases/realtime/lib/libstats.c
===================================================================
--- ltp.tmp.orig/testcases/realtime/lib/libstats.c	2009-10-22 22:40:24.000000000 +0530
+++ ltp.tmp/testcases/realtime/lib/libstats.c	2009-10-23 11:31:49.000000000 +0530
@@ -75,7 +75,7 @@
 {
 	int myindex = ++data->index;
 	if (myindex >= data->size) {
-		debug(DBG_ERR, "Number of elements cannot be more than %d\n",
+		debug(DBG_ERR, "Number of elements cannot be more than %ld\n",
 				data->size);
 		data->index--;
 		return -1;

--------------080301020602060307050709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--------------080301020602060307050709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080301020602060307050709--

