From: Dong ZHu <bluezhudong@gmail.com>
Date: Wed, 1 Jun 2016 17:07:28 +0800
Subject: [LTP] [Re-Send][PATCH] controllers/memcg: Mark testcase_2 as pass
 when mlock failed
In-Reply-To: <CAAUgArC7-C7tc2W5gpwt9=U_=gcU98uiLJci3xnjHDXjk8mUxg@mail.gmail.com>
References: <CAAUgArC7-C7tc2W5gpwt9=U_=gcU98uiLJci3xnjHDXjk8mUxg@mail.gmail.com>
Message-ID: <20160601090728.GA25827@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There was a format issue in former mail, re-send this patch as below:

--8<--

While running "memcg_memsw_limit_in_bytes_test" always reported below error:
"memcg_memsw_limit_in_bytes_test 2 TFAIL : ltpapicmd.c:193: process 3769
is killed by error"

In function mmap_lock2() mlock failed to lock pages with errno EAGAIN,
the "memcg_process" process exit not the oom killer kill it.

Base on the this:
http://marc.info/?l=linux-mm&m=142122902313315&w=2

So mlock failed it is a expect behavior, in this case test should return
PASS.

Signed-off-by: Dong Zhu <bluezhudong@gmail.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh    | 3 +++
 testcases/kernel/controllers/memcg/functional/memcg_process.c | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 9b9b0fd..2f889ab 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -229,8 +229,11 @@ test_proc_kill()
 	ps -p $pid > /dev/null 2> /dev/null
 	if [ $? -ne 0 ]; then
 		wait $pid
+		ret=$?
 		if [ $? -eq 1 ]; then
 			result $FAIL "process $pid is killed by error"
+		elif [[ $2 == "--mmap-lock2" ]] && [[ $ret -eq 0 ]]; then
+			result $PASS "process $pid exit, mlock failed to lock page return with errno EAGAIN"
 		else
 			result $PASS "process $pid is killed"
 		fi
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index 3d34394..dc33567 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -203,8 +203,12 @@ void mmap_lock2()
 		if (p == MAP_FAILED)
 			err(1, "mmap failed");
 
-		if (mlock(p, memsize) == -1)
-			err(1, "mlock failed");
+                if (mlock(p, memsize) == -1) {
+                        if (errno == EAGAIN)
+				flag_exit = 1;
+                        else
+				err(1, "mlock failed");
+                }
 	} else {
 		if (munmap(p, memsize) == -1)
 			err(1, "munmap failed");
-- 
2.1.0

-- 
Best Regards,
Dong Zhu
