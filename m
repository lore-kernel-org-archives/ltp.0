From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:21 +0200
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building cve-2017-5669
In-Reply-To: <20170902005926.15923-1-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
Message-ID: <20170902005926.15923-2-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

shmat() is not available on Android/Binder

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/cve/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 04abc1f9c..5119c67cf 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -28,4 +28,8 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
 cve-2017-2671:	CFLAGS += -pthread
 cve-2017-2671:	LDLIBS += -lrt
 
+ifeq ($(ANDROID),1)
+FILTER_OUT_MAKE_TARGETS	+= cve-2017-5669
+endif
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.14.0

