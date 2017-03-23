From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 23 Mar 2017 16:26:49 +0100
Subject: [LTP] [PATCH 4/4] Add CVE .gitignore, Makefile and runtest files
Message-ID: <20170323162649.33890c67@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve              |  5 +++++
 runtest/syscalls         |  2 ++
 scenario_groups/default  |  1 +
 testcases/cve/.gitignore |  3 +++
 testcases/cve/Makefile   | 24 ++++++++++++++++++++++++
 5 files changed, 35 insertions(+)
 create mode 100644 runtest/cve
 create mode 100644 testcases/cve/.gitignore
 create mode 100644 testcases/cve/Makefile

diff --git a/runtest/cve b/runtest/cve
new file mode 100644
index 000000000..83b53d906
--- /dev/null
+++ b/runtest/cve
@@ -0,0 +1,5 @@
+# Tests which check for vulnerabilities by CVE number
+cve-2012-0957 cve-2012-0957
+cve-2016-4997 cve-2016-4997
+cve-2016-5195 dirtyc0w
+cve-2016-7117 cve-2016-7117
diff --git a/runtest/syscalls b/runtest/syscalls
index 84930caf7..16048db9b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1138,6 +1138,7 @@ set_tid_address01 set_tid_address01
 setsid01 setsid01
 
 setsockopt01 setsockopt01
+cve-2016-4997 cve-2016-4997
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
@@ -1349,6 +1350,7 @@ umask01 umask01
 uname01 uname01
 uname02 uname02
 uname03 uname03
+cve-2012-0957 cve-2012-0957
 
 unlink01 symlink01 -T unlink01
 unlink05 unlink05
diff --git a/scenario_groups/default b/scenario_groups/default
index b0d770171..5658a618b 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -32,3 +32,4 @@ can
 cpuhotplug
 net.ipv6_lib
 input
+cve
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
new file mode 100644
index 000000000..9c24b83ec
--- /dev/null
+++ b/testcases/cve/.gitignore
@@ -0,0 +1,3 @@
+cve-2012-0957
+cve-2016-4997
+cve-2016-7117
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
new file mode 100644
index 000000000..42225ac58
--- /dev/null
+++ b/testcases/cve/Makefile
@@ -0,0 +1,24 @@
+# Copyright (c) 2017 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+cve-2016-7117:	LDFLAGS += -lpthread
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.12.0
