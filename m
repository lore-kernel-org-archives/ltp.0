Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C933C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19433C9215
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:13:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D09D93C06C4
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:13:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B9CD11001265
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:13:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA4D5210EC;
 Tue, 21 Dec 2021 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1640077988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PX4xjbBSIglyFpu1j1ZkvmRriPUkDUmwwD8yoBbTsa0=;
 b=DUDSOoYFrct/7SlQ6ObFTgLXbCDxz8Tp9RI6upHu4F875LsY4gFStrzq36C6DxNt5964Hu
 rmtJQrD1i61KMXs0uHVJ3k5kQaRzNkkcvO/hhK0NuwHaOS3cA1RvkPnS+nPJk5MM+mYRKt
 T9N3wnIfkVTxfmPICOnupgZxqtxyPAc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B60BF13C26;
 Tue, 21 Dec 2021 09:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S9UcKqSawWGkPAAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 21 Dec 2021 09:13:08 +0000
To: ltp@lists.linux.it
Date: Tue, 21 Dec 2021 10:13:02 +0100
Message-Id: <20211221091302.26904-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Complete help message adding option before desc
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_test.c                                | 10 +++-
 testcases/kernel/fs/lftest/lftest.c           |  2 +-
 testcases/kernel/fs/read_all/read_all.c       | 16 +++----
 testcases/kernel/io/ltp-aiodio/dio_append.c   |  6 +--
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |  6 +--
 .../mem/hugetlb/hugeshmat/hugeshmat01.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat02.c       |  2 +-
 .../mem/hugetlb/hugeshmat/hugeshmat03.c       |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl02.c     |  2 +-
 .../mem/hugetlb/hugeshmctl/hugeshmctl03.c     |  2 +-
 .../mem/hugetlb/hugeshmdt/hugeshmdt01.c       |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget01.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget02.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget05.c     |  2 +-
 testcases/kernel/mem/ksm/ksm01.c              |  6 +--
 testcases/kernel/mem/ksm/ksm02.c              |  6 +--
 testcases/kernel/mem/ksm/ksm03.c              |  6 +--
 testcases/kernel/mem/ksm/ksm04.c              |  6 +--
 testcases/kernel/mem/ksm/ksm06.c              |  2 +-
 testcases/kernel/mem/mtest01/mtest01.c        | 10 ++--
 testcases/kernel/mem/mtest06/mmap3.c          |  8 ++--
 .../kernel/mem/tunable/overcommit_memory.c    |  2 +-
 .../integrity/ima/src/ima_boot_aggregate.c    |  4 +-
 .../security/integrity/ima/src/ima_mmap.c     |  2 +-
 testcases/kernel/syscalls/execve/execve05.c   |  2 +-
 .../kernel/syscalls/fallocate/fallocate04.c   |  2 +-
 .../syscalls/gettimeofday/gettimeofday02.c    |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl01.c     |  2 +-
 testcases/kernel/syscalls/ioctl/ioctl07.c     |  2 +-
 .../perf_event_open/perf_event_open02.c       |  2 +-
 .../kernel/syscalls/readahead/readahead02.c   |  2 +-
 .../syscalls/request_key/request_key03.c      |  2 +-
 testcases/kernel/syscalls/splice/splice02.c   |  2 +-
 testcases/kernel/syscalls/splice/splice04.c   |  2 +-
 testcases/kernel/syscalls/splice/splice05.c   |  2 +-
 testcases/kernel/syscalls/tgkill/tgkill01.c   |  2 +-
 testcases/kernel/tracing/pt_test/pt_test.c    |  6 +--
 .../network/can/filter-tests/can_filter.c     |  2 +-
 .../can/filter-tests/can_rcv_own_msgs.c       |  2 +-
 testcases/network/netstress/netstress.c       | 48 +++++++++----------
 .../network/nfs/nfs_stress/nfs05_make_tree.c  |  6 +--
 testcases/network/sctp/sctp_big_chunk.c       |  2 +-
 .../stress/route/route-change-netlink.c       | 12 ++---
 48 files changed, 117 insertions(+), 111 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 3e83c991f..41301ce3d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -474,6 +474,7 @@ static struct option {
 static void print_help(void)
 {
 	unsigned int i;
+	char msg[1024];
 
 	/* see doc/user-guide.txt, which lists also shell API variables */
 	fprintf(stderr, "Environment Variables\n");
@@ -498,8 +499,13 @@ static void print_help(void)
 	if (!tst_test->options)
 		return;
 
-	for (i = 0; tst_test->options[i].optstr; i++)
-		fprintf(stderr, "%s\n", tst_test->options[i].help);
+	for (i = 0; tst_test->options[i].optstr; i++) {
+		snprintf(msg, 1024, "-%c\t %s",
+			tst_test->options[i].optstr[0],
+			tst_test->options[i].help);
+
+		fprintf(stderr, "%s\n", msg);
+	}
 }
 
 static void print_test_tags(void)
diff --git a/testcases/kernel/fs/lftest/lftest.c b/testcases/kernel/fs/lftest/lftest.c
index 1f363b7c6..7290fb0df 100644
--- a/testcases/kernel/fs/lftest/lftest.c
+++ b/testcases/kernel/fs/lftest/lftest.c
@@ -70,7 +70,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"n:", &str_bufnum, "-n COUNT Number of megabytes to write (default 100)"},
+		{"n:", &str_bufnum, "COUNT Number of megabytes to write (default 100)"},
 		{}
 	},
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index a4123220a..a5b93b966 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -450,21 +450,21 @@ static void run(void)
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
 		{"v", &verbose,
-		 "-v       Print information about successful reads."},
+		 "Print information about successful reads."},
 		{"q", &quiet,
-		 "-q       Don't print file read or open errors."},
+		 "Don't print file read or open errors."},
 		{"d:", &root_dir,
-		 "-d path  Path to the directory to read from, defaults to /sys."},
+		 "Path to the directory to read from, defaults to /sys."},
 		{"e:", &blacklist[0],
-		 "-e pattern Ignore files which match an 'extended' pattern, see fnmatch(3)."},
+		 "Pattern Ignore files which match an 'extended' pattern, see fnmatch(3)."},
 		{"r:", &str_reads,
-		 "-r count The number of times to schedule a file for reading."},
+		 "Count The number of times to schedule a file for reading."},
 		{"w:", &str_max_workers,
-		 "-w count Set the worker count limit, the default is 15."},
+		 "Count Set the worker count limit, the default is 15."},
 		{"W:", &str_worker_count,
-		 "-W count Override the worker count. Ignores (-w) and the processor count."},
+		 "Count Override the worker count. Ignores (-w) and the processor count."},
 		{"p", &drop_privs,
-		 "-p       Drop privileges; switch to the nobody user."},
+		 "Drop privileges; switch to the nobody user."},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
index 4764f4f1d..f9de54da6 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
@@ -86,9 +86,9 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &str_numchildren, "-n\t Number of processes (default 16)"},
-		{"w:", &str_writesize, "-w\t Write size for each append (default 64K)"},
-		{"c:", &str_appends, "-c\t Number of appends (default 1000)"},
+		{"n:", &str_numchildren, "Number of processes (default 16)"},
+		{"w:", &str_writesize, "Write size for each append (default 64K)"},
+		{"c:", &str_appends, "Number of appends (default 1000)"},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 1783bfb12..fcb4443f7 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -91,8 +91,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 0b27154af..3be68418a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -138,8 +138,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index f63b41f28..236010fe0 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -109,8 +109,8 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"H:", &Hopt,   "-H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index a8524b6f9..40d3bd8da 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -299,9 +299,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s",  &opt_sysfs, "-s        Setup hugepages from sysfs"},
-		{"m",  &opt_shmid, "-m        Reserve hugepages by shmget"},
-		{"a:", &opt_alloc, "-a        Number of overcommint hugepages"},
+		{"s",  &opt_sysfs, "Setup hugepages from sysfs"},
+		{"m",  &opt_shmid, "Reserve hugepages by shmget"},
+		{"a:", &opt_alloc, "Number of overcommint hugepages"},
 		{}
 },
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index f206522c0..8273ede83 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -173,7 +173,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index fcad8f5d9..11000a4f0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -100,7 +100,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 1f1d2613a..5aca7dab0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -95,7 +95,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.test_all = verify_hugeshmat,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index b5b5496fd..56f3a73dd 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -303,7 +303,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index e014edd94..8a4c8bc2d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -105,7 +105,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 8c485810d..f7dd43452 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -128,7 +128,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.needs_tmpdir = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 571a4cf10..287e5990e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -146,7 +146,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 470563653..2a440f79d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -72,7 +72,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 323b5d6d1..11497d150 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -91,7 +91,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 2053d0a98..72d8701f4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -90,7 +90,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 60c86455c..91e30afa4 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -86,7 +86,7 @@ void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"s:", &nr_opt, "-s num   Set the number of the been allocated hugepages"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index cd2c5c6ee..7470d3143 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -96,9 +96,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &opt_numstr,  "-n       Number of processes"},
-		{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-		{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
+		{"n:", &opt_numstr,  "Number of processes"},
+		{"s:", &opt_sizestr, "Memory allocation size in MB"},
+		{"u:", &opt_unitstr, "Memory allocation unit in MB"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 80017df66..c578cfb7f 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -116,9 +116,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &opt_numstr,  "-n       Number of processes"},
-		{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-		{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
+		{"n:", &opt_numstr,  "Number of processes"},
+		{"s:", &opt_sizestr, "Memory allocation size in MB"},
+		{"u:", &opt_unitstr, "Memory allocation unit in MB"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 83b821c81..df847cf95 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -97,9 +97,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &opt_numstr,  "-n       Number of processes"},
-		{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-		{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
+		{"n:", &opt_numstr,  "Number of processes"},
+		{"s:", &opt_sizestr, "Memory allocation size in MB"},
+		{"u:", &opt_unitstr, "Memory allocation unit in MB"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 65f7e6510..e8bc1de85 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -116,9 +116,9 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &opt_numstr,  "-n       Number of processes"},
-		{"s:", &opt_sizestr, "-s       Memory allocation size in MB"},
-		{"u:", &opt_unitstr, "-u       Memory allocation unit in MB"},
+		{"n:", &opt_numstr,  "Number of processes"},
+		{"s:", &opt_sizestr, "Memory allocation size in MB"},
+		{"u:", &opt_unitstr, "Memory allocation unit in MB"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 1c435586e..c5f219c37 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -89,7 +89,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"n:", &n_opt,  "-n x    Allocate x pages memory per node"},
+		{"n:", &n_opt,  "Allocate x pages memory per node"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 9676ea4b5..20cb95191 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -227,11 +227,11 @@ static void mem_test(void)
 static struct tst_test test = {
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"c:", &opt_chunksize,	"-c  size of chunk in bytes to malloc on each pass"},
-		{"b:", &opt_maxbytes,	"-b  maximum number of bytes to allocate before stopping"},
-		{"p:", &opt_maxpercent, "-p  percent of total memory used at which the program stops"},
-		{"w",  &dowrite,   	"-w  write to the memory after allocating"},
-		{"v",  &verbose,     	"-v  verbose"},
+		{"c:", &opt_chunksize,	"Size of chunk in bytes to malloc on each pass"},
+		{"b:", &opt_maxbytes,	"Maximum number of bytes to allocate before stopping"},
+		{"p:", &opt_maxpercent, "Percent of total memory used at which the program stops"},
+		{"w",  &dowrite,   	"Write to the memory after allocating"},
+		{"v",  &verbose,     	"Verbose"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/mtest06/mmap3.c b/testcases/kernel/mem/mtest06/mmap3.c
index c18bd2f56..23609752f 100644
--- a/testcases/kernel/mem/mtest06/mmap3.c
+++ b/testcases/kernel/mem/mtest06/mmap3.c
@@ -181,10 +181,10 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"l:", &str_loops, "-l uint  Number of map-write-unmap loops"},
-		{"n:", &str_threads, "-n uint  Number of worker threads"},
-		{"p", &map_private, "-p       Turns on MAP_PRIVATE (default MAP_SHARED)"},
-		{"x:", &str_exec_time, "-x float Execution time in hours (default 24H)"},
+		{"l:", &str_loops, "Number of map-write-unmap loops"},
+		{"n:", &str_threads, "Number of worker threads"},
+		{"p", &map_private, "Turns on MAP_PRIVATE (default MAP_SHARED)"},
+		{"x:", &str_exec_time, "float Execution time in hours (default 24H)"},
 		{}
 	},
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index ac875ab18..20151ebb0 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -265,7 +265,7 @@ static void calculate_total_batch_size(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.options = (struct tst_option[]) {
-		{"R:", &R_opt, "  -R n    Percentage of overcommitting memory"},
+		{"R:", &R_opt, "Percentage of overcommitting memory"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 04d106662..05c20e5ae 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -123,8 +123,8 @@ static void do_test(void)
 }
 
 static struct tst_option options[] = {
-	{"d", &debug, "-d       enable debug"},
-	{"f:", &file, "-f x     binary_bios_measurement file (required)\n"},
+	{"d", &debug, "Enable debug"},
+	{"f:", &file, "binary_bios_measurement file (required)\n"},
 	{NULL, NULL, NULL}
 };
 
diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index e5dafb525..8596809ef 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -43,7 +43,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"f:", &filename, "-f file  File to mmap"},
+		{"f:", &filename, "File to mmap"},
 		{}
 	},
 	.test_all = run,
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index 4c9789cc5..63bfb0fbd 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -80,7 +80,7 @@ static void setup(void)
 static struct tst_test test = {
 	.test_all = verify_execve,
 	.options = (struct tst_option[]) {
-		{"n:", &opt_nchild, "-n    numbers of children"},
+		{"n:", &opt_nchild, "Numbers of children"},
 		{}
 	},
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 7ffc8f4fa..29de5886e 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -298,7 +298,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"v", &verbose, "-v       Turns on verbose mode"},
+		{"v", &verbose, "Turns on verbose mode"},
 		{}
 	},
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index c0e56ed34..948d2d8ec 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -81,7 +81,7 @@ static void setup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.options = (struct tst_option[]) {
-		{"T:", &str_rtime, "-T len   Test iteration runtime in seconds"},
+		{"T:", &str_rtime, "Test iteration runtime in seconds"},
 		{},
 	},
 	.test_all = verify_gettimeofday,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index c8a1b9a10..26b603ebe 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -107,7 +107,7 @@ static struct tst_test test = {
 	.test = verify_ioctl,
 	.tcnt = ARRAY_SIZE(tcases),
 	.options = (struct tst_option[]) {
-		{"D:", &device, "-D <tty device> : for example, /dev/tty[0-9]"},
+		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl07.c b/testcases/kernel/syscalls/ioctl/ioctl07.c
index 883a556c5..073ff033f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl07.c
@@ -50,7 +50,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"f:", &s_fuzz, "-f c     Fuzz factor for valid match (default 2)"},
+		{"f:", &s_fuzz, "Fuzz factor for valid match (default 2)"},
 		{}
 	},
 	.test_all = verify_ioctl,
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 7200d35e3..0335a296e 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -330,7 +330,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"v", &verbose, "-v       verbose output"},
+		{"v", &verbose, "Verbose output"},
 		{},
 	},
 	.test_all = verify,
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 258c70e21..4fa8cfaf8 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -401,7 +401,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"s:", &opt_fsizestr, "-s    testfile size (default 64MB)"},
+		{"s:", &opt_fsizestr, "Testfile size (default 64MB)"},
 		{}
 	},
 	.test = test_readahead,
diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
index b33da1a3b..3f0c093f3 100644
--- a/testcases/kernel/syscalls/request_key/request_key03.c
+++ b/testcases/kernel/syscalls/request_key/request_key03.c
@@ -183,7 +183,7 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
-		{"b:", &opt_bug,  "-b       Bug to test for (cve-2017-15299 or cve-2017-15951; default is both)"},
+		{"b:", &opt_bug,  "Bug to test for (cve-2017-15299 or cve-2017-15951; default is both)"},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index 0397360eb..c81195102 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -157,7 +157,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.min_kver = "2.6.17",
 	.options = (struct tst_option[]) {
-		{"s:", &sarg, "-s x     Size of output file in bytes (default: 16x max pipe size, i.e. 1M on intel)"},
+		{"s:", &sarg, "Size of output file in bytes (default: 16x max pipe size, i.e. 1M on intel)"},
 		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index 29fdd24e9..1189afcde 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -80,7 +80,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
+		{"l:", &str_len_data, "Length of test data (in bytes)"},
 		{}
 	},
 	.min_kver = "2.6.31"
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index 9a9a7d1d5..306f3c60e 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -105,7 +105,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
+		{"l:", &str_len_data, "Length of test data (in bytes)"},
 		{}
 	},
 	.min_kver = "2.6.17"
diff --git a/testcases/kernel/syscalls/tgkill/tgkill01.c b/testcases/kernel/syscalls/tgkill/tgkill01.c
index 37a4a331d..04f06a673 100644
--- a/testcases/kernel/syscalls/tgkill/tgkill01.c
+++ b/testcases/kernel/syscalls/tgkill/tgkill01.c
@@ -122,7 +122,7 @@ static void setup(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"t:", &str_threads, "-t       Number of threads (default 10)"},
+		{"t:", &str_threads, "Number of threads (default 10)"},
 		{}
 	},
 	.needs_checkpoints = 1,
diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
index 33db6d770..54011a884 100644
--- a/testcases/kernel/tracing/pt_test/pt_test.c
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -219,9 +219,9 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test_all = intel_pt_trace_check,
 	.options = (struct tst_option[]) {
-		{"m", &str_mode, "-m different mode, default is full mode"},
-		{"e:", &str_exclude_info, "-e exclude info, user or kernel"},
-		{"b", &str_branch_flag, "-b if disable branch trace"},
+		{"m", &str_mode, "Different mode, default is full mode"},
+		{"e:", &str_exclude_info, "Exclude info, user or kernel"},
+		{"b", &str_branch_flag, "Disable branch trace"},
 		{}
 	},
 	.min_kver = "4.1",
diff --git a/testcases/network/can/filter-tests/can_filter.c b/testcases/network/can/filter-tests/can_filter.c
index ed35b08e7..f2704c26e 100644
--- a/testcases/network/can/filter-tests/can_filter.c
+++ b/testcases/network/can/filter-tests/can_filter.c
@@ -172,7 +172,7 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.tcnt = TC,
 	.options = (struct tst_option[]) {
-		{"D:", &can_dev_name, "-D <device>   CAN device name"},
+		{"D:", &can_dev_name, "CAN device name"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
index dc29d195a..609ceb6d7 100644
--- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
+++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
@@ -134,7 +134,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.options = (struct tst_option[]) {
-		{"D:", &can_dev_name, "-D <device>   CAN device name"},
+		{"D:", &can_dev_name, "CAN device name"},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 03b1563dc..0914c65bd 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -998,30 +998,30 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"f", &fastopen_api, "-f       Use TFO API, default is old API"},
-		{"F", &fastopen_sapi, "-F       TCP_FASTOPEN_CONNECT socket option and standard API"},
-		{"t:", &targ, "-t x     Set tcp_fastopen value"},
-		{"S:", &source_addr, "-S x     Source address to bind"},
-		{"g:", &tcp_port, "-g x     x - server port"},
-		{"b:", &barg, "-b x     x - low latency busy poll timeout"},
-		{"T:", &type, "-T x     tcp (default), udp, udp_lite, dccp, sctp"},
-		{"z", &zcopy, "-z       enable SO_ZEROCOPY"},
-		{"P:", &reuse_port, "-P       enable SO_REUSEPORT"},
-		{"D:", &dev, "-D x     bind to device x\n"},
-
-		{"H:", &server_addr, "Client:\n-H x     Server name or IP address"},
-		{"l", &client_mode, "-l       Become client, default is server"},
-		{"a:", &aarg, "-a x     Number of clients running in parallel"},
-		{"r:", &rarg, "-r x     Number of client requests"},
-		{"n:", &narg, "-n x     Client message size"},
-		{"N:", &Narg, "-N x     Server message size"},
-		{"m:", &Targ, "-m x     Receive timeout in milliseconds (not used by UDP/DCCP client)"},
-		{"d:", &rpath, "-d x     x is a path to file where result is saved"},
-		{"A:", &Aarg, "-A x     x max payload length (generated randomly)\n"},
-
-		{"R:", &Rarg, "Server:\n-R x     x requests after which conn.closed"},
-		{"q:", &qarg, "-q x     x - TFO queue"},
-		{"B:", &server_bg, "-B x     run in background, x - process directory"},
+		{"f", &fastopen_api, "Use TFO API, default is old API"},
+		{"F", &fastopen_sapi, "TCP_FASTOPEN_CONNECT socket option and standard API"},
+		{"t:", &targ, "Set tcp_fastopen value"},
+		{"S:", &source_addr, "Source address to bind"},
+		{"g:", &tcp_port, "Server port"},
+		{"b:", &barg, "Low latency busy poll timeout"},
+		{"T:", &type, "Tcp (default), udp, udp_lite, dccp, sctp"},
+		{"z", &zcopy, "Enable SO_ZEROCOPY"},
+		{"P:", &reuse_port, "Enable SO_REUSEPORT"},
+		{"D:", &dev, "Bind to device x"},
+
+		{"H:", &server_addr, "Server name or IP address"},
+		{"l", &client_mode, "Become client, default is server"},
+		{"a:", &aarg, "Number of clients running in parallel"},
+		{"r:", &rarg, "Number of client requests"},
+		{"n:", &narg, "Client message size"},
+		{"N:", &Narg, "Server message size"},
+		{"m:", &Targ, "Receive timeout in milliseconds (not used by UDP/DCCP client)"},
+		{"d:", &rpath, "Path to file where result is saved"},
+		{"A:", &Aarg, "Max payload length (generated randomly)"},
+
+		{"R:", &Rarg, "Server requests after which conn.closed"},
+		{"q:", &qarg, "TFO queue"},
+		{"B:", &server_bg, "Run in background, arg is the process directory"},
 		{}
 	},
 };
diff --git a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
index 23c520d9d..add55e156 100644
--- a/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
+++ b/testcases/network/nfs/nfs_stress/nfs05_make_tree.c
@@ -60,9 +60,9 @@ static int file_num = 100;
 static char *t_arg, *d_arg, *f_arg;
 
 static struct tst_option opts[] = {
-	{"t:", &t_arg, "-t x    Number of threads to generate, default: 8\n"},
-	{"d:", &d_arg, "-d x    Number of subdirs to generate, default: 100\n"},
-	{"f:", &f_arg, "-f x    Number of c files in each dir, default: 100\n"},
+	{"t:", &t_arg, "Number of threads to generate, default: 8"},
+	{"d:", &d_arg, "Number of subdirs to generate, default: 100"},
+	{"f:", &f_arg, "Number of c files in each dir, default: 100"},
 	{NULL, NULL, NULL}
 };
 
diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
index 8b584bac1..a6a326ea2 100644
--- a/testcases/network/sctp/sctp_big_chunk.c
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -178,7 +178,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = run,
 	.options = (struct tst_option[]) {
-		{"a:", &addr_param, "-a       number of additional IP address params"},
+		{"a:", &addr_param, "Number of additional IP address params"},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/network/stress/route/route-change-netlink.c b/testcases/network/stress/route/route-change-netlink.c
index 3c49b7adc..dcc9637aa 100644
--- a/testcases/network/stress/route/route-change-netlink.c
+++ b/testcases/network/stress/route/route-change-netlink.c
@@ -309,12 +309,12 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.options = (struct tst_option[]) {
-		{"6", &ipv6_opt, "-6       Use IPv6 (default is IPv4)"},
-		{"c:", &c_opt, "-c x     Num loops (mandatory)"},
-		{"d:", &d_opt, "-d iface Interface to work on (mandatory)"},
-		{"g:", &g_opt, "-g x     Gateway IP"},
-		{"p:", &p_opt, "-p port  Rhost port (mandatory)"},
-		{"r:", &r_opt, "-r x     Rhost IP (mandatory)\n\n-g, -r IP parameter can contain more IP, separated by "
+		{"6", &ipv6_opt, "Use IPv6 (default is IPv4)"},
+		{"c:", &c_opt, "Num loops (mandatory)"},
+		{"d:", &d_opt, "Interface to work on (mandatory)"},
+		{"g:", &g_opt, "Gateway IP"},
+		{"p:", &p_opt, "Rhost port (mandatory)"},
+		{"r:", &r_opt, "Rhost IP (mandatory)\n\n-g, -r IP parameter can contain more IP, separated by "
 			CHR2STR(IP_ADDR_DELIM)},
 		{}
 	},
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
