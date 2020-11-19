From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 11:27:40 +0100
Subject: [LTP] [PATCH v3 3/5] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201113164944.26101-4-pvorel@suse.cz>
References: <20201113164944.26101-1-pvorel@suse.cz>
 <20201113164944.26101-4-pvorel@suse.cz>
Message-ID: <20201119102740.GD2785@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	return rval;
>  }
> +
>  #define SAFE_FANOTIFY_INIT(fan, mode)  \
>  	safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
>  
> @@ -189,6 +190,41 @@ struct fanotify_event_info_fid {
>  #define MAX_HANDLE_SZ		128
>  #endif
>  
> +static inline int safe_fanotify_mark(const char *file, const int lineno,
> +			int fd, unsigned int flags, uint64_t mask,
> +			int dfd, const char *pathname)
> +{
> +	int rval;
> +
> +	rval = fanotify_mark(fd, flags, mask, dfd, pathname);
> +
> +	if (rval == -1) {
> +		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV)
> +			tst_brk(TCONF,
> +				"%s:%d: FAN_REPORT_FID not supported on %s filesystem",
> +				file, lineno, tst_device->fs_type);

I guess that we should use tst_brk_() and pass the file and lineno here
and in the rest of the tst_ calls in this function.

> +		if (errno == EINVAL && (flags & FAN_MARK_FILESYSTEM) == FAN_MARK_FILESYSTEM) {

The comparsion in (flags & FAN_MARK_FILESYSTEM) == FAN_MARK_FILESYSTEM
seems to be useless. How is this different from a simple
(flags & MARK_FILESYSTEM) when converted into a boolean value?

> +				tst_brk(TCONF,
> +					"%s:%d: FAN_MARK_FILESYSTEM not supported by kernel?",
> +					file, lineno);
> +		}
> +
> +		tst_brk(TBROK | TERRNO, "%s:%d: fanotify_mark() failed",
> +			file, lineno);
> +	}
> +
> +	if (rval < -1) {
> +		tst_brk(TBROK | TERRNO, "%s:%d: invalid fanotify_mark() return %d",
> +			file, lineno, rval);
> +	}
> +
> +	return rval;
> +}
> +
> +#define SAFE_FANOTIFY_MARK(fd, flags, mask, dfd, pathname)  \
> +	safe_fanotify_mark(__FILE__, __LINE__, (fd), (flags), (mask), (dfd), (pathname))
> +
>  /*
>   * Helper function used to obtain fsid and file_handle for a given path.
>   * Used by test files correlated to FAN_REPORT_FID functionality.
> @@ -242,7 +278,6 @@ static inline void fanotify_save_fid(const char *path,
>  #define INIT_FANOTIFY_MARK_TYPE(t) \
>  	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
>  
> -
>  static inline void fanotify_access_permissions_supported_by_kernel(void)
>  {
>  	int fd;
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index 03e453f41..7690f6b88 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -101,19 +101,8 @@ static void test_fanotify(unsigned int n)
>  			"failed", tc->init_flags);
>  	}
>  
> -	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> -			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> -			  AT_FDCWD, fname) < 0) {
> -		if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
> -			tst_res(TCONF,
> -				"FAN_MARK_FILESYSTEM not supported in kernel?");
> -			return;
> -		}

Here we had tst_res(TCONF, ...) followed by a return but we will can
tst_brk() after the change. I guess that we may skip part of the test on
older kernels with that change.

> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
> -			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> -			"failed", fd_notify, mark->name, fname);
> -	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
> +			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, fname);
>  
>  	/*
>  	 * generate sequence of events
> @@ -161,14 +150,9 @@ static void test_fanotify(unsigned int n)
>  	 */
>  
>  	/* Ignore access events */
> -	if (fanotify_mark(fd_notify,
> +	SAFE_FANOTIFY_MARK(fd_notify,
>  			  FAN_MARK_ADD | mark->flag | FAN_MARK_IGNORED_MASK,
> -			  FAN_ACCESS, AT_FDCWD, fname) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
> -			"FAN_MARK_IGNORED_MASK, FAN_ACCESS, AT_FDCWD, %s) "
> -			"failed", fd_notify, mark->name, fname);
> -	}
> +			  FAN_ACCESS, AT_FDCWD, fname);
>  
>  	fd = SAFE_OPEN(fname, O_RDWR);
>  	event_set[tst_count] = FAN_OPEN;
> @@ -211,15 +195,9 @@ static void test_fanotify(unsigned int n)
>  	 * Now ignore open & close events regardless of file
>  	 * modifications
>  	 */
> -	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag |
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag |
>  			  FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
> -			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_ADD | %s | "
> -			"FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY, "
> -			"FAN_OPEN | FAN_CLOSE, AT_FDCWD, %s) failed",
> -			fd_notify, mark->name, fname);
> -	}
> +			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname);
>  
>  	/* This event should be ignored */
>  	fd = SAFE_OPEN(fname, O_RDWR);
> @@ -240,15 +218,9 @@ static void test_fanotify(unsigned int n)
>  	len += ret;
>  
>  	/* Now remove open and close from ignored mask */
> -	if (fanotify_mark(fd_notify,
> +	SAFE_FANOTIFY_MARK(fd_notify,
>  			  FAN_MARK_REMOVE | mark->flag | FAN_MARK_IGNORED_MASK,
> -			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_REMOVE | %s | "
> -			"FAN_MARK_IGNORED_MASK, FAN_OPEN | FAN_CLOSE, "
> -			"AT_FDCWD, %s) failed", fd_notify,
> -			mark->name, fname);
> -	}
> +			  FAN_OPEN | FAN_CLOSE, AT_FDCWD, fname);
>  
>  	SAFE_CLOSE(fd);
>  	event_set[tst_count] = FAN_CLOSE_WRITE;
> @@ -344,14 +316,9 @@ pass:
>  
>  	}
>  	/* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
> -	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | mark->flag,
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
>  			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> -			  AT_FDCWD, fname) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_REMOVE | %s, FAN_ACCESS | "
> -			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
> -			"failed", fd_notify, mark->name, fname);
> -	}
> +			  AT_FDCWD, fname);
>  
>  	SAFE_CLOSE(fd_notify);
>  }
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify02.c b/testcases/kernel/syscalls/fanotify/fanotify02.c
> index c578e0ae8..36c87648e 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify02.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify02.c
> @@ -46,16 +46,9 @@ void test01(void)
>  
>  	int tst_count = 0;
>  
> -	if (fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
> -			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN |
> -			  FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD,
> -			  ".") < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | "
> -			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN | "
> -			"FAN_EVENT_ON_CHILD | FAN_ONDIR, AT_FDCWD, '.') "
> -			"failed", fd_notify);
> -	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_ACCESS |
> +			  FAN_MODIFY | FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD |
> +			  FAN_ONDIR, AT_FDCWD, ".");
>  
>  	/*
>  	 * generate sequence of events
> @@ -102,13 +95,8 @@ void test01(void)
>  	/*
>  	 * now remove child mark
>  	 */
> -	if (fanotify_mark(fd_notify, FAN_MARK_REMOVE,
> -			  FAN_EVENT_ON_CHILD, AT_FDCWD, ".") < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK REMOVE, "
> -			"FAN_EVENT_ON_CHILD, AT_FDCWD, '.') failed",
> -			fd_notify);
> -	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE,
> +			  FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
>  
>  	/*
>  	 * Do something to verify events didn't get generated
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index fbec652f6..e98694a66 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -221,22 +221,8 @@ static int setup_mark(unsigned int n)
>  	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
>  
>  	for (; i < ARRAY_SIZE(files); i++) {
> -		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> -				  tc->mask, AT_FDCWD, files[i]) < 0) {
> -			if (errno == EINVAL &&
> -					mark->flag == FAN_MARK_FILESYSTEM) {
> -				tst_res(TCONF,
> -					"FAN_MARK_FILESYSTEM not supported in "
> -					"kernel?");
> -				return -1;


Here as well.


> -			} else {
> -				tst_brk(TBROK | TERRNO,
> -					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
> -					"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
> -					"AT_FDCWD, %s) failed.",
> -					fd_notify, mark->name, fname);
> -			}
> -		}
> +		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
> +				  tc->mask, AT_FDCWD, files[i]);
>  	}
>  
>  	return 0;
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify04.c b/testcases/kernel/syscalls/fanotify/fanotify04.c
> index 722ad5d41..a24e7f7c3 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify04.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify04.c
> @@ -77,13 +77,8 @@ static void check_mark(char *file, unsigned long long flag, char *flagstr,
>  		if (test_event)
>  			test_event(file);
>  
> -		if (fanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
> -				  FAN_OPEN, AT_FDCWD, file) < 0) {
> -			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
> -				"FAN_OPEN, AT_FDCWD, '%s') failed",
> -				fd_notify, flagstr, file);
> -		}
> +		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | flag,
> +				  FAN_OPEN, AT_FDCWD, file);
>  	}
>  }
>  
> @@ -191,29 +186,14 @@ void test01(void)
>  	CHECK_MARK(sname, 0, 0, test_open_file);
>  
>  	/* Verify FAN_MARK_FLUSH destroys all inode marks */
> -	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
> -			  FAN_OPEN, AT_FDCWD, fname) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN, "
> -			"AT_FDCWD, '%s') failed", fd_notify, fname);
> -	}
> -	if (fanotify_mark(fd_notify, FAN_MARK_ADD,
> -			  FAN_OPEN | FAN_ONDIR, AT_FDCWD, dir) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_ADD, FAN_OPEN | "
> -			"FAN_ONDIR, AT_FDCWD, '%s') failed", fd_notify,
> -			dir);
> -	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD, fname);
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD, FAN_OPEN | FAN_ONDIR,
> +			   AT_FDCWD, dir);
>  	open_file(fname);
>  	verify_event(S_IFREG);
>  	open_dir(dir);
>  	verify_event(S_IFDIR);
> -	if (fanotify_mark(fd_notify, FAN_MARK_FLUSH,
> -			  0, AT_FDCWD, ".") < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_FLUSH, 0, "
> -			"AT_FDCWD, '.') failed", fd_notify);
> -	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_FLUSH, 0, AT_FDCWD, ".");
>  
>  	open_dir(dir);
>  	verify_no_event();
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
> index e53cc333a..c13b9ad7b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify05.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
> @@ -107,13 +107,8 @@ static void setup(void)
>  	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK,
>  			O_RDONLY);
>  
> -	if (fanotify_mark(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
> -			  AT_FDCWD, MOUNT_PATH) < 0) {
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark (%d, FAN_MARK_MOUNT | FAN_MARK_ADD, "
> -			"FAN_OPEN, AT_FDCWD, \".\") failed",
> -			fd_notify);
> -	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
> +			  AT_FDCWD, MOUNT_PATH);
>  }
>  
>  static void cleanup(void)
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
> index 99e312a4f..ac4901f6f 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify06.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
> @@ -78,7 +78,6 @@ static struct tcase {
>  static void create_fanotify_groups(void)
>  {
>  	unsigned int p, i;
> -	int ret;
>  
>  	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
>  		for (i = 0; i < GROUPS_PER_PRIO; i++) {
> @@ -87,32 +86,20 @@ static void create_fanotify_groups(void)
>  							     O_RDONLY);
>  
>  			/* Add mount mark for each group */
> -			ret = fanotify_mark(fd_notify[p][i],
> +			SAFE_FANOTIFY_MARK(fd_notify[p][i],
>  					    FAN_MARK_ADD | FAN_MARK_MOUNT,
>  					    FAN_MODIFY,
>  					    AT_FDCWD, fname);
> -			if (ret < 0) {
> -				tst_brk(TBROK | TERRNO,
> -					"fanotify_mark(%d, FAN_MARK_ADD | "
> -					"FAN_MARK_MOUNT, FAN_MODIFY, AT_FDCWD,"
> -					" %s) failed", fd_notify[p][i], fname);
> -			}
> +
>  			/* Add ignore mark for groups with higher priority */
>  			if (p == 0)
>  				continue;
> -			ret = fanotify_mark(fd_notify[p][i],
> +
> +			SAFE_FANOTIFY_MARK(fd_notify[p][i],
>  					    FAN_MARK_ADD |
>  					    FAN_MARK_IGNORED_MASK |
>  					    FAN_MARK_IGNORED_SURV_MODIFY,
>  					    FAN_MODIFY, AT_FDCWD, fname);
> -			if (ret < 0) {
> -				tst_brk(TBROK | TERRNO,
> -					"fanotify_mark(%d, FAN_MARK_ADD | "
> -					"FAN_MARK_IGNORED_MASK | "
> -					"FAN_MARK_IGNORED_SURV_MODIFY, "
> -					"FAN_MODIFY, AT_FDCWD, %s) failed",
> -					fd_notify[p][i], fname);
> -			}
>  		}
>  	}
>  }
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
> index f4e8ac9e6..8b2c1c4c9 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> @@ -102,20 +102,7 @@ static int setup_instance(void)
>  	int fd;
>  
>  	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> -
> -	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
> -			  fname) < 0) {
> -		close(fd);
> -		if (errno == EINVAL) {
> -			tst_brk(TCONF | TERRNO,
> -				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
> -				"configured in kernel?");
> -		} else {
> -			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, "
> -				"AT_FDCWD, %s) failed.", fd, fname);
> -		}
> -	}
> +	SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
>  
>  	return fd;
>  }
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index 83210bc1c..9c9938619 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -99,7 +99,6 @@ static void create_fanotify_groups(struct tcase *tc)
>  {
>  	struct fanotify_mark_type *mark = &tc->mark;
>  	unsigned int i, onchild, ondir = tc->ondir;
> -	int ret;
>  
>  	for (i = 0; i < NUM_GROUPS; i++) {
>  		fd_notify[i] = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF |
> @@ -111,17 +110,11 @@ static void create_fanotify_groups(struct tcase *tc)
>  		 * but only the first group requests events on dir.
>  		 */
>  		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
> -		ret = fanotify_mark(fd_notify[i],
> +		SAFE_FANOTIFY_MARK(fd_notify[i],
>  				    FAN_MARK_ADD | mark->flag,
>  				    FAN_CLOSE_NOWRITE | onchild,
>  				    AT_FDCWD, tc->testdir);
> -		if (ret < 0) {
> -			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
> -				"%x, AT_FDCWD, '%s') failed",
> -				fd_notify[i], mark->name,
> -				FAN_CLOSE_NOWRITE | ondir, tc->testdir);
> -		}
> +
>  		/*
>  		 * Add inode mark on parent for each group with MODIFY event,
>  		 * but only the first group requests events on child.
> @@ -129,15 +122,9 @@ static void create_fanotify_groups(struct tcase *tc)
>  		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
>  		 * flag.
>  		 */
> -		ret = fanotify_mark(fd_notify[i], FAN_MARK_ADD,
> +		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD,
>  				    FAN_MODIFY | ondir | onchild,
>  				    AT_FDCWD, ".");
> -		if (ret < 0) {
> -			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark(%d, FAN_MARK_ADD, "
> -				"%x, AT_FDCWD, '.') failed",
> -				fd_notify[i], FAN_MODIFY | ondir | onchild);
> -		}
>  	}
>  }
>  
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index b95efb998..ab906f3fb 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -288,7 +288,6 @@ static int create_fanotify_groups(unsigned int n)
>  	struct fanotify_mark_type *mark, *ignore_mark;
>  	unsigned int mark_ignored, mask;
>  	unsigned int p, i;
> -	int ret;
>  
>  	mark = &fanotify_mark_types[tc->mark_type];
>  	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
> @@ -317,32 +316,12 @@ static int create_fanotify_groups(unsigned int n)
>  			 * FAN_EVENT_ON_CHILD has no effect on filesystem/mount
>  			 * or inode mark on non-directory.
>  			 */
> -			ret = fanotify_mark(fd_notify[p][i],
> +			SAFE_FANOTIFY_MARK(fd_notify[p][i],
>  					    FAN_MARK_ADD | mark->flag,
>  					    tc->expected_mask_without_ignore |
>  					    FAN_EVENT_ON_CHILD,
>  					    AT_FDCWD, tc->mark_path);
> -			if (ret < 0) {
> -				if (errno == EINVAL &&
> -				    tc->expected_mask_without_ignore &
> -				    FAN_OPEN_EXEC) {
> -					tst_res(TCONF,
> -						"FAN_OPEN_EXEC not supported "
> -						"by kernel?");
> -					return -1;
> -				} else if (errno == EINVAL &&
> -					tc->mark_type == FANOTIFY_FILESYSTEM) {
> -					tst_res(TCONF,
> -						"FAN_MARK_FILESYSTEM not "
> -						"supported in kernel?");
> -					return -1;
> -				}
> -				tst_brk(TBROK | TERRNO,
> -					"fanotify_mark(%d, FAN_MARK_ADD | %s,"
> -					"FAN_OPEN, AT_FDCWD, %s) failed",
> -					fd_notify[p][i], mark->name,
> -					tc->mark_path);
> -			}
> +
>  			/* Add ignore mark for groups with higher priority */
>  			if (p == 0)
>  				continue;
> @@ -351,18 +330,9 @@ static int create_fanotify_groups(unsigned int n)
>  			mark_ignored = FAN_MARK_IGNORED_MASK |
>  					FAN_MARK_IGNORED_SURV_MODIFY;
>  add_mark:
> -			ret = fanotify_mark(fd_notify[p][i],
> +			SAFE_FANOTIFY_MARK(fd_notify[p][i],
>  					    FAN_MARK_ADD | ignore_mark->flag | mark_ignored,
>  					    mask, AT_FDCWD, tc->ignore_path);
> -			if (ret < 0) {
> -				tst_brk(TBROK | TERRNO,
> -					"fanotify_mark(%d, FAN_MARK_ADD | %s | %s, "
> -					"%x, AT_FDCWD, %s) failed",
> -					fd_notify[p][i], ignore_mark->name,
> -					mark_ignored ? "FAN_MARK_IGNORED_MASK | "
> -					"FAN_MARK_IGNORED_SURV_MODIFY" : "",
> -					mask, tc->ignore_path);
> -			}
>  
>  			/*
>  			 * If ignored mask is on a parent watching children,
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
> index 9e8606c72..56b7153f8 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify11.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
> @@ -55,7 +55,6 @@ static unsigned int tcases[] = {
>  
>  void test01(unsigned int i)
>  {
> -	int ret;
>  	pthread_t p_id;
>  	struct fanotify_event_metadata event;
>  	int fd_notify;
> @@ -76,10 +75,8 @@ void test01(unsigned int i)
>  				tcases[i]);
>  	}
>  
> -	ret = fanotify_mark(fd_notify, FAN_MARK_ADD,
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD,
>  			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
> -	if (ret != 0)
> -		tst_brk(TBROK, "fanotify_mark FAN_MARK_ADD fail ret=%d", ret);
>  
>  	SAFE_PTHREAD_CREATE(&p_id, NULL, thread_create_file, NULL);
>  
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
> index bddbdc37c..9adf8bc8a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -146,31 +146,15 @@ static int setup_mark(unsigned int n)
>  
>  	for (; i < ARRAY_SIZE(files); i++) {
>  		/* Setup normal mark on object */
> -		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> -					tc->mask, AT_FDCWD, files[i]) < 0) {
> -			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
> -				"%llx, AT_FDCWD, %s) failed",
> -				fd_notify,
> -				mark->name,
> -				tc->mask,
> -				files[i]);
> -		}
> +		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
> +					tc->mask, AT_FDCWD, files[i]);
>  
>  		/* Setup ignore mark on object */
>  		if (tc->ignore_mask) {
> -			if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag
> +			SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag
>  						| FAN_MARK_IGNORED_MASK,
>  						tc->ignore_mask, AT_FDCWD,
> -						files[i]) < 0) {
> -				tst_brk(TBROK | TERRNO,
> -					"fanotify_mark (%d, "
> -					"FAN_MARK_ADD | %s "
> -					"| FAN_MARK_IGNORED_MASK, "
> -					"%llx, AT_FDCWD, %s) failed",
> -					fd_notify, mark->name,
> -					tc->ignore_mask, files[i]);
> -			}
> +						files[i]);
>  		}
>  	}
>  
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
> index c2a21bb66..997efaf08 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
> @@ -116,28 +116,8 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
>  	struct fanotify_mark_type *mark = &tc->mark;
>  
>  	for (i = 0; i < ARRAY_SIZE(objects); i++) {
> -		if (fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
> -					AT_FDCWD, objects[i].path) == -1) {
> -			if (errno == EINVAL &&
> -				mark->flag & FAN_MARK_FILESYSTEM) {
> -				tst_res(TCONF,
> -					"FAN_MARK_FILESYSTEM not supported by "
> -					"kernel");
> -				return 1;
> -			} else if (errno == ENODEV &&
> -				   !objects[i].fid.fsid.val[0] &&
> -				   !objects[i].fid.fsid.val[1]) {
> -				tst_res(TCONF,
> -					"FAN_REPORT_FID not supported on "
> -					"filesystem type %s",
> -					tst_device->fs_type);
> -				return 1;

And here as well.

> -			}
> -			tst_brk(TBROK | TERRNO,
> -				"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
> -				"AT_FDCWD, %s) failed",
> -				fanotify_fd, objects[i].path);
> -		}
> +		SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | mark->flag, tc->mask,
> +					AT_FDCWD, objects[i].path);
>  
>  		/* Setup the expected mask for each generated event */
>  		event_set[i].expected_mask = tc->mask;

Otherwise it looks like a nice cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
