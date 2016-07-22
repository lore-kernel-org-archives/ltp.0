From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:49 -0700
Subject: [LTP] [PATCH V3 16/23] Fix test_proc_kill hanging
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-16-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: George Nita <george.nita@enea.com>

Sometimes the signal is delivered to memcg_process before the framework took
into consideration its pid entered in the tasks. Fixed by delaying the signal
send command.

Signed-off-by: George Nita <george.nita@enea.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index c90d0a2..331e75b 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -220,8 +220,8 @@ test_proc_kill()
 
 	$TEST_PATH/memcg_process $2 -s $3 &
 	pid=$!
-	sleep 1
 	echo $pid > tasks
+	sleep 1
 
 	kill -s USR1 $pid 2> /dev/null
 	sleep 1
-- 
2.9.0

