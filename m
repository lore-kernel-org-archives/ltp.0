From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Jun 2018 08:32:45 -0400 (EDT)
Subject: [LTP] [PATCH] open08: rewrite to newlib
In-Reply-To: <8f4b0a827cd6da1c3774d8fe4f281039b8bce43b.1528979235.git.jstancek@redhat.com>
References: <8f4b0a827cd6da1c3774d8fe4f281039b8bce43b.1528979235.git.jstancek@redhat.com>
Message-ID: <1171059315.26614818.1528979565733.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Fixes: https://github.com/linux-test-project/ltp/issues/330
> 
> EACCES testcase changed:
> Test now creates file (0600) in tmpdir, that is owned by privileged user,
> and unprivileged user tries to open it for writing.
> 
> uclinux ifdefs dropped.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/open/open08.c | 137
>  +++++++++++++-------------------
>  1 file changed, 55 insertions(+), 82 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/open/open08.c
> b/testcases/kernel/syscalls/open/open08.c
> index d55d8e6bdd53..8cf44b64063a 100644
> --- a/testcases/kernel/syscalls/open/open08.c
> +++ b/testcases/kernel/syscalls/open/open08.c
> @@ -1,5 +1,6 @@
>  /*
>   *   Copyright (c) 2013 Wanlong Gao <gaowanlong@cn.fujitsu.com>
> + *   Copyright (c) 2018 Linux Test Project
>   *
>   *   This program is free software;  you can redistribute it and/or modify
>   *   it under the terms of the GNU General Public License as published by
> @@ -39,7 +40,7 @@
>   *	4. Attempt to open() a filename which is more than VFS_MAXNAMLEN, and
>   *	   check for errno to be ENAMETOOLONG.
>   *
> - *	5. Attempt to open a test executable in WRONLY mode,
> + *	5. Attempt to open a (0600) file owned by different user in WRONLY mode,
>   *	   open(2) should fail with EACCES.
>   *
>   *	6. Attempt to pass an invalid pathname with an address pointing outside
> @@ -56,113 +57,85 @@
>  #include <fcntl.h>
>  #include <signal.h>
>  #include <pwd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -char *TCID = "open08";
> -
> -static char nobody_uid[] = "nobody";
> -static struct passwd *ltpuser;
> -
> -static char *bad_addr;
> +#include "tst_test.h"
>  
>  static char filename[40] = "";
> -static char fname[] = "/bin/cat";
> +static char user2_file[] = "user2_0600";
>  static char bad_file[] =
>  "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
>  
> +struct test_case_t;
> +static void setup_badfname_buf(struct test_case_t *t);
> +
>  static struct test_case_t {
> +	void (*setup)(struct test_case_t *t);
>  	char *fname;
>  	int flags;
>  	int error;
> -} TC[] = {
> -	{filename, O_CREAT | O_EXCL, EEXIST},
> -	{"/tmp", O_RDWR, EISDIR},
> -	{filename, O_DIRECTORY, ENOTDIR},
> -	{bad_file, O_RDWR, ENAMETOOLONG},
> -	{fname, O_WRONLY, EACCES},
> -#if !defined(UCLINUX)
> -	{(char *)-1, O_CREAT, EFAULT}
> -#endif
> +} tcases[] = {
> +	{NULL, filename, O_CREAT | O_EXCL, EEXIST},
> +	{NULL, "/tmp", O_RDWR, EISDIR},
> +	{NULL, filename, O_DIRECTORY, ENOTDIR},
> +	{NULL, bad_file, O_RDWR, ENAMETOOLONG},
> +	{NULL, user2_file, O_WRONLY, EACCES},
> +	{setup_badfname_buf, NULL, O_CREAT, EFAULT}
>  };
>  
> -int TST_TOTAL = sizeof(TC) / sizeof(TC[0]);
> -
> -int main(int ac, char **av)
> +void verify_open(unsigned int i)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(open(TC[i].fname, TC[i].flags,
> -				  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
> -
> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS, "expected failure - "
> -					 "errno = %d : %s", TEST_ERRNO,
> -					 strerror(TEST_ERRNO));
> -			} else {
> -				tst_resm(TFAIL, "unexpected error - %d : %s - "
> -					 "expected %d", TEST_ERRNO,
> -					 strerror(TEST_ERRNO), TC[i].error);
> -			}
> -		}
> +	TEST(open(tcases[i].fname, tcases[i].flags,
> +		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
> +
> +	if (TEST_RETURN != -1) {
> +		tst_res(TFAIL, "call succeeded unexpectedly");
> +		return;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	if (TEST_ERRNO == tcases[i].error) {
> +		tst_res(TPASS, "expected failure - "
> +				"errno = %d : %s", TEST_ERRNO,
> +				strerror(TEST_ERRNO));
> +	} else {
> +		tst_res(TFAIL, "unexpected error - %d : %s - "
> +				"expected %d", TEST_ERRNO,
> +				strerror(TEST_ERRNO), tcases[i].error);
> +	}
>  }
>  
> -static void setup(void)
> +static void setup_badfname_buf(struct test_case_t *t)
>  {
> -	int fildes;
> +	if (!t->fname) {
> +		char *bad_addr;
>  
> -	tst_require_root();
> +		bad_addr = SAFE_MMAP(0, 1, PROT_NONE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +		t->fname = bad_addr;
> +	}
> +}

I realized I forgot to add call to setup func, so this isn't getting called,
but NULL leads to EFAULT as well. Will fix in v2.

>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +static void setup(void)
> +{
> +	int fildes;
> +	char nobody_uid[] = "nobody";
> +	struct passwd *ltpuser;
>  
>  	umask(0);
>  
> -	TEST_PAUSE;
> +	SAFE_CREAT(user2_file, 0600);
>  
>  	/* Switch to nobody user for correct error code collection */
>  	ltpuser = getpwnam(nobody_uid);
> -	SAFE_SETGID(NULL, ltpuser->pw_gid);
> -	SAFE_SETUID(NULL, ltpuser->pw_uid);
> -
> -	tst_tmpdir();
> +	SAFE_SETGID(ltpuser->pw_gid);
> +	SAFE_SETUID(ltpuser->pw_uid);
>  
>  	sprintf(filename, "open3.%d", getpid());
> -
> -	fildes = SAFE_CREAT(cleanup, filename, 0600);
> -
> +	fildes = SAFE_CREAT(filename, 0600);
>  	close(fildes);
> -
> -#if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED)
> -		tst_brkm(TBROK, cleanup, "mmap failed");
> -
> -	TC[5].fname = bad_addr;
> -#endif
>  }
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.setup = setup,
> +	.test = verify_open,
> +};
> --
> 1.8.3.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
