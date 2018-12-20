From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 20 Dec 2018 18:21:49 +0000
Subject: [LTP] [PATCH v2 4/4]  cgroup: helpers various fixes
In-Reply-To: <20181220182149.48326-1-cristian.marussi@arm.com>
References: <20181220182149.48326-1-cristian.marussi@arm.com>
Message-ID: <20181220182149.48326-5-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Regarding cgroup/ helpers:
- converted Copyright headers to SPDX
- removed residual bashism
- renamed each helper to include a tag prefix (cgroup_regress_)
  in order to avoid possible name clashes once installed all together
  into testcases/bin

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/controllers/cgroup/Makefile  | 22 ++------
 .../cgroup/cgroup_regress_test_10_1.sh        | 14 +++++
 .../cgroup/cgroup_regress_test_10_2.sh        | 12 +++++
 .../cgroup/cgroup_regress_test_3_1.sh         | 14 +++++
 .../cgroup/cgroup_regress_test_3_2.sh         | 11 ++++
 .../cgroup/cgroup_regress_test_6_1.sh         | 13 +++++
 .../cgroup/cgroup_regress_test_6_2.c          | 37 +++++++++++++
 .../cgroup/cgroup_regress_test_9_1.sh         | 14 +++++
 .../cgroup/cgroup_regress_test_9_2.sh         | 13 +++++
 .../cgroup/cgroup_regression_test.sh          | 43 +++++----------
 .../controllers/cgroup/fork_processes.c       | 27 +++-------
 .../kernel/controllers/cgroup/getdelays.c     |  1 +
 .../kernel/controllers/cgroup/test_10_1.sh    | 33 ------------
 .../kernel/controllers/cgroup/test_10_2.sh    | 31 -----------
 .../kernel/controllers/cgroup/test_3_1.sh     | 33 ------------
 .../kernel/controllers/cgroup/test_3_2.sh     | 30 -----------
 .../kernel/controllers/cgroup/test_6_1.sh     | 32 ------------
 .../kernel/controllers/cgroup/test_6_2.c      | 52 -------------------
 .../kernel/controllers/cgroup/test_9_1.sh     | 33 ------------
 .../kernel/controllers/cgroup/test_9_2.sh     | 32 ------------
 20 files changed, 150 insertions(+), 347 deletions(-)
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh
 create mode 100644 testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh
 create mode 100755 testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_10_1.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_10_2.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_3_1.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_3_2.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_6_1.sh
 delete mode 100644 testcases/kernel/controllers/cgroup/test_6_2.c
 delete mode 100755 testcases/kernel/controllers/cgroup/test_9_1.sh
 delete mode 100755 testcases/kernel/controllers/cgroup/test_9_2.sh

diff --git a/testcases/kernel/controllers/cgroup/Makefile b/testcases/kernel/controllers/cgroup/Makefile
index 0cd60adae..8075ae80d 100644
--- a/testcases/kernel/controllers/cgroup/Makefile
+++ b/testcases/kernel/controllers/cgroup/Makefile
@@ -1,24 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Author: Ngie Cooper, July 2009
 #
 #    kernel/controllers/cgroup test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh
new file mode 100755
index 000000000..d7bc5feb2
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_1.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	mkdir cgroup/0 > /dev/null 2>&1
+	rmdir cgroup/0 > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh
new file mode 100755
index 000000000..b1222422d
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_10_2.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh
new file mode 100755
index 000000000..a23afab4c
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_1.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+
+path=$1
+
+while true
+do
+	mkdir $path/0
+	rmdir $path/0
+done
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh
new file mode 100755
index 000000000..e1836a3e2
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_3_2.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	cat /proc/sched_debug > /dev/null
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh
new file mode 100755
index 000000000..3ca5e3154
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_1.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
+	rmdir cgroup/[1-9]* > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
new file mode 100644
index 000000000..9e0db9915
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_6_2.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
+
+#define _GNU_SOURCE
+
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include "test.h"
+
+#define DEFAULT_USEC	30000
+
+int foo(void __attribute__ ((unused)) * arg)
+{
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int usec;
+
+	if (argc == 2)
+		usec = atoi(argv[1]);
+	else
+		usec = DEFAULT_USEC;
+
+	while (1) {
+		usleep(usec);
+		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
+	}
+
+	tst_exit();
+}
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh
new file mode 100755
index 000000000..4b6741a91
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_1.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	cat cgroup/release_agent > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh
new file mode 100755
index 000000000..b9c05d032
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_regress_test_9_2.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
+
+trap exit USR1
+while true
+do
+#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
+	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
+	umount cgroup/ > /dev/null 2>&1
+done
+
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index a66ed71e1..21760f178 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -1,26 +1,7 @@
-#! /bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2009 FUJITSU LIMITED
+# Author: Li Zefan <lizf@cn.fujitsu.com>
 
 TST_TESTFUNC=do_test
 TST_SETUP=do_setup
@@ -207,9 +188,9 @@ test_3()
 		cpu_subsys_path=cgroup
 	fi
 
-	./test_3_1.sh $cpu_subsys_path &
+	cgroup_regress_test_3_1.sh $cpu_subsys_path &
 	pid1=$!
-	./test_3_2.sh &
+	cgroup_regress_test_3_2.sh &
 	pid2=$!
 
 	sleep 30
@@ -358,9 +339,9 @@ test_6()
 	fi
 
 	# run the test for 30 secs
-	./test_6_1.sh &
+	cgroup_regress_test_6_1.sh &
 	local pid1=$!
-	./test_6_2 &
+	cgroup_regress_test_6_2 &
 	local pid2=$!
 
 	sleep 30
@@ -525,9 +506,9 @@ test_8()
 #---------------------------------------------------------------------------
 test_9()
 {
-	./test_9_1.sh &
+	cgroup_regress_test_9_1.sh &
 	local pid1=$!
-	./test_9_2.sh &
+	cgroup_regress_test_9_2.sh &
 	local pid2=$!
 
 	sleep 30
@@ -552,9 +533,9 @@ test_9()
 #---------------------------------------------------------------------------
 test_10()
 {
-	./test_10_1.sh &
+	cgroup_regress_test_10_1.sh &
 	local pid1=$!
-	./test_10_2.sh &
+	cgroup_regress_test_10_2.sh &
 	local pid2=$!
 
 	sleep 30
diff --git a/testcases/kernel/controllers/cgroup/fork_processes.c b/testcases/kernel/controllers/cgroup/fork_processes.c
index b4bb77101..6f2498bb8 100644
--- a/testcases/kernel/controllers/cgroup/fork_processes.c
+++ b/testcases/kernel/controllers/cgroup/fork_processes.c
@@ -1,24 +1,9 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 FUJITSU LIMITED
+ *
+ * Author: Li Zefan <lizf@cn.fujitsu.com>
+ */
 
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/controllers/cgroup/getdelays.c b/testcases/kernel/controllers/cgroup/getdelays.c
index 4e87a13ca..57f37a5f8 100644
--- a/testcases/kernel/controllers/cgroup/getdelays.c
+++ b/testcases/kernel/controllers/cgroup/getdelays.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /* getdelays.c
  *
  * Utility to get per-pid and per-tgid delay accounting statistics
diff --git a/testcases/kernel/controllers/cgroup/test_10_1.sh b/testcases/kernel/controllers/cgroup/test_10_1.sh
deleted file mode 100755
index 2a7763b09..000000000
--- a/testcases/kernel/controllers/cgroup/test_10_1.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	mkdir cgroup/0 > /dev/null 2>&1
-	rmdir cgroup/0 > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_10_2.sh b/testcases/kernel/controllers/cgroup/test_10_2.sh
deleted file mode 100755
index a6e50d883..000000000
--- a/testcases/kernel/controllers/cgroup/test_10_2.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_3_1.sh b/testcases/kernel/controllers/cgroup/test_3_1.sh
deleted file mode 100755
index dcc78a6b1..000000000
--- a/testcases/kernel/controllers/cgroup/test_3_1.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-
-path=$1
-
-for ((; ;))
-{
-	mkdir $path/0
-	rmdir $path/0
-}
diff --git a/testcases/kernel/controllers/cgroup/test_3_2.sh b/testcases/kernel/controllers/cgroup/test_3_2.sh
deleted file mode 100755
index 63bafaa46..000000000
--- a/testcases/kernel/controllers/cgroup/test_3_2.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	cat /proc/sched_debug > /dev/null
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_6_1.sh b/testcases/kernel/controllers/cgroup/test_6_1.sh
deleted file mode 100755
index 4eb6b3293..000000000
--- a/testcases/kernel/controllers/cgroup/test_6_1.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-	mount -t cgroup -o ns xxx cgroup/ > /dev/null 2>&1
-	rmdir cgroup/[1-9]* > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_6_2.c b/testcases/kernel/controllers/cgroup/test_6_2.c
deleted file mode 100644
index df85b1f91..000000000
--- a/testcases/kernel/controllers/cgroup/test_6_2.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) 2009 FUJITSU LIMITED                                         */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/* Author: Li Zefan <lizf@cn.fujitsu.com>                                     */
-/*                                                                            */
-/******************************************************************************/
-
-#define _GNU_SOURCE
-
-#include <sched.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include "test.h"
-
-#define DEFAULT_USEC	30000
-
-int foo(void __attribute__ ((unused)) * arg)
-{
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int usec;
-
-	if (argc == 2)
-		usec = atoi(argv[1]);
-	else
-		usec = DEFAULT_USEC;
-
-	while (1) {
-		usleep(usec);
-		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
-	}
-
-	tst_exit();
-}
diff --git a/testcases/kernel/controllers/cgroup/test_9_1.sh b/testcases/kernel/controllers/cgroup/test_9_1.sh
deleted file mode 100755
index b7c26a46c..000000000
--- a/testcases/kernel/controllers/cgroup/test_9_1.sh
+++ /dev/null
@@ -1,33 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	cat cgroup/release_agent > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
diff --git a/testcases/kernel/controllers/cgroup/test_9_2.sh b/testcases/kernel/controllers/cgroup/test_9_2.sh
deleted file mode 100755
index 2d7d38675..000000000
--- a/testcases/kernel/controllers/cgroup/test_9_2.sh
+++ /dev/null
@@ -1,32 +0,0 @@
-#! /bin/bash
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2009 FUJITSU LIMITED                                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-## Author: Li Zefan <lizf@cn.fujitsu.com>                                     ##
-##                                                                            ##
-################################################################################
-
-trap exit SIGUSR1
-for ((; ;))
-{
-#	mount -t cgroup -o debug xxx cgroup/ > /dev/null 2>&1
-	mount -t cgroup xxx cgroup/ > /dev/null 2>&1
-	umount cgroup/ > /dev/null 2>&1
-}
-
-- 
2.17.1

