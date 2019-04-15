From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 15 Apr 2019 15:21:29 +0200
Subject: [LTP] [COMMITTED][PATCH 1/1] tst_test.h: Include <string.h> to fix
	missing function declaration
Message-ID: <20190415132129.23429-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes build errors caused by -Werror-implicit-function-declaration
defined for android. There are many places, where missing <string.h> is
needed for memory and string related functions (see [1]). Including
headers here seems to be better than handling implicit function
declaration error every now and then.

There are few other headers missing, most notably <strings.h>. As this
header is deprecated, these should be replaced by these <string.h>.
Other headers (e.g. <stdlib.h>) should be manually added.

+ update copyright, use SPDX-License-Identifier.

[1] http://lists.linux.it/pipermail/ltp/2019-April/011655.html

Suggested-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index cf2447fe3..e4b935c45 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -1,18 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Linux Test Project, 2016-2019
  */
 
 #ifndef TST_TEST_H__
@@ -24,6 +13,7 @@
 
 #include <unistd.h>
 #include <limits.h>
+#include <string.h>
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
-- 
2.20.1

