From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Jun 2021 19:15:09 +0800
Subject: [LTP] [PATCH 2/2] oom: enable lite == 1 for memory.swap.max testing
In-Reply-To: <20210621111509.358656-1-liwang@redhat.com>
References: <20210621111509.358656-1-liwang@redhat.com>
Message-ID: <20210621111509.358656-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

oom03: adding print info and restore memory.swap.max after testing
oom05: enable lite == 1 for memory.swap.max testing

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/oom/oom03.c | 7 +++++++
 testcases/kernel/mem/oom/oom05.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 939413744..8d78f3d26 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -46,8 +46,15 @@ static void verify_oom(void)
 	testoom(0, 0, ENOMEM, 1);
 
 	if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
+		tst_res(TINFO, "OOM on MEMCG with special memswap limitation:");
 		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
+
 		testoom(0, 1, ENOMEM, 1);
+
+		if (TST_CGROUP_VER(cg, "memory") == TST_CGROUP_V1)
+			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", ~0UL);
+		else
+			SAFE_CGROUP_PRINT(cg, "memory.swap.max", "max");
 	}
 
 	/* OOM for MEMCG with mempolicy */
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 9c9bba7f6..a25dc6560 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -64,7 +64,7 @@ static void verify_oom(void)
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
 		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
-		testoom(0, 0, ENOMEM, 1);
+		testoom(0, 1, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-- 
2.31.1

