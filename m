From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 30 Dec 2020 17:09:29 +0800
Subject: [LTP] [COMMITTED] lapi/sem.h: Adjust "sys/sem.h" position
Message-ID: <1609319369-8153-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/sem.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/lapi/sem.h b/include/lapi/sem.h
index 7cef3d5a7..8ba92de36 100644
--- a/include/lapi/sem.h
+++ b/include/lapi/sem.h
@@ -2,12 +2,11 @@
 /*
  * Copyright (c) 2015 Linux Test Project
  */
-
-#include <sys/sem.h>
-
 #ifndef LAPI_SEM_H
 #define LAPI_SEM_H
 
+#include <sys/sem.h>
+
 #if defined(__GNU_LIBRARY__) && !defined(_SEM_SEMUN_UNDEFINED)
 /* union semun is defined by including <sys/sem.h> */
 #else
-- 
2.23.0



