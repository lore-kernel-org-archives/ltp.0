From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 Jan 2020 15:58:05 +0100
Subject: [LTP] [PATCH] max_map_count: use default overcommit mode
Message-ID: <7a2d56fa03583ca7979cbe22a61ac648b3d6b6eb.1579877813.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

max_map_count has been observed to sporadically fail on some
architectures, for example ppc64le (64k pages, ~3GB RAM).

Even though we don't touch all the mappings, the test is configuring
NO_OVERCOMMIT policy, which makes __vm_enough_memory() more strict
and we sporadically fail on a percpu counter, when we come close
to global CommitLimit:
        if (percpu_counter_read_positive(&vm_committed_as) < allowed)
                return 0;

Per comments from 2012 the main reason for this was bad OOM behaviour.
Let's go back to default overcommit mode. If we run into issues with
OOM again, we can lower the number of mappings to have larger reserve.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/tunable/max_map_count.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index 5b03a60ec860..aa70fde59c77 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -65,7 +65,7 @@ static void setup(void)
 
 	old_max_map_count = get_sys_tune("max_map_count");
 	old_overcommit = get_sys_tune("overcommit_memory");
-	set_sys_tune("overcommit_memory", 2, 1);
+	set_sys_tune("overcommit_memory", 0, 1);
 
 	if (uname(&un) != 0)
 		tst_brk(TBROK | TERRNO, "uname error");
@@ -154,13 +154,8 @@ static void max_map_count_test(void)
 	 * 1) use a safe maximum max_map_count value as upper-bound,
 	 *    we set it 65536 in this case, i.e., we don't test too big
 	 *    value;
-	 * 2) make sure total mapping isn't larger tha
+	 * 2) make sure total mapping isn't larger than
 	 *        CommitLimit - Committed_AS
-	 *    and set overcommit_memory to 2, this could help mapping
-	 *    returns ENOMEM instead of triggering oom-killer when
-	 *    memory is tight. (When there are enough free memory,
-	 *    step 1) will be used first.
-	 * Hope OOM-killer can be more stable oneday.
 	 */
 	memfree = SAFE_READ_MEMINFO("CommitLimit:") - SAFE_READ_MEMINFO("Committed_AS:");
 	/* 64 used as a bias to make sure no overflow happen */
-- 
2.18.1

