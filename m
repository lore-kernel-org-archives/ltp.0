From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Mar 2019 16:05:40 +0100
Subject: [LTP] [COMMITTED] [PATCH] syscalls/set_mempolicy04: Fix mistake
Message-ID: <20190312150540.23077-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I've accidentally left the number of numa nodes hardcoded in the
computation so this test was failing on anything but machines with
three nodes.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
index 8d8aa988d..32d7b7f41 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
@@ -77,8 +77,8 @@ static void alloc_and_check(void)
 
 	for (i = 0; i < nodes->cnt; i++) {
 		float treshold = 1.00 * total_pages / 60; /* five percents */
-		float min_pages = 1.00 * total_pages / 3 - treshold;
-		float max_pages = 1.00 * total_pages / 3 + treshold;
+		float min_pages = 1.00 * total_pages / nodes->cnt - treshold;
+		float max_pages = 1.00 * total_pages / nodes->cnt + treshold;
 
 		if (nodes->counters[i] > min_pages && nodes->counters[i] < max_pages) {
 			tst_res(TPASS, "Node %u allocated %u <%.2f,%.2f>",
-- 
2.19.2

