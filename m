Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A867CC4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 04:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03C503CBCD7
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 05:02:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8B403CBCF6
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:25 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A146560076C
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 05:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671163283; i=@fujitsu.com;
 bh=I6XF/bKdxfYYHdb5f4YRwfcpch9iQdA5Kpy9+mj9fck=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Qqbo7+GbnxV9tFx5gZgcRqFPP9UXCjzvoguhgD4t9cjcAD86jEttUzqhUf5Yya5n0
 OibtmryjffxqT0COtq9BoMXxlkG8+Nqb4L2gBF5wLaMunaTXuAq7DBI3ZLYqx2gEqO
 OFiWCPXKn9Pl+Vb54pYt6NNoV8uEklw81jED63eKvnmrNqJJedmJuxlLZptc+cX15S
 NXXgw8KLlGfb9KRxiP9HH0y7sSi0qjebflh0fj4LW4ykX9IPfHgPilBoWBnBC1c8za
 /mUIXQoSXhEkCXUQQpr6rFhn1nSoCYNylR/DEaMP7e7oZ/J9Rb4JRe28XUKgPDkaLo
 eweX2Wjf+iB0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8MxSXfS29n
 JBgdXWFqs+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBnf3z1hKXh/j7Gi9/U91gbGj/sYuxi5OIQE
 zjJKrO3tZIFwDjBJPN3wB8rZwyjxvWEnkMPJwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSzgLXH7wnSwehYBVYl9d26AxXkFPCT+LmliBbElBBQkpjx8DzSHg4NTwFPi8TFnEFMIqO
 Tdv3qIakGJkzOfsEBMl5A4+OIFM0SnosSljm+MEHaFxKxZbUwQtprE1XObmCcwCs5C0j4LSfs
 CRqZVjGbFqUVlqUW6hqZ6SUWZ6RkluYmZOXqJVbqJeqmluuWpxSW6hnqJ5cV6qcXFesWVuck5
 KXp5qSWbGIHhm1LMXryD8cGyP3qHGCU5mJREefWXz04W4kvKT6nMSCzOiC8qzUktPsQow8GhJ
 MFb+RooJ1iUmp5akZaZA4wlmLQEB4+SCO+WC0Bp3uKCxNzizHSI1ClGXY6ps//tZxZiycvPS5
 US5135CqhIAKQoozQPbgQsri8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEua98BJoCk9mXgn
 cpldARzABHSFzbybIESWJCCmpBiaDhY9M5vCl7KpdcjepTvlmNf8HziqNSz5hDqtLJ6zedayB
 f76avttHAa1zdgcmRZ1eq3/z2GUh2y9tL9xMrHZGfjWKOL57x/oFfa+CF/Yzi324IjOZqSiFr
 frKmvJNm9t4lvkJmBubV08865h8Mv63qcL8OX77XL8cvR3pVHB048IXTpaTtZZ7M6599MQ87J
 51jl2Bo7nz1ZXtahc43VbqLT3PqeowQ0C04ncgA8uZnUE58rOfSUawa6YFbT/6KeVfk5MST2g
 25/6jqye0GEYVvvxmczCRr2Euy5MJEgcXPWzduCF+eUdwjUvOFJbV+3qjViw2qLdbOZv7x8Mj
 K7KOfX4yZ5qoz+UtSr+W1woqsRRnJBpqMRcVJwIAM/vFemYDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-585.messagelabs.com!1671163282!71620!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23107 invoked from network); 16 Dec 2022 04:01:22 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-4.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Dec 2022 04:01:22 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 850681000D2
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:22 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 774311000C1
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 04:01:22 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 16 Dec 2022 04:01:20 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 16 Dec 2022 13:02:02 +0800
Message-ID: <1671166923-2173-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/7] Remove old kernel version check when using
 min_kver
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The oldest supported kernel version check is 3.0, so remove them.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/cve/cve-2016-10044.c                               | 1 -
 testcases/cve/cve-2016-7117.c                                | 1 -
 testcases/cve/meltdown.c                                     | 1 -
 testcases/kernel/controllers/memcg/regression/memcg_test_3.c | 1 -
 testcases/kernel/mem/cpuset/cpuset01.c                       | 1 -
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c           | 1 -
 testcases/kernel/mem/ksm/ksm01.c                             | 1 -
 testcases/kernel/mem/ksm/ksm02.c                             | 1 -
 testcases/kernel/mem/ksm/ksm03.c                             | 1 -
 testcases/kernel/mem/ksm/ksm04.c                             | 1 -
 testcases/kernel/mem/ksm/ksm05.c                             | 1 -
 testcases/kernel/syscalls/clone/clone09.c                    | 1 -
 testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c   | 1 -
 testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c            | 1 -
 testcases/kernel/syscalls/fadvise/posix_fadvise04.c          | 1 -
 testcases/kernel/syscalls/fchmodat/fchmodat01.c              | 1 -
 testcases/kernel/syscalls/fcntl/fcntl35.c                    | 1 -
 testcases/kernel/syscalls/futex/futex_wake04.c               | 1 -
 testcases/kernel/syscalls/getrusage/getrusage03.c            | 1 -
 testcases/kernel/syscalls/keyctl/keyctl08.c                  | 1 -
 testcases/kernel/syscalls/madvise/madvise07.c                | 1 -
 testcases/kernel/syscalls/migrate_pages/migrate_pages03.c    | 1 -
 testcases/kernel/syscalls/mlock2/mlock201.c                  | 1 -
 testcases/kernel/syscalls/mlock2/mlock202.c                  | 1 -
 testcases/kernel/syscalls/mlock2/mlock203.c                  | 1 -
 testcases/kernel/syscalls/mmap/mmap12.c                      | 1 -
 testcases/kernel/syscalls/move_pages/move_pages12.c          | 1 -
 testcases/kernel/syscalls/msync/msync04.c                    | 1 -
 testcases/kernel/syscalls/pipe2/pipe2_04.c                   | 1 -
 testcases/kernel/syscalls/preadv/preadv01.c                  | 1 -
 testcases/kernel/syscalls/preadv/preadv02.c                  | 1 -
 testcases/kernel/syscalls/preadv/preadv03.c                  | 1 -
 testcases/kernel/syscalls/pwritev/pwritev01.c                | 1 -
 testcases/kernel/syscalls/pwritev/pwritev02.c                | 1 -
 testcases/kernel/syscalls/pwritev/pwritev03.c                | 1 -
 testcases/kernel/syscalls/recvmsg/recvmsg02.c                | 1 -
 testcases/kernel/syscalls/sendfile/sendfile08.c              | 1 -
 testcases/kernel/syscalls/sendfile/sendfile09.c              | 1 -
 testcases/kernel/syscalls/setsockopt/setsockopt03.c          | 1 -
 testcases/kernel/syscalls/socket/socket02.c                  | 1 -
 testcases/kernel/syscalls/socketpair/socketpair02.c          | 1 -
 testcases/kernel/syscalls/splice/splice01.c                  | 1 -
 testcases/kernel/syscalls/splice/splice02.c                  | 1 -
 testcases/kernel/syscalls/splice/splice03.c                  | 1 -
 testcases/kernel/syscalls/splice/splice04.c                  | 1 -
 testcases/kernel/syscalls/splice/splice05.c                  | 1 -
 testcases/kernel/syscalls/switch/endian_switch01.c           | 1 -
 testcases/kernel/syscalls/tee/tee01.c                        | 1 -
 testcases/kernel/syscalls/tee/tee02.c                        | 1 -
 testcases/kernel/syscalls/timerfd/timerfd01.c                | 1 -
 testcases/kernel/syscalls/timerfd/timerfd_gettime01.c        | 1 -
 testcases/kernel/syscalls/timerfd/timerfd_settime01.c        | 1 -
 testcases/kernel/syscalls/timerfd/timerfd_settime02.c        | 1 -
 testcases/kernel/syscalls/unlinkat/unlinkat01.c              | 1 -
 testcases/kernel/syscalls/vmsplice/vmsplice01.c              | 1 -
 testcases/kernel/syscalls/vmsplice/vmsplice02.c              | 1 -
 testcases/kernel/syscalls/vmsplice/vmsplice03.c              | 1 -
 testcases/kernel/syscalls/vmsplice/vmsplice04.c              | 1 -
 58 files changed, 58 deletions(-)

diff --git a/testcases/cve/cve-2016-10044.c b/testcases/cve/cve-2016-10044.c
index b0a329d83..9ac644fc2 100644
--- a/testcases/cve/cve-2016-10044.c
+++ b/testcases/cve/cve-2016-10044.c
@@ -61,7 +61,6 @@ found_mapping:
 static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
-	.min_kver = "2.6.8",
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "22f6b4d34fcf"},
 		{"CVE", "2016-10044"},
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 64bf0a85e..109333985 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -149,7 +149,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.min_kver = "2.6.33",
 	.max_runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a2e2725541fa"},
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index cd16b0fb2..398e496a9 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -377,7 +377,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
-	.min_kver = "2.6.32",
 	.supported_archs = (const char *const []) {
 		"x86",
 		"x86_64",
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 4bf4270bb..f29c2bea5 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -81,7 +81,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.min_kver = "2.6.24",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = do_test,
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 6e9691edb..956ac30c8 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -175,7 +175,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.setup = setup,
 	.test_all = test_cpuset,
-	.min_kver = "2.6.32",
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 91dfa0616..79bea8e8b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -114,7 +114,6 @@ static void do_mmap(unsigned int j LTP_ATTRIBUTE_UNUSED)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.32",
 	.needs_root = 1,
 	.tcnt = LOOP,
 	.needs_tmpdir = 1,
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index fafa2da71..bcd095865 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -93,5 +93,4 @@ static struct tst_test test = {
 		NULL
 	},
 	.test_all = verify_ksm,
-	.min_kver = "2.6.32",
 };
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index b5c90464e..bce639dce 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -114,7 +114,6 @@ static struct tst_test test = {
 		NULL
 	},
 	.test_all = verify_ksm,
-	.min_kver = "2.6.32",
 	.max_runtime = 32,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 };
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 94029054f..4a733269f 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -96,6 +96,5 @@ static struct tst_test test = {
 		NULL
 	},
 	.test_all = verify_ksm,
-	.min_kver = "2.6.32",
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 };
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 2302a2a1d..4f1f2f721 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -116,7 +116,6 @@ static struct tst_test test = {
 		NULL
 	},
 	.test_all = verify_ksm,
-	.min_kver = "2.6.32",
 	.max_runtime = 32,
 	.needs_cgroup_ctrls = (const char *const []){
 		"memory", "cpuset", NULL
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index c4cb779aa..25f3435b2 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -87,7 +87,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.test_all = test_ksm,
-	.min_kver = "2.6.32",
 	.save_restore = (const struct tst_path_val[]) {
 		{"/sys/kernel/mm/ksm/run", "1", TST_SR_TBROK},
 		{}
diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index e4691f513..37528e4b6 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -87,5 +87,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.min_kver = "2.6.24",
 };
diff --git a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
index ed359d434..6d2bf2a30 100644
--- a/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
+++ b/testcases/kernel/syscalls/epoll_create1/epoll_create1_01.c
@@ -44,7 +44,6 @@ static void run(unsigned int n)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.27",
 	.tcnt = ARRAY_SIZE(tc),
 	.test = run,
 };
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
index e96960ba9..c92b0b62e 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl03.c
@@ -74,5 +74,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run_all,
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
index f389a219b..8baf91bb0 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
@@ -83,5 +83,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test = verify_fadvise,
 	.tcnt = ARRAY_SIZE(defined_advise),
-	.min_kver = "2.6.16",
 };
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 925f397ef..3deff0ebe 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -97,7 +97,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.16",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_fchmodat,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index 8eb71486f..2d730377b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -113,7 +113,6 @@ static void do_test(unsigned int n)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.35",
 	.needs_root = 1,
 	.forks_child = 1,
 	.tcnt = ARRAY_SIZE(tcases),
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
index 110c628c3..176dd4aeb 100644
--- a/testcases/kernel/syscalls/futex/futex_wake04.c
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -130,7 +130,6 @@ static struct tst_test test = {
 	.test_all = wakeup_thread2,
 	.test_variants = ARRAY_SIZE(variants),
 	.needs_root = 1,
-	.min_kver = "2.6.32",
 	.needs_tmpdir = 1,
 	.hugepages = {1, TST_NEEDS},
 };
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index 7e7a1f555..fc14e93cf 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -177,7 +177,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.resource_files = resource,
-	.min_kver = "2.6.32",
 	.min_mem_avail = 512,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1f10206cf8e9"},
diff --git a/testcases/kernel/syscalls/keyctl/keyctl08.c b/testcases/kernel/syscalls/keyctl/keyctl08.c
index bc01192e7..be4b23b14 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl08.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl08.c
@@ -28,7 +28,6 @@ void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
-	.min_kver = "2.6.13",
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2016-9604"},
 		{"linux-git", "ee8f844e3c5a"},
diff --git a/testcases/kernel/syscalls/madvise/madvise07.c b/testcases/kernel/syscalls/madvise/madvise07.c
index ca76d237b..d6e2e7d1f 100644
--- a/testcases/kernel/syscalls/madvise/madvise07.c
+++ b/testcases/kernel/syscalls/madvise/madvise07.c
@@ -92,7 +92,6 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.min_kver = "2.6.31",
 	.needs_root = 1,
 	.forks_child = 1
 };
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index f77e47539..4d3299b61 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -140,7 +140,6 @@ static void migrate_test(void)
 
 static struct tst_test test = {
 	.max_runtime = 300,
-	.min_kver = "2.6.32",
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/mlock2/mlock201.c b/testcases/kernel/syscalls/mlock2/mlock201.c
index 1d1f5b7ac..b0e5f12b7 100644
--- a/testcases/kernel/syscalls/mlock2/mlock201.c
+++ b/testcases/kernel/syscalls/mlock2/mlock201.c
@@ -144,5 +144,4 @@ static struct tst_test test = {
 	.test = verify_mlock2,
 	.setup = setup,
 	.needs_root = 1,
-	.min_kver = "2.6.9",
 };
diff --git a/testcases/kernel/syscalls/mlock2/mlock202.c b/testcases/kernel/syscalls/mlock2/mlock202.c
index 630da6568..3b4965065 100644
--- a/testcases/kernel/syscalls/mlock2/mlock202.c
+++ b/testcases/kernel/syscalls/mlock2/mlock202.c
@@ -109,5 +109,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.min_kver = "2.6.9",
 };
diff --git a/testcases/kernel/syscalls/mlock2/mlock203.c b/testcases/kernel/syscalls/mlock2/mlock203.c
index 8451b2cd1..0a519ad51 100644
--- a/testcases/kernel/syscalls/mlock2/mlock203.c
+++ b/testcases/kernel/syscalls/mlock2/mlock203.c
@@ -88,5 +88,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.min_kver = "2.6.9",
 };
diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 2c0ebfb22..995a2bab0 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -135,5 +135,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_mmap,
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index df55bbbe9..fd7017d79 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -333,7 +333,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.32",
 	.needs_root = 1,
 	.forks_child = 1,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
index abe8f1659..72ddc27a4 100644
--- a/testcases/kernel/syscalls/msync/msync04.c
+++ b/testcases/kernel/syscalls/msync/msync04.c
@@ -102,5 +102,4 @@ static struct tst_test test = {
 		"tmpfs",
 		NULL
 	},
-	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
index 45e0f075b..3911f95b4 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
@@ -97,7 +97,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.35",
 	.test_all = test_pipe2,
 	.setup = setup,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/preadv/preadv01.c b/testcases/kernel/syscalls/preadv/preadv01.c
index 4b257968d..62f9296f2 100644
--- a/testcases/kernel/syscalls/preadv/preadv01.c
+++ b/testcases/kernel/syscalls/preadv/preadv01.c
@@ -105,7 +105,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_preadv,
-	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
 	.bufs = (struct tst_buffers []) {
 		{&rd_iovec, .iov_sizes = (int[]){CHUNK, 0, -1}},
diff --git a/testcases/kernel/syscalls/preadv/preadv02.c b/testcases/kernel/syscalls/preadv/preadv02.c
index 12d93da43..500059e42 100644
--- a/testcases/kernel/syscalls/preadv/preadv02.c
+++ b/testcases/kernel/syscalls/preadv/preadv02.c
@@ -126,6 +126,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_preadv,
-	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/preadv/preadv03.c b/testcases/kernel/syscalls/preadv/preadv03.c
index 00b25c549..d4595dda6 100644
--- a/testcases/kernel/syscalls/preadv/preadv03.c
+++ b/testcases/kernel/syscalls/preadv/preadv03.c
@@ -131,7 +131,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_direct_preadv,
-	.min_kver = "2.6.30",
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/pwritev/pwritev01.c b/testcases/kernel/syscalls/pwritev/pwritev01.c
index 1ee783855..66358f7c4 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev01.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev01.c
@@ -103,6 +103,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_pwritev,
-	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/pwritev/pwritev02.c b/testcases/kernel/syscalls/pwritev/pwritev02.c
index 82792df27..0881b7566 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev02.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev02.c
@@ -117,6 +117,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_pwritev,
-	.min_kver = "2.6.30",
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/pwritev/pwritev03.c b/testcases/kernel/syscalls/pwritev/pwritev03.c
index 91a5e3c54..8b91de336 100644
--- a/testcases/kernel/syscalls/pwritev/pwritev03.c
+++ b/testcases/kernel/syscalls/pwritev/pwritev03.c
@@ -130,7 +130,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_direct_pwritev,
-	.min_kver = "2.6.30",
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg02.c b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
index b15b37867..3aac4dd36 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg02.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg02.c
@@ -94,7 +94,6 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.27",
 	.test_all = verify_recvmsg,
 	.cleanup = cleanup,
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index da334f1f5..66fd40cae 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -71,7 +71,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
-	.min_kver = "2.6.33",
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "2cb4b05e76478"},
 		{}
diff --git a/testcases/kernel/syscalls/sendfile/sendfile09.c b/testcases/kernel/syscalls/sendfile/sendfile09.c
index 66d5f31a9..4a2d2083f 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile09.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile09.c
@@ -96,7 +96,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tc),
-	.min_kver = "2.6.33",
 	.max_runtime = 120,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "5d73320a96fcc"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
index 191c4cdfe..210b75429 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -74,7 +74,6 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "2.6.32",
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index 59fd942d5..51b8cc59c 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -68,6 +68,5 @@ static void cleanup(void)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_socket,
-	.min_kver = "2.6.27",
 	.cleanup = cleanup
 };
diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index e23945c53..eb679d5d9 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -81,6 +81,5 @@ static void cleanup(void)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_socketpair,
-	.min_kver = "2.6.27",
 	.cleanup = cleanup
 };
diff --git a/testcases/kernel/syscalls/splice/splice01.c b/testcases/kernel/syscalls/splice/splice01.c
index f5b2cbe17..508ccdeb7 100644
--- a/testcases/kernel/syscalls/splice/splice01.c
+++ b/testcases/kernel/syscalls/splice/splice01.c
@@ -101,5 +101,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = splice_test,
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/splice/splice02.c b/testcases/kernel/syscalls/splice/splice02.c
index b29415a8a..1da1186b2 100644
--- a/testcases/kernel/syscalls/splice/splice02.c
+++ b/testcases/kernel/syscalls/splice/splice02.c
@@ -155,7 +155,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_tmpdir = 1,
 	.forks_child = 1,
-	.min_kver = "2.6.17",
 	.options = (struct tst_option[]) {
 		{"s:", &sarg, "Size of output file in bytes (default: 16x max pipe size, i.e. 1M on intel)"},
 		{}
diff --git a/testcases/kernel/syscalls/splice/splice03.c b/testcases/kernel/syscalls/splice/splice03.c
index f3c135dee..c054e6c1c 100644
--- a/testcases/kernel/syscalls/splice/splice03.c
+++ b/testcases/kernel/syscalls/splice/splice03.c
@@ -123,5 +123,4 @@ static struct tst_test test = {
 	.test = splice_verify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
index 896f45839..5e6e8df05 100644
--- a/testcases/kernel/syscalls/splice/splice04.c
+++ b/testcases/kernel/syscalls/splice/splice04.c
@@ -83,5 +83,4 @@ static struct tst_test test = {
 		{"l:", &str_len_data, "Length of test data (in bytes)"},
 		{}
 	},
-	.min_kver = "2.6.31"
 };
diff --git a/testcases/kernel/syscalls/splice/splice05.c b/testcases/kernel/syscalls/splice/splice05.c
index d77dc887e..501df10f6 100644
--- a/testcases/kernel/syscalls/splice/splice05.c
+++ b/testcases/kernel/syscalls/splice/splice05.c
@@ -108,5 +108,4 @@ static struct tst_test test = {
 		{"l:", &str_len_data, "Length of test data (in bytes)"},
 		{}
 	},
-	.min_kver = "2.6.17"
 };
diff --git a/testcases/kernel/syscalls/switch/endian_switch01.c b/testcases/kernel/syscalls/switch/endian_switch01.c
index f357ff54d..bee35184a 100644
--- a/testcases/kernel/syscalls/switch/endian_switch01.c
+++ b/testcases/kernel/syscalls/switch/endian_switch01.c
@@ -93,7 +93,6 @@ static void endian_test(void)
 
 static struct tst_test test = {
 	.test_all = endian_test,
-	.min_kver = "2.6.26",
 	.forks_child = 1,
 };
 
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index 87a7ecd09..d1489d045 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -106,5 +106,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = tee_test,
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/tee/tee02.c b/testcases/kernel/syscalls/tee/tee02.c
index 885877d1f..5ebb3c3f6 100644
--- a/testcases/kernel/syscalls/tee/tee02.c
+++ b/testcases/kernel/syscalls/tee/tee02.c
@@ -90,5 +90,4 @@ static struct tst_test test = {
 	.test = tee_verify,
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/timerfd/timerfd01.c b/testcases/kernel/syscalls/timerfd/timerfd01.c
index 9f5694217..4461c4fd4 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd01.c
@@ -158,5 +158,4 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
-	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
index aba77c05d..8dd31f9f0 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_gettime01.c
@@ -101,5 +101,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
index 36577e2c4..7ebcaf4b4 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime01.c
@@ -108,5 +108,4 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-	.min_kver = "2.6.25",
 };
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index 84ce95538..33d9f7b46 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -110,7 +110,6 @@ static struct tst_test test = {
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.cleanup = cleanup,
-	.min_kver = "2.6.25",
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.max_runtime = 150,
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index cdbb09927..7dba1d641 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -107,7 +107,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.tcnt = ARRAY_SIZE(tc),
-	.min_kver = "2.6.16",
 	.setup = setup,
 	.test = run,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 36ecc08ef..17486179b 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -121,5 +121,4 @@ static struct tst_test test = {
 		"nfs",
 		NULL
 	},
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index 0135b6f7e..8f1965c2e 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -103,5 +103,4 @@ static struct tst_test test = {
 		"nfs",
 		NULL
 	},
-	.min_kver = "2.6.17",
 };
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice03.c b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
index 622c11017..d3a39254b 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice03.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
@@ -62,7 +62,6 @@ static void setup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = vmsplice_test,
-	.min_kver = "2.6.23",
 	.bufs = (struct tst_buffers []) {
 		{&iov, .iov_sizes = (int[]){TEST_BLOCK_SIZE, -1}},
 		{}
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice04.c b/testcases/kernel/syscalls/vmsplice/vmsplice04.c
index 9aaa0b56f..96c24bc60 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice04.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice04.c
@@ -88,6 +88,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = vmsplice_test,
-	.min_kver = "2.6.17",
 	.forks_child = 1,
 };
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
