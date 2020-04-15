From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Apr 2020 13:26:31 +0200
Subject: [LTP] [PATCH v2 5/9] kernel/mem: Fix linking error with -fno-common
In-Reply-To: <20200415112635.14144-1-pvorel@suse.cz>
References: <20200415112635.14144-1-pvorel@suse.cz>
Message-ID: <20200415112635.14144-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Adding missing extern.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/include/mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index a12c2231f..cce9c0497 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -37,7 +37,7 @@ static inline void clean_node(unsigned long *array)
 #define MLOCK			2
 #define KSM			3
 
-long overcommit;
+extern long overcommit;
 void oom(int testcase, int lite, int retcode, int allow_sigkill);
 void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
 
-- 
2.26.0

