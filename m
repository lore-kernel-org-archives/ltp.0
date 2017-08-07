From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Aug 2017 16:03:09 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/madvise07: Fix typo.
Message-ID: <20170807140309.2339-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise07.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index 29ac10e99..76adb2e06 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -53,7 +53,7 @@ static int maptypes[] = {
 static char *mapname(int maptype)
 {
 	switch (maptype) {
-	case MAP_PRIVATE: return "MAP_SHARED";
+	case MAP_PRIVATE: return "MAP_PRIVATE";
 	case MAP_PRIVATE | MAP_POPULATE: return "MAP_PRIVATE | MAP_POPULATE";
 	case MAP_SHARED: return "MAP_SHARED";
 	default:
-- 
2.13.0

