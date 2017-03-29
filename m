From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 15:55:06 +0200
Subject: [LTP] [COMMITTED] [PATCH 4/4] lib/tst_safe_posix_ipc.c: Add licence.
In-Reply-To: <20170329135506.23901-1-chrubis@suse.cz>
References: <20170329135506.23901-1-chrubis@suse.cz>
Message-ID: <20170329135506.23901-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_safe_posix_ipc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/tst_safe_posix_ipc.c b/lib/tst_safe_posix_ipc.c
index d9fbf77..7142a25 100644
--- a/lib/tst_safe_posix_ipc.c
+++ b/lib/tst_safe_posix_ipc.c
@@ -1,3 +1,20 @@
+/*
+ * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
 #include <mqueue.h>
 #include <stdarg.h>
 
-- 
2.10.2

