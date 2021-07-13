From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 12:13:34 +0200
Subject: [LTP] [PATCH v4 3/7] tst_strstatus.c: Use musl compatible status
 number
In-Reply-To: <20210713101338.6985-1-pvorel@suse.cz>
References: <20210713101338.6985-1-pvorel@suse.cz>
Message-ID: <20210713101338.6985-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

musl since commit 41c632824c08 ("fix definitions of WIFSTOPPED and
WIFSIGNALED to support up to signal 127") returns 1 on
WIFSIGNALED(0xff). Thus test with WIFSIGNALED(0x1ff), which is
compatible for both glibc and musl.

Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 lib/newlib_tests/tst_strstatus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/newlib_tests/tst_strstatus.c b/lib/newlib_tests/tst_strstatus.c
index aeeeb77ed..f8655fe82 100644
--- a/lib/newlib_tests/tst_strstatus.c
+++ b/lib/newlib_tests/tst_strstatus.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
  */
 
 /*
@@ -18,7 +19,7 @@ static struct tcase {
 	{0x0001, "killed by SIGHUP"},
 	{0x137f, "is stopped"},
 	{0xffff, "is resumed"},
-	{0xff, "invalid status 0xff"},
+	{0x1ff, "invalid status 0x1ff"},
 };
 
 static void do_test(unsigned int n)
-- 
2.32.0

