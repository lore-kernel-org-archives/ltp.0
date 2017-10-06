From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Oct 2017 03:53:33 +0200
Subject: [LTP] [RFC PATCH 3/6] m4: Simplify check for linux/can.h header
In-Reply-To: <20171006015336.29972-1-pvorel@suse.cz>
References: <20171006015336.29972-1-pvorel@suse.cz>
Message-ID: <20171006015336.29972-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac  |  2 +-
 m4/ltp-can.m4 | 25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)
 delete mode 100644 m4/ltp-can.m4

diff --git a/configure.ac b/configure.ac
index 458a5b13f..56fc9248e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,6 +36,7 @@ AC_CHECK_HEADERS([ \
     mm.h \
     pthread.h \
     sys/xattr.h \
+    linux/can.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
@@ -176,7 +177,6 @@ LTP_CHECK_TEE
 LTP_CHECK_SPLICE
 LTP_CHECK_VMSPLICE
 LTP_CHECK_TIMERFD
-LTP_CHECK_CAN_SUPPORT
 LTP_CHECK_IOVEC
 LTP_CHECK_KEYCTL
 LTP_CHECK_LINUXRANDOM
diff --git a/m4/ltp-can.m4 b/m4/ltp-can.m4
deleted file mode 100644
index af437ef5e..000000000
--- a/m4/ltp-can.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_CAN_SUPPORT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_CAN_SUPPORT],[
-AC_CHECK_HEADERS([linux/can.h])
-])
-- 
2.14.2

