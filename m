From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 19 Jan 2021 14:40:57 +0100
Subject: [LTP] [PATCH] Reduce ksm06 memory footprint
Message-ID: <20210119134057.17785-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allocating 10,000 pages requires over 600MB on PPC64. This may result in some
pages being pushed to swap even if the test machine has 1GB of RAM per NUMA
node. Reduce memory footprint a little to avoid bogus failures.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/mm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/mm b/runtest/mm
index 481d39691..eeebd878e 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -70,7 +70,7 @@ ksm04_1 ksm04 -u 128
 ksm05 ksm05 -I 10
 ksm06 ksm06
 ksm06_1 ksm06 -n 10
-ksm06_2 ksm06 -n 10000
+ksm06_2 ksm06 -n 8000
 
 cpuset01 cpuset01
 
-- 
2.29.2

