From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 15:54:01 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls: shmctl/Makefile Fix.
Message-ID: <20200616135401.26590-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove fogotten LDLIBS.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmctl/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 252c11058..0172bb495 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -13,6 +13,4 @@ include $(top_srcdir)/include/mk/testcases.mk
 shmctl01 shmctl02 shmctl03 shmctl04 shmctl05: LDLIBS += -lltpipc
 shmctl06: LDLIBS += -lltpnewipc
 
-LDLIBS  += -lltpipc
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.26.2

