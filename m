From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 12 Apr 2017 11:34:01 +0800
Subject: [LTP] [PATCH 1/2] lapi/seek.h: fix typo for SEEK_DATA
Message-ID: <1491968042-5173-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on RHEL6.9GA because SEEK_DATA is not defined.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/seek.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/lapi/seek.h b/include/lapi/seek.h
index fe1999f..023f1fb 100644
--- a/include/lapi/seek.h
+++ b/include/lapi/seek.h
@@ -20,8 +20,8 @@
 
 #include <unistd.h>
 
-#ifndef DATA_HOLE
-# define DATA_HOLE 4
+#ifndef SEEK_DATA
+# define SEEK_DATA 3
 #endif
 
 #ifndef SEEK_HOLE
-- 
1.8.3.1



