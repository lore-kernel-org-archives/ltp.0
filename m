From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Feb 2019 20:01:11 +0100
Subject: [LTP] [PATCH] fcntl36: make sure write threads complete at least 1
	loop
Message-ID: <815b921d8f5eeeabd65096c96c7572520b3287fb.1550862006.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A failure has been reported while this test ran on a 1 CPU KVM guest
with 4.20 kernel:
  ...
  fcntl36.c:303: INFO: OFD r/w lock vs POSIX read lock
  fcntl36.c:360: FAIL: Unexpected data offset 3072 value 1

I wasn't able to reproduce it, to test the theory that
one of write threads was given time on CPU only after
loop_flag changed. Which means it wasn't able to complete
a single iteration.

This patch makes sure that write threads make at least
one iteration.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl36.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 2942e4e6adc2..58a37e7bc562 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -95,7 +95,7 @@ static void *fn_ofd_w(void *arg)
 		.l_pid    = 0,
 	};
 
-	while (loop_flag) {
+	do {
 
 		memset(buf, wt, pa->length);
 
@@ -113,7 +113,7 @@ static void *fn_ofd_w(void *arg)
 			wt = pa->cnt;
 
 		sched_yield();
-	}
+	} while (loop_flag);
 
 	pthread_barrier_wait(&barrier);
 	SAFE_CLOSE(fd);
@@ -134,7 +134,7 @@ static void *fn_posix_w(void *arg)
 		.l_len    = pa->length,
 	};
 
-	while (loop_flag) {
+	do {
 
 		memset(buf, wt, pa->length);
 
@@ -152,7 +152,7 @@ static void *fn_posix_w(void *arg)
 			wt = pa->cnt;
 
 		sched_yield();
-	}
+	} while (loop_flag);
 
 	pthread_barrier_wait(&barrier);
 	SAFE_CLOSE(fd);
-- 
1.8.3.1

