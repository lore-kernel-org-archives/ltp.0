Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SkAdX-0006VX-Hc
	for ltp-list@lists.sourceforge.net; Thu, 28 Jun 2012 09:03:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SkAdT-0004RK-90
	for ltp-list@lists.sourceforge.net; Thu, 28 Jun 2012 09:03:39 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5S93Td5021663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jun 2012 05:03:29 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q5S93RGk029832
	for <ltp-list@lists.sourceforge.net>; Thu, 28 Jun 2012 05:03:29 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Jun 2012 11:03:15 +0200
Message-Id: <0bd4e5a5604e461f2a560803a01678ce1f0d1f85.1340872565.git.jstancek@redhat.com>
In-Reply-To: <cover.1340872565.git.jstancek@redhat.com>
References: <cover.1340872565.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v2 1/4] add libnuma_helper
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

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


A library to share NUMA helper functions shared by
multiple testcases.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/numa/Makefile          |   22 ++++
 testcases/kernel/syscalls/numa/Makefile.inc      |   27 +++++
 testcases/kernel/syscalls/numa/lib/Makefile      |   26 ++++
 testcases/kernel/syscalls/numa/lib/numa_helper.c |  135 ++++++++++++++++++++++
 testcases/kernel/syscalls/numa/lib/numa_helper.h |   34 ++++++
 5 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/numa/Makefile
 create mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
 create mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
 create mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
 create mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h


--------------1.7.1
Content-Type: text/x-patch; name="0001-add-libnuma_helper.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-add-libnuma_helper.patch"

diff --git a/testcases/kernel/syscalls/numa/Makefile b/testcases/kernel/syscalls/numa/Makefile
new file mode 100644
index 0000000..b38c5b2
--- /dev/null
+++ b/testcases/kernel/syscalls/numa/Makefile
@@ -0,0 +1,22 @@
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
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/syscalls/numa/Makefile.inc b/testcases/kernel/syscalls/numa/Makefile.inc
new file mode 100644
index 0000000..59c2f9e
--- /dev/null
+++ b/testcases/kernel/syscalls/numa/Makefile.inc
@@ -0,0 +1,27 @@
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
+CPPFLAGS		+= $(NUMA_CPPFLAGS) -I../numa/lib/
+LIBDIR			:= ../numa/lib
+LIB			:= $(LIBDIR)/libnuma_helper.a
+MAKE_DEPS		+= $(LIB)
+LDLIBS			+= $(NUMA_LIBS) -lnuma_helper -lltp
+LDFLAGS			+= -L$(LIBDIR)
+
+$(LIB): $(LIBDIR)
+		$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
diff --git a/testcases/kernel/syscalls/numa/lib/Makefile b/testcases/kernel/syscalls/numa/lib/Makefile
new file mode 100644
index 0000000..d4a6f41
--- /dev/null
+++ b/testcases/kernel/syscalls/numa/lib/Makefile
@@ -0,0 +1,26 @@
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
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+CPPFLAGS		+= -I../../../include
+LIB			:= libnuma_helper.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.c b/testcases/kernel/syscalls/numa/lib/numa_helper.c
new file mode 100644
index 0000000..855ee2c
--- /dev/null
+++ b/testcases/kernel/syscalls/numa/lib/numa_helper.c
@@ -0,0 +1,135 @@
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
+#include <unistd.h>
+#include <errno.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "numa_helper.h"
+#include "linux_syscall_numbers.h"
+
+/*
+ * get_allowed_nodes_arr - get number and array of available nodes
+ * @num_allowed_nodes: pointer where number of available nodes will be stored
+ * @allowed_nodes: array of available node ids, this is MPOL_F_MEMS_ALLOWED
+ *                 node bitmask compacted (without holes), so that each field
+ *                 contains node number. If NULL only num_allowed_nodes is
+ *                 returned, otherwise it cotains new allocated array,
+ *                 which caller is responsible to free.
+ * RETURNS:
+ *     0 on success
+ *    -1 on allocation failure
+ *    -2 on get_mempolicy failure
+ */
+int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes)
+{
+#if HAVE_NUMA_H
+	int i;
+	struct bitmask *allowed_nodemask = NULL;
+#endif
+	*num_allowed_nodes = 0;
+	if (allowed_nodes)
+		*allowed_nodes = NULL;
+
+#if HAVE_NUMA_H && HAVE_MPOL_CONSTANTS
+	if ((allowed_nodemask = numa_allocate_nodemask()) == NULL)
+		return -1;
+
+	if (allowed_nodes) {
+		*allowed_nodes = malloc(sizeof(int)*allowed_nodemask->size);
+		if (*allowed_nodes == NULL)
+			return -1;
+	}
+
+	/*
+	 * avoid numa_get_mems_allowed(), because of bug in getpol()
+	 * utility function in older versions:
+	 * http://www.spinics.net/lists/linux-numa/msg00849.html
+	 */
+	if (syscall(__NR_get_mempolicy, NULL, allowed_nodemask->maskp,
+		allowed_nodemask->size, 0, MPOL_F_MEMS_ALLOWED) < 0) {
+		numa_bitmask_free(allowed_nodemask);
+		if (allowed_nodes) {
+			free(*allowed_nodes);
+			*allowed_nodes = NULL;
+		}
+		return -2;
+	}
+
+	for (i = 0; i <	allowed_nodemask->size; i++) {
+		if (numa_bitmask_isbitset(allowed_nodemask, i)) {
+			if (allowed_nodes)
+				(*allowed_nodes)[*num_allowed_nodes] = i;
+			(*num_allowed_nodes)++;
+		}
+	}
+	numa_bitmask_free(allowed_nodemask);
+#endif
+	return 0;
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
+int get_allowed_nodes(int count, ...)
+{
+	int ret;
+	int i, *nodep;
+	va_list ap;
+	int num_nodes = 0;
+	int *nodes = NULL;
+
+	if ((ret = get_allowed_nodes_arr(&num_nodes, &nodes)) < 0)
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
diff --git a/testcases/kernel/syscalls/numa/lib/numa_helper.h b/testcases/kernel/syscalls/numa/lib/numa_helper.h
new file mode 100644
index 0000000..73b6513
--- /dev/null
+++ b/testcases/kernel/syscalls/numa/lib/numa_helper.h
@@ -0,0 +1,34 @@
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
+int get_allowed_nodes_arr(int *num_allowed_nodes, int **allowed_nodes);
+int get_allowed_nodes(int count, ...);
+
+#endif
+

--------------1.7.1
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
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



