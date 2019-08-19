From: Yixin Zhang <yixin.zhang@intel.com>
Date: Mon, 19 Aug 2019 14:59:28 +0800
Subject: [LTP] [PATCH ltp] testcases/kernel/Makefile: remove 'timer' from
 Android FILTER_OUT_DIRS
Message-ID: <20190819065928.26939-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'timer' folder is removed in 0051eab232e7f777f435945b1aba8911f203d65b.
Remove it from FILTER_OUT_DIRS for Android

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 1a6a79be0..03ea25375 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -63,7 +63,7 @@ endif
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_DIRS		+= containers controllers device-drivers fs io ipc mem \
-				sched security timers
+				sched security
 endif
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
-- 
2.17.1

