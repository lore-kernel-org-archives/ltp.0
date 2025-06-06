Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14CEC5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749207978; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=PmibjY0S6epxi3IFl2ZoN+yJYaSKcF6lRT+oRF1bm0A=;
 b=A++afG8l6T3pG6F7mVMeTiF7EBZfGhXqEKQuf9c5rXYV4XmJN+6Bi3i0PIlqGmZUZ4aWl
 arnKpK7JNnu1bX67cKf9HxRzXhul5y1cTzAoEAMj/B+rU04SXLkRle2bHSSEtzngvHZSool
 Ik9fgDwwRxNLtUV6lxMt+MibvlqoG9E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49A483C01FE
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:06:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B5E83C1A2E
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:05:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15118601551
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749207953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xegOkOTaLuDUKavpsT+gWrHG6pgN1rOzxHetR0lA+XY=;
 b=KsIhdkvWyChx2YdTajY+vTEyAioM06rp+aQuqbIASHvPeZiqxdMKYeAvM/47POnQ+t8oZ/
 4TUJCoaoqoa3NPjz7uSBc2JBcyyhRh7JKx96Kjzv9srPJdnQ7HZkYNhK9/LucOlSXkuqod
 N/vwNJHC4uOdrUhkY+E5/tGGwEAo8gk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-qdovklKaOHiAI0V-GivViw-1; Fri,
 06 Jun 2025 07:05:52 -0400
X-MC-Unique: qdovklKaOHiAI0V-GivViw-1
X-Mimecast-MFC-AGG-ID: qdovklKaOHiAI0V-GivViw_1749207951
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FDE219560B2
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:05:51 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4AB18002B3
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 11:05:49 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri,  6 Jun 2025 19:05:40 +0800
Message-ID: <20250606110541.220472-2-liwang@redhat.com>
In-Reply-To: <20250606110541.220472-1-liwang@redhat.com>
References: <20250606110541.220472-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e8BHjQWDAih6rx9I8UaMGUiIeL-ALzxWugBIitKUszg_1749207951
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] tst_atomic: Introduce tst_atomic_t and apply
 it consistently
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch introduces a new tst_atomic_t typedef (int32_t) to replace
direct usage of int in atomic operations across the test framework.

The changes ensure:

- Consistent 32-bit atomic operations across platforms
- Clearer intent for variables used in atomic contexts
- Better maintainability through centralized type definition
- Fixed declaration consistency in atomic APIs

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_atomic.h                          | 23 +++++++++++--------
 include/tst_fuzzy_sync.h                      |  6 ++---
 lib/newlib_tests/test08.c                     |  2 +-
 lib/newlib_tests/test09.c                     |  2 +-
 lib/newlib_tests/test15.c                     |  2 +-
 lib/newlib_tests/tst_fuzzy_sync01.c           |  2 +-
 lib/newlib_tests/tst_fuzzy_sync02.c           |  2 +-
 testcases/kernel/containers/pidns/pidns32.c   |  2 +-
 .../kernel/controllers/cgroup/cgroup_core03.c |  2 +-
 testcases/kernel/fs/fs_fill/fs_fill.c         |  2 +-
 testcases/kernel/fs/read_all/read_all.c       |  4 ++--
 testcases/kernel/io/ltp-aiodio/dio_read.c     |  2 +-
 testcases/kernel/mem/mtest06/mmap1.c          |  2 +-
 testcases/kernel/mem/mtest06/mmap3.c          |  2 +-
 .../kernel/syscalls/exit_group/exit_group01.c |  2 +-
 .../syscalls/futex/futex_cmp_requeue01.c      |  4 ++--
 .../syscalls/ipc/msgstress/msgstress01.c      |  2 +-
 testcases/kernel/syscalls/writev/writev03.c   |  2 +-
 .../func/sched_football/sched_football.c      |  4 ++--
 19 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/include/tst_atomic.h b/include/tst_atomic.h
index 7c320c633..57b6b6bd5 100644
--- a/include/tst_atomic.h
+++ b/include/tst_atomic.h
@@ -6,23 +6,26 @@
 #ifndef TST_ATOMIC_H__
 #define TST_ATOMIC_H__
 
+#include <stdint.h>
 #include "config.h"
 
+typedef int32_t tst_atomic_t;
+
 #if HAVE_ATOMIC_MEMORY_MODEL == 1
 
 /* Use __atomic built-ins (GCC >= 4.7), with sequential consistency. */
 
-static inline int tst_atomic_add_return(int i, int *v)
+static inline int tst_atomic_add_return(int32_t i, tst_atomic_t *v)
 {
 	return __atomic_add_fetch(v, i, __ATOMIC_SEQ_CST);
 }
 
-static inline int tst_atomic_load(int *v)
+static inline int32_t tst_atomic_load(tst_atomic_t *v)
 {
 	return __atomic_load_n(v, __ATOMIC_SEQ_CST);
 }
 
-static inline void tst_atomic_store(int i, int *v)
+static inline void tst_atomic_store(int32_t i, tst_atomic_t *v)
 {
 	__atomic_store_n(v, i, __ATOMIC_SEQ_CST);
 }
@@ -31,14 +34,14 @@ static inline void tst_atomic_store(int i, int *v)
 
 /* Use __sync built-ins (GCC >= 4.1), with explicit memory barriers. */
 
-static inline int tst_atomic_add_return(int i, int *v)
+static inline int tst_atomic_add_return(int32_t i, tst_atomic_t *v)
 {
 	return __sync_add_and_fetch(v, i);
 }
 
-static inline int tst_atomic_load(int *v)
+static inline int32_t tst_atomic_load(tst_atomic_t *v)
 {
-	int ret;
+	tst_atomic_t ret;
 
 	__sync_synchronize();
 	ret = *v;
@@ -46,7 +49,7 @@ static inline int tst_atomic_load(int *v)
 	return ret;
 }
 
-static inline void tst_atomic_store(int i, int *v)
+static inline void tst_atomic_store(int32_t i, tst_atomic_t *v)
 {
 	__sync_synchronize();
 	*v = i;
@@ -57,14 +60,14 @@ static inline void tst_atomic_store(int i, int *v)
 # error "Your compiler does not support atomic operations (__atomic or __sync)"
 #endif
 
-static inline int tst_atomic_inc(int *v)
+static inline int tst_atomic_inc(tst_atomic_t *v)
 {
 	return tst_atomic_add_return(1, v);
 }
 
-static inline int tst_atomic_dec(int *v)
+static inline int tst_atomic_dec(tst_atomic_t *v)
 {
 	return tst_atomic_add_return(-1, v);
 }
 
-#endif	/* TST_ATOMIC_H__ */
+#endif /* TST_ATOMIC_H__ */
diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index bef424002..b22364cab 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -155,11 +155,11 @@ struct tst_fzsync_pair {
 	float max_dev_ratio;
 
 	/** Internal; Atomic counter used by fzsync_pair_wait() */
-	int a_cntr;
+	tst_atomic_t a_cntr;
 	/** Internal; Atomic counter used by fzsync_pair_wait() */
-	int b_cntr;
+	tst_atomic_t b_cntr;
 	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
-	int exit;
+	tst_atomic_t exit;
 	/** Internal; The test time remaining on tst_fzsync_pair_reset() */
 	float exec_time_start;
 	/**
diff --git a/lib/newlib_tests/test08.c b/lib/newlib_tests/test08.c
index 5099b08d3..d48bf29ee 100644
--- a/lib/newlib_tests/test08.c
+++ b/lib/newlib_tests/test08.c
@@ -22,7 +22,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	static int flag;
+	static tst_atomic_t flag;
 
 	/* Avoid subsequent threads to enter the cleanup */
 	if (tst_atomic_inc(&flag) != 1)
diff --git a/lib/newlib_tests/test09.c b/lib/newlib_tests/test09.c
index 0f42bacc6..eae258e2d 100644
--- a/lib/newlib_tests/test09.c
+++ b/lib/newlib_tests/test09.c
@@ -13,7 +13,7 @@
 #define THREADS 64
 #define ITERATIONS 100000
 
-static int atomic;
+static tst_atomic_t atomic;
 
 static void *worker(void *id)
 {
diff --git a/lib/newlib_tests/test15.c b/lib/newlib_tests/test15.c
index 3a2ac362e..c63da18fc 100644
--- a/lib/newlib_tests/test15.c
+++ b/lib/newlib_tests/test15.c
@@ -39,7 +39,7 @@ struct block {
 	intptr_t filler[FILLER];
 };
 
-static int atomic;
+static tst_atomic_t atomic;
 /* Instead of storing seq_n on the stack (probably next to the atomic variable
  * above), we store it in the middle of some anonymous mapped memory and keep
  * a pointer to it. This should decrease the probability that the value of
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index 6c361e8cc..b1390f460 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -88,7 +88,7 @@ struct race {
 	const struct window b;
 };
 
-static int H;
+static tst_atomic_t H;
 static struct tst_fzsync_pair pair;
 
 static const struct race races[] = {
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index 0a595b1e2..bc079f6ff 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -61,7 +61,7 @@ struct race {
 	const struct window b;
 };
 
-static int H, D;
+static tst_atomic_t H, D;
 static struct tst_fzsync_pair pair;
 
 /**
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index 3798f798b..a192c128d 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -21,7 +21,7 @@ static const struct tst_clone_args args = {
 	.flags = CLONE_NEWPID,
 	.exit_signal = SIGCHLD,
 };
-static int *level;
+static tst_atomic_t *level;
 
 static pid_t child_func(void)
 {
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core03.c b/testcases/kernel/controllers/cgroup/cgroup_core03.c
index 49b8eff40..846c00f29 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core03.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core03.c
@@ -22,7 +22,7 @@
 #define PID_NUM MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
 #define BUF_LEN (20 * PID_NUM)
 
-static int *data_ptr;
+static tst_atomic_t *data_ptr;
 static char *buf;
 static struct tst_cg_group *cg_child_test_simple;
 
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 1662cdb50..131128db5 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -22,7 +22,7 @@
 
 static volatile int run;
 static unsigned int nthreads;
-static int enospc_cnt;
+static tst_atomic_t enospc_cnt;
 static struct worker *workers;
 
 struct worker {
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 14588a829..e18945a34 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -57,7 +57,7 @@
 
 struct queue {
 	sem_t sem;
-	int front;
+	tst_atomic_t front;
 	int back;
 	char data[QUEUE_SIZE];
 	char popped[BUFFER_SIZE];
@@ -67,7 +67,7 @@ struct worker {
 	int i;
 	pid_t pid;
 	struct queue *q;
-	int last_seen;
+	tst_atomic_t last_seen;
 	unsigned int kill_sent:1;
 };
 
diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index f9587ef3d..1c913cc2b 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -28,7 +28,7 @@ static int numchildren = 8;
 static long long writesize = 32 * 1024 * 1024;
 static long long readsize = 32 * 1024 * 1024;
 static long long filesize = 128 * 1024 * 1024;
-static int *children_completed;
+static tst_atomic_t *children_completed;
 static char *iobuf;
 static int fd;
 
diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 4e67f5fb9..5c4ffa665 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -55,7 +55,7 @@ static unsigned long data_matched;
 static unsigned long repeated_reads;
 
 /* sequence id for each map/unmap performed */
-static int mapcnt, unmapcnt;
+static tst_atomic_t mapcnt, unmapcnt;
 /* stored sequence id before making read attempt */
 static int br_map, br_unmap;
 
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index 6cebc6fbe..58127ad9a 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -28,7 +28,7 @@ static int loops = 1000;
 static int threads = 40;
 
 static volatile int sig_caught;
-static int threads_running;
+static tst_atomic_t threads_running;
 
 static int mkfile(int *size)
 {
diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 585bb7cdb..9005f4679 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -23,7 +23,7 @@ static int cpu_count;
 
 static struct worker_data {
 	pid_t tid;
-	int counter;
+	tst_atomic_t counter;
 } *workers_data;
 
 static void *worker(void *arg)
diff --git a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
index 946e4e949..51b5c6a8d 100644
--- a/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
+++ b/testcases/kernel/syscalls/futex/futex_cmp_requeue01.c
@@ -22,8 +22,8 @@
 
 struct shared_data {
 	futex_t futexes[2];
-	int spurious;
-	int test_done;
+	tst_atomic_t spurious;
+	tst_atomic_t test_done;
 };
 
 static struct shared_data *sd;
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 22a2c0e7a..10c9adcb0 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -49,7 +49,7 @@ static int num_messages = 1000;
 static int num_iterations = MAXNREPS;
 static volatile int *stop;
 static volatile int *fail;
-static int *finished;
+static tst_atomic_t *finished;
 static int *flags;
 
 static int get_used_sysvipc(void)
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index f2326095e..a0b237112 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -33,7 +33,7 @@
 
 static unsigned char buf[BUF_SIZE], *map_ptr;
 static int mapfd = -1, writefd = -1, readfd = -1;
-static int written;
+static tst_atomic_t written;
 static struct tst_fzsync_pair fzsync_pair;
 struct iovec iov[5];
 
diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index b89970542..1d761d43c 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -41,10 +41,10 @@
 #define SPIN_TIME_NS 200000000ULL
 #define SLEEP_TIME_NS 50000000ULL
 
-static int the_ball;
+static tst_atomic_t the_ball;
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
-static int players_ready;
+static tst_atomic_t players_ready;
 
 static char *str_game_length;
 static char *str_players_per_team;
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
