From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Jan 2020 16:46:59 +0100
Subject: [LTP] [COMMITTED] [PATCH] pty03: Add -lrt into LDFLAGS
Message-ID: <20200128154659.32399-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Older distributions needs -lrt for clock_* functions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/pty/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
index 88101a6b8..8fed1b510 100644
--- a/testcases/kernel/pty/Makefile
+++ b/testcases/kernel/pty/Makefile
@@ -27,5 +27,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 CPPFLAGS		+= -D_GNU_SOURCE
 
 pty03: CFLAGS += -pthread
+pty03: LDFLAGS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.23.0

