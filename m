Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <iwamatsu.nobuhiro@renesas.com>) id 1MC7IM-0005fw-1q
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 07:23:26 +0000
Received: from mail.renesas.com ([202.234.163.13] helo=mail01.idc.renesas.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MC7IK-0005i6-8D
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2009 07:23:26 +0000
Date: Thu, 04 Jun 2009 16:23:17 +0900
From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Message-id: <4A277665.1080402@renesas.com>
MIME-version: 1.0
Subject: [LTP] [RFC][PATCH] Add cpu architecrute check
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

Some system call test program depends cpu architecture.
We cannot compile these, and there is a case to fail in a test even if
We compile it.
This check cpu architecture and build check in Makefile.
This didn't check all syscall and test cases.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 Makefile                                           |   10 +++++++++-
 testcases/kernel/syscalls/fallocate/Makefile       |    6 ++++++
 testcases/kernel/syscalls/set_thread_area/Makefile |    6 ++++++
 testcases/kernel/syscalls/sgetmask/Makefile        |    6 ++++++
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4cf124b..5243290 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,13 @@
 # See toplevel INSTALL for build info

+ifndef ARCH
+# copy from Makefile in linux kernel
+ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
+	-e s/arm.*/arm/ -e s/sa110/arm/ \
+	-e s/s390x/s390/ -e s/parisc64/parisc/ \
+	-e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+	-e s/sh[234].*/sh/ )
+endif
 ifdef CROSS_COMPILE
 CROSS_COMPILER = $(CROSS_COMPILE)
 endif
@@ -12,7 +20,7 @@ endif
 HAS_NUMA=$(shell sh tools/scripts/numa_test.sh)

 export CFLAGS += -Wall $(CROSS_CFLAGS)
-export CC AR RANLIB CPPFLAGS LDFLAGS HAS_NUMA
+export CC AR RANLIB CPPFLAGS LDFLAGS HAS_NUMA ARCH

 -include config.mk

diff --git a/testcases/kernel/syscalls/fallocate/Makefile b/testcases/kernel/syscalls/fallocate/Makefile
index d6016be..e16c722 100644
--- a/testcases/kernel/syscalls/fallocate/Makefile
+++ b/testcases/kernel/syscalls/fallocate/Makefile
@@ -20,8 +20,14 @@
 CFLAGS += -I../../../../include -Wall
 LDLIBS += -L../../../../lib -lltp

+# This system call is suported in i386, x86_64 and ppc only.
+ifneq (,$(findstring $(ARCH), i386 x86_64 ppc))
 SRCS    = $(wildcard *.c)
 TARGETS = $(patsubst %.c,%,$(SRCS))
+else
+SRCS    =
+TARGETS =
+endif

 all: $(TARGETS)

diff --git a/testcases/kernel/syscalls/set_thread_area/Makefile b/testcases/kernel/syscalls/set_thread_area/Makefile
index b5289a9..6342839 100644
--- a/testcases/kernel/syscalls/set_thread_area/Makefile
+++ b/testcases/kernel/syscalls/set_thread_area/Makefile
@@ -19,8 +19,14 @@
 CFLAGS += -I../../../../include -Wall
 LDLIBS += -L../../../../lib -lltp

+# This system call is supported in i386 and x86_64 only.
+ifneq (,$(findstring $(ARCH), i386 x86_64))
 SRCS    = $(wildcard *.c)
 TARGETS = $(patsubst %.c,%,$(SRCS))
+else
+SRCS    =
+TARGETS =
+endif

 all: $(TARGETS)

diff --git a/testcases/kernel/syscalls/sgetmask/Makefile b/testcases/kernel/syscalls/sgetmask/Makefile
index b5289a9..f684be8 100644
--- a/testcases/kernel/syscalls/sgetmask/Makefile
+++ b/testcases/kernel/syscalls/sgetmask/Makefile
@@ -19,8 +19,14 @@
 CFLAGS += -I../../../../include -Wall
 LDLIBS += -L../../../../lib -lltp

+# This system call does not support x86_64.
+ifeq (,$(findstring $(ARCH),x86_64))
 SRCS    = $(wildcard *.c)
 TARGETS = $(patsubst %.c,%,$(SRCS))
+else
+SRCS    =
+TARGETS =
+endif

 all: $(TARGETS)

-- 
1.6.3.1


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
