From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Mar 2017 16:51:20 +0200
Subject: [LTP] [PATCH 1/1] realtime: Fix include for out-of-tree build
Message-ID: <20170329145120.1389-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/realtime/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/realtime/lib/Makefile b/testcases/realtime/lib/Makefile
index 9a29ee7ce..71d73dd4b 100644
--- a/testcases/realtime/lib/Makefile
+++ b/testcases/realtime/lib/Makefile
@@ -25,7 +25,7 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CFLAGS			+= -D_GNU_SOURCE -I../include/
+CFLAGS			+= -D_GNU_SOURCE -I$(top_srcdir)/testcases/realtime/include/ -I$(top_builddir)/testcases/realtime/include/
 
 LDLIBS			+= -lpthread -lrt -lm
 
-- 
2.12.0

