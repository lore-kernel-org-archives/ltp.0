Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B78C10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 08:20:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 204643CB82B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 09:20:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DDE33CB84B
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 09:19:34 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1AEA22003BB
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 09:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1672129172; i=@fujitsu.com;
 bh=TxIVIUNeiWWUf1HItQxgPcJ44uMIcqZKmEm7KNaG09k=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Bzq1vacF6A8nvN1+zWLao/2cM4m7J1pZ5dbEYsZXSbySXcQGZUwlSEtshA1/mUApt
 yyqtVSq4CdLU1YrVYTCcQjOxhWuM/tM7XSana+VPAryxECRSS2AsD8hzfEZSFsuS/p
 klQTFNbAHw/d5h9yK8eKDINhDZq+r2Jx4r4+d1IihOgEILaufiTKcWwZgLsZpBIkDt
 T7hVTmcuZhleoVag+XDlFB4ZitUKMFpvnYGOpZM9dUQvPZumPjCln4w/7Oume2MoNz
 ycdGvz71RzG0ka1zLopY7G82w0tqi+6HK+FkvDKsMZdKfHwnYmokFRLZ2FqOjU3D3e
 ij6m07V1/UYgw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8ORqDt51ap
 kgwu/pC1WfN/B6MDose/3OtYAxijWzLyk/IoE1ozG37/YCnboVHyespuxgXGVWhcjF4eQwFlG
 ibmnFrBCOAeYJPofv2aDcPYwSiy+NZepi5GTg01AU+JZ5wJmEFtEQEKio+EtO4jNLKAusXzSL
 7AaYYFgiStvutlAbBYBVYlN92+BxXkFPCWuPXkKVi8hoCAx5eF7sDmcAl4SGw4cYQGxhYBqdu
 6ewAhRLyhxcuYTFoj5EhIHX7xghuhVlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/
 AyLSK0aw4tagstUjX0FQvqSgzPaMkNzEzRy+xSjdRL7VUtzy1uETXUC+xvFgvtbhYr7gyNzkn
 RS8vtWQTIzB8U4rZi3cwPlj2R+8QoyQHk5Ior1T3qmQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKE
 rwGK4BygkWp6akVaZk5wFiCSUtw8CiJ8J5bBpTmLS5IzC3OTIdInWLU5VjbcGAvsxBLXn5eqp
 Q4r+ZKoCIBkKKM0jy4EbC4vsQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcvyCU8mXklcJt
 eAR3BBHTEh0MrQY4oSURISTUwsYn2rDtyoObcild6M99yXm8UEJszx/73/u3TOb2WRLCGPF/k
 naEhwFPnY/7lyam7N3Q+rZM2VeUINphxZH0sA9fT1bP7mTtclihFRr+7Viq6WOiKhX6G66+0r
 moD8cjY3T8uB3asd4p68u/m6uCVy3J7Kq+1Rzs1eyVu4f/qP1M9+XXtr10/L0m+tz9gqqnxKN
 72860bL2etl/X5Z78yV+UzV1NOyeP/VYHG+g9FdEN3zTzmlHWt/JPkjysTnfgblUUm3LuRof7
 FTTw0+rxohuVUf+1JdTmHk04ncV5acsp2Xcse7ajkPm5pCZUpk6dZhEcknnl90jVcPiHf5PCm
 rdasu7mYdF9NnbX4cAefEktxRqKhFnNRcSIAVLPlh2YDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-585.messagelabs.com!1672129171!195541!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16114 invoked from network); 27 Dec 2022 08:19:31 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-7.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Dec 2022 08:19:31 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 0F22F100182
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:19:31 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 02C14100043
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:19:31 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 27 Dec 2022 08:19:29 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 27 Dec 2022 17:20:13 +0800
Message-ID: <1672132813-26636-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Remove old kernel version check when using
 min_kver under 3.10
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

We have raised the minimal kernel version from 3.0 to 3.10,
so remove these useless check.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/c-test-api.txt                                  | 2 +-
 testcases/kernel/logging/kmsg/kmsg01.c              | 1 -
 testcases/kernel/syscalls/getxattr/getxattr05.c     | 1 -
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c     | 1 -
 testcases/kernel/syscalls/kcmp/kcmp01.c             | 1 -
 testcases/kernel/syscalls/kcmp/kcmp02.c             | 1 -
 testcases/kernel/syscalls/kcmp/kcmp03.c             | 1 -
 testcases/kernel/syscalls/madvise/madvise05.c       | 1 -
 testcases/kernel/syscalls/madvise/madvise06.c       | 1 -
 testcases/kernel/syscalls/madvise/madvise08.c       | 1 -
 testcases/kernel/syscalls/setsockopt/setsockopt02.c | 1 -
 11 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index e6d121dce..b15321ca2 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -559,7 +559,7 @@ static struct tst_test test = {
 Testcases for newly added kernel functionality require kernel newer than a
 certain version to run. All you need to skip a test on older kernels is to
 set the '.min_kver' string in the 'struct tst_test' to a minimal required
-kernel version, e.g. '.min_kver = "2.6.30"'.
+kernel version, e.g. '.min_kver = "4.10.0"'.
 
 For more complicated operations such as skipping a test for a certain range
 of kernel versions, following functions could be used:
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index bf2de5741..ba8179d5a 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -573,5 +573,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.test_all = test_kmsg,
-	.min_kver = "3.5.0"
 };
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index 28eb4cbcf..8d1752fd0 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -175,7 +175,6 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = do_getxattr,
-	.min_kver = "3.8",
 };
 
 #else /* HAVE_SYS_XATTR_H && HAVE_LIBACL*/
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
index ebc583b3e..3e461b307 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
@@ -83,7 +83,6 @@ static struct tst_test test = {
 		"CONFIG_CHECKPOINT_RESTORE",
 		NULL
 	},
-	.min_kver = "3.8.0",
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_msgrcv,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/kcmp/kcmp01.c b/testcases/kernel/syscalls/kcmp/kcmp01.c
index 903525ff0..0e7cc7a22 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp01.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp01.c
@@ -103,6 +103,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.test = verify_kcmp,
-	.min_kver = "3.5.0",
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
index ab07bb866..076b4a723 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp02.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
@@ -94,6 +94,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test = verify_kcmp,
-	.min_kver = "3.5.0",
 	.needs_tmpdir = 1
 };
diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 4b90e6d87..7af5cb150 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -87,5 +87,4 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.forks_child = 1,
 	.test = verify_kcmp,
-	.min_kver = "3.5.0"
 };
diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index 3ab4a8749..9b00a1ff0 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -46,7 +46,6 @@ static void verify_madvise(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "3.9.0",
 	.test_all = verify_madvise,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ee53664bda16"},
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index c1c55bbc2..c7967ae6f 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -235,7 +235,6 @@ static void test_advice_willneed(void)
 static struct tst_test test = {
 	.test_all = test_advice_willneed,
 	.setup = setup,
-	.min_kver = "3.10.0",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.save_restore = (const struct tst_path_val[]) {
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 0996cf91b..96bcaf159 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -208,7 +208,6 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.setup = setup,
 	.cleanup = cleanup,
-	.min_kver = "3.4.0",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt02.c b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
index f0a2a5ecd..e7621538b 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt02.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
@@ -96,5 +96,4 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.min_kver = "3.2",
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
