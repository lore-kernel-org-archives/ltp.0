From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 14 Apr 2019 12:26:22 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_safe_posix_ipc.h: Replace
	definition ANDROID with __ANDROID__
Message-ID: <20190414102622.27343-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

Based on previous discussion on commit be944db1f and [1].

+ use SPDX-License-Identifier.

[1] https://groups.google.com/forum/#!topic/android-ndk/cf9_f1SLXls

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 include/tst_safe_posix_ipc.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
index b089f01b0..d74ef4ee8 100644
--- a/include/tst_safe_posix_ipc.h
+++ b/include/tst_safe_posix_ipc.h
@@ -1,24 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (C) 2017 Petr Vorel pvorel@suse.cz
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * Copyright (C) 2017-2019 Petr Vorel pvorel@suse.cz
  */
 
 #ifndef TST_SAFE_POSIX_IPC_H__
@@ -43,7 +25,7 @@ static inline int safe_mq_open(const char *file, const int lineno,
 	/* Android's NDK's mode_t is smaller than an int, which results in
 	 * SIGILL here when passing the mode_t type.
 	 */
-#ifndef ANDROID
+#ifndef __ANDROID__
 	mode = va_arg(ap, mode_t);
 #else
 	mode = va_arg(ap, int);
-- 
2.20.1

