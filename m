From: Matthias Maennich <maennich@google.com>
Date: Tue, 26 Feb 2019 17:02:43 +0000
Subject: [LTP] [PATCH v4 3/3] io/aio: cleanup test directory
In-Reply-To: <20190226170243.134366-1-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
 <20190226170243.134366-1-maennich@google.com>
Message-ID: <20190226170243.134366-4-maennich@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now that aio_tio is just a single file test, consolidate the aio tests
within io/aio.

Suggested-by: Steve Muckle <smuckle@google.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 runtest/io                                    |  2 +-
 testcases/kernel/io/aio/.gitignore            |  4 +--
 testcases/kernel/io/aio/Makefile              | 22 +++++---------
 testcases/kernel/io/aio/{aio01 => }/aio01.c   |  0
 testcases/kernel/io/aio/aio01/Makefile        | 30 -------------------
 .../io/aio/{aio02/aio_tio.c => aio02.c}       |  0
 testcases/kernel/io/aio/aio02/Makefile        | 14 ---------
 testcases/kernel/io/aio/aio02/README          | 12 --------
 8 files changed, 10 insertions(+), 74 deletions(-)
 rename testcases/kernel/io/aio/{aio01 => }/aio01.c (100%)
 delete mode 100644 testcases/kernel/io/aio/aio01/Makefile
 rename testcases/kernel/io/aio/{aio02/aio_tio.c => aio02.c} (100%)
 delete mode 100644 testcases/kernel/io/aio/aio02/Makefile
 delete mode 100644 testcases/kernel/io/aio/aio02/README

diff --git a/runtest/io b/runtest/io
index 00032ffde..cd51cce3c 100644
--- a/runtest/io
+++ b/runtest/io
@@ -1,3 +1,3 @@
 #AIO01 & AIO02 tests to be run
 aio01 aio01
-aio02 aio_tio
+aio02 aio02
diff --git a/testcases/kernel/io/aio/.gitignore b/testcases/kernel/io/aio/.gitignore
index 646af5479..81cc7c4fa 100644
--- a/testcases/kernel/io/aio/.gitignore
+++ b/testcases/kernel/io/aio/.gitignore
@@ -1,2 +1,2 @@
-/aio01/aio01
-/aio02/aio_tio
+aio01
+aio02
diff --git a/testcases/kernel/io/aio/Makefile b/testcases/kernel/io/aio/Makefile
index daf81f50e..13ed4a395 100644
--- a/testcases/kernel/io/aio/Makefile
+++ b/testcases/kernel/io/aio/Makefile
@@ -1,22 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 #
 #  Copyright (c) International Business Machines  Corp., 2001
 #
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+CPPFLAGS		+= -D_GNU_SOURCE
+
+LDLIBS			+= $(AIO_LIBS)
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/io/aio/aio01/aio01.c b/testcases/kernel/io/aio/aio01.c
similarity index 100%
rename from testcases/kernel/io/aio/aio01/aio01.c
rename to testcases/kernel/io/aio/aio01.c
diff --git a/testcases/kernel/io/aio/aio01/Makefile b/testcases/kernel/io/aio/aio01/Makefile
deleted file mode 100644
index 9a0ad7732..000000000
--- a/testcases/kernel/io/aio/aio01/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-###########################################################################
-# name of file	: Makefile						  #
-# description	: make(1) description file                                #
-###########################################################################
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-LDLIBS			+= $(AIO_LIBS)
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/io/aio/aio02/aio_tio.c b/testcases/kernel/io/aio/aio02.c
similarity index 100%
rename from testcases/kernel/io/aio/aio02/aio_tio.c
rename to testcases/kernel/io/aio/aio02.c
diff --git a/testcases/kernel/io/aio/aio02/Makefile b/testcases/kernel/io/aio/aio02/Makefile
deleted file mode 100644
index 629aa9a58..000000000
--- a/testcases/kernel/io/aio/aio02/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-CPPFLAGS		+= -D_GNU_SOURCE
-
-LDLIBS			+= $(AIO_LIBS)
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/io/aio/aio02/README b/testcases/kernel/io/aio/aio02/README
deleted file mode 100644
index 81ab36e22..000000000
--- a/testcases/kernel/io/aio/aio02/README
+++ /dev/null
@@ -1,12 +0,0 @@
-This program will test Asynchronous I/O support by kernel 2.5 .
-make the program
-	make
-execute the test
-	./aio_tio
-
-
-NOTE:
-	make sure your system are support with libaio-0.3.92 or higher.
-		you can download this form http://www.kernel.org.
-	make sure your system are support with glibc 2.1.91 or higher.
-
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

