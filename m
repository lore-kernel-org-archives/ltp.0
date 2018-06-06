From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  6 Jun 2018 14:37:35 +0200
Subject: [LTP] [PATCH] [RFC] syscalls/ipc: Rename some msgctl tests
Message-ID: <20180606123735.15589-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test from msgctl08 to msgctl11 are actually msg stress tests, these
do not actually call msgctl() during the test but rather than that they
fork large number of processes and send message around. Renaming them to
msgstress seems to be more fitting.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltplite                                    |  4 +--
 runtest/stress.part3                               |  4 +--
 runtest/syscalls                                   |  8 +++---
 runtest/syscalls-ipc                               |  8 +++---
 testcases/kernel/syscalls/ipc/msgctl/.gitignore    |  4 ---
 testcases/kernel/syscalls/ipc/msgstress/.gitignore |  4 +++
 testcases/kernel/syscalls/ipc/msgstress/Makefile   | 29 ++++++++++++++++++++++
 .../{msgctl/msgctl08.c => msgstress/msgstress01.c} |  0
 .../{msgctl/msgctl09.c => msgstress/msgstress02.c} |  0
 .../{msgctl/msgctl10.c => msgstress/msgstress03.c} |  0
 .../{msgctl/msgctl11.c => msgstress/msgstress04.c} |  0
 11 files changed, 45 insertions(+), 16 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ipc/msgstress/.gitignore
 create mode 100644 testcases/kernel/syscalls/ipc/msgstress/Makefile
 rename testcases/kernel/syscalls/ipc/{msgctl/msgctl08.c => msgstress/msgstress01.c} (100%)
 rename testcases/kernel/syscalls/ipc/{msgctl/msgctl09.c => msgstress/msgstress02.c} (100%)
 rename testcases/kernel/syscalls/ipc/{msgctl/msgctl10.c => msgstress/msgstress03.c} (100%)
 rename testcases/kernel/syscalls/ipc/{msgctl/msgctl11.c => msgstress/msgstress04.c} (100%)

diff --git a/runtest/ltplite b/runtest/ltplite
index 5f16dec00..3c6f51270 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -487,8 +487,8 @@ msgctl04 msgctl04
 msgctl05 msgctl05
 msgctl06 msgctl06
 msgctl07 msgctl07
-msgctl08 msgctl08
-msgctl09 msgctl09
+msgstress01 msgstress01
+msgstress02 msgstress02
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 0420827e8..e0a8869e8 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -403,8 +403,8 @@ msgctl04 msgctl04
 msgctl05 msgctl05
 msgctl06 msgctl06
 msgctl07 msgctl07
-msgctl08 msgctl08
-msgctl09 msgctl09
+msgstress01 msgstress01
+msgstress02 msgstress02
 
 msgget01 msgget01
 msgget02 msgget02
diff --git a/runtest/syscalls b/runtest/syscalls
index 738d2242c..95d470cde 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -693,10 +693,10 @@ msgctl04 msgctl04
 msgctl05 msgctl05
 msgctl06 msgctl06
 msgctl07 msgctl07
-msgctl08 msgctl08
-msgctl09 msgctl09
-msgctl10 msgctl10
-msgctl11 msgctl11
+msgstress01 msgstress01
+msgstress02 msgstress02
+msgstress03 msgstress03
+msgstress04 msgstress04
 msgctl12 msgctl12
 msgctl13 msgctl13
 
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index de32c6ba9..c734e239d 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -5,10 +5,10 @@ msgctl04 msgctl04
 msgctl05 msgctl05
 msgctl06 msgctl06
 msgctl07 msgctl07
-msgctl08 msgctl08
-msgctl09 msgctl09
-msgctl10 msgctl10
-msgctl11 msgctl11
+msgstress01 msgstress01
+msgstress02 msgstress02
+msgstress03 msgstress03
+msgstress04 msgstress04
 msgctl12 msgctl12
 msgctl13 msgctl13
 
diff --git a/testcases/kernel/syscalls/ipc/msgctl/.gitignore b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
index 3d3a8bf52..2edde5de4 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/.gitignore
+++ b/testcases/kernel/syscalls/ipc/msgctl/.gitignore
@@ -5,9 +5,5 @@
 /msgctl05
 /msgctl06
 /msgctl07
-/msgctl08
-/msgctl09
-/msgctl10
-/msgctl11
 /msgctl12
 /msgctl13
diff --git a/testcases/kernel/syscalls/ipc/msgstress/.gitignore b/testcases/kernel/syscalls/ipc/msgstress/.gitignore
new file mode 100644
index 000000000..a8f675399
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgstress/.gitignore
@@ -0,0 +1,4 @@
+/msgstress01
+/msgstress02
+/msgstress03
+/msgstress04
diff --git a/testcases/kernel/syscalls/ipc/msgstress/Makefile b/testcases/kernel/syscalls/ipc/msgstress/Makefile
new file mode 100644
index 000000000..4472eeb1c
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/msgstress/Makefile
@@ -0,0 +1,29 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+top_srcdir              ?= ../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LIBMSGCTL               := $(LIBDIR)/libmsgctl.a
+LDLIBS                  += -lmsgctl
+
+MAKE_DEPS               := $(LIBMSGCTL)
+
+include $(abs_srcdir)/../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl08.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl08.c
rename to testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl09.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl09.c
rename to testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
rename to testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
similarity index 100%
rename from testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
rename to testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
-- 
2.13.6

