Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OHhF5-00067p-Ei
	for ltp-list@lists.sourceforge.net; Thu, 27 May 2010 17:51:39 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 1363186391
	for <ltp-list@lists.sourceforge.net>;
	Thu, 27 May 2010 19:51:32 +0200 (CEST)
Date: Thu, 27 May 2010 20:01:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100527180158.GA9894@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix io_xxxx Makefiles
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


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Makefiles for io_xxx syscall tests contains line:

LDFLAGS			+= $(AIO_LIBS)

Which leads to wrong order of flags passed to the
linker and compilation failure on certain linux
systems. Changing these lines to:

LDLIBS                  += $(AIO_LIBS)

Fixes this problem. Patch is attached.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--ibTvN161/egqYuK8
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_io_xxx_makefiles.patch"

Index: ltp-full-20100430/testcases/kernel/syscalls/io_cancel/Makefile
===================================================================
--- ltp-full-20100430.orig/testcases/kernel/syscalls/io_cancel/Makefile
+++ ltp-full-20100430/testcases/kernel/syscalls/io_cancel/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS			+= $(AIO_LIBS)
+LDLIBS			+= $(AIO_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: ltp-full-20100430/testcases/kernel/syscalls/io_destroy/Makefile
===================================================================
--- ltp-full-20100430.orig/testcases/kernel/syscalls/io_destroy/Makefile
+++ ltp-full-20100430/testcases/kernel/syscalls/io_destroy/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS			+= $(AIO_LIBS)
+LDLIBS			+= $(AIO_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: ltp-full-20100430/testcases/kernel/syscalls/io_getevents/Makefile
===================================================================
--- ltp-full-20100430.orig/testcases/kernel/syscalls/io_getevents/Makefile
+++ ltp-full-20100430/testcases/kernel/syscalls/io_getevents/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS			+= $(AIO_LIBS)
+LDLIBS			+= $(AIO_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: ltp-full-20100430/testcases/kernel/syscalls/io_setup/Makefile
===================================================================
--- ltp-full-20100430.orig/testcases/kernel/syscalls/io_setup/Makefile
+++ ltp-full-20100430/testcases/kernel/syscalls/io_setup/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS			+= $(AIO_LIBS)
+LDLIBS			+= $(AIO_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: ltp-full-20100430/testcases/kernel/syscalls/io_submit/Makefile
===================================================================
--- ltp-full-20100430.orig/testcases/kernel/syscalls/io_submit/Makefile
+++ ltp-full-20100430/testcases/kernel/syscalls/io_submit/Makefile
@@ -20,6 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-LDFLAGS			+= $(AIO_LIBS)
+LDLIBS			+= $(AIO_LIBS)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--ibTvN161/egqYuK8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--ibTvN161/egqYuK8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--ibTvN161/egqYuK8--

