Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D04AE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 13:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2DA13C23A5
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:01:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DBAF3C1D33
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:00:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3EB1A1421723
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:00:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736427651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ogb+Jv0HiW8fLOr+HuUB10fo3j8rODH8tn/7hJYVH2w=;
 b=ZJSveD+fs68DMzqw0aCohT3ehN1jWTkUPaWKqDnD7N0tyeMbaNhyjqyVAlww99ki0LL0be
 VzRlChKGtx2gzwZ+ySeMwbvo94LZWQpdQvyGH0H+KlAsFZZF3ctJJrgG1k2ScVWG3TIlzf
 T1SzjR1rRy2IgZhrmBK0nqexp/74b/A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-ageaDvabNP-sIPuWOB3V4w-1; Thu,
 09 Jan 2025 08:00:46 -0500
X-MC-Unique: ageaDvabNP-sIPuWOB3V4w-1
X-Mimecast-MFC-AGG-ID: ageaDvabNP-sIPuWOB3V4w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 370A61956064; Thu,  9 Jan 2025 13:00:44 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 248CE1944D01; Thu,  9 Jan 2025 13:00:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 21:00:32 +0800
Message-ID: <20250109130032.50480-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RCbwpoqNGbzZTJx7aD7fEVFc3doHHFTw260Eow9PF5c_1736427644
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch revises the logic for managing test timeout and runtime
limits, introducing a more structured approach. The key changes include
renaming max_runtime to runtime for clarity and adding overall_time to
represent the total time limit for a test. This ensures better separation
of test phases (setup, execution, and cleanup) and clearer timeout management.

Key Concepts:

 timeout: Defines the maximum time allowed for the entire test, including
          setup, execution, and cleanup, when no explicit runtime is set.
	  But if a runtime is explicitly defined and tst_remaining_runtime()
	  is used, the timeout applies only to the setup and cleanup phases,
	  as the runtime controls the test execution duration.

 runtime: The maximum runtime of the test's main execution loop, used
          in tests that call tst_remaining_runtime(). It ensures the
	  main execution runs for a fixed duration, regardless of kernel
	  configuration (e.g., debug kernel).

Overall timeout is structured as follows:

| -- (default_30s + timeout) * timeout_mul -- | -- runtime * runtime_mul -- |

And, the TST_UNLIMITED_RUNTIME constant has been deprecated and replaced
by TST_UNLIMITED_TIMEOUT. This change simplifies the handling of unlimited
execution scenarios while aligning the terminology with the new timeout model.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Petr Vorel <pvorel@suse.cz>,
Cc: Martin Doucha <martin.doucha@suse.com>,
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Avinesh Kumar <akumar@suse.de>,
---

Notes:
    Changes V2 --> V3:
    	* Improve timeout description based on Cyril's suggestion
    	* Move .runtime to .timeout for some tests (fsplough, ksm02, ksm04)
    	* Drop the changes on shell test test_timeout.sh
    	* Squash tst_set_timeout and set_mempolicy01 patches into the first one
    	* Double the duration of a single test iteration on an RPi4 and use that
    	  value to set .timeout for readahead02 test
    
    CI job: https://github.com/wangli5665/ltp/actions/runs/12690072719/

 doc/old/C-Test-API.asciidoc                   |  50 +++++---
 doc/users/setup_tests.rst                     |   6 +-
 include/tst_test.h                            |  39 +++++--
 lib/newlib_tests/test_runtime01.c             |   2 +-
 lib/newlib_tests/test_runtime02.c             |   2 +-
 lib/newlib_tests/tst_fuzzy_sync01.c           |   2 +-
 lib/newlib_tests/tst_fuzzy_sync02.c           |   2 +-
 lib/newlib_tests/tst_fuzzy_sync03.c           |   2 +-
 lib/tst_test.c                                | 108 ++++++++++--------
 lib/tst_timer_test.c                          |   2 +-
 testcases/cve/cve-2014-0196.c                 |   2 +-
 testcases/cve/cve-2015-3290.c                 |   2 +-
 testcases/cve/cve-2016-7117.c                 |   2 +-
 testcases/cve/cve-2017-2671.c                 |   2 +-
 .../kernel/controllers/cgroup/cgroup_core03.c |   2 +-
 testcases/kernel/crypto/af_alg02.c            |   2 +-
 testcases/kernel/crypto/af_alg07.c            |   2 +-
 testcases/kernel/crypto/pcrypt_aead01.c       |   2 +-
 testcases/kernel/fs/fs_fill/fs_fill.c         |   2 +-
 testcases/kernel/fs/fsplough/fsplough.c       |   2 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c     |   2 +-
 testcases/kernel/fs/read_all/read_all.c       |   4 +-
 testcases/kernel/io/ltp-aiodio/aio-stress.c   |   2 +-
 testcases/kernel/io/ltp-aiodio/aiocp.c        |   2 +-
 .../kernel/io/ltp-aiodio/aiodio_append.c      |   2 +-
 .../kernel/io/ltp-aiodio/aiodio_sparse.c      |   2 +-
 testcases/kernel/io/ltp-aiodio/dio_append.c   |   2 +-
 testcases/kernel/io/ltp-aiodio/dio_read.c     |   2 +-
 testcases/kernel/io/ltp-aiodio/dio_sparse.c   |   2 +-
 testcases/kernel/io/ltp-aiodio/dio_truncate.c |   2 +-
 testcases/kernel/mem/ksm/ksm02.c              |   4 +-
 testcases/kernel/mem/ksm/ksm04.c              |   4 +-
 .../kernel/mem/mmapstress/mmapstress01.c      |   2 +-
 testcases/kernel/mem/mtest01/mtest01.c        |   2 +-
 testcases/kernel/mem/mtest06/mmap1.c          |   2 +-
 testcases/kernel/mem/mtest06/mmap3.c          |   2 +-
 testcases/kernel/mem/mtest07/mallocstress.c   |   2 +-
 testcases/kernel/mem/oom/oom01.c              |   2 +-
 testcases/kernel/mem/oom/oom02.c              |   2 +-
 testcases/kernel/mem/oom/oom03.c              |   2 +-
 testcases/kernel/mem/oom/oom04.c              |   2 +-
 testcases/kernel/mem/oom/oom05.c              |   2 +-
 testcases/kernel/mem/swapping/swapping01.c    |   2 +-
 testcases/kernel/mem/thp/thp04.c              |   2 +-
 .../kernel/mem/tunable/min_free_kbytes.c      |   2 +-
 testcases/kernel/pty/pty03.c                  |   2 +-
 testcases/kernel/pty/pty05.c                  |   2 +-
 testcases/kernel/pty/pty06.c                  |   2 +-
 testcases/kernel/pty/pty07.c                  |   2 +-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |   2 +-
 .../kernel/sched/cfs-scheduler/starvation.c   |   2 +-
 .../security/dirtyc0w_shmem/dirtyc0w_shmem.c  |   2 +-
 testcases/kernel/security/kallsyms/kallsyms.c |   2 +-
 testcases/kernel/sound/snd_seq01.c            |   2 +-
 testcases/kernel/sound/snd_timer01.c          |   2 +-
 testcases/kernel/syscalls/bind/bind06.c       |   2 +-
 .../copy_file_range/copy_file_range01.c       |   2 +-
 .../kernel/syscalls/fallocate/fallocate06.c   |   2 +-
 testcases/kernel/syscalls/fork/fork13.c       |   2 +-
 testcases/kernel/syscalls/fsync/fsync02.c     |   2 +-
 .../syscalls/gettimeofday/gettimeofday02.c    |   2 +-
 testcases/kernel/syscalls/inotify/inotify06.c |   2 +-
 testcases/kernel/syscalls/inotify/inotify09.c |   2 +-
 testcases/kernel/syscalls/inotify/inotify12.c |   2 +-
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c  |   2 +-
 .../syscalls/ipc/msgstress/msgstress01.c      |   2 +-
 .../kernel/syscalls/ipc/semget/semget05.c     |   2 +-
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |   2 +-
 testcases/kernel/syscalls/keyctl/keyctl02.c   |   2 +-
 .../kernel/syscalls/landlock/landlock04.c     |   2 +-
 testcases/kernel/syscalls/madvise/madvise06.c |   2 +-
 testcases/kernel/syscalls/madvise/madvise11.c |   2 +-
 .../syscalls/migrate_pages/migrate_pages03.c  |   2 +-
 .../kernel/syscalls/move_pages/move_pages12.c |   2 +-
 testcases/kernel/syscalls/nice/nice05.c       |   2 +-
 .../perf_event_open/perf_event_open02.c       |   2 +-
 .../perf_event_open/perf_event_open03.c       |   2 +-
 testcases/kernel/syscalls/preadv2/preadv203.c |   2 +-
 .../kernel/syscalls/readahead/readahead02.c   |  17 +--
 .../syscalls/request_key/request_key03.c      |   2 +-
 .../kernel/syscalls/sendfile/sendfile09.c     |   2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |   2 +-
 .../syscalls/set_mempolicy/set_mempolicy01.c  |   6 +-
 .../kernel/syscalls/setsockopt/setsockopt06.c |   2 +-
 .../kernel/syscalls/setsockopt/setsockopt07.c |   2 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c |   2 +-
 testcases/kernel/syscalls/swapon/swapon01.c   |   2 +-
 .../syscalls/timerfd/timerfd_settime02.c      |   2 +-
 testcases/kernel/syscalls/writev/writev03.c   |   2 +-
 testcases/network/can/cve/can_bcm01.c         |   2 +-
 testcases/network/netstress/netstress.c       |   2 +-
 .../network/nfs/nfs_stress/nfs05_make_tree.c  |   2 +-
 testcases/network/packet/fanout01.c           |   2 +-
 testcases/network/sockets/vsock01.c           |   2 +-
 94 files changed, 222 insertions(+), 186 deletions(-)

diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 36036039b..27c2fce51 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -94,26 +94,32 @@ in range of [0, '.tcnt' - 1].
 
 IMPORTANT: Only one of '.test' and '.test_all' can be set at a time.
 
-Each test has a limit on how long it can run and the limit composes of two
-parts max_runtime and timeout. The max_runtime is a limit for how long can the
-'.test_all' or a set of '.test' functions take and the timeout is static part
-that should cover the duration of test setup and cleanup plus some safety.
+Each test has a limit on how long it can run, composed of two parts: 'runtime'
+and 'timeout'. The 'runtime' is the limit for how long the '.test_all' or a set
+of '.test' main functions can execute. The 'timeout', on the other hand, applies
+to the total time for setup, single test function invocation, cleanup, and some
+additional safety margin. If test without an explicit runtime, the 'timeout'
+governs the entire test duration.
+
+The timeout timer is also reset on each subsequent iteration with the test -i
+parameter, variants or .all_filesystems.
 
 Any test that runs for more than a second or two has to make sure to:
 
-- set the runtime either by setting the '.max_runtime' in tst_test or by
-  calling 'tst_set_max_runtime()' in the test setup
+- set the runtime by setting '.runtime' in tst_test and calling 'tst_set_runtime()'
+  to monitor the remaining runtime and ensure the test exits when the runtime
+  limit is reached.
 
-- monitor remaning runtime by regular calls to 'tst_remaining_runtime()' and
-  exit when runtime has been used up
+- set the timeout by setting '.timeout' in tst_test to limit the whole test
+  run that does not use 'tst_remaining_runtime()'.
 
-Test is free to exit before max_runtime has been used up for example when
+Test is free to exit before runtime has been used up for example when
 minimal number of iteration was finished.
 
 The limit is applied to a single call of the '.test_all' function that means
 that for example when '.test_variants' or '.all_filesystems' is set the whole
-test will be limited by 'variants * (max_runtime + timeout)' seconds and the
-test runtime will be likely close to 'variants * max_runtime' seconds.
+test will be limited by 'variants * (runtime + timeout)' seconds and the
+test runtime will be likely close to 'variants * runtime' seconds.
 
 [source,c]
 -------------------------------------------------------------------------------
@@ -401,13 +407,25 @@ WARNING: This function is not thread safe.
 
 [source,c]
 -------------------------------------------------------------------------------
-void tst_set_max_runtime(int max_runtime);
+void tst_set_timeout(int timeout);
 -------------------------------------------------------------------------------
 
-Allows for setting max_runtime per test iteration dynamically in the test 'setup()',
-the timeout is specified in seconds. There are a few testcases whose runtime
-can vary arbitrarily, these can disable timeouts by setting it to
-TST_UNLIMITED_RUNTIME.
+Allows for setting the entire timeout dynamically during the test setup(). The
+timeout is specified in seconds and represents the total time allowed for a single
+test iteration, including setup, runtime, and teardown phases.
+
+[source,c]
+-------------------------------------------------------------------------------
+void tst_set_runtime(int runtime);
+-------------------------------------------------------------------------------
+
+Allows for setting the runtime per test iteration dynamically during the test 'setup()'.
+The runtime is specified in seconds and represents the duration the test is allowed
+to execute its main workload, excluding setup and teardown phases.
+
+This function is useful for tests where the duration of the main workload can be
+controlled or needs to be adjusted dynamically. For example, tests that loop until
+the runtime expires can use this function to define how long they should run.
 
 [source,c]
 -------------------------------------------------------------------------------
diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 7f183ca51..721ec6bb5 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -87,14 +87,14 @@ See :master:`testcases/network/README.md`.
 Test execution time and timeout
 -------------------------------
 
-The limit on how long a test can run does compose of two parts: ``max_runtime``
+The limit on how long a test can run does compose of two parts: ``runtime``
 and ``timeout``. The limit does apply to a single test variant. That means, for
 example, that tests which run for all available filesystems will apply this
 limit for a single filesystem only.
 
-The ``max_runtime`` is a cap on how long the ``run()`` function can take and for
+The ``runtime`` is a cap on how long the ``run()`` function can take and for
 most testcases this part is set to zero. For tests that do run for more than a
-second or two the ``max_runtime`` has to be defined and the ``run()`` function
+second or two the ``runtime`` has to be defined and the ``run()`` function
 has to check actively how much runtime is left.
 
 Test runtime can be scaled up and down with ``LTP_RUNTIME_MUL`` environment
diff --git a/include/tst_test.h b/include/tst_test.h
index 9da411a13..2ac67944b 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -234,7 +234,7 @@ struct tst_tag {
 
 extern unsigned int tst_variant;
 
-#define TST_UNLIMITED_RUNTIME (-1)
+#define TST_UNLIMITED_TIMEOUT (-1)
 
 /**
  * struct tst_ulimit_val - An ulimit resource and value.
@@ -435,13 +435,26 @@ struct tst_fs {
  *            The directory is created by the library, the test must not create
  *            it itself.
  *
- * @max_runtime: Maximal test runtime in seconds. Any test that runs for more
- *               than a second or two should set this and also use
- *               tst_remaining_runtime() to exit when runtime was used up.
- *               Tests may finish sooner, for example if requested number of
- *               iterations was reached before the runtime runs out. If test
- *               runtime cannot be know in advance it should be set to
- *               TST_UNLIMITED_RUNTIME.
+ * @timeout: Maximum allowable time in seconds for the entire duration of a test.
+ *           By default, the timeout limits the total time for setup, single test
+ *           function invocation, and cleanup phases. However, if .runtime is
+ *           explicitly set and tst_remaining_runtime() is used in the test's
+ *           main loop, the timeout then applies only to the setup and cleanup
+ *           phases, as the runtime separately limits the main test execution.
+ *           This ensures the test does not hang indefinitely, in the rare case
+ *           that the test timeout cannot be accurately determined, it can be
+ *           set to a sufficientlylarge value or TST_UNLIMITED_TIMEOUT to remove
+ *           the limit.
+ *
+ * @runtime: Maximum runtime in seconds for the test's main execution loop.
+ *           This should be set for tests that are expected to run longer
+ *           than a few seconds and call tst_remaining_runtime() in their
+ *           main loop to exit gracefully when the runtime is exceeded.
+ *           Tests may finish sooner if their task completes (e.g., reaching
+ *           a requested number of iterations) before the runtime runs out.
+ *           The runtime is fixed and does not scale with timeout multipliers
+ *           (e.g., TIMEOUT_MUL), ensuring consistent test duration across
+ *           different environments (e.g., debug vs. stock kernels).
  *
  * @setup: Setup callback is called once at the start of the test in order to
  *         prepare the test environment.
@@ -565,7 +578,8 @@ struct tst_fs {
 
 	const char *mntpoint;
 
-	int max_runtime;
+	int timeout;
+	int runtime;
 
 	void (*setup)(void);
 	void (*cleanup)(void);
@@ -662,6 +676,11 @@ void tst_reinit(void);
  */
 int tst_run_script(const char *script_name, char *const params[]);
 
+/*
+ * Sets entire timeout in seconds.
+ */
+void tst_set_timeout(int timeout);
+
 unsigned int tst_multiply_timeout(unsigned int timeout);
 
 /*
@@ -676,7 +695,7 @@ unsigned int tst_remaining_runtime(void);
 /*
  * Sets maximal test runtime in seconds.
  */
-void tst_set_max_runtime(int max_runtime);
+void tst_set_runtime(int runtime);
 
 /*
  * Create and open a random file inside the given dir path.
diff --git a/lib/newlib_tests/test_runtime01.c b/lib/newlib_tests/test_runtime01.c
index 5e027546d..169033850 100644
--- a/lib/newlib_tests/test_runtime01.c
+++ b/lib/newlib_tests/test_runtime01.c
@@ -25,6 +25,6 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.max_runtime = 4,
+	.runtime = 4,
 	.test_variants = 2,
 };
diff --git a/lib/newlib_tests/test_runtime02.c b/lib/newlib_tests/test_runtime02.c
index 6d89cb531..dd8eaa4d3 100644
--- a/lib/newlib_tests/test_runtime02.c
+++ b/lib/newlib_tests/test_runtime02.c
@@ -24,5 +24,5 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.max_runtime = 5,
+	.runtime = 5,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index f0e55a97f..2d440df5b 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -248,5 +248,5 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 150,
+	.runtime = 150,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index 25a6c2233..c81ebc7ea 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -225,5 +225,5 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 150,
+	.runtime = 150,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync03.c b/lib/newlib_tests/tst_fuzzy_sync03.c
index 47ce7675a..7468e79ea 100644
--- a/lib/newlib_tests/tst_fuzzy_sync03.c
+++ b/lib/newlib_tests/tst_fuzzy_sync03.c
@@ -99,5 +99,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
-	.max_runtime = 150,
+	.runtime = 150,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index feffc9f86..43583e2f9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -71,8 +71,8 @@ struct results {
 	int failed;
 	int warnings;
 	int broken;
-	unsigned int timeout;
-	int max_runtime;
+	unsigned int runtime;
+	unsigned int overall_time;
 };
 
 static struct results *results;
@@ -546,16 +546,13 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
 	}
 }
 
-static int multiply_runtime(int max_runtime)
+static int multiply_runtime(unsigned int runtime)
 {
 	static float runtime_mul = -1;
 
-	if (max_runtime <= 0)
-		return max_runtime;
-
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
-	return max_runtime * runtime_mul;
+	return runtime * runtime_mul;
 }
 
 static struct option {
@@ -593,21 +590,21 @@ static void print_help(void)
 	fprintf(stderr, "Timeout and runtime\n");
 	fprintf(stderr, "-------------------\n");
 
-	if (tst_test->max_runtime) {
-		runtime = multiply_runtime(tst_test->max_runtime);
+	if (tst_test->timeout == TST_UNLIMITED_TIMEOUT) {
+		fprintf(stderr, "Test timeout is not limited\n");
+	} else {
+		timeout = tst_multiply_timeout(DEFAULT_TIMEOUT + tst_test->timeout);
 
-		if (runtime == TST_UNLIMITED_RUNTIME) {
-			fprintf(stderr, "Test iteration runtime is not limited\n");
-		} else {
-			fprintf(stderr, "Test iteration runtime cap %ih %im %is\n",
-				runtime/3600, (runtime%3600)/60, runtime % 60);
-		}
+		fprintf(stderr, "Test timeout (not including runtime) %ih %im %is\n",
+				timeout/3600, (timeout%3600)/60, timeout % 60);
 	}
 
-	timeout = tst_multiply_timeout(DEFAULT_TIMEOUT);
+	if (tst_test->runtime) {
+		runtime = multiply_runtime(tst_test->runtime);
 
-	fprintf(stderr, "Test timeout (not including runtime) %ih %im %is\n",
-		timeout/3600, (timeout%3600)/60, timeout % 60);
+		fprintf(stderr, "Test iteration runtime cap %ih %im %is\n",
+				runtime/3600, (runtime%3600)/60, runtime % 60);
+	}
 
 	fprintf(stderr, "\n");
 
@@ -740,8 +737,8 @@ static void parse_opts(int argc, char *argv[])
 			iterations = SAFE_STRTOL(optarg, 0, INT_MAX);
 		break;
 		case 'I':
-			if (tst_test->max_runtime > 0)
-				tst_test->max_runtime = SAFE_STRTOL(optarg, 1, INT_MAX);
+			if (tst_test->runtime > 0)
+				tst_test->runtime = SAFE_STRTOL(optarg, 1, INT_MAX);
 			else
 				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
 		break;
@@ -1265,9 +1262,14 @@ static void do_setup(int argc, char *argv[])
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
-	if (tst_test->max_runtime < -1) {
+	if (tst_test->timeout < -1) {
+		tst_brk(TBROK, "Invalid timeout value %i",
+			tst_test->timeout);
+	}
+
+	if (tst_test->runtime < 0) {
 		tst_brk(TBROK, "Invalid runtime value %i",
-			results->max_runtime);
+			results->runtime);
 	}
 
 	if (tst_test->tconf_msg)
@@ -1662,7 +1664,7 @@ static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
 
 static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	alarm(results->timeout);
+	alarm(results->overall_time);
 	sigkill_retries = 0;
 }
 
@@ -1679,18 +1681,15 @@ unsigned int tst_remaining_runtime(void)
 	static struct timespec now;
 	int elapsed;
 
-	if (results->max_runtime == TST_UNLIMITED_RUNTIME)
-		return UINT_MAX;
-
-	if (results->max_runtime == 0)
+	if (results->runtime == 0)
 		tst_brk(TBROK, "Runtime not set!");
 
 	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
 	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
-	if (results->max_runtime > elapsed)
-		return results->max_runtime - elapsed;
+	if (results->runtime > elapsed)
+		return results->runtime - elapsed;
 
 	return 0;
 }
@@ -1709,33 +1708,46 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	return timeout * timeout_mul;
 }
 
-static void set_timeout(void)
+static void set_overall_timeout(void)
 {
-	unsigned int timeout = DEFAULT_TIMEOUT;
+	unsigned int timeout = DEFAULT_TIMEOUT + tst_test->timeout;
 
-	if (results->max_runtime == TST_UNLIMITED_RUNTIME) {
+	if (tst_test->timeout == TST_UNLIMITED_TIMEOUT) {
 		tst_res(TINFO, "Timeout per run is disabled");
 		return;
 	}
 
-	if (results->max_runtime < 0) {
-		tst_brk(TBROK, "max_runtime must to be >= -1! (%d)",
-			results->max_runtime);
+	if (results->runtime < 0) {
+		tst_brk(TBROK, "runtime must to be > 0! (%d)",
+			results->runtime);
 	}
 
-	results->timeout = tst_multiply_timeout(timeout) + results->max_runtime;
+	results->overall_time = tst_multiply_timeout(timeout) + results->runtime;
+
+	tst_res(TINFO, "Overall timeout per run is %uh %02um %02us",
+		results->overall_time/3600, (results->overall_time%3600)/60,
+		results->overall_time % 60);
+}
+
+void tst_set_timeout(int timeout)
+{
+	int timeout_adj = DEFAULT_TIMEOUT + timeout;
+
+	results->overall_time = tst_multiply_timeout(timeout_adj) + results->runtime;
 
-	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
-		results->timeout/3600, (results->timeout%3600)/60,
-		results->timeout % 60);
+	tst_res(TINFO, "Overall timeout per run is %uh %02um %02us",
+		results->overall_time/3600, (results->overall_time%3600)/60,
+		results->overall_time % 60);
+
+	heartbeat();
 }
 
-void tst_set_max_runtime(int max_runtime)
+void tst_set_runtime(int runtime)
 {
-	results->max_runtime = multiply_runtime(max_runtime);
-	tst_res(TINFO, "Updating max runtime to %uh %02um %02us",
-		max_runtime/3600, (max_runtime%3600)/60, max_runtime % 60);
-	set_timeout();
+	results->runtime = multiply_runtime(runtime);
+	tst_res(TINFO, "Updating runtime to %uh %02um %02us",
+		runtime/3600, (runtime%3600)/60, runtime % 60);
+	set_overall_timeout();
 	heartbeat();
 }
 
@@ -1746,7 +1758,7 @@ static int fork_testrun(void)
 	SAFE_SIGNAL(SIGINT, sigint_handler);
 	SAFE_SIGNAL(SIGTERM, sigint_handler);
 
-	alarm(results->timeout);
+	alarm(results->overall_time);
 
 	show_failure_hints = 1;
 
@@ -1896,10 +1908,10 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	uname(&uval);
 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
 
-	if (tst_test->max_runtime)
-		results->max_runtime = multiply_runtime(tst_test->max_runtime);
+	if (tst_test->runtime)
+		results->runtime = multiply_runtime(tst_test->runtime);
 
-	set_timeout();
+	set_overall_timeout();
 
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 512edc54b..b5a088a14 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -454,7 +454,7 @@ static void parse_timer_opts(void)
 			runtime_us += tcases[i].usec * tcases[i].samples;
 	}
 
-	tst_set_max_runtime((runtime_us + runtime_us/10)/1000000);
+	tst_set_runtime((runtime_us + runtime_us/10)/1000000);
 }
 
 struct tst_test *tst_timer_test_setup(struct tst_test *timer_test)
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 9d20a3986..49f39cf31 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -141,7 +141,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
-	.max_runtime = 60,
+	.runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4291086b1f08"},
 		{"CVE", "2014-0196"},
diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 231069bbb..63e5d92c9 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -519,7 +519,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_checkpoints = 1,
 	.setup = setup,
-	.max_runtime = 180,
+	.runtime = 180,
 	.test_all = run,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "9b6e6a8334d5"},
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 109333985..87ed10d02 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -149,7 +149,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 60,
+	.runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a2e2725541fa"},
 		{"CVE", "2016-7117"},
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 9092481de..41775177d 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -109,7 +109,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.max_runtime = 40,
+	.runtime = 40,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "43a6684519ab"},
 		{"CVE", "2017-2671"},
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core03.c b/testcases/kernel/controllers/cgroup/cgroup_core03.c
index 7d40d47f9..c0c3485e6 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core03.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core03.c
@@ -124,7 +124,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
-	.max_runtime = 20,
+	.timeout = 20,
 	.needs_cgroup_ctrls = (const char *const []){ "base", NULL },
 	.needs_cgroup_ver = TST_CG_V2,
 	.needs_checkpoints = 1,
diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index 40d07ca90..0fc241146 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -77,7 +77,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.max_runtime = 20,
+	.runtime = 20,
 	.needs_checkpoints = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ecaaab564978"},
diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index 9c2516632..b18d40a6f 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -125,7 +125,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "4.10.0",
 	.min_cpus = 2,
-	.max_runtime = 150,
+	.runtime = 150,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ff7b11aa481f"},
diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 3979f317a..3dc2b604e 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -75,7 +75,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.max_runtime = 300,
+	.runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d76c68109f37"},
 		{"CVE", "2017-18075"},
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 3b4ee1ae9..1662cdb50 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -121,7 +121,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 300,
+	.timeout = 300,
 	.needs_root = 1,
 	.dev_min_size = 1024,
 	.mount_device = 1,
diff --git a/testcases/kernel/fs/fsplough/fsplough.c b/testcases/kernel/fs/fsplough/fsplough.c
index 900aaacab..66aa37c47 100644
--- a/testcases/kernel/fs/fsplough/fsplough.c
+++ b/testcases/kernel/fs/fsplough/fsplough.c
@@ -190,7 +190,7 @@ static void setup(void)
 		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	filedata = SAFE_MALLOC(filesize);
 
-	tst_set_max_runtime(bufsize * loop_count / (8 * 1024 * 1024));
+	tst_set_timeout(bufsize * loop_count / (8 * 1024 * 1024));
 }
 
 static void run(void)
diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index ba1e21bbc..ac3b06ff7 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -367,7 +367,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
-	.max_runtime = 1800,
+	.timeout = 1800,
 	.options = (struct tst_option[]) {
 		{ "l:", &str_file_max_size, "Maximum size in MB of the test file(s) (default 262144)" },
 		{ "o:", &str_op_max_size, "Maximum size for single operation (default 65536)" },
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 9c58b5e85..14588a829 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -598,7 +598,7 @@ static void setup(void)
 			worker_timeout);
 	} else {
 		worker_timeout = 10 * tst_remaining_runtime();
-		tst_res(TINFO, "Worker timeout set to 10%% of max_runtime: %dms",
+		tst_res(TINFO, "Worker timeout set to 10%% of runtime: %dms",
 			worker_timeout);
 	}
 	worker_timeout *= 1000;
@@ -746,5 +746,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.forks_child = 1,
-	.max_runtime = 100,
+	.runtime = 100,
 };
diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index c29ede671..419fc2cd2 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1347,7 +1347,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
-	.max_runtime = 1800,
+	.timeout = 1800,
 	.options = (struct tst_option[]){
 		{ "a:", &str_iterations, "Total number of ayncs I/O the program will run (default 500)" },
 		{ "b:", &str_max_io_submit, "Max number of iocbs to give io_submit at once" },
diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index 6212d8ee8..c201505ae 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -322,7 +322,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.max_runtime = 1800,
+	.runtime = 1800,
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
 		{"b:", &str_aio_blksize, "Size of writing blocks (default 1K)"},
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index 45e96879e..e6280d3e8 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -190,7 +190,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-	.max_runtime = 1800,
+	.runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"s:", &str_writesize, "Size of the file to write (default 64K)"},
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
index 595c76226..8f41fdbe1 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
@@ -244,7 +244,7 @@ static struct tst_test test = {
 		"tmpfs",
 		NULL
 	},
-	.max_runtime = 1800,
+	.runtime = 1800,
 };
 #else
 TST_TEST_TCONF("test requires libaio and its development packages");
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 0ecb76e2f..16bed5db2 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -96,7 +96,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-	.max_runtime = 1800,
+	.runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of processes (default 16)"},
 		{"w:", &str_writesize, "Write size for each append (default 64K)"},
diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index 54a0bc5c2..e6d1b7438 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -178,7 +178,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-	.max_runtime = 1800,
+	.runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 8)"},
 		{"w:", &str_writesize, "Size of writing blocks (default 32M)"},
diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
index 04b93ff2b..755668220 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
@@ -135,5 +135,5 @@ static struct tst_test test = {
 		"tmpfs",
 		NULL
 	},
-	.max_runtime = 1800,
+	.runtime = 1800,
 };
diff --git a/testcases/kernel/io/ltp-aiodio/dio_truncate.c b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
index 2c54f8981..69799e6a2 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_truncate.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_truncate.c
@@ -170,7 +170,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-	.max_runtime = 1800,
+	.runtime = 1800,
 	.options = (struct tst_option[]) {
 		{"n:", &str_numchildren, "Number of threads (default 16)"},
 		{"s:", &str_filesize, "Size of file (default 64K)"},
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 3707de95d..ab0725303 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -87,7 +87,7 @@ static void setup(void)
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	if (opt_sizestr && size > DEFAULT_MEMSIZE)
-		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
+		tst_set_timeout(32 * (size / DEFAULT_MEMSIZE));
 }
 
 static struct tst_test test = {
@@ -116,7 +116,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.test_all = verify_ksm,
-	.max_runtime = 32,
+	.timeout = 32,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index f558b23be..7b478c46d 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -74,7 +74,7 @@ static void setup(void)
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 
 	if (opt_sizestr && size > DEFAULT_MEMSIZE)
-		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
+		tst_set_timeout(32 * (size / DEFAULT_MEMSIZE));
 }
 
 static struct tst_test test = {
@@ -103,7 +103,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.test_all = verify_ksm,
-	.max_runtime = 32,
+	.timeout = 32,
 	.needs_cgroup_ctrls = (const char *const []){
 		"memory", "cpuset", NULL
 	},
diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
index 9189f113e..5ba09208d 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -362,7 +362,7 @@ static struct tst_test test = {
 		{},
 	},
 	.cleanup = cleanup,
-	.max_runtime = 12,
+	.runtime = 12,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index fb991ce8b..04fde9590 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -235,7 +235,7 @@ static struct tst_test test = {
 		{"v",  &verbose,     	"Verbose"},
 		{}
 	},
-	.max_runtime = 300,
+	.runtime = 300,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = mem_test,
diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 907597d16..4e67f5fb9 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -249,6 +249,6 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-	.max_runtime = 180,
+	.runtime = 180,
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index 19f4e33df..6cebc6fbe 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -182,5 +182,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_mmap,
-	.max_runtime = 60,
+	.runtime = 60,
 };
diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 2d047cf6f..f5b4f3016 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -194,7 +194,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 600,
+	.runtime = 600,
 	.needs_checkpoints = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 903785f93..ddb904459 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -36,7 +36,7 @@ static void verify_oom(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = TST_UNLIMITED_RUNTIME,
+	.timeout = TST_UNLIMITED_TIMEOUT,
 	.test_all = verify_oom,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 087d61abe..50b514cb4 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -45,7 +45,7 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = TST_UNLIMITED_RUNTIME,
+	.timeout = TST_UNLIMITED_TIMEOUT,
 	.setup = setup,
 	.test_all = verify_oom,
 	.skip_in_compat = 1,
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 1041a6a1d..873a6d84c 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -71,7 +71,7 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = TST_UNLIMITED_RUNTIME,
+	.timeout = TST_UNLIMITED_TIMEOUT,
 	.setup = setup,
 	.test_all = verify_oom,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 3f0bcf7e2..94e70f3c5 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -67,7 +67,7 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = TST_UNLIMITED_RUNTIME,
+	.timeout = TST_UNLIMITED_TIMEOUT,
 	.setup = setup,
 	.test_all = verify_oom,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 74f0f78b3..16e4018cf 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -88,7 +88,7 @@ void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = TST_UNLIMITED_RUNTIME,
+	.timeout = TST_UNLIMITED_TIMEOUT,
 	.setup = setup,
 	.test_all = verify_oom,
 	.needs_cgroup_ctrls = (const char *const []){
diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index 79dd2b4d5..df1dcdf56 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -174,7 +174,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
-	.max_runtime = 600,
+	.runtime = 600,
 	.test_all = test_swapping,
 	.skip_in_compat = 1,
 	.needs_kconfigs = (const char *[]) {
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index b5f518ac5..16d766c34 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -161,7 +161,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a8f97366452e"},
 		{"linux-git", "8310d48b125d"},
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 19da409e8..65b467d60 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -221,7 +221,7 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = TST_UNLIMITED_RUNTIME,
+	.timeout = TST_UNLIMITED_TIMEOUT,
 	.setup = setup,
 	.test_all = min_free_kbytes_test,
 	.save_restore = (const struct tst_path_val[]) {
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 6324bc876..883a539d5 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -152,7 +152,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.max_runtime = 30,
+	.runtime = 30,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_SERIO_SERPORT",
 		NULL
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
index 925ce3854..6f6a9bce7 100644
--- a/testcases/kernel/pty/pty05.c
+++ b/testcases/kernel/pty/pty05.c
@@ -97,7 +97,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "82f2341c94d27"},
 		{"CVE", "2017-2636"},
diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
index cc95eb1a8..430916355 100644
--- a/testcases/kernel/pty/pty06.c
+++ b/testcases/kernel/pty/pty06.c
@@ -97,7 +97,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 	    {"CVE", "2020-36557"},
 	    {"linux-git", "ca4463bf8438"},
diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index cc3df55cb..ebd5b1607 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -114,7 +114,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{ "linux-git", "6cd1ed50efd8"},
 		{}
diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
index 27fc0fc5d..aa137eb67 100644
--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -174,7 +174,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.max_runtime = 20,
+	.timeout = 20,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_CFS_BANDWIDTH",
diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 2c5b1363d..901556a7b 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -112,7 +112,7 @@ static void setup(void)
 	if (tst_has_slow_kconfig())
 		tst_brk(TCONF, "Skip test due to slow kernel configuration");
 
-	tst_set_max_runtime(timeout);
+	tst_set_runtime(timeout);
 }
 
 static void handler(int sig LTP_ATTRIBUTE_UNUSED)
diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
index f3d6e6423..deb43aa6a 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c
@@ -108,7 +108,7 @@ static struct tst_test test = {
 	.needs_checkpoints = 1,
 	.forks_child = 1,
 	.needs_root = 1,
-	.max_runtime = 120,
+	.runtime = 120,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = dirtyc0w_shmem_test,
diff --git a/testcases/kernel/security/kallsyms/kallsyms.c b/testcases/kernel/security/kallsyms/kallsyms.c
index beab4ae96..cf1390fb4 100644
--- a/testcases/kernel/security/kallsyms/kallsyms.c
+++ b/testcases/kernel/security/kallsyms/kallsyms.c
@@ -203,7 +203,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 60,
+	.timeout = 60,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KALLSYMS=y",
 		NULL
diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index 31038b937..a23fdb34e 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -123,7 +123,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testfunc_list),
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 60,
+	.runtime = 60,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index 310169b0f..bbc5f72a4 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -136,7 +136,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d11662f4f798"},
 		{"linux-git", "ba3021b2c79b"},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 7c3300c42..4e7a8d11f 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -92,7 +92,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 300,
+	.runtime = 300,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index bbcb0ca3b..2390a32da 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -232,5 +232,5 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.test = copy_file_range_verify,
 	.test_variants = TEST_VARIANTS,
-	.max_runtime = 5
+	.timeout = 5
 };
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 24f98e271..5e1454c30 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -261,7 +261,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.needs_root = 1,
 	.dev_min_size = 1024,
-	.max_runtime = 120,
+	.timeout = 120,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 4923d8a91..3e96d0d42 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -110,7 +110,7 @@ static void check(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.max_runtime = 600,
+	.runtime = 600,
 	.test_all = check,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/kernel/pid_max", PID_MAX_STR, TST_SR_TBROK},
diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index c9de5c729..3293415f3 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -115,5 +115,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.max_runtime = 300,
+	.timeout = 300,
 };
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 84bf1f773..a58a3cb4f 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -72,6 +72,6 @@ static void setup(void)
 
 static struct tst_test test = {
 	.setup = setup,
-	.max_runtime = 10,
+	.runtime = 10,
 	.test_all = verify_gettimeofday,
 };
diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index 7452ee47d..b0eb8cafb 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -116,7 +116,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 600,
+	.runtime = 600,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index 62d529d04..e999dac39 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -97,7 +97,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d90a10e2444b"},
 		{}
diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
index 2eef545cf..208263b17 100644
--- a/testcases/kernel/syscalls/inotify/inotify12.c
+++ b/testcases/kernel/syscalls/inotify/inotify12.c
@@ -153,7 +153,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 10,
+	.timeout = 10,
 	.needs_tmpdir = 1,
 	.cleanup = cleanup,
 	.test = verify_inotify,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index d130e7130..1c5039cf0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -128,7 +128,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 3600,
+	.timeout = 3600,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a45b599ad808"},
 		{"CVE", "2018-1000204"},
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 2d9284e9d..2ceea5846 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -311,7 +311,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.forks_child = 1,
-	.max_runtime = 180,
+	.runtime = 180,
 	.options = (struct tst_option[]) {
 		{"n:", &str_num_messages, "Number of messages to send (default: 1000)"},
 		{"l:", &str_num_iterations, "Number iterations per message (default: "
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index dd9a6285d..b49e5653c 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -43,7 +43,7 @@ static void setup(void)
 	SAFE_FILE_SCANF("/proc/sys/kernel/sem", "%*d %*d %*d %d", &maxsems);
 
 	/* Prevent timeout due to high semaphore array limit */
-	tst_set_max_runtime(maxsems / 200);
+	tst_set_runtime(maxsems / 200);
 
 	sem_id_arr = SAFE_MALLOC((maxsems - used_cnt) * sizeof(int));
 	for (num = 0; num < maxsems - used_cnt; num++) {
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index ca668aaf7..6d9a53b9b 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -106,7 +106,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 10,
+	.runtime = 10,
 	.setup = setup,
 	.test_all = do_test,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index fd3f86bbc..788e9657c 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -160,7 +160,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 60,
+	.runtime = 60,
 	.test_all = do_test,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b4a1b4f5047e"},
diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
index 2485591e2..2faba7a2b 100644
--- a/testcases/kernel/syscalls/landlock/landlock04.c
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -204,5 +204,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = SANDBOX_FOLDER,
 	.all_filesystems = 1,
-	.max_runtime = 360,
+	.timeout = 360,
 };
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index b227840df..9cc64ceb5 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -242,7 +242,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_tmpdir = 1,
 	.needs_root = 1,
-	.max_runtime = 60,
+	.timeout = 60,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/sys/vm/swappiness", NULL,
diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index fe27a18d8..cfe9d7f17 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -432,7 +432,7 @@ static struct tst_test test = {
 		"CONFIG_MEMORY_FAILURE=y",
 		NULL
 	},
-	.max_runtime = 30,
+	.runtime = 30,
 	.needs_checkpoints = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index 4d3299b61..59d7e79db 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -139,7 +139,7 @@ static void migrate_test(void)
 }
 
 static struct tst_test test = {
-	.max_runtime = 300,
+	.runtime = 300,
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index dd2764b42..78f17f99b 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -342,7 +342,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
-	.max_runtime = 240,
+	.runtime = 240,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "e66f17ff7177"},
 		{"linux-git", "c9d398fa2378"},
diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
index 2c8ae4156..270171317 100644
--- a/testcases/kernel/syscalls/nice/nice05.c
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -154,5 +154,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_nice,
 	.needs_root = 1,
-	.max_runtime = 3,
+	.runtime = 3,
 };
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index defe13c62..7306ecf51 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -334,5 +334,5 @@ static struct tst_test test = {
 	},
 	.test_all = verify,
 	.needs_root = 1,
-	.max_runtime = 72
+	.timeout = 72
 };
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index 65626bad2..389cc3511 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -127,7 +127,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.max_runtime = 300,
+	.runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "7bdb157cdebb"},
 		{"CVE", "2020-25704"},
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 42b265680..72a35d3ab 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -278,6 +278,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.max_runtime = 60,
+	.runtime = 60,
 	.needs_root = 1,
 };
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index a109573fe..412784dbb 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -318,19 +318,6 @@ static void test_readahead(unsigned int n)
 		tst_res(TCONF, "Page cache on your system is too small "
 			"to hold whole testfile.");
 	}
-
-	/*
-	 * The time consuming of readahead quite depending on the platform IO
-	 * speed, sometime test timeout when the default max_runtime is used up.
-	 *
-	 *  readahead02.c:221: TINFO: Test #2: POSIX_FADV_WILLNEED on file
-	 *  readahead02.c:285: TINFO: read_testfile(0) took: 26317623 usec
-	 *  readahead02.c:286: TINFO: read_testfile(1) took: 26101484 usec
-	 *
-	 * Here raise the maximum runtime dynamically.
-	 */
-	if ((tc+1)->readahead)
-		tst_set_max_runtime(test.max_runtime + (usec + usec_ra) / 1000000);
 }
 
 
@@ -381,7 +368,7 @@ static void setup(void)
 {
 	if (opt_fsizestr) {
 		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
-		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
+		tst_set_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
 	}
 
 	if (access(PROC_IO_FNAME, F_OK))
@@ -422,7 +409,7 @@ static struct tst_test test = {
 	},
 	.test = test_readahead,
 	.tcnt = ARRAY_SIZE(tcases),
-	.max_runtime = 30,
+	.runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b833a3660394"},
 		{"linux-git", "5b910bd615ba"},
diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index 1637228f4..3837993ef 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -215,7 +215,7 @@ static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.forks_child = 1,
-	.max_runtime = 20,
+	.runtime = 20,
 	.options = (struct tst_option[]) {
 		{"b:", &opt_bug,  "Bug to test for (cve-2017-15299 or cve-2017-15951; default is both)"},
 		{}
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 6cb3cd593..eeef44519 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -93,7 +93,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
-	.max_runtime = 120,
+	.timeout = 120,
 	.skip_in_compat = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "5d73320a96fcc"},
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index d1d22b719..2edccb8d9 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -105,7 +105,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 150,
+	.runtime = 150,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
index e9712b7be..39e7156d0 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
@@ -41,9 +41,9 @@ static void setup(void)
 	 * has multiple NUMA nodes, the test matrix combination grows exponentially
 	 * and bring about test time to increase extremely fast.
 	 *
-	 * Here reset the maximum runtime according to the NUMA nodes.
+	 * Here reset the entire timeout according to the NUMA nodes.
 	 */
-	tst_set_max_runtime(test.max_runtime * (1 << nodes->cnt/16));
+	tst_set_timeout(test.timeout * (1 << nodes->cnt/16));
 }
 
 static void cleanup(void)
@@ -119,7 +119,7 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.max_runtime = 600,
+	.timeout = 600,
 };
 
 #else
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 8986f633f..1c2421fe9 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -110,7 +110,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 270,
+	.runtime = 270,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 59448e005..ed80d2c50 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -123,7 +123,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 150,
+	.runtime = 150,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index 965d17cc8..e97ff2c62 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -53,6 +53,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_root = 1,
 	.test_all = verify_swapoff,
-	.max_runtime = 60,
+	.timeout = 60,
 	.setup = setup
 };
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index eddcd5788..7d1ec7070 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -51,6 +51,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.test_all = verify_swapon,
-	.max_runtime = 60,
+	.timeout = 60,
 	.setup = setup
 };
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index 33d9f7b46..769ff3647 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 150,
+	.runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1e38da300e1e"},
 		{"CVE", "2017-10661"},
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 3575ca449..7074a418a 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -145,7 +145,7 @@ static struct tst_test test = {
 	.min_cpus = 2,
 	.setup = setup,
 	.cleanup = cleanup,
-	.max_runtime = 75,
+	.runtime = 75,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d4690f1e1cda"},
 		{}
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index d9a835b03..30d85ad62 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -141,7 +141,7 @@ static struct tst_test test = {
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_root = 1,
 	.skip_in_compat = 1,
-	.max_runtime = 30,
+	.runtime = 30,
 	.needs_drivers = (const char *const[]) {
 		"vcan",
 		"can-bcm",
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index b17d8c04e..36dbf05c8 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -1024,6 +1024,6 @@ static struct tst_test test = {
 		{"B:", &server_bg, "Run in background, arg is the process directory"},
 		{}
 	},
-	.max_runtime = 300,
+	.timeout = 300,
 	.needs_checkpoints = 1,
 };
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index f4ec5b332..0c2df5614 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -214,5 +214,5 @@ static struct tst_test test = {
 	.options = opts,
 	.test_all = do_test,
 	.setup = setup,
-	.max_runtime = 300,
+	.timeout = 300,
 };
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index 30c132621..b2b271aea 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -89,7 +89,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.max_runtime = 180,
+	.runtime = 180,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/network/sockets/vsock01.c b/testcases/network/sockets/vsock01.c
index 7be71a83b..7eecebdfc 100644
--- a/testcases/network/sockets/vsock01.c
+++ b/testcases/network/sockets/vsock01.c
@@ -112,7 +112,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
-	.max_runtime = 60,
+	.runtime = 60,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_VSOCKETS_LOOPBACK",
 		NULL
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
