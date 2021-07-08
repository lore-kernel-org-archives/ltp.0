From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  8 Jul 2021 11:18:05 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/wait403: Fix docparse comment
Message-ID: <20210708091805.23783-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reported-by: Yang Xu <xuyang2018.jy@fujitsu.com
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/wait4/wait403.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/wait4/wait403.c b/testcases/kernel/syscalls/wait4/wait403.c
index bbd240770..8746794e5 100644
--- a/testcases/kernel/syscalls/wait4/wait403.c
+++ b/testcases/kernel/syscalls/wait4/wait403.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
  */
 
-/*
+/*\
  * [Description]
  *
  * Check wait4(INT_MIN, ...) is not allowed. The pid is negated before
-- 
2.31.1

