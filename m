From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:26:29 +0200
Subject: [LTP] [PATCH v2 3/9] controllers: Simplify fullpath definition
In-Reply-To: <20200415112635.14144-1-pvorel@suse.cz>
References: <20200415112635.14144-1-pvorel@suse.cz>
Message-ID: <20200415112635.14144-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

PATH_MAX has been in <limits.h> in all libc for a long time.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/libcontrollers/libcontrollers.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/kernel/controllers/libcontrollers/libcontrollers.h b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
index cdde9f9e6..f999f705e 100644
--- a/testcases/kernel/controllers/libcontrollers/libcontrollers.h
+++ b/testcases/kernel/controllers/libcontrollers/libcontrollers.h
@@ -42,11 +42,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#ifdef PATH_MAX
 char fullpath[PATH_MAX];
-#else
-char fullpath[1024]; /* Guess */
-#endif
 
 int FLAG;
 volatile int timer_expired;
-- 
2.26.0

