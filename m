Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SyGqQ-0004nB-E8
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 06:31:14 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SyGqO-0008GV-Jg
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 06:31:14 +0000
Received: by pbcwy7 with SMTP id wy7so1109945pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 05 Aug 2012 23:31:06 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon,  6 Aug 2012 14:30:50 +0800
Message-Id: <2fbaeedd90ff07905a440eff5a3877bc7bf40f4c.1344234636.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH v2 1/2] numa_helper: move to libkerntest
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


libnuma_helper could be used by testcases both under syscalls/ and mem/,
it's better to add a new common lib in their parent dir, so I created
libkerntest under testcases/kernel/lib/, and put numa_helper to it. In
the future, we can add more APIs to it.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/include/lib.mk                  |   37 +++
 testcases/kernel/include/numa_helper.h           |   37 +++
 testcases/kernel/lib/Makefile                    |   29 +++
 testcases/kernel/lib/numa_helper.c               |  266 ++++++++++++++++++++++
 testcases/kernel/syscalls/get_mempolicy/Makefile |    2 +-
 testcases/kernel/syscalls/mbind/Makefile         |    2 +-
 testcases/kernel/syscalls/move_pages/Makefile    |    2 +-
 testcases/kernel/syscalls/numa/Makefile          |   22 --
 testcases/kernel/syscalls/numa/Makefile.inc      |   27 ---
 testcases/kernel/syscalls/numa/lib/Makefile      |   26 --
 testcases/kernel/syscalls/numa/lib/numa_helper.c |  266 ----------------------
 testcases/kernel/syscalls/numa/lib/numa_helper.h |   37 ---
 12 files changed, 372 insertions(+), 381 deletions(-)
 create mode 100644 testcases/kernel/include/lib.mk
 create mode 100644 testcases/kernel/include/numa_helper.h
 create mode 100644 testcases/kernel/lib/Makefile
 create mode 100644 testcases/kernel/lib/numa_helper.c
 delete mode 100644 testcases/kernel/syscalls/numa/Makefile
 delete mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
 delete mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
 delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
 delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h


--------------1.7.8.6
Content-Type: text/x-patch; name="0001-numa_helper-move-to-libkerntest.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-numa_helper-move-to-libkerntest.patch"

diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/lib.mk
new file mode 100644
index 0000000..624134b
--- /dev/null
+++ b/testcases/kernel/include/lib.mk
@@ -0,0 +1,37 @@
+#
+#  Copyright (C) 2012 Linux Test Project, Inc.
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
+KERNEL_DIR		:= $(top_srcdir)/testcases/kernel
+LIBKERNTEST_DIR		:= $(KERNEL_DIR)/lib
+LIBKERNTEST		:= $(KERNEL_DIR)/libkerntest.a
+CPPFLAGS		+= $(NUMA_CPPFLAGS) -I$(KERNEL_DIR)/include
+LDLIBS			+= $(NUMA_LIBS) -lkerntest -lltp
+LDFLAGS			+= -L$(LIBKERNTEST_DIR)
+
+$(LIBKERNTEST_DIR):
+	mkdir -p "$@"
+
+$(LIBKERNTEST): $(LIBKERNTEST_DIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+
+MAKE_DEPS		+= $(LIBKERNTEST)
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBKERNTEST_DIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
diff --git a/testcases/kernel/include/numa_helper.h b/testcases/kernel/include/numa_helper.h
new file mode 100644
index 0000000..463019a
--- /dev/null
+++ b/testcases/kernel/include/numa_helper.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef NUMA_HELPER_H
+#define NUMA_HELPER_H
+
+#include "config.h"
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+
+#define NH_MEMS (1 << 0)
+#define NH_CPUS (1 << 1)
+
+int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
+int get_allowed_nodes(int flag, int count, ...);
+void nh_dump_nodes();
+
+#endif
diff --git a/testcases/kernel/lib/Makefile b/testcases/kernel/lib/Makefile
new file mode 100644
index 0000000..847f6af
--- /dev/null
+++ b/testcases/kernel/lib/Makefile
@@ -0,0 +1,29 @@
+#
+#    kernel/lib Makefile.
+#
+#    Copyright (C) 2012, Linux Test Project.
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
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+CPPFLAGS		+= $(NUMA_CPPFLAGS) -I../include
+LIB			:= libkerntest.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
new file mode 100644
index 0000000..aa98522
--- /dev/null
+++ b/testcases/kernel/lib/numa_helper.c
@@ -0,0 +1,266 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "config.h"
+#include <errno.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "numa_helper.h"
+#include "linux_syscall_numbers.h"
+
+#if HAVE_NUMA_H
+static unsigned long get_max_node()
+{
+	unsigned long max_node = 0;
+#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
+	max_node = NUMA_NUM_NODES;
+	/*
+	 * NUMA_NUM_NODES is not reliable, libnuma >=2 is looking
+	 * at /proc/self/status to figure out correct number.
+	 * If buffer is not large enough get_mempolicy will fail with EINVAL.
+	 */
+	if (max_node < 1024)
+		max_node = 1024;
+#else
+	max_node = numa_max_possible_node() + 1;
+#endif
+	return max_node;
+}
+
+static void get_nodemask_allnodes(nodemask_t *nodemask,
+	unsigned long max_node)
+{
+	unsigned long nodemask_size = max_node/8+1;
+	int i;
+	char fn[64];
+	struct stat st;
+
+	memset(nodemask, 0, nodemask_size);
+	for (i = 0; i < max_node; i++) {
+		sprintf(fn, "/sys/devices/system/node/node%d", i);
+		if (stat(fn, &st) == 0)
+			nodemask_set(nodemask, i);
+	}
+}
+
+static int filter_nodemask_mem(nodemask_t *nodemask, unsigned long max_node)
+{
+#if MPOL_F_MEMS_ALLOWED
+	unsigned long nodemask_size = max_node/8+1;
+	memset(nodemask, 0, nodemask_size);
+	/*
+	 * avoid numa_get_mems_allowed(), because of bug in getpol()
+	 * utility function in older versions:
+	 * http://www.spinics.net/lists/linux-numa/msg00849.html
+	 */
+	if (syscall(__NR_get_mempolicy, NULL, nodemask->n,
+		max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
+		return -2;
+#else
+	int i;
+	/*
+	 * old libnuma/kernel don't have MPOL_F_MEMS_ALLOWED, so let's assume
+	 * that we can use any node with memory > 0
+	 */
+	for (i = 0; i < max_node; i++) {
+		if (!nodemask_isset(nodemask, i))
+			continue;
+		if (numa_node_size64(i, NULL) <= 0)
+			nodemask_clr(nodemask, i);
+	}
+#endif /* MPOL_F_MEMS_ALLOWED */
+	return 0;
+}
+
+static int cpumask_has_cpus(char *cpumask, size_t len)
+{
+	int j;
+	for (j = 0; j < len; j++)
+		if (cpumask[j] == '\0')
+			return 0;
+		else if ((cpumask[j] > '0' && cpumask[j] <= '9') ||
+			(cpumask[j] >= 'a' && cpumask[j] <= 'f'))
+			return 1;
+	return 0;
+
+}
+
+static void filter_nodemask_cpu(nodemask_t *nodemask, unsigned long max_node)
+{
+	char *cpumask = NULL;
+	char fn[64];
+	FILE *f;
+	size_t len;
+	int i, ret;
+
+	for (i = 0; i < max_node; i++) {
+		if (!nodemask_isset(nodemask, i))
+			continue;
+		sprintf(fn, "/sys/devices/system/node/node%d/cpumap", i);
+		f = fopen(fn, "r");
+		if (f) {
+			ret = getdelim(&cpumask, &len, '\n', f);
+			if ((ret > 0) && (!cpumask_has_cpus(cpumask, len)))
+				nodemask_clr(nodemask, i);
+			fclose(f);
+		}
+	}
+	free(cpumask);
+}
+#endif /* HAVE_NUMA_H */
+
+/*
+ * get_allowed_nodes_arr - get number and array of available nodes
+ * @num_nodes: pointer where number of available nodes will be stored
+ * @nodes: array of available node ids, this is MPOL_F_MEMS_ALLOWED
+ *                 node bitmask compacted (without holes), so that each field
+ *                 contains node number. If NULL only num_nodes is
+ *                 returned, otherwise it cotains new allocated array,
+ *                 which caller is responsible to free.
+ * RETURNS:
+ *     0 on success
+ *    -1 on allocation failure
+ *    -2 on get_mempolicy failure
+ */
+int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
+{
+	int ret = 0;
+#if HAVE_NUMA_H
+	int i;
+	nodemask_t *nodemask = NULL;
+#endif
+	*num_nodes = 0;
+	if (nodes)
+		*nodes = NULL;
+
+#if HAVE_NUMA_H
+	unsigned long max_node = get_max_node();
+	unsigned long nodemask_size = max_node/8+1;
+
+	nodemask = malloc(nodemask_size);
+	if (nodes)
+		*nodes = malloc(sizeof(int)*max_node);
+
+	do {
+		if (nodemask == NULL ||	(nodes && (*nodes == NULL))) {
+			ret = -1;
+			break;
+		}
+
+		/* allow all nodes at start, then filter based on flags */
+		get_nodemask_allnodes(nodemask, max_node);
+		if ((flag & NH_MEMS) == NH_MEMS) {
+			ret = filter_nodemask_mem(nodemask, max_node);
+			if (ret < 0)
+				break;
+		}
+		if ((flag & NH_CPUS) == NH_CPUS)
+			filter_nodemask_cpu(nodemask, max_node);
+
+		for (i = 0; i <	max_node; i++) {
+			if (nodemask_isset(nodemask, i)) {
+				if (nodes)
+					(*nodes)[*num_nodes] = i;
+				(*num_nodes)++;
+			}
+		}
+	} while (0);
+	free(nodemask);
+#endif
+	return ret;
+}
+
+/*
+ * get_allowed_nodes - convenience function to get fixed number of nodes
+ * @count: how many nodes to get
+ * @...: int pointers, where node ids will be stored
+ * RETURNS:
+ *     0 on success
+ *    -1 on allocation failure
+ *    -2 on get_mempolicy failure
+ *    -3 on not enough allowed nodes
+ */
+int get_allowed_nodes(int flag, int count, ...)
+{
+	int ret;
+	int i, *nodep;
+	va_list ap;
+	int num_nodes = 0;
+	int *nodes = NULL;
+
+	ret = get_allowed_nodes_arr(flag, &num_nodes, &nodes);
+	if (ret < 0)
+		return ret;
+
+	va_start(ap, count);
+	for (i = 0; i < count; i++) {
+		nodep = va_arg(ap, int *);
+		if (i < num_nodes) {
+			*nodep = nodes[i];
+		} else {
+			ret = -3;
+			errno = EINVAL;
+			break;
+		}
+	}
+	free(nodes);
+	va_end(ap);
+
+	return ret;
+}
+
+static void print_node_info(int flag)
+{
+	int *allowed_nodes = NULL;
+	int i, ret, num_nodes;
+
+	ret = get_allowed_nodes_arr(flag, &num_nodes, &allowed_nodes);
+	printf("nodes (flag=%d): ", flag);
+	if (ret == 0) {
+		for (i = 0; i < num_nodes; i++)
+			printf("%d ", allowed_nodes[i]);
+		printf("\n");
+	} else
+		printf("error(%d)\n", ret);
+	free(allowed_nodes);
+}
+
+/*
+ * nh_dump_nodes - dump info about nodes to stdout
+ */
+void nh_dump_nodes()
+{
+	print_node_info(0);
+	print_node_info(NH_MEMS);
+	print_node_info(NH_CPUS);
+	print_node_info(NH_MEMS | NH_CPUS);
+}
diff --git a/testcases/kernel/syscalls/get_mempolicy/Makefile b/testcases/kernel/syscalls/get_mempolicy/Makefile
index 333ad21..fb7e9ac 100644
--- a/testcases/kernel/syscalls/get_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/get_mempolicy/Makefile
@@ -22,5 +22,5 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -I$(abs_srcdir)/../utils
 
-include $(abs_srcdir)/../numa/Makefile.inc
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/mbind/Makefile b/testcases/kernel/syscalls/mbind/Makefile
index 932037f..5132dff 100644
--- a/testcases/kernel/syscalls/mbind/Makefile
+++ b/testcases/kernel/syscalls/mbind/Makefile
@@ -31,5 +31,5 @@ endif
 
 CPPFLAGS		+= -I$(abs_srcdir)/../utils/
 
-include $(abs_srcdir)/../numa/Makefile.inc
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/move_pages/Makefile b/testcases/kernel/syscalls/move_pages/Makefile
index cf2b83f..d4620e1 100644
--- a/testcases/kernel/syscalls/move_pages/Makefile
+++ b/testcases/kernel/syscalls/move_pages/Makefile
@@ -35,5 +35,5 @@ $(MAKE_TARGETS): %: %.o move_pages_support.o
 
 LDLIBS			+= -lpthread -lrt
 
-include $(abs_srcdir)/../numa/Makefile.inc
+include $(top_srcdir)/testcases/kernel/include/lib.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/numa/Makefile b/testcases/kernel/syscalls/numa/Makefile
deleted file mode 100644
index b38c5b2..0000000
--- a/testcases/kernel/syscalls/numa/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#  Copyright (C) 2012 Linux Test Project, Inc.
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
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/numa/Makefile.inc b/testcases/kernel/syscalls/numa/Makefile.inc
deleted file mode 100644
index 59c2f9e..0000000
--- a/testcases/kernel/syscalls/numa/Makefile.inc
+++ /dev/null
@@ -1,27 +0,0 @@
-#
-#  Copyright (C) 2012 Linux Test Project, Inc.
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
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-
-CPPFLAGS		+= $(NUMA_CPPFLAGS) -I../numa/lib/
-LIBDIR			:= ../numa/lib
-LIB			:= $(LIBDIR)/libnuma_helper.a
-MAKE_DEPS		+= $(LIB)
-LDLIBS			+= $(NUMA_LIBS) -lnuma_helper -lltp
-LDFLAGS			+= -L$(LIBDIR)
-
-$(LIB): $(LIBDIR)
-		$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
diff --git a/testcases/kernel/syscalls/numa/lib/Makefile b/testcases/kernel/syscalls/numa/lib/Makefile
deleted file mode 100644
index ba2fb48..0000000
--- a/testcases/kernel/syscalls/numa/lib/Makefile
+++ /dev/null
@@ -1,26 +0,0 @@
-#
-#  Copyright (C) 2012 Linux Test Project, Inc.
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
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-CPPFLAGS		+= -I../../../include $(NUMA_CPPFLAGS)
-LIB			:= libnuma_helper.a
-
-include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.c b/testcases/kernel/syscalls/numa/lib/numa_helper.c
deleted file mode 100644
index aa98522..0000000
--- a/testcases/kernel/syscalls/numa/lib/numa_helper.c
+++ /dev/null
@@ -1,266 +0,0 @@
-/*
- * Copyright (C) 2012 Linux Test Project, Inc.
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include "config.h"
-#include <errno.h>
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
-#include <stdarg.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include "test.h"
-#include "usctest.h"
-#include "safe_macros.h"
-#include "numa_helper.h"
-#include "linux_syscall_numbers.h"
-
-#if HAVE_NUMA_H
-static unsigned long get_max_node()
-{
-	unsigned long max_node = 0;
-#if !defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
-	max_node = NUMA_NUM_NODES;
-	/*
-	 * NUMA_NUM_NODES is not reliable, libnuma >=2 is looking
-	 * at /proc/self/status to figure out correct number.
-	 * If buffer is not large enough get_mempolicy will fail with EINVAL.
-	 */
-	if (max_node < 1024)
-		max_node = 1024;
-#else
-	max_node = numa_max_possible_node() + 1;
-#endif
-	return max_node;
-}
-
-static void get_nodemask_allnodes(nodemask_t *nodemask,
-	unsigned long max_node)
-{
-	unsigned long nodemask_size = max_node/8+1;
-	int i;
-	char fn[64];
-	struct stat st;
-
-	memset(nodemask, 0, nodemask_size);
-	for (i = 0; i < max_node; i++) {
-		sprintf(fn, "/sys/devices/system/node/node%d", i);
-		if (stat(fn, &st) == 0)
-			nodemask_set(nodemask, i);
-	}
-}
-
-static int filter_nodemask_mem(nodemask_t *nodemask, unsigned long max_node)
-{
-#if MPOL_F_MEMS_ALLOWED
-	unsigned long nodemask_size = max_node/8+1;
-	memset(nodemask, 0, nodemask_size);
-	/*
-	 * avoid numa_get_mems_allowed(), because of bug in getpol()
-	 * utility function in older versions:
-	 * http://www.spinics.net/lists/linux-numa/msg00849.html
-	 */
-	if (syscall(__NR_get_mempolicy, NULL, nodemask->n,
-		max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
-		return -2;
-#else
-	int i;
-	/*
-	 * old libnuma/kernel don't have MPOL_F_MEMS_ALLOWED, so let's assume
-	 * that we can use any node with memory > 0
-	 */
-	for (i = 0; i < max_node; i++) {
-		if (!nodemask_isset(nodemask, i))
-			continue;
-		if (numa_node_size64(i, NULL) <= 0)
-			nodemask_clr(nodemask, i);
-	}
-#endif /* MPOL_F_MEMS_ALLOWED */
-	return 0;
-}
-
-static int cpumask_has_cpus(char *cpumask, size_t len)
-{
-	int j;
-	for (j = 0; j < len; j++)
-		if (cpumask[j] == '\0')
-			return 0;
-		else if ((cpumask[j] > '0' && cpumask[j] <= '9') ||
-			(cpumask[j] >= 'a' && cpumask[j] <= 'f'))
-			return 1;
-	return 0;
-
-}
-
-static void filter_nodemask_cpu(nodemask_t *nodemask, unsigned long max_node)
-{
-	char *cpumask = NULL;
-	char fn[64];
-	FILE *f;
-	size_t len;
-	int i, ret;
-
-	for (i = 0; i < max_node; i++) {
-		if (!nodemask_isset(nodemask, i))
-			continue;
-		sprintf(fn, "/sys/devices/system/node/node%d/cpumap", i);
-		f = fopen(fn, "r");
-		if (f) {
-			ret = getdelim(&cpumask, &len, '\n', f);
-			if ((ret > 0) && (!cpumask_has_cpus(cpumask, len)))
-				nodemask_clr(nodemask, i);
-			fclose(f);
-		}
-	}
-	free(cpumask);
-}
-#endif /* HAVE_NUMA_H */
-
-/*
- * get_allowed_nodes_arr - get number and array of available nodes
- * @num_nodes: pointer where number of available nodes will be stored
- * @nodes: array of available node ids, this is MPOL_F_MEMS_ALLOWED
- *                 node bitmask compacted (without holes), so that each field
- *                 contains node number. If NULL only num_nodes is
- *                 returned, otherwise it cotains new allocated array,
- *                 which caller is responsible to free.
- * RETURNS:
- *     0 on success
- *    -1 on allocation failure
- *    -2 on get_mempolicy failure
- */
-int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes)
-{
-	int ret = 0;
-#if HAVE_NUMA_H
-	int i;
-	nodemask_t *nodemask = NULL;
-#endif
-	*num_nodes = 0;
-	if (nodes)
-		*nodes = NULL;
-
-#if HAVE_NUMA_H
-	unsigned long max_node = get_max_node();
-	unsigned long nodemask_size = max_node/8+1;
-
-	nodemask = malloc(nodemask_size);
-	if (nodes)
-		*nodes = malloc(sizeof(int)*max_node);
-
-	do {
-		if (nodemask == NULL ||	(nodes && (*nodes == NULL))) {
-			ret = -1;
-			break;
-		}
-
-		/* allow all nodes at start, then filter based on flags */
-		get_nodemask_allnodes(nodemask, max_node);
-		if ((flag & NH_MEMS) == NH_MEMS) {
-			ret = filter_nodemask_mem(nodemask, max_node);
-			if (ret < 0)
-				break;
-		}
-		if ((flag & NH_CPUS) == NH_CPUS)
-			filter_nodemask_cpu(nodemask, max_node);
-
-		for (i = 0; i <	max_node; i++) {
-			if (nodemask_isset(nodemask, i)) {
-				if (nodes)
-					(*nodes)[*num_nodes] = i;
-				(*num_nodes)++;
-			}
-		}
-	} while (0);
-	free(nodemask);
-#endif
-	return ret;
-}
-
-/*
- * get_allowed_nodes - convenience function to get fixed number of nodes
- * @count: how many nodes to get
- * @...: int pointers, where node ids will be stored
- * RETURNS:
- *     0 on success
- *    -1 on allocation failure
- *    -2 on get_mempolicy failure
- *    -3 on not enough allowed nodes
- */
-int get_allowed_nodes(int flag, int count, ...)
-{
-	int ret;
-	int i, *nodep;
-	va_list ap;
-	int num_nodes = 0;
-	int *nodes = NULL;
-
-	ret = get_allowed_nodes_arr(flag, &num_nodes, &nodes);
-	if (ret < 0)
-		return ret;
-
-	va_start(ap, count);
-	for (i = 0; i < count; i++) {
-		nodep = va_arg(ap, int *);
-		if (i < num_nodes) {
-			*nodep = nodes[i];
-		} else {
-			ret = -3;
-			errno = EINVAL;
-			break;
-		}
-	}
-	free(nodes);
-	va_end(ap);
-
-	return ret;
-}
-
-static void print_node_info(int flag)
-{
-	int *allowed_nodes = NULL;
-	int i, ret, num_nodes;
-
-	ret = get_allowed_nodes_arr(flag, &num_nodes, &allowed_nodes);
-	printf("nodes (flag=%d): ", flag);
-	if (ret == 0) {
-		for (i = 0; i < num_nodes; i++)
-			printf("%d ", allowed_nodes[i]);
-		printf("\n");
-	} else
-		printf("error(%d)\n", ret);
-	free(allowed_nodes);
-}
-
-/*
- * nh_dump_nodes - dump info about nodes to stdout
- */
-void nh_dump_nodes()
-{
-	print_node_info(0);
-	print_node_info(NH_MEMS);
-	print_node_info(NH_CPUS);
-	print_node_info(NH_MEMS | NH_CPUS);
-}
diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.h b/testcases/kernel/syscalls/numa/lib/numa_helper.h
deleted file mode 100644
index 463019a..0000000
--- a/testcases/kernel/syscalls/numa/lib/numa_helper.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2012 Linux Test Project, Inc.
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef NUMA_HELPER_H
-#define NUMA_HELPER_H
-
-#include "config.h"
-#if HAVE_NUMA_H
-#include <numa.h>
-#endif
-#if HAVE_NUMAIF_H
-#include <numaif.h>
-#endif
-
-#define NH_MEMS (1 << 0)
-#define NH_CPUS (1 << 1)
-
-int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
-int get_allowed_nodes(int flag, int count, ...);
-void nh_dump_nodes();
-
-#endif

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



