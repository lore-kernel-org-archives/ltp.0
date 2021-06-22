From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Jun 2021 20:25:37 +0800
Subject: [LTP] [PATCH v2 2/3] oom: enable lite == 1 for memory.swap.max
 testing
In-Reply-To: <20210622122538.402907-1-liwang@redhat.com>
References: <20210622122538.402907-1-liwang@redhat.com>
Message-ID: <20210622122538.402907-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

oom03: adding print info and restore memory.swap.max after testing
oom05: enable lite == 1 for memory.swap.max testing

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/oom/oom03.c | 6 ++++++
 testcases/kernel/mem/oom/oom05.c | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 89d7711a5..6728e1ddb 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -46,6 +46,7 @@ static void verify_oom(void)
 	testoom(0, 0, ENOMEM, 1);
 
 	if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
+		tst_res(TINFO, "OOM on MEMCG with special memswap limitation:");
 		/*
 		 * Cgroup v2 tracks memory and swap in separate, which splits
 		 * memory and swap counter. So with swappiness enable (default
@@ -63,6 +64,11 @@ static void verify_oom(void)
 			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
 
 		testoom(0, 1, ENOMEM, 1);
+
+		if (TST_CGROUP_VER(cg, "memory") == TST_CGROUP_V1)
+			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", ~0UL);
+		else
+			SAFE_CGROUP_PRINT(cg, "memory.swap.max", "max");
 	}
 
 	/* OOM for MEMCG with mempolicy */
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 9c9bba7f6..9e1cff312 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -63,8 +63,12 @@ static void verify_oom(void)
 	if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
-		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
-		testoom(0, 0, ENOMEM, 1);
+		if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
+			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", MB);
+		else
+			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
+
+		testoom(0, 1, ENOMEM, 1);
 
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"disabled memswap limitation:");
-- 
2.31.1

