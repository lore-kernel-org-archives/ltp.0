From: Michael Moese <mmoese@suse.de>
Date: Thu, 25 Jan 2018 16:22:59 +0100
Subject: [LTP] [PATCH 05/10] fix old-style-definition in hackbench.c
In-Reply-To: <20180125152304.32747-1-mmoese@suse.de>
References: <20180125152304.32747-1-mmoese@suse.de>
Message-ID: <20180125152304.32747-6-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sched/cfs-scheduler/hackbench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
index c7b7e0c16..6f37060aa 100644
--- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
+++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
@@ -92,7 +92,7 @@ static void barf(const char *msg)
 	exit(1);
 }
 
-static void print_usage_exit()
+static void print_usage_exit(void)
 {
 	printf
 	    ("Usage: hackbench [-pipe] <num groups> [process|thread] [loops]\n");
-- 
2.13.6

