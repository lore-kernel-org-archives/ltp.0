From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jul 2019 11:29:45 +0200
Subject: [LTP] [COMMITTED] [PATCH] snd_timer01: Fix compilation
Message-ID: <20190715092945.14175-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On a few older distributions the timer functions used in fuzzy sync
library needs -lrt and also -pthread has to be in CFLAGS instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/sound/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/sound/Makefile b/testcases/kernel/sound/Makefile
index ad1e25c30..9abcc2b27 100644
--- a/testcases/kernel/sound/Makefile
+++ b/testcases/kernel/sound/Makefile
@@ -6,7 +6,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CPPFLAGS		+= -D_GNU_SOURCE
 
-LDLIBS			+= -pthread
-
+snd_timer01: CFLAGS+=-pthread
+snd_timer01: LDLIBS+=-lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.21.0

