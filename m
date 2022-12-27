Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D470C10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 08:19:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 490D13CB821
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 09:19:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87E523CB842
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 09:19:32 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 75ABE1000654
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 09:19:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1672129169; i=@fujitsu.com;
 bh=/yM2mZZMyidJwkI569xoDImZ1jSSxa5iTek3LfZ8/vs=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=xRRUMYSBkNHqT9qT/E3zvpWMIXyMlm4vmvb0mue+AjnIoOhcupjMSSdEgFIQOllvM
 ET1ktrXw2ZCfdqmxVQEbPsodD1mmJSu9RAV/TvFayQ1gAIwlbQmkmh83ZkofEbiPsV
 E/kgrZIA0OVvt5FJ7qC29s9vaciBV6ZBBLEGndIXvOuKdSq9IlgQgv1pVwRcReM5wV
 Om4XtIv+GdGj+nA4jrZlIXDEQJRh85OxD97Tv8oCQTEvp1LJgBWz/Z5IEy/pqiMPF0
 WkpU3wVai4zxM+T/0bb0099OrMZdjoXFUtQtDaD0eW5nPpzsCRX0qbSkk62/nckIZr
 aUEINdEB9sZ0w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8MxSXfCqlX
 JBs8+K1qs+L6D0YHRY9/vdawBjFGsmXlJ+RUJrBnN2/+wFtxKqpg56SRbA+OD4C5GLg4hgbOM
 Eg9XXGGDcA4wSbzafIUJwtnDKLHu6C/WLkZODjYBTYlnnQuYQWwRAQmJjoa37CA2s4C6xPJJv
 5hAbGGBMInjTS8Yuxg5OFgEVCWWd5aBhHkFPCW2z/kOViIhoCAx5eF7sDGcAl4SGw4cYQGxhY
 Bqdu6ewAhRLyhxcuYTFojxEhIHX7xghuhVlLjU8Y0Rwq6QmDWrDWqmmsTVc5uYJzAKzkLSPgt
 J+wJGplWMpsWpRWWpRbqWeklFmekZJbmJmTl6iVW6iXqppbrlqcUluoZ6ieXFeqnFxXrFlbnJ
 OSl6eaklmxiBoZtSzPZ7B+P5ZX/0DjFKcjApifJKda9KFuJLyk+pzEgszogvKs1JLT7EKMPBo
 STBa7ACKCdYlJqeWpGWmQOMI5i0BAePkgjvuWVAad7igsTc4sx0iNQpRkUpcV7NlUAJAZBERm
 keXBssdi8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEubdC7KdJzOvBG76K6DFTECLPxxaCbK
 4JBEhJdXApPhBxq3/mfuep5euNIrvv7hgykr+ugaD6Y9W5/xpWKg9OfHMZqUTM1SO3j3S7rB3
 EvNfx3yxnDw/Fu6N9Q6Rz8NKL+/+eyv4rzfLgsl2H+826q9Yf9zd6fLibZvMtHw7bI9cXG+tw
 hJhOmGKHL/3E0NGrSf1IUrOh2NCVihxx4pxMc1Yf2ntNKFNztpNRbMqzhee81ZL7yusunzub2
 /XQ6kpi00tD7Fd4Vi+oonV0yLPYEfdM5v5ndveNh2oknz93XH3fatbX0xMpT8WXl976cvR11s
 tMstC5W9sLd7+1K/bIX2BsRz3JJnal8vuG6ue+3m5gGnbkb7zX2plJ0zI+Bsqs4t53+VHrPwX
 t8S+ClViKc5INNRiLipOBAD4MmMfWAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1672129168!462073!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11731 invoked from network); 27 Dec 2022 08:19:28 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Dec 2022 08:19:28 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 2B0011000D5
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:19:28 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1D7B51000D2
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 08:19:28 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 27 Dec 2022 08:19:26 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 27 Dec 2022 17:20:12 +0800
Message-ID: <1672132813-26636-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] Remove old kernel version check when using
 tst_kvercmp under 3.10
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
 include/lapi/init_module.h                      | 12 ------------
 .../kernel/containers/userns/userns_helper.h    |  3 ---
 .../controllers/cgroup_xattr/cgroup_xattr.c     |  5 -----
 testcases/kernel/device-drivers/acpi/ltp_acpi.c | 15 ---------------
 .../kernel/firmware/fw_load_user/fw_load.c      |  5 -----
 testcases/kernel/input/input_helper.c           | 17 ++++-------------
 .../security/prot_hsymlinks/prot_hsymlinks.c    |  4 ----
 .../kernel/syscalls/fallocate/fallocate04.c     |  9 ++-------
 .../syscalls/finit_module/finit_module01.c      |  2 --
 .../syscalls/finit_module/finit_module02.c      |  2 --
 testcases/kernel/syscalls/ioctl/ioctl01.c       |  8 --------
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c |  3 +--
 testcases/kernel/syscalls/madvise/madvise02.c   |  3 +--
 testcases/kernel/syscalls/mbind/mbind01.c       |  6 ------
 testcases/kernel/syscalls/mlockall/mlockall02.c |  3 +--
 testcases/kernel/syscalls/pipe2/pipe2_01.c      |  4 ----
 .../kernel/syscalls/sockioctl/sockioctl01.c     |  3 +--
 testcases/network/netstress/netstress.c         |  3 ---
 18 files changed, 10 insertions(+), 97 deletions(-)

diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
index fe35ec3ae..ba0d2b266 100644
--- a/include/lapi/init_module.h
+++ b/include/lapi/init_module.h
@@ -22,16 +22,4 @@ static inline int finit_module(int fd, const char *param_values, int flags)
 	return tst_syscall(__NR_finit_module, fd, param_values, flags);
 }
 
-static inline void finit_module_supported_by_kernel(void)
-{
-       long ret;
-
-       if ((tst_kvercmp(3, 8, 0)) < 0) {
-               /* Check if the syscall is backported on an older kernel */
-               ret = syscall(__NR_finit_module, 0, "", 0);
-               if (ret == -1 && errno == ENOSYS)
-                       tst_brk(TCONF, "Test not supported on kernel version < v3.8");
-       }
-}
-
 #endif /* LAPI_INIT_MODULE_H__ */
diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
index 2759d32c2..be47690ea 100644
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ b/testcases/kernel/containers/userns/userns_helper.h
@@ -29,9 +29,6 @@ static int check_newuser(void)
 {
 	int pid, status;
 
-	if (tst_kvercmp(3, 8, 0) < 0)
-		tst_brkm(TCONF, NULL, "CLONE_NEWUSER not supported");
-
 	pid = do_clone_unshare_test(T_CLONE, CLONE_NEWUSER, dummy_child, NULL);
 	if (pid == -1)
 		tst_brkm(TCONF | TERRNO, NULL, "CLONE_NEWUSER not supported");
diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index 71a03d12c..a870118f5 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -150,11 +150,6 @@ void setup(int argc, char *argv[])
 	if (access("/proc/cgroups", F_OK) == -1)
 		tst_brkm(TCONF, NULL, "Kernel doesn't support cgroups");
 
-	if (tst_kvercmp(3, 7, 0) < 0) {
-		tst_brkm(TCONF, NULL,
-			"Test must be run with kernel 3.7 or newer");
-	}
-
 	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
 		if (!strcmp(tkeys[i].name, "security.")) {
 			tkeys[i].good = tst_kvercmp(3, 15, 0) < 0;
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
index 08d4d8632..7dba04552 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
@@ -57,8 +57,6 @@ static int tc_acpi_str(void)
 	int res, ret = 0;
 	char descr[4096], sysfs_path[4096];
 
-	int not_kver_3_7 = tst_kvercmp(3, 7, 0) < 0;
-
 	while (1) {
 
 		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", ACPI_TRAVERSE);
@@ -86,19 +84,6 @@ static int tc_acpi_str(void)
 			continue;
 		}
 
-		/*
-		 * Find device description in sysfs.
-		 *
-		 * New sysfs interface to export device description
-		 * implemented since Linux 3.7
-		 */
-		if (not_kver_3_7) {
-			tst_resm(TINFO, "sysfs _STR check required Linux 3.7+");
-			ret = TCONF;
-			/* continue, we can still traverse ACPI devices */
-			continue;
-		}
-
 		strcat(sysfs_path, "/description");
 		if (access(sysfs_path, R_OK)) {
 			tst_resm(TINFO, "can't find description file '%s'",
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index e81d159f6..83648b625 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -114,11 +114,6 @@ void setup(int argc, char *argv[])
 
 	tst_require_root();
 
-	if (tst_kvercmp(3, 7, 0) < 0) {
-		tst_brkm(TCONF, NULL,
-			"Test must be run with kernel 3.7 or newer");
-	}
-
 	char fw_size_param[19];
 	snprintf(fw_size_param, 19, "fw_size=%d", fw_size);
 	char *const mod_params[2] = { fw_size_param, NULL };
diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
index c4736eadd..09530fb4d 100644
--- a/testcases/kernel/input/input_helper.c
+++ b/testcases/kernel/input/input_helper.c
@@ -249,27 +249,18 @@ int check_sync_event(struct input_event *iev)
 int no_events_queued(int fd, int stray_sync_event)
 {
 	struct pollfd fds = {.fd = fd, .events = POLLIN};
-	int ret, res, sync_event_ignored;
+	int ret, res;
 	struct input_event ev;
 
-	if (tst_kvercmp(3, 7, 0) < 0 && stray_sync_event)
-		sync_event_ignored = 1;
-
 	ret = poll(&fds, 1, 30);
 
 	if (ret > 0) {
 		res = read(fd, &ev, sizeof(ev));
 
 		if (res == sizeof(ev)) {
-			if (sync_event_ignored && check_sync_event(&ev)) {
-				ret = 0;
-				tst_resm(TINFO,
-					 "Ignoring stray sync event (known problem)");
-			} else {
-				tst_resm(TINFO,
-					 "Unexpected ev type=%i code=%i value=%i",
-					 ev.type, ev.code, ev.value);
-			}
+			tst_resm(TINFO,
+				"Unexpected ev type=%i code=%i value=%i",
+				ev.type, ev.code, ev.value);
 		}
 	}
 
diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 369df2b22..20f33527c 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -193,10 +193,6 @@ static void setup(int argc, char *argv[])
 
 	tst_require_root();
 
-	if (tst_kvercmp(3, 7, 0) < 0)
-		tst_brkm(TCONF, NULL,
-			"Test must be run with kernel 3.7 or newer");
-
 	if (eaccess("/etc/passwd", W_OK)) {
 		tst_brkm(TCONF, NULL,
 			"/etc/passwd is not accessible");
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 0014241da..ff372a9bf 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -121,13 +121,8 @@ static void test02(void)
 			tst_brk(TFAIL | TERRNO,
 				 "fallocate() or lseek() failed");
 		}
-		if (tst_kvercmp(3, 1, 0) < 0) {
-			tst_res(TINFO, "lseek() doesn't support SEEK_HOLE, "
-				 "this is expected for < 3.1 kernels");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				 "lseek() doesn't support SEEK_HOLE");
-		}
+		tst_brk(TBROK | TERRNO,
+			"lseek() doesn't support SEEK_HOLE");
 	} else {
 		tst_res(TINFO, "found a hole at '%ld' offset", ret);
 	}
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index 21c35f101..f960b2e40 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -25,8 +25,6 @@ static char *mod_path;
 
 static void setup(void)
 {
-	finit_module_supported_by_kernel();
-
 	tst_module_exists(MODULE_NAME, &mod_path);
 
 	fd = SAFE_OPEN(mod_path, O_RDONLY|O_CLOEXEC);
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index b3437b5d0..a7434de7d 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -81,8 +81,6 @@ static void setup(void)
 {
 	unsigned long int i;
 
-	finit_module_supported_by_kernel();
-
 	tst_module_exists(MODULE_NAME, &mod_path);
 
 	kernel_lockdown = tst_lockdown_enabled();
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 26b603ebe..2989c0e9b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -79,14 +79,6 @@ static void setup(void)
 		tst_brk(TBROK, "You must specify a tty device with -D option");
 
 	fd = SAFE_OPEN(device, O_RDWR, 0777);
-
-	if (tst_kvercmp(3, 7, 0) < 0) {
-		for (i = 0; i < ARRAY_SIZE(tcases); i++) {
-			if (tcases[i].request == INVAL_IOCTL)
-				tcases[i].error = EINVAL;
-		}
-	}
-
 	fd_file = SAFE_OPEN("x", O_CREAT, 0777);
 }
 
diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
index f4bca5ec8..d2d1a882a 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
@@ -247,8 +247,7 @@ static void setup(void)
 {
 	msgkey = GETIPCKEY();
 
-	if (tst_kvercmp(3, 8, 0) >= 0)
-		msg_copy_sup = 1;
+	msg_copy_sup = 1;
 }
 
 static void (*testfunc[])(void) = {test_msg_except, test_msg_noerror,
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index b158dc351..858d67ae2 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -107,8 +107,7 @@ static void tcases_filter(void)
 			/* In kernel commit 1998cc0, madvise(MADV_WILLNEED) to
 			 * anon mem doesn't return -EBADF now, as now we support
 			 * swap prefretch. */
-			if ((tst_kvercmp(3, 9, 0)) > 0 &&
-					tc->exp_errno == EBADF)
+			if (tc->exp_errno == EBADF)
 				tc->skip = 1;
 		break;
 		case MADV_FREE:
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 5f3c5d7c0..4b8d168cd 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -197,12 +197,6 @@ static void do_test(unsigned int i)
 	tst_res(TINFO, "case %s", tc->desc);
 
 	if (tc->policy == MPOL_LOCAL) {
-		if ((tst_kvercmp(3, 8, 0)) < 0) {
-			tst_res(TCONF, "%s is not supported",
-				tst_mempolicy_mode_name(tc->policy));
-			return;
-		}
-
 		if ((tst_kvercmp(5, 14, 0)) >= 0)
 			tc->check_policy = NULL;
 	}
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index e301bcb03..94d6e3270 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -230,8 +230,7 @@ void cleanup_test(int i)
 
 	switch (i) {
 	case 0:
-		if (tst_kvercmp(2, 6, 9) >= 0)
-			seteuid(0);
+		seteuid(0);
 
 		rl.rlim_max = -1;
 		rl.rlim_cur = -1;
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_01.c b/testcases/kernel/syscalls/pipe2/pipe2_01.c
index 6597162e7..87e81a455 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_01.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_01.c
@@ -54,10 +54,6 @@ static void verify_pipe2(unsigned int n)
 	int get_flag = 0, i = 0;
 
 	tst_res(TINFO, "%s ", tc->message);
-	if ((tc->flags ==  O_DIRECT) && (tst_kvercmp(3, 4, 0)) < 0) {
-		tst_res(TCONF, "O_DIRECT needs Linux 3.4 or newer");
-		return;
-	}
 
 	SAFE_PIPE2(fds, tc->flags);
 	for (i = 0; i < 2; i++) {
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 155f0cec5..51dac9c16 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -190,8 +190,7 @@ static void setup0(void)
 		 * changed -EINVAL to -ENOIOCTLCMD, so vfs_ioctl now
 		 * returns -ENOTTY.
 		 */
-		if ((tst_kvercmp(3, 5, 0)) >= 0)
-			tdat[testno].experrno = ENOTTY;
+		tdat[testno].experrno = ENOTTY;
 	}
 }
 
diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 7c222531d..6a888f2ee 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -882,9 +882,6 @@ static void setup(void)
 	if (!clients_num)
 		clients_num = sysconf(_SC_NPROCESSORS_ONLN);
 
-	if (tfo_value > 0 && tst_kvercmp(3, 7, 0) < 0)
-		tst_brk(TCONF, "Test must be run with kernel 3.7 or newer");
-
 	if (busy_poll >= 0 && tst_kvercmp(3, 11, 0) < 0)
 		tst_brk(TCONF, "Test must be run with kernel 3.11 or newer");
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
