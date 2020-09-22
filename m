From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 22 Sep 2020 12:55:07 +0200
Subject: [LTP] [PATCH] Fix top_srcdir handling in numa/sound test Makefiles
Message-ID: <20200922105507.18079-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/numa/Makefile  | 18 ++----------------
 testcases/kernel/sound/Makefile |  2 +-
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/numa/Makefile b/testcases/kernel/numa/Makefile
index 48494e456..2c6a7c6a1 100644
--- a/testcases/kernel/numa/Makefile
+++ b/testcases/kernel/numa/Makefile
@@ -1,22 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #
 #  Copyright (c) International Business Machines  Corp., 2007
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
 
-top_srcdir		:= ../../..
+top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
diff --git a/testcases/kernel/sound/Makefile b/testcases/kernel/sound/Makefile
index 022e69197..5c728ef36 100644
--- a/testcases/kernel/sound/Makefile
+++ b/testcases/kernel/sound/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-top_srcdir		:= ../../..
+top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-- 
2.28.0

