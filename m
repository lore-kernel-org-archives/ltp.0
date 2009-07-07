Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MO2vf-00011k-LS
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:09:19 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO2vf-0005NZ-43
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:09:19 +0000
Received: by pzk8 with SMTP id 8so4299374pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 22:09:18 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 Jul 2009 22:09:17 -0700
Message-ID: <364299f40907062209u75b0ed0emb660a34dd6c744aa@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Enable PATCH 2 / PATCH 3 support with libcontrollers
	for deterministic placement
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
To: LTP list <ltp-list@lists.sourceforge.net>

In order to put libcontrollers.a in an appropriate location, s.t. the
cpuset, etc tests can properly find it, we need to adjust the Makefile
to establish feature parity with the current backend supported in the
cpuset Makefiles.

This patch is needed to properly address the cross-compilation issues
just posted on the list.

This requires PATCH 2/4 and PATCH 3/4 in order to function.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/controllers/libcontrollers/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/libcontrollers/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- testcases/kernel/controllers/libcontrollers/Makefile	28 Feb 2008
14:50:59 -0000	1.1
+++ testcases/kernel/controllers/libcontrollers/Makefile	7 Jul 2009
05:04:11 -0000
@@ -1,15 +1,38 @@
-TARGET=libcontrollers.a
-SRCS=$(wildcard *.c)
-OBJS=$(patsubst %.c,%.o,$(SRCS))
+#
+#    testcases/kernel/controllers library Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+# Copyright (c) 2009 by Cisco Systems, Inc.
+# All rights reserved
+#
+
+srcdir			?= ../../../..
+
+include $(srcdir)/include/master_include.mk
+
+INSTALL_DIR		:= $(libdir)

-all : $(TARGET)
+LIB			:= lib$(LIBSUFFIX).a

-$(TARGET): $(OBJS)
-	$(AR) -cr $@ $^
-
-clean:
-	rm -f $(TARGET) $(OBJS)
-
-install:
+MAKE_TARGETS		:= $(LIB)

+$(LIB): $(OBJS)

+$(eval $(generic_leaf_target))

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
