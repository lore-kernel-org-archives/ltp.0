From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 28 Jul 2021 13:34:12 +0100
Subject: [LTP] [PATCH v3 8/8] API/tst_tsc: Add guards and remove some
 boilerplate
In-Reply-To: <20210728123412.31858-1-rpalethorpe@suse.com>
References: <20210728123412.31858-1-rpalethorpe@suse.com>
Message-ID: <20210728123412.31858-9-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_tsc.h | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/tst_tsc.h b/include/tst_tsc.h
index 9ad5fd659..3f49a6ca7 100644
--- a/include/tst_tsc.h
+++ b/include/tst_tsc.h
@@ -1,28 +1,6 @@
-/******************************************************************************
- *
- *   Copyright ? International Business Machines  Corp., 2006-2008
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * NAME
- *       libtsc.h
- *
- * DESCRIPTION
- *
- * USAGE:
- *       To be included in some testcases.
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright ? International Business Machines  Corp., 2006-2008
  *
  * AUTHOR
  *        Darren Hart <dvhltc@us.ibm.com>
@@ -30,8 +8,10 @@
  *
  * HISTORY
  *      It directly comes from the librttest.h (see its HISTORY).
- *
- *****************************************************************************/
+ */
+
+#ifndef TST_TSC_H
+#define TST_TSC_H
 
 #undef TSC_UNSUPPORTED
 
@@ -70,3 +50,4 @@
 #define TSC_UNSUPPORTED
 #endif
 
+#endif
-- 
2.31.1

