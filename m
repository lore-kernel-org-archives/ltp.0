From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  9 Oct 2017 13:00:57 +0200
Subject: [LTP] [RFC PATCH v2 3/7] m4: Simplify check for linux/can.h header
In-Reply-To: <20171009110101.3329-1-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
Message-ID: <20171009110101.3329-4-pvorel@suse.cz>
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
index e9c61ef78..c99b1540e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,6 +37,7 @@ AC_CHECK_HEADERS([ \
     pthread.h \
     sys/xattr.h \
     keyutils.h \
+    linux/can.h \
     linux/genetlink.h \
     linux/mempolicy.h \
     linux/module.h \
@@ -178,7 +179,6 @@ LTP_CHECK_TEE
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

