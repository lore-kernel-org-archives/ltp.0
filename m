Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33412C71148
	for <ltp@archiver.kernel.org>; Fri, 13 Jun 2025 14:55:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23EDE3CB5CA
	for <ltp@archiver.kernel.org>; Fri, 13 Jun 2025 16:55:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CA893C9188
 for <ltp@lists.linux.it>; Fri, 13 Jun 2025 16:55:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D18D1A0092B
 for <ltp@lists.linux.it>; Fri, 13 Jun 2025 16:54:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 594B31F397;
 Fri, 13 Jun 2025 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749826497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+7xJuyHfrBg47cysf79eiD4tI1KTvOf2+VBLR/Q2Bs=;
 b=qT+tbuxJ5431zF6tGhGsz+xFNP2YGXdYmF7ozk4cCkdGvPS6uoB00pJjOJfZn8BEi79o/H
 sBzu+gQBdGCsB/daRE/c6RV99E+sTHZmLmVmPTkzL2qUrPsft7/iGNdmtzF9ZopsTZVAch
 Klpfp5G2gn47zIoZRnfvJBBxlX2UydY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749826497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+7xJuyHfrBg47cysf79eiD4tI1KTvOf2+VBLR/Q2Bs=;
 b=Wyamt5ylWYH8GVeEXKfbTtdSEiM0LSli2NcdroKgRw1ykx4cD/I495fycedGtqf0D80SHQ
 rU+xscJouyQwKlDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qT+tbuxJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Wyamt5yl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749826497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+7xJuyHfrBg47cysf79eiD4tI1KTvOf2+VBLR/Q2Bs=;
 b=qT+tbuxJ5431zF6tGhGsz+xFNP2YGXdYmF7ozk4cCkdGvPS6uoB00pJjOJfZn8BEi79o/H
 sBzu+gQBdGCsB/daRE/c6RV99E+sTHZmLmVmPTkzL2qUrPsft7/iGNdmtzF9ZopsTZVAch
 Klpfp5G2gn47zIoZRnfvJBBxlX2UydY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749826497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+7xJuyHfrBg47cysf79eiD4tI1KTvOf2+VBLR/Q2Bs=;
 b=Wyamt5ylWYH8GVeEXKfbTtdSEiM0LSli2NcdroKgRw1ykx4cD/I495fycedGtqf0D80SHQ
 rU+xscJouyQwKlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4712913782;
 Fri, 13 Jun 2025 14:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cTGQEME7TGhIHwAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 13 Jun 2025 14:54:57 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Fri, 13 Jun 2025 16:54:56 +0200
Message-ID: <2804439.mvXUDI8C0e@thinkpad>
In-Reply-To: <20250606110541.220472-3-liwang@redhat.com>
References: <20250606110541.220472-1-liwang@redhat.com>
 <20250606110541.220472-3-liwang@redhat.com>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 594B31F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] lib: moves test infrastructure states into
 a shared context structure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

This seems to be causing a regression with connectors/pec test:

susetest:~/ltp/testcases/kernel/connectors/pec # ./cn_pec.sh 
cn_pec 1 TINFO: Running: cn_pec.sh 
cn_pec 1 TINFO: Tested kernel: Linux susetest 6.14.6-2-default #1 SMP PREEMPT_DYNAMIC Tue May 13 09:56:22 UTC 2025 (ad69173) x86_64 x86_64 x86_64 GNU/Linux
cn_pec 1 TINFO: Using /tmp/LTP_cn_pec.djtsC3Zcsz as tmpdir (tmpfs filesystem)
cn_pec 1 TINFO: timeout per run is 0h 5m 0s
cn_pec 1 TINFO: Test process events connector
cn_pec 1 TINFO: Testing fork event (nevents=10)
tst_test.c:199: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 4, 0)
tst_test.c:203: TBROK: Invalid shared memory region (bad magic)
tst_test.c:199: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 3, 0)
tst_test.c:203: TBROK: Invalid shared memory region (bad magic)
tst_test.c:199: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 3, 0)
tst_test.c:203: TBROK: Invalid shared memory region (bad magic)
cn_pec 1 TBROK: tst_checkpoint wait 10000 0 failed
cn_pec 1 TINFO: SELinux enabled in enforcing mode, this may affect test results
cn_pec 1 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
cn_pec 1 TINFO: loaded SELinux profiles: none

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0




On Friday, June 6, 2025 1:05:41 PM CEST Li Wang via ltp wrote:
> This patch introduces a new struct context to consolidate various
> runtime state variables previously maintained as global variables
> in tst_test.c. The goal is to support better state sharing between
> parent and child processes particularly in scenarios that involve
> checkpointing or fork/exec patterns.
> 
> To achieve this, a new struct ipc_region is defined, which encapsulates
> three components: a magic field for validation, a context structure for
> runtime metadata, and a results structure for test result counters.
> Optionally, a futex array is appended for test checkpoint synchronization.
> 
> Test library IPC region (only one page size):
> 
>         +----------------------+
>         |   Magic Number       |
>         +----------------------+
>         |   struct context     |
>         +----------------------+
>         |   struct results     |
>         +----------------------+
>         |   futexes[], or N/A  |
>         +----------------------+
> 
> The shared memory region is allocated with a single page using mmap()
> and is zero-initialized with memset() to ensure a clean initial state.
> 
> The patch refactors setup_ipc() and tst_reinit() to map this shared
> region and properly initialize internal pointers to the `context`,
> `results`, and `futexes` regions.
> 
> Overall, this refactor reduces global state pollution, centralizes the
> runtime state management, and enables safe and efficient state sharing
> across test lifecycle phases. It also sets the foundation for future
> improvements such as multi-threaded test coordination or enhanced IPC
> mechanisms.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_test.c | 209 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 118 insertions(+), 91 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 92dd6279d..8cb3507c9 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -52,6 +52,7 @@ const char *TCID __attribute__((weak));
>  #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
>  
>  #define DEFAULT_TIMEOUT 30
> +#define LTP_MAGIC 0x4C54504D /* Magic number is "LTPM" */
>  
>  struct tst_test *tst_test;
>  
> @@ -59,36 +60,47 @@ static const char *tcid;
>  static int iterations = 1;
>  static float duration = -1;
>  static float timeout_mul = -1;
> -static int mntpoint_mounted;
> -static int ovl_mounted;
> -static struct timespec tst_start_time; /* valid only for test pid */
> -static int tdebug;
>  static int reproducible_output;
>  
> -struct results {
> -	int passed;
> -	int skipped;
> -	int failed;
> -	int warnings;
> -	int broken;
> +struct context {
> +	int32_t lib_pid;
> +	int32_t main_pid;
> +	struct timespec start_time;
> +	int32_t runtime;
> +	int32_t overall_time;
>  	/*
>  	 * This is set by a call to tst_brk() with TBROK parameter and means
>  	 * that the test should exit immediately.
>  	 */
> -	int abort_flag;
> -	unsigned int runtime;
> -	unsigned int overall_time;
> -	pid_t lib_pid;
> -	pid_t main_pid;
> +	tst_atomic_t abort_flag;
> +	uint32_t mntpoint_mounted:1;
> +	uint32_t ovl_mounted:1;
> +	uint32_t tdebug:1;
>  };
>  
> -static struct results *results;
> +struct results {
> +	tst_atomic_t passed;
> +	tst_atomic_t skipped;
> +	tst_atomic_t failed;
> +	tst_atomic_t warnings;
> +	tst_atomic_t broken;
> +};
>  
> -static int ipc_fd;
> +struct ipc_region {
> +	int32_t magic;
> +	struct context context;
> +	struct results results;
> +	futex_t futexes[];
> +};
>  
> -extern void *tst_futexes;
> +static struct ipc_region *ipc;
> +static struct context *context;
> +static struct results *results;
> +
> +extern volatile void *tst_futexes;
>  extern unsigned int tst_max_futexes;
>  
> +static int ipc_fd;
>  static char ipc_path[1064];
>  const char *tst_ipc_path = ipc_path;
>  
> @@ -127,25 +139,29 @@ static void setup_ipc(void)
>  
>  	SAFE_FTRUNCATE(ipc_fd, size);
>  
> -	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, ipc_fd, 0);
> -
> -	/* Checkpoints needs to be accessible from processes started by exec() */
> -	if (tst_test->needs_checkpoints || tst_test->child_needs_reinit) {
> -		sprintf(ipc_path, IPC_ENV_VAR "=%s", shm_path);
> -		putenv(ipc_path);
> -	} else {
> -		SAFE_UNLINK(shm_path);
> -	}
> +	ipc = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, ipc_fd, 0);
>  
>  	SAFE_CLOSE(ipc_fd);
>  
> +	memset(ipc, 0, size);
> +
> +	ipc->magic = LTP_MAGIC;
> +	context = &ipc->context;
> +	results = &ipc->results;
> +	context->lib_pid = getpid();
> +
>  	if (tst_test->needs_checkpoints) {
> -		tst_futexes = (char *)results + sizeof(struct results);
> -		tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
> +		tst_futexes = ipc->futexes;
> +		tst_max_futexes = (size - offsetof(struct ipc_region, futexes)) / sizeof(futex_t);
>  	}
>  
> -	memset(results, 0 , size);
> -	results->lib_pid = getpid();
> +	/* Set environment variable for exec()'d children */
> +	if (tst_test->needs_checkpoints || tst_test->child_needs_reinit) {
> +		snprintf(ipc_path, sizeof(ipc_path), IPC_ENV_VAR "=%s", shm_path);
> +		putenv(ipc_path);
> +	} else {
> +		SAFE_UNLINK(shm_path);
> +	}
>  }
>  
>  static void cleanup_ipc(void)
> @@ -158,9 +174,11 @@ static void cleanup_ipc(void)
>  	if (shm_path[0] && !access(shm_path, F_OK) && unlink(shm_path))
>  		tst_res(TWARN | TERRNO, "unlink(%s) failed", shm_path);
>  
> -	if (results) {
> -		msync((void *)results, size, MS_SYNC);
> -		munmap((void *)results, size);
> +	if (ipc) {
> +		msync((void *)ipc, size, MS_SYNC);
> +		munmap((void *)ipc, size);
> +		ipc = NULL;
> +		context = NULL;
>  		results = NULL;
>  	}
>  }
> @@ -178,12 +196,21 @@ void tst_reinit(void)
>  		tst_brk(TBROK, "File %s does not exist!", path);
>  
>  	fd = SAFE_OPEN(path, O_RDWR);
> +	ipc = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	SAFE_CLOSE(fd);
>  
> -	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> -	tst_futexes = (char *)results + sizeof(struct results);
> -	tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
> +	if (ipc->magic != LTP_MAGIC)
> +		tst_brk(TBROK, "Invalid shared memory region (bad magic)");
>  
> -	SAFE_CLOSE(fd);
> +	/* Restore the parent context from IPC region */
> +	context = &ipc->context;
> +	results = &ipc->results;
> +
> +	tst_futexes = ipc->futexes;
> +	tst_max_futexes = (size - offsetof(struct ipc_region, futexes)) / sizeof(futex_t);
> +
> +	if (context->tdebug)
> +		tst_res(TINFO, "tst_reinit(): restored metadata for PID %d", getpid());
>  }
>  
>  extern char **environ;
> @@ -400,7 +427,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>  	 * If tst_brk() is called from some of the C helpers even before the
>  	 * library was initialized, just exit.
>  	 */
> -	if (!results || !results->lib_pid)
> +	if (!results || !context->lib_pid)
>  		exit(TTYPE_RESULT(ttype));
>  
>  	update_results(TTYPE_RESULT(ttype));
> @@ -411,13 +438,13 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>  	 * specified but CLONE_THREAD is not. Use direct syscall to avoid
>  	 * cleanup running in the child.
>  	 */
> -	if (tst_getpid() == results->main_pid)
> +	if (tst_getpid() == context->main_pid)
>  		do_test_cleanup();
>  
>  	/*
>  	 * The test library process reports result statistics and exits.
>  	 */
> -	if (getpid() == results->lib_pid)
> +	if (getpid() == context->lib_pid)
>  		do_exit(TTYPE_RESULT(ttype));
>  
>  	/*
> @@ -428,16 +455,16 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>  	 */
>  	if (TTYPE_RESULT(ttype) == TBROK) {
>  		if (results)
> -			tst_atomic_inc(&results->abort_flag);
> +			tst_atomic_inc(&context->abort_flag);
>  
>  		/*
>  		 * If TBROK was called from one of the child processes we kill
>  		 * the main test process. That in turn triggers the code that
>  		 * kills leftover children once the main test process did exit.
>  		 */
> -		if (results->main_pid && tst_getpid() != results->main_pid) {
> +		if (context->main_pid && tst_getpid() != context->main_pid) {
>  			tst_res(TINFO, "Child process reported TBROK killing the test");
> -			kill(results->main_pid, SIGKILL);
> +			kill(context->main_pid, SIGKILL);
>  		}
>  	}
>  
> @@ -449,7 +476,7 @@ void tst_res_(const char *file, const int lineno, int ttype,
>  {
>  	va_list va;
>  
> -	if (ttype == TDEBUG && !tdebug)
> +	if (ttype == TDEBUG && context && !context->tdebug)
>  		return;
>  
>  	va_start(va, fmt);
> @@ -766,7 +793,7 @@ static void parse_opts(int argc, char *argv[])
>  		break;
>  		case 'D':
>  			tst_res(TINFO, "Enabling debug info");
> -			tdebug = 1;
> +			context->tdebug = 1;
>  		break;
>  		case 'h':
>  			print_help();
> @@ -1111,7 +1138,7 @@ static int prepare_and_mount_ro_fs(const char *dev, const char *mntpoint,
>  		return 1;
>  	}
>  
> -	mntpoint_mounted = 1;
> +	context->mntpoint_mounted = 1;
>  
>  	snprintf(buf, sizeof(buf), "%s/dir/", mntpoint);
>  	SAFE_MKDIR(buf, 0777);
> @@ -1135,14 +1162,14 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
>  		tst_res(TINFO, "tmpdir isn't suitable for creating devices, "
>  			"mounting tmpfs without nodev on %s", mntpoint);
>  		SAFE_MOUNT(NULL, mntpoint, "tmpfs", 0, NULL);
> -		mntpoint_mounted = 1;
> +		context->mntpoint_mounted = 1;
>  	}
>  }
>  
>  static void prepare_and_mount_hugetlb_fs(void)
>  {
>  	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
> -	mntpoint_mounted = 1;
> +	context->mntpoint_mounted = 1;
>  }
>  
>  int tst_creat_unlinked(const char *path, int flags, mode_t mode)
> @@ -1228,7 +1255,7 @@ static void prepare_device(struct tst_fs *fs)
>  
>  		SAFE_MOUNT(get_device_name(tdev.fs_type), tst_test->mntpoint,
>  				tdev.fs_type, fs->mnt_flags, mnt_data);
> -		mntpoint_mounted = 1;
> +		context->mntpoint_mounted = 1;
>  	}
>  }
>  
> @@ -1324,6 +1351,14 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>  		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
>  
> +	if (tst_test->sample)
> +		tst_test = tst_timer_test_setup(tst_test);
> +
> +	if (tst_test->runs_script) {
> +		tst_test->child_needs_reinit = 1;
> +		tst_test->forks_child = 1;
> +	}
> +
>  	if (reproducible_env &&
>  	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
>  		reproducible_output = 1;
> @@ -1332,23 +1367,15 @@ static void do_setup(int argc, char *argv[])
>  
>  	TCID = tcid = get_tcid(argv);
>  
> -	if (tst_test->sample)
> -		tst_test = tst_timer_test_setup(tst_test);
> +	setup_ipc();
>  
>  	parse_opts(argc, argv);
>  
>  	if (tdebug_env && (!strcmp(tdebug_env, "1") || !strcmp(tdebug_env, "y"))) {
>  		tst_res(TINFO, "Enabling debug info");
> -		tdebug = 1;
> +		context->tdebug = 1;
>  	}
>  
> -	if (tst_test->runs_script) {
> -		tst_test->child_needs_reinit = 1;
> -		tst_test->forks_child = 1;
> -	}
> -
> -	setup_ipc();
> -
>  	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
>  		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
>  
> @@ -1466,7 +1493,7 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->needs_hugetlbfs)
>  		prepare_and_mount_hugetlb_fs();
>  
> -	if (tst_test->needs_device && !mntpoint_mounted) {
> +	if (tst_test->needs_device && !context->mntpoint_mounted) {
>  		tdev.dev = tst_acquire_device_(NULL, tst_test->dev_min_size);
>  
>  		if (!tdev.dev)
> @@ -1492,12 +1519,12 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->needs_overlay && !tst_test->mount_device)
>  		tst_brk(TBROK, "tst_test->mount_device must be set");
>  
> -	if (tst_test->needs_overlay && !mntpoint_mounted)
> +	if (tst_test->needs_overlay && !context->mntpoint_mounted)
>  		tst_brk(TBROK, "tst_test->mntpoint must be mounted");
>  
> -	if (tst_test->needs_overlay && !ovl_mounted) {
> +	if (tst_test->needs_overlay && !context->ovl_mounted) {
>  		SAFE_MOUNT_OVERLAY();
> -		ovl_mounted = 1;
> +		context->ovl_mounted = 1;
>  	}
>  
>  	if (tst_test->resource_files)
> @@ -1517,7 +1544,7 @@ static void do_setup(int argc, char *argv[])
>  
>  static void do_test_setup(void)
>  {
> -	results->main_pid = getpid();
> +	context->main_pid = getpid();
>  
>  	if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
>  		long fs_type = tst_fs_type(".");
> @@ -1537,7 +1564,7 @@ static void do_test_setup(void)
>  	if (tst_test->setup)
>  		tst_test->setup();
>  
> -	if (results->main_pid != tst_getpid())
> +	if (context->main_pid != tst_getpid())
>  		tst_brk(TBROK, "Runaway child in setup()!");
>  
>  	if (tst_test->caps)
> @@ -1549,10 +1576,10 @@ static void do_cleanup(void)
>  	if (tst_test->needs_cgroup_ctrls)
>  		tst_cg_cleanup();
>  
> -	if (ovl_mounted)
> +	if (context->ovl_mounted)
>  		SAFE_UMOUNT(OVL_MNT);
>  
> -	if (mntpoint_mounted)
> +	if (context->mntpoint_mounted)
>  		tst_umount(tst_test->mntpoint);
>  
>  	if (tst_test->needs_device && tdev.dev)
> @@ -1574,7 +1601,7 @@ static void do_cleanup(void)
>  
>  static void heartbeat(void)
>  {
> -	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
> +	if (tst_clock_gettime(CLOCK_MONOTONIC, &context->start_time))
>  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>  
>  	if (getppid() == 1) {
> @@ -1600,7 +1627,7 @@ static void run_tests(void)
>  		heartbeat();
>  		tst_test->test_all();
>  
> -		if (tst_getpid() != results->main_pid)
> +		if (tst_getpid() != context->main_pid)
>  			exit(0);
>  
>  		tst_reap_children();
> @@ -1616,7 +1643,7 @@ static void run_tests(void)
>  		heartbeat();
>  		tst_test->test(i);
>  
> -		if (tst_getpid() != results->main_pid)
> +		if (tst_getpid() != context->main_pid)
>  			exit(0);
>  
>  		tst_reap_children();
> @@ -1716,7 +1743,7 @@ static void alarm_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  
>  static void heartbeat_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
> -	alarm(results->overall_time);
> +	alarm(context->overall_time);
>  	sigkill_retries = 0;
>  }
>  
> @@ -1733,15 +1760,15 @@ unsigned int tst_remaining_runtime(void)
>  	static struct timespec now;
>  	int elapsed;
>  
> -	if (results->runtime == 0)
> +	if (context->runtime == 0)
>  		tst_brk(TBROK, "Runtime not set!");
>  
>  	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
>  		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
>  
> -	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
> -	if (results->runtime > (unsigned int) elapsed)
> -		return results->runtime - elapsed;
> +	elapsed = tst_timespec_diff_ms(now, context->start_time) / 1000;
> +	if (context->runtime > elapsed)
> +		return context->runtime - elapsed;
>  
>  	return 0;
>  }
> @@ -1769,29 +1796,29 @@ static void set_overall_timeout(void)
>  		return;
>  	}
>  
> -	results->overall_time = tst_multiply_timeout(timeout) + results->runtime;
> +	context->overall_time = tst_multiply_timeout(timeout) + context->runtime;
>  
>  	tst_res(TINFO, "Overall timeout per run is %uh %02um %02us",
> -		results->overall_time/3600, (results->overall_time%3600)/60,
> -		results->overall_time % 60);
> +		context->overall_time/3600, (context->overall_time%3600)/60,
> +		context->overall_time % 60);
>  }
>  
>  void tst_set_timeout(int timeout)
>  {
>  	int timeout_adj = DEFAULT_TIMEOUT + timeout;
>  
> -	results->overall_time = tst_multiply_timeout(timeout_adj) + results->runtime;
> +	context->overall_time = tst_multiply_timeout(timeout_adj) + context->runtime;
>  
>  	tst_res(TINFO, "Overall timeout per run is %uh %02um %02us",
> -		results->overall_time/3600, (results->overall_time%3600)/60,
> -		results->overall_time % 60);
> +		context->overall_time/3600, (context->overall_time%3600)/60,
> +		context->overall_time % 60);
>  
>  	heartbeat();
>  }
>  
>  void tst_set_runtime(int runtime)
>  {
> -	results->runtime = multiply_runtime(runtime);
> +	context->runtime = multiply_runtime(runtime);
>  	tst_res(TINFO, "Updating runtime to %uh %02um %02us",
>  		runtime/3600, (runtime%3600)/60, runtime % 60);
>  	set_overall_timeout();
> @@ -1805,7 +1832,7 @@ static int fork_testrun(void)
>  	SAFE_SIGNAL(SIGINT, sigint_handler);
>  	SAFE_SIGNAL(SIGTERM, sigint_handler);
>  
> -	alarm(results->overall_time);
> +	alarm(context->overall_time);
>  
>  	show_failure_hints = 1;
>  
> @@ -1839,7 +1866,7 @@ static int fork_testrun(void)
>  	if (WIFEXITED(status) && WEXITSTATUS(status))
>  		tst_brk(TBROK, "Child returned with %i", WEXITSTATUS(status));
>  
> -	if (results->abort_flag)
> +	if (context->abort_flag)
>  		return 0;
>  
>  	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
> @@ -1898,9 +1925,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>  
>  	ret = fork_testrun();
>  
> -	if (mntpoint_mounted) {
> +	if (context->mntpoint_mounted) {
>  		tst_umount(tst_test->mntpoint);
> -		mntpoint_mounted = 0;
> +		context->mntpoint_mounted = 0;
>  	}
>  
>  	return ret;
> @@ -1925,7 +1952,7 @@ static int run_tcases_per_fs(void)
>  		found_valid_fs = true;
>  		run_tcase_on_fs(fs, filesystems[i]);
>  
> -		if (tst_atomic_load(&results->abort_flag))
> +		if (tst_atomic_load(&context->abort_flag))
>  			do_exit(0);
>  	}
>  
> @@ -1945,7 +1972,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  	tst_test = self;
>  
>  	do_setup(argc, argv);
> -	tst_enable_oom_protection(results->lib_pid);
> +	tst_enable_oom_protection(context->lib_pid);
>  
>  	SAFE_SIGNAL(SIGALRM, alarm_handler);
>  	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> @@ -1956,7 +1983,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
>  
>  	if (tst_test->runtime)
> -		results->runtime = multiply_runtime(tst_test->runtime);
> +		context->runtime = multiply_runtime(tst_test->runtime);
>  
>  	set_overall_timeout();
>  
> @@ -1969,7 +1996,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  		else
>  			fork_testrun();
>  
> -		if (tst_atomic_load(&results->abort_flag))
> +		if (tst_atomic_load(&context->abort_flag))
>  			do_exit(0);
>  	}
>  
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
