From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  8 Jan 2018 14:17:22 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/1] m4: Export HOST_CPU for make
Message-ID: <20180108131722.7615-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac            |  1 +
 include/mk/config.mk.in |  2 ++
 m4/ltp-host-cpu.m4      | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 m4/ltp-host-cpu.m4

diff --git a/configure.ac b/configure.ac
index 16c8e4692..5c8d4eaf8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -203,5 +203,6 @@ LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_X_TABLES
 LTP_CHECK_ATOMIC_MEMORY_MODEL
 LTP_CHECK_TPACKET_V3
+LTP_DETECT_HOST_CPU
 
 AC_OUTPUT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 8c4f9da82..01f178bff 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -81,6 +81,8 @@ LINUX_VERSION_MAJOR	:= @LINUX_VERSION_MAJOR@
 LINUX_VERSION_PATCH	:= @LINUX_VERSION_PATCH@
 WITH_MODULES		:= @WITH_MODULES@
 
+HOST_CPU		:= @HOST_CPU@
+
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
 endif
diff --git a/m4/ltp-host-cpu.m4 b/m4/ltp-host-cpu.m4
new file mode 100644
index 000000000..2536047fb
--- /dev/null
+++ b/m4/ltp-host-cpu.m4
@@ -0,0 +1,25 @@
+dnl Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+AC_DEFUN([LTP_DETECT_HOST_CPU], [
+AC_SUBST([HOST_CPU], [$host_cpu])
+AS_CASE([$host_cpu],
+  [amd64], [HOST_CPU=x86_64],
+  [arm*], [HOST_CPU=arm],
+  [i?86|x86], [HOST_CPU=x86],
+  [s390*], [HOST_CPU=s390],
+)
+AC_SUBST([HOST_CPU])
+])
-- 
2.15.1

