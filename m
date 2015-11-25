From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 25 Nov 2015 12:44:31 +0100
Subject: [LTP] [PATCH] mem/oom: don't fail if pthread_create hits EAGAIN
Message-ID: <3c782728d90f07391df826231c7327a2ddf38540.1448451542.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a rare situation on system with many CPUs, small RAM
and overcommit_memory == 2, threads that are already started
can create memory pressure, that causes pthread_create
to hit EAGAIN. Don't fail the test, keep going with threads
that are already spawned.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 215c0527d068..cee4e91fb89f 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -90,7 +90,12 @@ static void child_alloc(int testcase, int lite, int threads)
 			(void *)((long)testcase)));
 		if (TEST_RETURN) {
 			tst_resm(TINFO | TRERRNO, "pthread_create");
-			goto out;
+			/*
+			 * Keep going if thread other than first fails to
+			 * spawn due to lack of resources.
+			 */
+			if (i == 0 || TEST_RETURN != EAGAIN)
+				goto out;
 		}
 	}
 
-- 
1.8.3.1

