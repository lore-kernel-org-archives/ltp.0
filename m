From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Sep 2021 15:08:18 +0200
Subject: [LTP] [PATCH v2 5/7] sched/.gitignore: Ignore logs
In-Reply-To: <20210910130820.21141-1-pvorel@suse.cz>
References: <20210910130820.21141-1-pvorel@suse.cz>
Message-ID: <20210910130820.21141-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/sched/process_stress/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/sched/process_stress/.gitignore b/testcases/kernel/sched/process_stress/.gitignore
index b2d4946e6..d05d23b94 100644
--- a/testcases/kernel/sched/process_stress/.gitignore
+++ b/testcases/kernel/sched/process_stress/.gitignore
@@ -1 +1,2 @@
 /process
+/*.log
-- 
2.33.0

