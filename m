Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MO2ox-0003aW-42
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:02:23 +0000
Received: from mail-px0-f183.google.com ([209.85.216.183])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO2ow-0003mG-5e
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 05:02:22 +0000
Received: by pxi13 with SMTP id 13so2811086pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 22:02:21 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 Jul 2009 22:02:21 -0700
Message-ID: <364299f40907062202q2b7e792du973c602a768bd907@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Fix hardcoded compiler references in cpuset test
	suite and ebizzy
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

There are a number of controller Makefiles and also ebizzy's Makefile
uses hardcoded references to cc / gcc, with Make rules written
longhand, instead of using $(CC) and pattern rules.

This patch addresses those items.

This requires PATCH 2/4 and 3/4.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile	23
Jun 2009 14:18:16 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_base_ops_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,12 +1,30 @@
-SRCS = $(wildcard *.sh)
+#
+#    kernel/controllers/cpuset/cpuset_base_ops_test testcase Makefile.
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

-all:
-	@true
+include ../Makefile.inc

-clean:
-	@true
-
-install:
-	@set -e; \
-	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
+MAKE_TARGETS		:=

+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile	23
Jun 2009 14:18:16 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_exclusive_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,12 +1,30 @@
-SRCS = $(wildcard *.sh)
+#
+#    kernel/controllers/cpuset/cpuset_exclusive_test testcase Makefile.
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

-all:
-	@true
+include ../Makefile.inc

-clean:
-	@true
-
-install:
-	@set -e; \
-	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
+MAKE_TARGETS		:=

+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile	23
Jun 2009 14:18:16 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_hierarchy_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,12 +1,30 @@
-SRCS = $(wildcard *.sh)
+#
+#    kernel/controllers/cpuset/cpuset_hierarchy_test testcase Makefile.
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

-all:
-	@true
+include ../Makefile.inc

-clean:
-	@true
-
-install:
-	@set -e; \
-	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
+MAKE_TARGETS		:=

+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile	23
Jun 2009 14:18:16 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_hotplug_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,22 +1,36 @@
-CFLAGS += -Wall -g -Wextra
-LDLIBS := -lm
+#
+#    kernel/controllers/cpuset/cpuset_hotplug_test testcase Makefile.
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
+include ../Makefile.inc
+
+CFLAGS			+= -Wall -g -Wextra
+
+# XXX (garrcoop): testing..
+#LDLIBS			+= -lcpuset_lib
+LDLIBS			+= -lm -lcpuset_lib

-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+MAKE_TARGETS		:=

-SRCS=$(wildcard *.c)
-OBJECTS=$(patsubst %.c,%.o,$(SRCS))
-TARGETS=$(patsubst %.c,%,$(SRCS))
-
-all: $(TARGETS)
-
-$(TARGETS): %: %.o $(LIBOBJECTS)
-
-clean:
-	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
-
-install:
-	@set -e; \
-	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
-	ln -f cpuset_hotplug_test.sh ../../../../bin/cpuset_hotplug_test.sh;
-	chmod +x cpuset_hotplug_test.sh;
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile	23
Jun 2009 14:18:17 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_inherit_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,12 +1,36 @@
-SRCS = $(wildcard *.sh)
+#
+#    kernel/controllers/cpuset/cpuset_inherit_test testcase Makefile.
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

-all:
-	@true
+include ../Makefile.inc

-clean:
-	@true
+CFLAGS			+= -Wall -g -Wextra

-install:
-	@set -e; \
-	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
+# XXX (garrcoop): testing...
+#LDLIBS			+= -lm -lcpuset_lib
+LDLIBS			+= -lcpuset_lib

+MAKE_TARGETS		:=
+
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_lib/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_lib/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_lib/Makefile	23 Jun
2009 14:18:17 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_lib/Makefile	7 Jul 2009
04:53:42 -0000
@@ -1,16 +1,34 @@
-CFLAGS += -Wall -g -Wextra
-CPPFLAGS += -I../../../../include
-LDLIBS += -lm -L../../../../lib/ -lcontrollers -lltp
+#
+#    kernel/controllers/cpuset/cpuset_lib library Makefile.
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

-SRCS=$(wildcard *.c)
-TARGETS=$(patsubst %.c,%.o,$(SRCS))
+include ../Makefile.inc

-all: $(TARGETS)
+CFLAGS			+= -I$(objdir)/include -Wall -g -Wextra

-clean:
-	rm -f $(TARGETS)
+LDLIBS			+= -lm -lcontrollers -lltp

-install:
-	@set -e; \
-	ln -f cpuset_funcs.sh ../../../../bin/cpuset_funcs.sh;
-	chmod +x cpuset_funcs.sh;
+LDFLAGS			+= -L$(objdir)/lib
+
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile	23
Jun 2009 14:18:17 -0000	1.2
+++ testcases/kernel/controllers/cpuset/cpuset_load_balance_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,24 +1,32 @@
-CFLAGS += -Wall -g -Wextra
-LDLIBS := -lm
+#
+#    kernel/controllers/cpuset/cpuset_load_balance_test testcase Makefile.
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

-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+include ../Makefile.inc

-SRCS=$(wildcard *.c)
-OBJECTS=$(patsubst %.c,%.o,$(SRCS))
-TARGETS=$(patsubst %.c,%,$(SRCS))
+CFLAGS			+= -Wall -g -Wextra

-all: $(TARGETS)
+#LDLIBS			+= -lm

-$(TARGETS): %: %.o $(LIBOBJECTS)
-
-clean:
-	rm -f $(TARGETS) $(OBJECTS) $(LIBOBJECTS)
-
-install:
-	@set -e; \
-	for i in $(TARGETS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
-	ln -f cpuset_load_balance_test.sh ../../../../bin/cpuset_load_balance_test.sh;
-	ln -f cpuset_sched_domains_test.sh
../../../../bin/cpuset_sched_domains_test.sh;
-	chmod +x cpuset_load_balance_test.sh;
-	chmod +x cpuset_sched_domains_test.sh;
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile	11
May 2009 10:02:47 -0000	1.1
+++ testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,16 +1,30 @@
-CFLAGS += -Wall -g -Wextra
+#
+#    kernel/controllers/cpuset/cpuset_memory_pressure_test testcase Makefile.
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

-all: cpuset_memory_pressure
+include ../Makefile.inc

-cpuset_memory_pressure: cpuset_memory_pressure.o
-	cc cpuset_memory_pressure.o -o cpuset_memory_pressure
+CFLAGS			+= -Wall -g -Wextra

-clean:
-	rm -f cpuset_memory_pressure.o cpuset_memory_pressure
-
-install:
-	@set -e;
-	ln -f cpuset_memory_pressure ../../../../bin/cpuset_memory_pressure;
-	ln -f cpuset_memory_pressure_testset.sh
../../../../bin/cpuset_memory_pressure_testset.sh;
-	chmod +x cpuset_memory_pressure;
-	chmod +x cpuset_memory_pressure_testset.sh;
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile	11
May 2009 10:02:47 -0000	1.1
+++ testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,16 +1,30 @@
-CFLAGS += -Wall -g -Wextra
+#
+#    kernel/controllers/cpuset/cpuset_memory_spread_test testcase Makefile.
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

-all: cpuset_mem_hog
+include ../Makefile.inc

-cpuset_mem_hog: cpuset_mem_hog.o
-	cc cpuset_mem_hog.o -o cpuset_mem_hog
+CFLAGS			+= -Wall -g -Wextra

-clean:
-	rm -f cpuset_mem_hog.o cpuset_mem_hog
-
-install:
-	@set -e;
-	ln -f cpuset_mem_hog ../../../../bin/cpuset_mem_hog;
-	ln -f cpuset_memory_spread_testset.sh
../../../../bin/cpuset_memory_spread_testset.sh;
-	chmod +x cpuset_mem_hog;
-	chmod +x cpuset_memory_spread_testset.sh;
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile	11
May 2009 10:02:47 -0000	1.1
+++ testcases/kernel/controllers/cpuset/cpuset_memory_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,20 +1,30 @@
-CFLAGS += -Wall -g -Wextra
+#
+#    kernel/controllers/cpuset/cpuset_memory_test testcase Makefile.
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

-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+include ../Makefile.inc

-all: cpuset_memory_test
+CFLAGS			+= -Wall -g -Wextra

-cpuset_memory_test: cpuset_memory_test.o $(LIBOBJECTS)
-	cc cpuset_memory_test.o $(LIBOBJECTS) -o cpuset_memory_test -lpthread
-
-clean:
-	rm -f cpuset_memory_test cpuset_memory_test.o
-	rm -f $(LIBOBJECTS)
-
-install:
-	@set -e;
-	ln -f cpuset_memory_test ../../../../bin/cpuset_memory_test;
-	ln -f cpuset_memory_testset.sh ../../../../bin/cpuset_memory_testset.sh;
-	chmod +x cpuset_memory_test;
-	chmod +x cpuset_memory_testset.sh;
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile	23
Jun 2009 14:18:17 -0000	1.3
+++ testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile	7
Jul 2009 04:53:42 -0000
@@ -1,16 +1,28 @@
-SRCS = $(wildcard *.sh)
+#
+#    kernel/controllers/cpuset/cpuset_syscall_test testcase Makefile.
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

-LIBSRCS=$(wildcard ../cpuset_lib/*.c)
-LIBOBJECTS=$(patsubst %.c,%.o,$(LIBSRCS))
+include ../Makefile.inc

-all:cpuset_syscall_test
-
-cpuset_syscall_test: %: %.o $(LIBOBJECTS)
-
-clean:
-	rm -rf cpuset_syscall_test
-
-install:
-	@set -e; \
-	for i in $(SRCS); do ln -f $$i ../../../../bin/$$i; chmod +x $$i; done
-	ln -f cpuset_syscall_test ../../../../bin/cpuset_syscall_test;
+$(eval $(generic_leaf_target))
Index: testcases/kernel/controllers/cpuset/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/controllers/cpuset/Makefile,v
retrieving revision 1.3
diff -u -r1.3 Makefile
--- testcases/kernel/controllers/cpuset/Makefile	23 Jun 2009 14:18:16 -0000	1.3
+++ testcases/kernel/controllers/cpuset/Makefile	7 Jul 2009 04:53:42 -0000
@@ -1,17 +1,28 @@
-SUBDIRS = cpuset_base_ops_test cpuset_lib cpuset_inherit_test
-SUBDIRS += cpuset_exclusive_test cpuset_hierarchy_test cpuset_syscall_test
-SUBDIRS += cpuset_hotplug_test cpuset_load_balance_test
-SUBDIRS += cpuset_memory_pressure_test cpuset_memory_spread_test
-SUBDIRS += cpuset_memory_test
-all:
-	@set -e; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ;done;
+#
+#    kernel/controllers/cpuset testcase suite Makefile.
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

-install:
-	@set -e; \
-	for i in $(SUBDIRS); do $(MAKE) -C $$i install ; done;
-	ln -f run_cpuset_test.sh ../../../bin/run_cpuset_test.sh;
-	chmod +x run_cpuset_test.sh;
+include Makefile.inc

-clean:
-	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i clean ; done
+$(eval $(generic_dir_target))
Index: testcases/kernel/controllers/cpuset/Makefile.inc
===================================================================
RCS file: testcases/kernel/controllers/cpuset/Makefile.inc
diff -N testcases/kernel/controllers/cpuset/Makefile.inc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testcases/kernel/controllers/cpuset/Makefile.inc	7 Jul 2009 04:53:42 -0000
@@ -0,0 +1,55 @@
+#
+#    kernel/controllers/cpuset testcase suite common definitions Makefile.
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
+cpuset_base_dir		:= testcases/kernel/controllers/cpu_set
+
+cpuset_lib_dir		:= $(cpuset_base_dir)/cpuset_lib
+
+# The base directory.
+ifeq ($(cpuset_base_dir),$(CURDIR))
+
+srcdir			?= ../../../..
+
+# Not the base directory
+else
+
+srcdir			?= ../../../../..
+
+# Not the library.
+ifneq ($(cpuset_lib_dir),$(CURDIR))
+
+LDLIBS			+= -lcpu_set
+
+else
+INSTALL_DIR		:= $(libdir)
+endif	# library check.
+endif	# basedir check.
+
+include	$(srcdir)/include/mk/master_include.mk
+
+# We want to install the bourne scripts -- so let's make that the default.
+INSTALL_TARGETS		?= $(wildcard $(srcdir)/$(reldir)/*.sh)
+
+# vim: syntax=make
Index: utils/benchmark/ebizzy-0.3/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/utils/benchmark/ebizzy-0.3/Makefile,v
retrieving revision 1.1
diff -u -r1.1 Makefile
--- utils/benchmark/ebizzy-0.3/Makefile	25 Mar 2009 06:16:33 -0000	1.1
+++ utils/benchmark/ebizzy-0.3/Makefile	7 Jul 2009 04:53:42 -0000
@@ -1,8 +1,37 @@
-all: ebizzy
+#
+#    utils/benchmarks/ebizzy Makefile.
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

-configure:
-	./configure
-ebizzy: configure
-	gcc -Wall -Wshadow -lpthread  -o ebizzy ebizzy.c
-clean:
-	rm -f ebizzy *~
+# IMPORT NOTE: Be careful when upgrading this component as running the
+# `configure' bourne shell script will overwrite this file!
+
+srcdir			?= ../../..
+
+include $(srcdir)/include/mk/master_include.mk
+
+CFLAGS			+= -Wall -Wshadow
+
+LDLIBS			+= -lpthread
+
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
