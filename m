From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Apr 2020 14:40:30 +0200
Subject: [LTP] [COMMITTED] [PATCH] pty/Makefile: The -lrt has to go to LDLIBS
Message-ID: <20200408124030.9058-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: a49448f1b41b ("pty03: Add -lrt into LDFLAGS")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/pty/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
index ca2ba5507..4469775aa 100644
--- a/testcases/kernel/pty/Makefile
+++ b/testcases/kernel/pty/Makefile
@@ -25,6 +25,6 @@ top_srcdir		?= ../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 pty03: CFLAGS += -pthread
-pty03: LDFLAGS += -lrt
+pty03: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.24.1

