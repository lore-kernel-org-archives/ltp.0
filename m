From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Mon, 20 Aug 2018 15:49:14 -0400
Subject: [LTP]  [PATCH 4/5] acpi_hotplug: Add Makefile
In-Reply-To: <20180820194915.11805-1-msys.mizuma@gmail.com>
References: <20180820194915.11805-1-msys.mizuma@gmail.com>
Message-ID: <20180820194915.11805-5-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 .../kernel/hotplug/acpi_hotplug/Makefile      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 testcases/kernel/hotplug/acpi_hotplug/Makefile

diff --git a/testcases/kernel/hotplug/acpi_hotplug/Makefile b/testcases/kernel/hotplug/acpi_hotplug/Makefile
new file mode 100644
index 000000000..48c969b22
--- /dev/null
+++ b/testcases/kernel/hotplug/acpi_hotplug/Makefile
@@ -0,0 +1,26 @@
+#
+#    ACPI based CPU and Memory hotplug test suite Makefile.
+#    Copyright (c) 2018, FUJITSU LIMITED. All rights reserved.
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
+top_srcdir                      ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= *.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.18.0

