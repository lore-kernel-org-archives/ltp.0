From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Nov 2019 12:55:25 +0800
Subject: [LTP] [PATCH] mtest01: correct the ALLOC_THRESHOLD definition on
 s390x
Message-ID: <20191128045525.15454-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mtest01 hits a problem on s390x platform. The situation is that if children's
memory allocating is ongoing and the test remaining time is in an emergency, the
parent will break from the while loop and try to revoke children, obviously, it
doesn't have enough time to wait for the children's status change to 'T'. Then it
occurs timeout issue as below:

  mtest01.c:134: INFO: Filling up 80% of free ram which is 5868864 kbytes
  mtest01.c:149: INFO: ... child 38289 starting
  mtest01.c:149: INFO: ... child 38288 starting
  mtest01.c:208: WARN: the remaininig time is not enough for testing
  mtest01.c:218: FAIL: kbytes allocated (and written to) less than expected 5868864
  Test timeouted, sending SIGKILL!

The immediate cause is the memory allocating is too slow to finish fleetly on such
a small virtual s390x machine, because ALLOC_THRESHOLD does not take real effort.
Here let's correct the allocating threshold definition to make sure each child
allocates less memory.

And, another fix for the fail handling. In case children are still on memory
allocating, the remaining 15 seconds is not enough to wait for process status
change. We kill them directly to avoid test timeout occurring.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Rachel Sibley <rasibley@redhat.com>
---
 testcases/kernel/mem/mtest01/mtest01.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 960a2cef8..446d26897 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -33,7 +33,7 @@
 
 #define FIVE_HUNDRED_MB         (500ULL*1024*1024)
 
-#if defined(_s390_)
+#if defined(__s390__) || defined(__s390x__)
 #define ALLOC_THRESHOLD		FIVE_HUNDRED_MB
 #elif defined(TST_ABI32)
 #define ALLOC_THRESHOLD		(2*FIVE_HUNDRED_MB)
@@ -216,11 +216,16 @@ static void mem_test(void)
 	if (children_done < pid_cntr) {
 		tst_res(TFAIL, "kbytes allocated %sless than expected %llu",
 				write_msg, alloc_maxbytes / 1024);
-	} else {
-		tst_res(TPASS, "%llu kbytes allocated %s",
-				alloc_maxbytes / 1024, write_msg);
+
+		for (i = 0; i < pid_cntr; i++)
+			kill(pid_list[i], SIGKILL);
+
+		return;
 	}
 
+	tst_res(TPASS, "%llu kbytes allocated %s",
+			alloc_maxbytes / 1024, write_msg);
+
 	for (i = 0; i < pid_cntr; i++) {
 		TST_PROCESS_STATE_WAIT(pid_list[i], 'T');
 		kill(pid_list[i], SIGCONT);
-- 
2.20.1

