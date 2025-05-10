Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F819C3ABC3
	for <ltp@archiver.kernel.org>; Sat, 10 May 2025 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746867250; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Er0ZEt5Es2Zk2uOVwMvV7DRXqeggZ9aLJpR3s0ffnuE=;
 b=f+IDZOf3OlH1k94rmGaJX6cvJY7Auy5WucAEP1QMSKGjcd3mmUXgC7+oGd3yCQVmhb8JO
 6IGUd6lO42HJKN1yo93xa0Xq37v72HuRIpW9CTVNOijUWoSpmgCndpwn45bHSOnjeHlIgG/
 YT9ZiCxM9h0PR7BNViU7ARKK8QfsDZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D0363CC22D
	for <ltp@archiver.kernel.org>; Sat, 10 May 2025 10:54:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 252D43CC208
 for <ltp@lists.linux.it>; Sat, 10 May 2025 10:53:48 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51D1D600721
 for <ltp@lists.linux.it>; Sat, 10 May 2025 10:53:47 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a20257c815so96773f8f.3
 for <ltp@lists.linux.it>; Sat, 10 May 2025 01:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746867226; x=1747472026; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uOds1PPV6uR+4OMv93+lxYN6lkLYBAVonAN+6o2Paxc=;
 b=Q7WT6+QNkwgntIH1+wKlvRQNzQe0oeyl0eKosVlgRP44xvyYM04Jyf+RoaGvutMO3z
 AKO88IwnlxEy0gtbs4A2HpdTmHt8Jwa7D21o0mNJ7ygvicqzjv5uSjqu2/a8rAAlqbyr
 TdhUF/zS3dCOss+cz4GwRwIm2Cf8glHbQyNYMQTBGe7vDYW3JhWSEyaqdPRxakAiIOXj
 J+bHSqzzVSSj49cb5n0T+ShQ6plANzIGwYlHnGTHINPNSCL9yX7JzsSTBBuP/kAnIw/f
 ujYdBS92/lb3Ik3i6Qg4VF+3MuqqhXdus8oDJ0OBE2YVkfMK/NA9X2/AmUiaxXQhWzIo
 8g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867226; x=1747472026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uOds1PPV6uR+4OMv93+lxYN6lkLYBAVonAN+6o2Paxc=;
 b=TRH9E+Atxa0I8iK7mYF7vPGT5w7rWqWnGkNgRm5+nKpsaBAobsfxlqC/MrIWRBDg/q
 nko4UoWf6RNfxgIPikL1hPwAzI8fOjQF0+SmrAr/HowOLPpMmnj3hVzazcAKolr35CRU
 020sD2qeKwwIgm32aPNkm8gbIxdyuBXSbYMIHmY4hKlf83oVGW6h2j9sKNs+37zaVtD+
 pgzo3mF8hYumVMfxT3Q8N4zDL2nYyG/VsfXhO4HS7H71I3E2gbt2MwSL0/5X3iYUQQNo
 PrATzfwEltDmRum+NzM0gBAL7t6PmWmzJ+dCTzMI0uzGoisC/iFOeV/IA+V3WyDT5+ik
 uqeg==
X-Gm-Message-State: AOJu0YyFuWdNmVTrNf70o/wVK4aoyHZnMsNz7axzvNp9AGiUdEHjRJ9w
 7AtQGgR0qIEux7pDsRmB8y4fPcMr6oVqajgbO/NQTXPai13OFaDQ8zhydcOd/A6tMzsSGCf1YUR
 k3g==
X-Gm-Gg: ASbGncuGWbMiG+tE7Zt3wfvHRkvut742aZmOV2Sl/yqm/WcA9zorilv9zN3og8BwdCz
 xDP5ssFoiP035rxVaeSElTErM2Cbs4M2FEdrIn12QcpD0HlVOxx/CEJSxcVJ8tWnRuYpOn44b5t
 QNzpPxNhvw7MyM3RJwlTLAogP90/v9ZIjiIN6Rcg2bcEVcr3KPq7bMUn3hOFW6eg2EoDOdFaH1c
 352vxLcpwz1OMj3ZhGGeJ+x23yzkKvhRZvHrKc1e3jNrT7qEvj1kNi+vq6HC5vFifkpy756wPqZ
 +4j4zykq4iUo2FGgJ8MgzBhc+NAwxJB4mAbgc2pnCYga4kO0fys=
X-Google-Smtp-Source: AGHT+IHgemniMFUW7DPDf/K0wsbXx/ZzcybfQzNarO4mDxlh7XovgQLnZL+Lgys0fUv9lxMtDSxrnQ==
X-Received: by 2002:a05:6000:b07:b0:3a1:f7ca:a9cb with SMTP id
 ffacd0b85a97d-3a1f7caaa92mr3528770f8f.59.1746867226387; 
 Sat, 10 May 2025 01:53:46 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc8271c52sm29595245ad.138.2025.05.10.01.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 01:53:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat, 10 May 2025 16:53:24 -0400
Message-ID: <20250510205326.1353857-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with error
 due to uninitialized lib_pid
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The dirtyc0w_shmem test spawns a child process using execlp. This child process then calls tst_brk(), which exits early
with a non-zero status because execlp does not inherit the parent's lib_pid variable. Consequently, the parent process
incorrectly reports an "Invalid child exit value".

This commit addresses this by ensuring the child process has access to the necessary lib_pid and main_pid by passing
them through a shared results structure. This prevents the premature exit in the child and the subsequent error report
in the parent.

Related commit:
commit a1f82704c28d9e027ca899f5ca2841e7fe49de72
lib/tst_test.c: Fix tst_brk() handling

Detail failure log:
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_dirSOGVBC as tmpdir (btrfs filesystem)
tst_test.c:1938: TINFO: LTP version: 20250507.4a0e3a8fa
tst_test.c:1942: TINFO: Tested kernel: 6.4.0-150700.51-default #1 SMP Wed Apr 30 21:35:43 UTC 2025 (6930611) s390x
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:678: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1760: TINFO: Overall timeout per run is 0h 04m 00s
dirtyc0w_shmem.c:54: TINFO: Mounting tmp_dirtyc0w_shmem to /tmp/LTP_dirSOGVBC/tmp_dirtyc0w_shmem fstyp=tmpfs flags=0
dirtyc0w_shmem_child.c:160: TCONF: System does not have userfaultfd minor fault support for shmem <<<<<<<<<< 1
tst_test.c:481: TBROK: Invalid child (8163) exit value 32 <<<<<<<< 2
dirtyc0w_shmem.c:102: TINFO: Umounting /tmp/LTP_dirSOGVBC/tmp_dirtyc0w_shmem

tmp_dirtyc0w_shmem.c call execlp to create new process run dirtyc0w_shmem_child bin.

SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL)

Within dirtyc0w_shmem_child.c trigger

tst_brk(TCONF, "System does not have userfaultfd minor fault support for shmem")

Since execlp does not inherit the parent process's variables lib_pid, so it will return TCONF(32) directly.

void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
               va_list va)
{
...
        if (!lib_pid)
                exit(TTYPE_RESULT(ttype));   <<<<<
...
}

So finally captured by check_child_status report an error.

static void check_child_status(pid_t pid, int status)
{
...
        if (WEXITSTATUS(status))
                tst_brk(TBROK, "Invalid child (%i) exit value %i", pid, WEXITSTATUS(status));  <<<<
}

Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_test.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2bb4519dd..b666715b9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -59,7 +59,7 @@ static const char *tid;
 static int iterations = 1;
 static float duration = -1;
 static float timeout_mul = -1;
-static pid_t main_pid, lib_pid;
+static pid_t lib_pid;
 static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
@@ -78,6 +78,8 @@ struct results {
 	int abort_flag;
 	unsigned int runtime;
 	unsigned int overall_time;
+	pid_t lib_pid;
+	pid_t main_pid;
 };
 
 static struct results *results;
@@ -141,6 +143,7 @@ static void setup_ipc(void)
 		tst_futexes = (char *)results + sizeof(struct results);
 		tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
 	}
+	results->lib_pid = lib_pid;
 }
 
 static void cleanup_ipc(void)
@@ -391,7 +394,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	 * If tst_brk() is called from some of the C helpers even before the
 	 * library was initialized, just exit.
 	 */
-	if (!lib_pid)
+	if (!results->lib_pid)
 		exit(TTYPE_RESULT(ttype));
 
 	update_results(TTYPE_RESULT(ttype));
@@ -402,13 +405,13 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 	 * specified but CLONE_THREAD is not. Use direct syscall to avoid
 	 * cleanup running in the child.
 	 */
-	if (tst_getpid() == main_pid)
+	if (tst_getpid() == results->main_pid)
 		do_test_cleanup();
 
 	/*
 	 * The test library process reports result statistics and exits.
 	 */
-	if (getpid() == lib_pid)
+	if (getpid() == results->lib_pid)
 		do_exit(TTYPE_RESULT(ttype));
 
 	/*
@@ -426,9 +429,9 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
 		 * the main test process. That in turn triggers the code that
 		 * kills leftover children once the main test process did exit.
 		 */
-		if (main_pid && tst_getpid() != main_pid) {
+		if (results->main_pid && tst_getpid() != results->main_pid) {
 			tst_res(TINFO, "Child process reported TBROK killing the test");
-			kill(main_pid, SIGKILL);
+			kill(results->main_pid, SIGKILL);
 		}
 	}
 
@@ -1501,7 +1504,7 @@ static void do_setup(int argc, char *argv[])
 
 static void do_test_setup(void)
 {
-	main_pid = getpid();
+	results->main_pid = getpid();
 
 	if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
 		long fs_type = tst_fs_type(".");
@@ -1521,7 +1524,7 @@ static void do_test_setup(void)
 	if (tst_test->setup)
 		tst_test->setup();
 
-	if (main_pid != tst_getpid())
+	if (results->main_pid != tst_getpid())
 		tst_brk(TBROK, "Runaway child in setup()!");
 
 	if (tst_test->caps)
@@ -1584,7 +1587,7 @@ static void run_tests(void)
 		heartbeat();
 		tst_test->test_all();
 
-		if (tst_getpid() != main_pid)
+		if (tst_getpid() != results->main_pid)
 			exit(0);
 
 		tst_reap_children();
@@ -1600,7 +1603,7 @@ static void run_tests(void)
 		heartbeat();
 		tst_test->test(i);
 
-		if (tst_getpid() != main_pid)
+		if (tst_getpid() != results->main_pid)
 			exit(0);
 
 		tst_reap_children();
@@ -1930,7 +1933,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	tst_test = self;
 
 	do_setup(argc, argv);
-	tst_enable_oom_protection(lib_pid);
+	tst_enable_oom_protection(results->lib_pid);
 
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
