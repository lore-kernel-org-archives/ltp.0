From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 16:15:21 +0200
Subject: [LTP] [PATCH] [3/4] syscalls/chroot03: Convert to new API
In-Reply-To: <20210806040033.18653-1-zhanglianjie@uniontech.com>
References: <20210806040033.18653-1-zhanglianjie@uniontech.com>
Message-ID: <YRE4eYQf5Rr5L0+7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*\
> + * [DESCRIPTION]

[Description]

>   *
> - *	4.	Test for EFAULT:
> - *		The pathname parameter to chroot() points to an invalid address,
> - *		chroot(2) fails with EPERM.
> - *
> - *	5.	Test for ELOOP:
> - *		Too many symbolic links were encountered When resolving the
> - *		pathname parameter.
> - *
> - *	07/2001 Ported by Wayne Boyer
> + *	Testcase to test whether chroot(2) sets errno correctly.
>   */
> 
>  #include <stdio.h>
> -#include <errno.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
> -#include "test.h"
> -#include <fcntl.h>
> -#include "safe_macros.h"
> -
> -char *TCID = "chroot03";
> +#include "tst_test.h"
> 
>  static int fd;
>  static char fname[255];
>  static char nonexistent_dir[100] = "testdir";
>  static char bad_dir[] = "abcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyzabcdefghijklmnopqrstmnopqrstuvwxyz";
>  static char symbolic_dir[] = "sym_dir1";
> +static char *bad_addr;
> 
> -struct test_case_t {
> +static struct tcase {
>  	char *dir;
>  	int error;
> -} TC[] = {
> -	/*
> -	 * to test whether chroot() is setting ENAMETOOLONG if the
> -	 * pathname is more than VFS_MAXNAMELEN
> -	 */
> -	{
> -	bad_dir, ENAMETOOLONG},
> +} tcases[] = {
> +		/*
> +		* to test whether chroot() is setting ENAMETOOLONG if the
> +		* pathname is more than VFS_MAXNAMELEN
> +		*/

These comments are useless, it would make much more sense to have these
in the [Description] formatted as an asciidoc list.

> +	{bad_dir, ENAMETOOLONG},
>  	    /*
>  	     * to test whether chroot() is setting ENOTDIR if the argument
>  	     * is not a directory.
>  	     */
> -	{
> -	fname, ENOTDIR},
> +	{fname, ENOTDIR},
>  	    /*
>  	     * to test whether chroot() is setting ENOENT if the directory
>  	     * does not exist.
>  	     */
> -	{
> -	nonexistent_dir, ENOENT},
> -#if !defined(UCLINUX)
> +	{nonexistent_dir, ENOENT},
>  	    /*
>  	     * attempt to chroot to a path pointing to an invalid address
>  	     * and expect EFAULT as errno
>  	     */
> -	{
> -	(char *)-1, EFAULT},
> -#endif
> +	{(char *)-1, EFAULT},
>  	{symbolic_dir, ELOOP}
>  };
> 
> -int TST_TOTAL = ARRAY_SIZE(TC);
> -
> -static char *bad_addr;
> -
> -static void setup(void);
> -static void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void verify_chroot(unsigned int n)
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
> +	struct tcase *tc = &tcases[n];
> 
> -		for (i = 0; i < TST_TOTAL; i++) {
> -			TEST(chroot(TC[i].dir));
> +	TST_EXP_FAIL(chroot(tc->dir), tc->error,
> +			"didn't fail as expected (expected errno "
> +			"= %d : %s)", tc->error, strerror(tc->error));

This is completely wrong, the TST_EXP_FAIL() will build the PASS/FAIL
messages, all that should be passed to it is a message that describes
what is being tested.

In this case it would be probably for the best to include a description
in the tcase structure and do just "%s", tc->desc here. And the
descriptions should look like:

	...
	{not_dir, ENOTDIR, "chroot(not-a-directory)"},
	{nonexistent, ENOENT, "chroot(does-not-exists)"},
	...

> -			if (TEST_RETURN != -1) {
> -				tst_resm(TFAIL, "call succeeded unexpectedly");
> -				continue;
> -			}
> -
> -			if (TEST_ERRNO == TC[i].error) {
> -				tst_resm(TPASS | TTERRNO, "failed as expected");
> -			} else {
> -				tst_resm(TFAIL | TTERRNO,
> -					 "didn't fail as expected (expected errno "
> -					 "= %d : %s)",
> -					 TC[i].error, strerror(TC[i].error));
> -			}
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
>  }
> 
>  static void setup(void)
>  {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -
>  	/*
>  	 * create a file and use it to test whether chroot() is setting
>  	 * ENOTDIR if the argument is not a directory.
>  	 */
>  	(void)sprintf(fname, "tfile_%d", getpid());
> -	fd = SAFE_CREAT(cleanup, fname, 0777);
> +	fd = SAFE_CREAT(fname, 0777);

Again there is no reason to keep the fd open during the testrun, we can
as well use SAFE_TOUCH() here instead.

> -#if !defined(UCLINUX)
> -	bad_addr = mmap(0, 1, PROT_NONE,
> -			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
> -	if (bad_addr == MAP_FAILED)
> -		tst_brkm(TBROK, cleanup, "mmap failed");
> -
> -	TC[3].dir = bad_addr;
> -#endif
> +	bad_addr = tst_get_bad_addr(NULL);
> +	tcases[3].dir = bad_addr;

Why do we need to store the bad_addr to a global variable here?

Also in order to avoid hardcoded indexes we usually use for loop to
initialize bad address with

	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
		if (tcases[i].error == EFAULT)
			tcases[i].dir = tst_get_bad_addr(NULL);
	}

>  	/*
>  	 * create two symbolic directory who point to each other to
>  	 * test ELOOP.
>  	 */
> -	SAFE_SYMLINK(cleanup, "sym_dir1/", "sym_dir2");
> -	SAFE_SYMLINK(cleanup, "sym_dir2/", "sym_dir1");
> +	SAFE_SYMLINK("sym_dir1/", "sym_dir2");
> +	SAFE_SYMLINK("sym_dir2/", "sym_dir1");
>  }
> 
>  static void cleanup(void)
>  {
> -	close(fd);
> -	tst_rmdir();
> +	SAFE_CLOSE(fd);
>  }
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_chroot,
> +	.needs_tmpdir = 1,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
