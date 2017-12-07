From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  7 Dec 2017 18:25:51 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] syscalls/mknodat: Fix missing config
Message-ID: <20171207172551.13876-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Found by buildroot project, where this broke build on uClibc-ng, thanks!
http://autobuild.buildroot.net/results/6c0506423c76b61018da26c2549570e3d9eb5763/build-end.log

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mknodat/mknodat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/mknodat/mknodat.h b/testcases/kernel/syscalls/mknodat/mknodat.h
index 577d5ac9c..b4e828c5d 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat.h
+++ b/testcases/kernel/syscalls/mknodat/mknodat.h
@@ -22,6 +22,7 @@
 #define MKNODAT_H
 
 #include <sys/types.h>
+#include "config.h"
 #include "lapi/syscalls.h"
 
 #if !defined(HAVE_MKNODAT)
-- 
2.15.0

