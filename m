From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 26 Sep 2017 17:29:49 +0800
Subject: [LTP] [PATCH 1/2] configure: Add configure check for GCC -no-pie
Message-ID: <20170926092950.10856-1-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Signed-off-by: Fei Jie <feij.fnst@cn.fujitsu.com>
---
 configure.ac            |  1 +
 include/mk/config.mk.in |  1 +
 m4/ltp-no-pie.m4        | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 m4/ltp-no-pie.m4

diff --git a/configure.ac b/configure.ac
index 458a5b1..e30fd69 100644
--- a/configure.ac
+++ b/configure.ac
@@ -135,6 +135,7 @@ AC_CONFIG_COMMANDS([syscalls.h], [cd include/lapi/syscalls; ./regen.sh])
 # END testsuites knobs
 LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_CC_WARN_OLDSTYLE
+LTP_CHECK_CC_NO_PIE
 LTP_CHECK_MKDTEMP
 LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CRYPTO
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index dde2a9e..4fe380d 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -71,6 +71,7 @@ OPT_CXXFLAGS		?= $(OPT_CFLAGS)
 
 WCFLAGS			?= -Wall -W @GCC_WARN_OLDSTYLE@
 WCXXFLAGS		?= $(WCFLAGS)
+NOPIEFLAGS		?= @GCC_NO_PIE@
 
 LDFLAGS			+= $(WLDFLAGS)
 CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
diff --git a/m4/ltp-no-pie.m4 b/m4/ltp-no-pie.m4
new file mode 100644
index 0000000..608b70f
--- /dev/null
+++ b/m4/ltp-no-pie.m4
@@ -0,0 +1,37 @@
+dnl Copyright (c) 2017 FUJITSU LIMITED
+dnl
+dnl This program is free software; you can redistribute it and/or
+dnl modify it under the terms of the GNU General Public License as
+dnl published by the Free Software Foundation; either version 2 of
+dnl the License, or (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it would be useful,
+dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+dnl GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program; if not, see <http://www.gnu.org/licenses/>.
+dnl
+dnl Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+dnl
+
+AC_DEFUN([LTP_CHECK_CC_NO_PIE],[dnl
+
+pflag="-no-pie"
+AC_MSG_CHECKING([if $CC supports $pflag])
+
+backup_cflags="$CFLAGS"
+CFLAGS="$CFLAGS $pflag"
+
+AC_LINK_IFELSE(
+	[AC_LANG_PROGRAM([])],
+	[GCC_NO_PIE="$pflag"]
+	[AC_MSG_RESULT([yes])],
+	[AC_MSG_RESULT([no])]
+)
+
+AC_SUBST(GCC_NO_PIE)
+CFLAGS="$backup_cflags"
+
+])
-- 
2.9.5



