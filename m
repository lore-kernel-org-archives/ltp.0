From: Dong ZHu <bluezhudong@gmail.com>
Date: Tue, 7 Jun 2016 09:44:32 +0800
Subject: [LTP] [PATCH V3] controllers/memcg: Mark testcase_2 as pass when
 mlock failed
In-Reply-To: <20160606131653.GA21264@rei>
References: <CAAUgArC7-C7tc2W5gpwt9=U_=gcU98uiLJci3xnjHDXjk8mUxg@mail.gmail.com>
 <20160601090728.GA25827@localhost.localdomain>
 <20160601093652.GB19762@rei.lan>
 <20160602013657.GA8737@localhost.localdomain>
 <20160606131653.GA21264@rei>
Message-ID: <20160607014432.GA9918@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I refined the patch followed by your suggestion, below is the latest
version:

---8<---

While running "memcg_memsw_limit_in_bytes_test" always reported below error:
"memcg_memsw_limit_in_bytes_test 2 TFAIL : ltpapicmd.c:193: process 3769
is killed by error"

In function mmap_lock2() mlock failed to lock pages with errno EAGAIN,
the "memcg_process" process exit not the oom killer kill it.

And base on this:
http://marc.info/?l=linux-mm&m=142122902313315&w=2

So mlock failed it is a expect behavior, in this case test should return
PASS.

Signed-off-by: Dong Zhu <bluezhudong@gmail.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh    | 5 ++++-
 testcases/kernel/controllers/memcg/functional/memcg_process.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 9b9b0fd..c90d0a2 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -229,8 +229,11 @@ test_proc_kill()
 	ps -p $pid > /dev/null 2> /dev/null
 	if [ $? -ne 0 ]; then
 		wait $pid
-		if [ $? -eq 1 ]; then
+		ret=$?
+		if [ $ret -eq 1 ]; then
 			result $FAIL "process $pid is killed by error"
+		elif [ $ret -eq 2 ]; then
+			result $PASS "Failed to lock memory"
 		else
 			result $PASS "process $pid is killed"
 		fi
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index 3d34394..c12fae1 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -203,8 +203,12 @@ void mmap_lock2()
 		if (p == MAP_FAILED)
 			err(1, "mmap failed");
 
-		if (mlock(p, memsize) == -1)
-			err(1, "mlock failed");
+		if (mlock(p, memsize) == -1) {
+			if (errno == EAGAIN)
+				exit(2);
+			else
+				err(1, "mlock failed");
+		}
 	} else {
 		if (munmap(p, memsize) == -1)
 			err(1, "munmap failed");
-- 
2.1.0

-- 
Best Regards,
Dong Zhu
