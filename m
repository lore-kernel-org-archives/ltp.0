From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  7 Sep 2020 17:01:52 +0200
Subject: [LTP] [PATCH v2 05/10] syscalls/ipc: shmctl05 remove lib dependency
In-Reply-To: <20200907150157.23886-1-chrubis@suse.cz>
References: <20200907150157.23886-1-chrubis@suse.cz>
Message-ID: <20200907150157.23886-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The shmctl05 does not need any SHM library.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmctl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/Makefile b/testcases/kernel/syscalls/ipc/shmctl/Makefile
index 789fd4227..9d535014f 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmctl/Makefile
@@ -10,7 +10,7 @@ shmctl05: LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/testcases.mk
 
-shmctl01 shmctl05: LTPLDLIBS = -lltpipc
+shmctl01: LTPLDLIBS = -lltpipc
 shmctl02 shmctl04 shmctl06: LTPLDLIBS = -lltpnewipc
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
2.26.2

