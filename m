From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Feb 2018 17:08:47 +0100
Subject: [LTP] [PATCH v3 1/4] lib/get_high_address.c: Add
 tst_get_bad_addr.h for new API
In-Reply-To: <1518589199-14314-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180213134232.GA5518@rei>
 <1518589199-14314-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180220160847.GA13149@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +			if (!fname1)
> +				fname1 = tst_get_bad_addr(cleanup);

Here we should call the function only once in the setup() since this
will allocate two pages of memory for each test iteration and the test
may get out of memory if we pass large enough -i parameter.

I would do something similar in test setup():

	void *bad_add = tst_get_bad_addr(NULL);

	loop over test structure {
		if (!tc->fname)
			tc->fname = bad_addr;
	}

> -			if (fname2 == high_addr)
> -				fname2 = get_high_address();
> -#endif
> +			if (!fname2)
> +				fname2 = tst_get_bad_addr(cleanup);
>  
>  			TEST(link(fname1, fname2));
>  
> @@ -166,13 +152,6 @@ static void setup(void)
>  
>  	tst_tmpdir();
>  
> -#if !defined(UCLINUX)
> -	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> -	                     MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	test_cases[6].file1 = bad_addr;
> -	test_cases[12].file2 = bad_addr;
> -#endif
> -
>  	memset(longpath, 'a', PATH_MAX+1);
>  	SAFE_TOUCH(cleanup, "regfile", 0777, NULL);
>  	SAFE_TOUCH(cleanup, "regfile2", 0777, NULL);
> diff --git a/testcases/kernel/syscalls/lstat/lstat02.c b/testcases/kernel/syscalls/lstat/lstat02.c
> index ab46787..15285e7 100644
> --- a/testcases/kernel/syscalls/lstat/lstat02.c
> +++ b/testcases/kernel/syscalls/lstat/lstat02.c
> @@ -59,10 +59,10 @@
>  static char longpathname[PATH_MAX + 2];
>  static char elooppathname[sizeof(TEST_ELOOP) * 43] = ".";
>  
> -#if !defined(UCLINUX)
> +static void setup(void);
> +static void lstat_verify(int);
> +static void cleanup(void);
>  static void bad_addr_setup(int);
> -static void high_address_setup(int);
> -#endif
>  
>  static struct test_case_t {
>  	char *pathname;
> @@ -71,10 +71,7 @@ static struct test_case_t {
>  } test_cases[] = {
>  	{TEST_EACCES, EACCES, NULL},
>  	{TEST_ENOENT, ENOENT, NULL},
> -#if !defined(UCLINUX)
>  	{NULL, EFAULT, bad_addr_setup},
> -	{NULL, EFAULT, high_address_setup},
> -#endif
>  	{longpathname, ENAMETOOLONG, NULL},
>  	{TEST_ENOTDIR, ENOTDIR, NULL},
>  	{elooppathname, ELOOP, NULL},
> @@ -83,10 +80,6 @@ static struct test_case_t {
>  char *TCID = "lstat02";
>  int TST_TOTAL = ARRAY_SIZE(test_cases);
>  
> -static void setup(void);
> -static void lstat_verify(int);
> -static void cleanup(void);
> -
>  int main(int ac, char **av)
>  {
>  	int lc;
> @@ -140,18 +133,10 @@ static void setup(void)
>  		strcat(elooppathname, TEST_ELOOP);
>  }
>  
> -#if !defined(UCLINUX)
>  static void bad_addr_setup(int i)
>  {
> -	test_cases[i].pathname = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> -					   MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> -}
> -
> -static void high_address_setup(int i)
> -{
> -	test_cases[i].pathname = (char *)get_high_address();
> +	test_cases[i].pathname = tst_get_bad_addr(cleanup);
>  }
> -#endif
>  
>  static void lstat_verify(int i)
>  {
> diff --git a/testcases/kernel/syscalls/mkdir/mkdir01.c b/testcases/kernel/syscalls/mkdir/mkdir01.c
> index 9839a09..84012c0 100644
> --- a/testcases/kernel/syscalls/mkdir/mkdir01.c
> +++ b/testcases/kernel/syscalls/mkdir/mkdir01.c
> @@ -116,7 +116,7 @@ void setup();
>  void cleanup();
>  
>  char *TCID = "mkdir01";
> -int TST_TOTAL = 2;
> +int TST_TOTAL = 1;
>  
>  char *bad_addr = 0;
>  
> @@ -161,37 +161,6 @@ int main(int ac, char **av)
>  				 "mkdir - path argument pointing below allocated address space succeeded unexpectedly.");
>  
>  		}
> -#if !defined(UCLINUX)
> -		/*
> -		 * TEST CASE: 2
> -		 * mkdir() call with pointer above allocated address space.
> -		 */
> -
> -		/* Call mkdir(2) */
> -		TEST(mkdir(get_high_address(), 0777));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -		}
> -
> -		if (TEST_RETURN == -1) {
> -			if (TEST_ERRNO == EFAULT) {
> -				tst_resm(TPASS,
> -					 "mkdir - path argument pointing above allocated address space failed as expected with errno %d : %s",
> -					 TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL,
> -					 "mkdir - path argument pointing above allocated address space failed with errno %d : %s but expected %d (EFAULT)",
> -					 TEST_ERRNO,
> -					 strerror(TEST_ERRNO), EFAULT);
> -			}
> -		} else {
> -			tst_resm(TFAIL,
> -				 "mkdir - path argument pointing above allocated address space succeeded unexpectedly.");
> -
> -		}
> -#endif /* if !defined(UCLINUX) */
>  
>  	}
>  
> @@ -212,11 +181,7 @@ void setup(void)
>  	/* Create a temporary directory and make it current. */
>  	tst_tmpdir();
>  
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED) {
> -		tst_brkm(TBROK, cleanup, "mmap failed");
> -	}
> +	bad_addr = tst_get_bad_addr(cleanup);
>  }
>  
>  /***************************************************************
> diff --git a/testcases/kernel/syscalls/mknod/mknod06.c b/testcases/kernel/syscalls/mknod/mknod06.c
> index a8ee5ba..a128912 100644
> --- a/testcases/kernel/syscalls/mknod/mknod06.c
> +++ b/testcases/kernel/syscalls/mknod/mknod06.c
> @@ -93,7 +93,6 @@ int setup3();			/* setup function to test mknod for ENOTDIR */
>  int longpath_setup();		/* setup function to test mknod for ENAMETOOLONG */
>  int no_setup();			/* simply returns 0 to the caller */
>  char Longpathname[PATH_MAX + 2];
> -char High_address_node[64];
>  
>  struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	char *pathname;
> @@ -101,15 +100,8 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	int exp_errno;
>  	int (*setupfunc) ();
>  } Test_cases[] = {
> -	{
> -	"tnode_1", "Specified node already exists", EEXIST, setup1},
> -#if !defined(UCLINUX)
> -	{
> -	(char *)-1, "Negative address", EFAULT, no_setup}, {
> -	High_address_node, "Address beyond address space", EFAULT,
> -		    no_setup},
> -#endif
> -	{
> +	{"tnode_1", "Specified node already exists", EEXIST, setup1}, {
> +	NULL, "Negative address", EFAULT, no_setup}, {
              ^
	      This should say "Invalid address" now.

>  	"testdir_2/tnode_2", "Non-existent file", ENOENT, no_setup}, {
>  	"", "Pathname is empty", ENOENT, no_setup}, {
>  	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
> @@ -119,12 +111,6 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  
>  char *TCID = "mknod06";
>  int TST_TOTAL = ARRAY_SIZE(Test_cases);
> -#if !defined(UCLINUX)
> -extern char *get_high_address();
> -#else
> -#endif
> -
> -char *bad_addr = 0;
>  
>  void setup();			/* setup function for the tests */
>  void cleanup();			/* cleanup function for the tests */
> @@ -152,11 +138,8 @@ int main(int ac, char **av)
>  			node_name = Test_cases[ind].pathname;
>  			test_desc = Test_cases[ind].desc;
>  
> -#if !defined(UCLINUX)
> -			if (node_name == High_address_node) {
> -				node_name = get_high_address();
> -			}
> -#endif
> +			if (!node_name)
> +				node_name = tst_get_bad_addr(cleanup);

Here as well, the tst_get_bad_addr() should be called only once in the
test setup.

> diff --git a/testcases/kernel/syscalls/stat/stat03.c b/testcases/kernel/syscalls/stat/stat03.c
> index ef3d937..b0e4e89 100644
> --- a/testcases/kernel/syscalls/stat/stat03.c
> +++ b/testcases/kernel/syscalls/stat/stat03.c
> @@ -103,7 +103,6 @@ char nobody_uid[] = "nobody";
>  struct passwd *ltpuser;
>  
>  char Longpathname[PATH_MAX + 2];
> -char High_address_node[64];
>  
>  struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	char *pathname;
> @@ -111,15 +110,8 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	int exp_errno;
>  	int (*setupfunc) ();
>  } Test_cases[] = {
> -	{
> -	TEST_FILE1, "No Search permissions to process", EACCES, setup1},
> -#if !defined(UCLINUX)
> -	{
> -	High_address_node, "Address beyond address space", EFAULT, no_setup},
> -	{
> -	(char *)-1, "Negative address", EFAULT, no_setup},
> -#endif
> -	{
> +	{TEST_FILE1, "No Search permissions to process", EACCES, setup1}, {
> +	NULL, "Negative address", EFAULT, no_setup}, {
                 ^
		 Here as well, should be changed to "Invalid address"

>  	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
>  	"", "Pathname is empty", ENOENT, no_setup}, {
>  	TEST_FILE2, "Path contains regular file", ENOTDIR, setup2}, {
> @@ -129,8 +121,6 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  char *TCID = "stat03";
>  int TST_TOTAL = ARRAY_SIZE(Test_cases);
>  
> -char *bad_addr = 0;
> -
>  void setup();			/* Main setup function for the tests */
>  void cleanup();			/* cleanup function for the test */
>  
> @@ -158,11 +148,8 @@ int main(int ac, char **av)
>  			file_name = Test_cases[ind].pathname;
>  			test_desc = Test_cases[ind].desc;
>  
> -#if !defined(UCLINUX)
> -			if (file_name == High_address_node) {
> -				file_name = (char *)get_high_address();
> -			}
> -#endif
> +			if (!file_name)
> +				file_name = tst_get_bad_addr(cleanup);

Here as well the function should be called once in the test setup.

>  			/*
>  			 * Call stat(2) to test different test conditions.
> @@ -237,15 +224,6 @@ void setup(void)
>  	/* Make a temp dir and cd to it */
>  	tst_tmpdir();
>  
> -#if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED) {
> -		tst_brkm(TBROK, cleanup, "mmap failed");
> -	}
> -	Test_cases[2].pathname = bad_addr;
> -#endif
> -
>  	/* call individual setup functions */
>  	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
>  		Test_cases[ind].setupfunc();
> diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
> index 89f23c9..f1c0d6e 100644
> --- a/testcases/kernel/syscalls/symlink/symlink03.c
> +++ b/testcases/kernel/syscalls/symlink/symlink03.c
> @@ -103,8 +103,6 @@
>  char *TCID = "symlink03";
>  int TST_TOTAL = 1;
>  
> -char *bad_addr = 0;
> -
>  int no_setup();
>  int setup1();			/* setup function to test symlink for EACCES */
>  int setup2();			/* setup function to test symlink for EEXIST */
> @@ -121,18 +119,11 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	int exp_errno;
>  	int (*setupfunc) ();
>  } Test_cases[] = {
> -	{
> -	TEST_FILE1, SYM_FILE1, "No Search permissions to process",
> +	{TEST_FILE1, SYM_FILE1, "No Search permissions to process",
>  		    EACCES, setup1}, {
>  	TEST_FILE2, SYM_FILE2, "Specified symlink already exists",
> -		    EEXIST, setup2},
> -#if !defined(UCLINUX)
> -	{
> -	TESTFILE, High_address_node, "Address beyond address space",
> -		    EFAULT, no_setup},
> -#endif
> -	{
> -	TESTFILE, (char *)-1, "Negative address", EFAULT, no_setup}, {
> +		    EEXIST, setup2}, {
> +	TESTFILE, NULL, "Negative address", EFAULT, no_setup}, {
                           ^
			   And here as well.
>  	TESTFILE, Longpathname, "Symlink path too long", ENAMETOOLONG,
>  		    longpath_setup}, {
>  	TESTFILE, "", "Symlink Pathname is empty", ENOENT, no_setup}, {
> @@ -171,11 +162,9 @@ int main(int ac, char **av)
>  			test_file = Test_cases[ind].file;
>  			sym_file = Test_cases[ind].link;
>  			test_desc = Test_cases[ind].desc;
> -#if !defined(UCLINUX)
> -			if (sym_file == High_address_node) {
> -				sym_file = (char *)get_high_address();
> -			}
> -#endif
> +
> +			if (!sym_file)
> +				sym_file = tst_get_bad_addr(cleanup);

And here as well.

>  			/*
>  			 * Call symlink(2) to test different test conditions.
>  			 * verify that it fails with -1 return value and sets
> @@ -241,15 +230,6 @@ void setup(void)
>  
>  	tst_tmpdir();
>  
> -#if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED) {
> -		tst_brkm(TBROK, cleanup, "mmap failed");
> -	}
> -	Test_cases[3].link = bad_addr;
> -#endif
> -
>  	/* call individual setup functions */
>  	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
>  		Test_cases[ind].setupfunc();
> diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
> index 0aa7b3e..041bdfb 100644
> --- a/testcases/kernel/syscalls/truncate/truncate03.c
> +++ b/testcases/kernel/syscalls/truncate/truncate03.c
> @@ -76,10 +76,7 @@ static struct test_case_t {
>  } test_cases[] = {
>  	{ TEST_FILE1, TRUNC_LEN, EACCES },
>  	{ TEST_FILE2, TRUNC_LEN, ENOTDIR },
> -#if !defined(UCLINUX)
>  	{ NULL, TRUNC_LEN, EFAULT },
> -	{ (char *)-1, TRUNC_LEN, EFAULT },
> -#endif
>  	{ long_pathname, TRUNC_LEN, ENAMETOOLONG },
>  	{ "", TRUNC_LEN, ENOENT },
>  	{ TEST_DIR1, TRUNC_LEN, EISDIR },
> @@ -117,7 +114,6 @@ int main(int ac, char **av)
>  void setup(void)
>  {
>  	struct passwd *ltpuser;
> -	char *bad_addr;
>  	struct rlimit rlim;
>  	sigset_t signalset;
>  
> @@ -136,14 +132,6 @@ void setup(void)
>  
>  	SAFE_TOUCH(cleanup, "t_file", FILE_MODE, NULL);
>  
> -#if !defined(UCLINUX)
> -	test_cases[2].pathname = (char *)get_high_address();
> -
> -	bad_addr = SAFE_MMAP(cleanup, 0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	test_cases[3].pathname = bad_addr;
> -#endif
> -
>  	memset(long_pathname, 'a', PATH_MAX + 1);
>  
>  	SAFE_MKDIR(cleanup, TEST_DIR1, DIR_MODE);
> @@ -166,6 +154,9 @@ void setup(void)
>  
>  void truncate_verify(struct test_case_t *tc)
>  {
> +	if (!tc->pathname)
> +		tc->pathname = tst_get_bad_addr(cleanup);

And here as well.

>  	TEST(truncate(tc->pathname, tc->length));
>  
>  	if (TEST_RETURN != -1) {
> diff --git a/testcases/kernel/syscalls/unlink/unlink07.c b/testcases/kernel/syscalls/unlink/unlink07.c
> index 66e4db8..7eb8388 100644
> --- a/testcases/kernel/syscalls/unlink/unlink07.c
> +++ b/testcases/kernel/syscalls/unlink/unlink07.c
> @@ -123,13 +123,9 @@
>  void setup();
>  void cleanup();
>  
> -extern char *get_high_address();
> -
>  char *TCID = "unlink07";
>  int TST_TOTAL = 6;
>  
> -char *bad_addr = 0;
> -
>  int longpath_setup();
>  int no_setup();
>  int filepath_setup();
> @@ -146,21 +142,11 @@ struct test_case_t {
>  	"nonexistfile", "non-existent file", ENOENT, no_setup}, {
>  	"", "path is empty string", ENOENT, no_setup}, {
>  	"nefile/file", "path contains a non-existent file",
> -		    ENOENT, no_setup},
> -#if !defined(UCLINUX)
> -	{
> -	High_address, "address beyond address space", EFAULT, no_setup},
> -#endif
> -	{
> +		    ENOENT, no_setup}, {
>  	"file/file", "path contains a regular file",
> -		    ENOTDIR, filepath_setup},
> -#if !defined(UCLINUX)
> -	{
> -	High_address, "address beyond address space", EFAULT, no_setup},
> -#endif
> -	{
> +		    ENOTDIR, filepath_setup}, {
>  	Longpathname, "pathname too long", ENAMETOOLONG, longpath_setup}, {
> -	(char *)-1, "negative address", EFAULT, no_setup}, {
> +	NULL, "negative address", EFAULT, no_setup}, {
                ^
		And here as well.

>  	NULL, NULL, 0, no_setup}
>  };
>  
> @@ -196,10 +182,9 @@ int main(int ac, char **av)
>  			fname = Test_cases[ind].pathname;
>  			desc = Test_cases[ind].desc;
>  
> -#if !defined(UCLINUX)
> -			if (fname == High_address)
> -				fname = get_high_address();
> -#endif
> +			if (!fname)
> +				fname = tst_get_bad_addr(cleanup);

And here as well.


-- 
Cyril Hrubis
chrubis@suse.cz
