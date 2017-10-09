From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  9 Oct 2017 13:00:58 +0200
Subject: [LTP] [RFC PATCH v2 4/7] m4: Simplify check for linux/keyctl.h
	header
In-Reply-To: <20171009110101.3329-1-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
Message-ID: <20171009110101.3329-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac     |  2 +-
 m4/ltp-keyctl.m4 | 25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)
 delete mode 100644 m4/ltp-keyctl.m4

diff --git a/configure.ac b/configure.ac
index c99b1540e..4eb61e070 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,6 +39,7 @@ AC_CHECK_HEADERS([ \
     keyutils.h \
     linux/can.h \
     linux/genetlink.h \
+    linux/keyctl.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
@@ -180,7 +181,6 @@ LTP_CHECK_SPLICE
 LTP_CHECK_VMSPLICE
 LTP_CHECK_TIMERFD
 LTP_CHECK_IOVEC
-LTP_CHECK_KEYCTL
 LTP_CHECK_LINUXRANDOM
 LTP_CHECK_IF_LINK
 LTP_CHECK_KCMP
diff --git a/m4/ltp-keyctl.m4 b/m4/ltp-keyctl.m4
deleted file mode 100644
index 6a239ca64..000000000
--- a/m4/ltp-keyctl.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) 2014 Linux Test Project
-dnl
-dnl This program is free software; you can redistribute it and/or
-dnl modify it under the terms of the GNU General Public License as
-dnl published by the Free Software Foundation; either version 2 of
-dnl the License, or (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it would be useful,
-dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-dnl GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program; if not, write the Free Software Foundation,
-dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-dnl
-
-dnl
-dnl LTP_CHECK_KEYCTL
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_KEYCTL],[
-AC_CHECK_HEADERS([linux/keyctl.h])
-])
-- 
2.14.2

