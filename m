From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 24 Jul 2018 09:51:00 -0400 (EDT)
Subject: [LTP] [PATCH v2] Test for memfd_create() syscall with
 MFD_HUGETLB	flag.
In-Reply-To: <20180720101807.4760-1-vishnu@zilogic.com>
References: <20180720101807.4760-1-vishnu@zilogic.com>
Message-ID: <1721785370.35493152.1532440260470.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> memfd_create03.c: Tests the syscall for the flag MFD_HUGETLB.
> 
> memfd_create04.c: Tests the syscall for the flags MFD_HUGE_2MB,
> MFD_HUGE_1GB,... used in conjunction with MFD_HUGETLB flag.
> 
> memfd_create_hugetlb.c: Contains helper functions for memfd_create03.c
> and memfd_create04.c.
> 
> -- major changes from v1 to v2 --
> 
> Restore the original number of hugepages in cleanup().
> 
> Modify check_mfd_new() from memfd_create_common and replace
> safe_huge_new() + safe_huge_x_new() from memfd_create_hugetlb
> with it.
> 
> Modify get_from_file() from memfd_create_hugetlb to use
> FILE_LINES_SCANF in code logic.
> 
> Move test dependent flags to include/lapi

Hi,

<snip>

> +
> +static void test_write_protect(int fd)
> +{
> +	if (CHECK_HUGE_NON_WRITEABLE(fd) == 0)
> +		tst_res(TPASS, "write call failed as expected");
> +	else
> +		tst_res(TFAIL, "write call passed unexpectedly");
> +}

This looks unnecessarily complicated.

You have macro, that calls functions, which is printing
result text as TINFO, then returning retcode based on
which you decide if to report PASS or FAIL.

Why not report PASS/FAIL directly? Or why not put the test
right here, without all the indirection? Are you planning
on using CHECK_HUGE_NON_WRITEABLE() in other tests?

> +
> +static void test_def_pagesize(int fd)
> +{
> +	int ret;
> +	long hps;
> +	void *mem;
> +
> +	hps = GET_HUGE_DEF_PAGESIZE();
> +	mem = CHECK_HUGE_MMAPABLE(fd, hps);
> +
> +	ret = CHECK_MUNMAP_LT_PAGE(mem, hps);
> +	if (ret == 0)
> +		tst_res(TPASS, "File created in def pagesize %ldkB", hps/1024);
> +	else
> +		tst_res(TFAIL, "File is not in default pagesize");
> +}

Similar here, are you planning on using check_huge_mmapable() in other tests?

Side effect of CHECK_HUGE_MMAPABLE is that it mmaps a page.
You're not freeing that page.

> +
> +static void test_max_hugepages(int fd)
> +{
> +	int res;
> +	int new_fd;
> +	int dummy_fd;
> +	long hps;
> +	long free_pages;
> +	void *mem;
> +
> +	free_pages = GET_HUGE_FREE_PAGES();
> +	hps = GET_HUGE_DEF_PAGESIZE();
> +	mem = CHECK_HUGE_MMAPABLE(fd, free_pages * hps);
> +
> +	new_fd = CHECK_MFD_NEW("new_file", 0, MFD_HUGETLB);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO, "memfd_create() failed");
> +	res = CHECK_HUGE_NON_MMAPABLE(new_fd, hps);
> +	dummy_fd = new_fd;
> +	SAFE_CLOSE(new_fd);
> +	tst_res(TINFO, "close(%d) succeeded", dummy_fd);
> +
> +	SAFE_MUNMAP(mem, free_pages * hps);
> +
> +	if (res == 0)
> +		tst_res(TPASS, "Hugepages creation is limited as expected");
> +	else
> +		tst_res(TFAIL, "Hugepages creation limit failed");
> +}
> +
> +static const struct tcase {
> +	void (*func)(int fd);
> +	const char *desc;
> +} tcases[] = {
> +	{&test_write_protect, "--TESTING WRITE CALL IN HUGEPAGES--"},
> +	{&test_def_pagesize, "--TESTING PAGE SIZE OF CREATED FILE--"},
> +	{&test_max_hugepages, "--TESTING THE NUMBER OF HUGEPAGES--"},
> +};
> +
> +static void memfd_huge_controller(unsigned int n)
> +{
> +	int fd;
> +	int dummy_fd;
> +	const struct tcase *tc;
> +
> +	tc = &tcases[n];
> +
> +	tst_res(TINFO, "%s", tc->desc);
> +
> +	fd = CHECK_MFD_NEW("test_file", 0, MFD_HUGETLB);
> +	if (fd < 0)
> +		tst_brk(TBROK | TERRNO, "memfd_create() failed");
> +
> +	tc->func(fd);
> +
> +	dummy_fd = fd;
> +	SAFE_CLOSE(fd);
> +	tst_res(TINFO, "close(%d) succeeded", dummy_fd);
> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +

# ./memfd_create03 
tst_test.c:1018: INFO: Timeout per run is 0h 05m 00s
memfd_create03.c:134: BROK: Unable to get total number of hugepages

Summary:
passed   0
failed   0
skipped  0
warnings 0

Check if hugepages are supported is needed too, for example:

        if (access(PATH_HUGEPAGES, F_OK))
                tst_brk(TCONF, "Huge page is not supported.");

> +	if (GET_HUGE_TOTAL_PAGES() > 0)
> +		return;

I thought you need 4 huge pages for the test. This skips setup
even for 1.

> +
> +	fd = SAFE_OPEN("/proc/sys/vm/nr_hugepages", O_WRONLY);
> +	SAFE_WRITE(1, fd, "4", 1);

I'd suggest normal write, then read back the value from /proc to check
if test can proceed.

> +	hugepages_enabled = 1;
> +	SAFE_CLOSE(fd);
> +
> +	if (GET_HUGE_TOTAL_PAGES() == 0)
> +		tst_brk(TCONF, "Enable Hugepages manually");

If you need 4 huge pages for test, then shouldn't this check you have at least 4?

<snip>

> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> index f22e3d345..186eafa51 100644
> --- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> @@ -144,21 +144,33 @@ int mfd_flags_available(const char *filename, const int
> lineno,
>  }
>  
>  int check_mfd_new(const char *filename, const int lineno,
> -			const char *name, loff_t sz, int flags)
> +		  const char *name, loff_t sz, int flags)
>  {
>  	int fd;
>  
>  	fd = sys_memfd_create(name, flags);
>  	if (fd < 0) {
> +		if ((flags & MFD_HUGETLB) == MFD_HUGETLB)
> +			goto end;
> +
>  		tst_brk_(filename, lineno, TBROK | TERRNO,
> -			"memfd_create(%s, %d) failed", name, flags);
> +			 "memfd_create(%s, %d) failed", name, flags);
> +	}
> +
> +	if ((flags & MFD_HUGETLB) == MFD_HUGETLB) {
> +		tst_res_(filename, lineno, TINFO,
> +			 "memfd_create(%s, %d) succeeded",
> +			 name, flags);
> +		goto end;
>  	}
>  
> -	tst_res_(filename, lineno, TPASS, "memfd_create(%s, %d) succeeded",
> -		name, flags);
> +	tst_res_(filename, lineno, TPASS,
> +		 "memfd_create(%s, %d) succeeded",
> +		 name, flags);
>  
>  	check_ftruncate(filename, lineno, fd, sz);
>  
> + end:
>  	return fd;
>  }

This is ugly way of making it behave one way for your test,
and other way for different test.

There are couple options:

1. two functions
mfd_new() - calls the syscall, and only returns a value
check_mfd_new() - calls mfd_new(), checks returned value, calls tst_brk() 

2. extra parameter, that specifies if failure should lead to tst_brk(),
similar to 'strict' parameter in file_lines_scanf().

<snip>

> +int check_huge_non_writeable(const char *filename, const int lineno, int fd)
> +{
> +	ssize_t ret;
> +	char test_str[] = "data";
> +
> +	ret = write(fd, test_str, sizeof(test_str));
> +
> +	if (ret < 0) {
> +		if (errno != EINVAL) {
> +			tst_res_(filename, lineno, TINFO,
> +				 "write(%d, \"%s\", %zu) didn't fail as expected",
> +				 fd, test_str, strlen(test_str));
> +
> +			return -1;
> +		}
> +	} else {
> +		tst_res_(filename, lineno, TINFO,
> +			 "write(%d, \"%s\", %zu) succeeded unexpectedly",
> +			 fd, test_str, strlen(test_str));
> +
> +		return -1;
> +	}
> +
> +	tst_res_(filename, lineno, TINFO,
> +		 "write(%d, \"%s\", %zu) failed as expected",
> +		 fd, test_str, strlen(test_str));
> +
> +	return 0;
> +}

If this reported PASS/FAIL directly, instead of TINFO, you don't need
return code and extra logic in callers.

<snip>

> +
> +static void get_from_file(const char *filename, const int lineno,
> +			  char *pattern, char *err_msg, long *val)
> +{
> +	int ret;
> +
> +	ret = FILE_LINES_SCANF(MEMINFO_PATH, pattern, val);
> +	if (ret == 1)
> +		tst_brk_(filename, lineno, TBROK, err_msg, NULL);

As I mentioned in v1 review, there's also SAFE_FILE_LINES_SCANF,
that does exactly same thing.

--

memfd_create04.c:80: INFO: Attempt to create 1GB huge pages
memfd_create04.c:82: INFO: memfd_create(tfile, 2013265924) succeeded
memfd_create04.c:94: INFO: mmap((nil), 1073741824, 2, 2, 3, 0) failed
memfd_create04.c:96: WARN: Contiguous memory unavailable to map
memfd_create04.c:100: INFO: close(3) succeeded
memfd_create04.c:102: PASS: Successfully created 1GB pages

This looks like a guaranteed warning on some systems.
What do you expect user do with this warning? Report bug? Change config?

Regards,
Jan
