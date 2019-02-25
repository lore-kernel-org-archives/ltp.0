From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Feb 2019 00:43:59 +0100
Subject: [LTP] [PATCH 2/2] lapi/posix_clocks.h: Include <time.h> before
	definitions
In-Reply-To: <20190225234359.8165-1-pvorel@suse.cz>
References: <20190225234359.8165-1-pvorel@suse.cz>
Message-ID: <20190225234359.8165-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ minor formatting fixes (include guards, copyright).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/posix_clocks.h | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/lapi/posix_clocks.h b/include/lapi/posix_clocks.h
index 7819bb9c0..0d1f0e99c 100644
--- a/include/lapi/posix_clocks.h
+++ b/include/lapi/posix_clocks.h
@@ -1,23 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) 2019, Linux Test Project
  * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#ifndef __POSIX_CLOCK_IDS_H__
-#define __POSIX_CLOCK_IDS_H__
+#include <time.h>
+
+#ifndef POSIX_CLOCKS_H__
+#define POSIX_CLOCKS_H__
 
 #ifndef CLOCK_MONOTONIC_RAW
 # define CLOCK_MONOTONIC_RAW 4
@@ -43,4 +33,4 @@
 # define CLOCK_BOOTTIME_ALARM 9
 #endif
 
-#endif /* __POSIX_CLOCK_IDS_H__ */
+#endif /* POSIX_CLOCKS_H__ */
-- 
2.20.1

