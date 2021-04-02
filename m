From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 2 Apr 2021 11:46:12 +0800
Subject: [LTP] [PATCH 2/2] kernel/syscalls: Unify the annotation style and
 remove Redundant code
In-Reply-To: <20210402034612.127912-1-xieziyao@huawei.com>
References: <20210402034612.127912-1-xieziyao@huawei.com>
Message-ID: <20210402034612.127912-3-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change License for Makefile and remove some unnecessary annotation
in kernel/syscalls.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 .../syscalls/clock_gettime/clock_gettime03.c  | 20 +++++++------------
 .../clock_nanosleep/clock_nanosleep03.c       | 18 +++++++----------
 testcases/kernel/syscalls/clone3/clone301.c   |  5 +++++
 testcases/kernel/syscalls/clone3/clone302.c   |  5 +++++
 testcases/kernel/syscalls/execle/Makefile     | 19 +++---------------
 testcases/kernel/syscalls/execlp/Makefile     | 19 +++---------------
 testcases/kernel/syscalls/execvp/Makefile     | 20 +++----------------
 testcases/kernel/syscalls/lgetxattr/Makefile  | 16 +--------------
 8 files changed, 34 insertions(+), 88 deletions(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index dc570a06c..ef6bb119e 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -1,20 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-
-  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
-
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
 /*
-
-  Basic test for timer namespaces.
-
-  After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
-  process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
-  and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
-
-  The child processes also switch to the initial parent namespace and checks
-  that the offset is set to 0.
-
+ * After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
+ * process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
+ * and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
+ *
+ * The child processes also switch to the initial parent namespace and checks
+ * that the offset is set to 0.
  */

 #define _GNU_SOURCE
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
index bd2c38ee3..1d964d118 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
@@ -1,18 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-
-  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
-
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
-
-   Test that clock_nanosleep() adds correctly an offset with absolute timeout
-   and CLOCK_MONOTONIC inside of a timer namespace.
-
-   After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
-   process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
-   and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.

+/*
+ * Test that clock_nanosleep() adds correctly an offset with absolute timeout
+ * and CLOCK_MONOTONIC inside of a timer namespace.
+ * After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
+ * process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
+ * and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
  */

 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index 11787fc7e..7ac4bb5a3 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
  * Basic clone3() test.
  */
+
 #define _GNU_SOURCE

 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index 54d59a1f5..08d6417ce 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
  * Basic clone3() test to check various failures.
  */
+
 #define _GNU_SOURCE

 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/execle/Makefile b/testcases/kernel/syscalls/execle/Makefile
index a0e5f0fc4..ea102983a 100644
--- a/testcases/kernel/syscalls/execle/Makefile
+++ b/testcases/kernel/syscalls/execle/Makefile
@@ -1,20 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
-#  Copyright (c) Linux Test Project, 2018
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software: you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation, either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
+# Copyright (c) Linux Test Project, 2018
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/syscalls/execlp/Makefile b/testcases/kernel/syscalls/execlp/Makefile
index a0e5f0fc4..ea102983a 100644
--- a/testcases/kernel/syscalls/execlp/Makefile
+++ b/testcases/kernel/syscalls/execlp/Makefile
@@ -1,20 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
-#  Copyright (c) Linux Test Project, 2018
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software: you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation, either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
+# Copyright (c) Linux Test Project, 2018
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/syscalls/execvp/Makefile b/testcases/kernel/syscalls/execvp/Makefile
index a0e5f0fc4..d44bfa32b 100644
--- a/testcases/kernel/syscalls/execvp/Makefile
+++ b/testcases/kernel/syscalls/execvp/Makefile
@@ -1,20 +1,6 @@
-#
-#  Copyright (c) Linux Test Project, 2018
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software: you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation, either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2018
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/syscalls/lgetxattr/Makefile b/testcases/kernel/syscalls/lgetxattr/Makefile
index b788fed03..28f5f6f9a 100644
--- a/testcases/kernel/syscalls/lgetxattr/Makefile
+++ b/testcases/kernel/syscalls/lgetxattr/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Fujitsu Ltd.
 # Author: Jinbao Huang <huangjb.jy@cn.fujitsu.com>
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation;  either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.
-#

 top_srcdir		?= ../../../..

--
2.17.1

