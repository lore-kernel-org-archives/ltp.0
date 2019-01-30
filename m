From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Jan 2019 16:16:23 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/clock_settime: Fix linking on
	older distros
Message-ID: <20190130151623.25334-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Older distributions require -lrt for clock_* syscalls.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/clock_settime/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_settime/Makefile b/testcases/kernel/syscalls/clock_settime/Makefile
index e6674a6b2..d1cf993dc 100644
--- a/testcases/kernel/syscalls/clock_settime/Makefile
+++ b/testcases/kernel/syscalls/clock_settime/Makefile
@@ -5,4 +5,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+LDLIBS+=-lrt
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.19.2

