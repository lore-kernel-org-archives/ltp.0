From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Aug 2021 15:53:56 +0200
Subject: [LTP] [PATCH] [v2,2/4] syscalls/chroot02: Convert to new API
In-Reply-To: <20210806040011.18375-1-zhanglianjie@uniontech.com>
References: <20210806040011.18375-1-zhanglianjie@uniontech.com>
Message-ID: <YREzdGriU/g4H9L3@yuki>
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
> - * RESTRICTIONS
> - *	NONE
> + * Change root directory and then stat a file.

This may be better as well with something as:

    * Basic test for a chroot()
    *
    * - Create a file in a temporary directory
    * - Change root to the teporary directory
    * - Check that the file can be accessed
    *   in the new root directory

>   */
> 
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/wait.h>
> +#include <stdio.h>
> +#include <stdlib.h>
>  #include <errno.h>
> -#include "test.h"
> +#include <sys/stat.h>
>  #include <fcntl.h>
> -
> -char *TCID = "chroot02";
> -int TST_TOTAL = 1;
> -int fileHandle = 0;
> +#include "tst_test.h"
> 
>  #define TMP_FILENAME	"chroot02_testfile"
> -struct stat buf;
> -
> -void setup(void);
> -void cleanup(void);
> +static int fd;
> +static struct stat buf;
> 
> -int main(int ac, char **av)
> +static void verify_chroot(void)
>  {
> -	int lc;
> -	int pid, status, retval;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	/* Check for looping state if -i option is given */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		if ((pid = FORK_OR_VFORK()) == -1) {
> -			tst_brkm(TBROK, cleanup, "Could not fork");
> -		}
> -
> -		if (pid == 0) {
> -			retval = 0;
> -
> -			if (chroot(tst_get_tmpdir()) == -1) {
> -				perror("chroot failed");
> -				retval = 1;
> +	if (!SAFE_FORK()) {
> +		TST_EXP_PASS_SILENT(chroot(tst_get_tmpdir()), "chroot functionality correct");

Can we please store the pointer to tst_get_tmpdir() in the test setup?

As this will allocate buffer for each test iteration.

Also why PASS_SILENT, we are testing chroot here, it should show
PASS/FAIL for the chroot call.

Also the message passed to the TST_EXP_PASS is misleading, as it will be
printed when the call fails as well, it should be something as: "chroot(tmpdir)"

> +		if (TST_PASS) {
> +			if (stat("/" TMP_FILENAME, &buf) == -1) {
> +				tst_res(TFAIL, "chroot functionality incorrect");
>  			} else {
> -				if (stat("/" TMP_FILENAME, &buf) == -1) {
> -					retval = 1;
> -					perror("stat failed");
> -				}
> +				tst_res(TPASS, "chroot functionality correct");

And this should be just TST_EXP_PASS() as well.

Also the code can be written better so that we do not end up several
blocks deep as:

	if (!SAFE_FORK()) {
		TST_EXP_PASS(chroot(... );

		if (!TST_PASS)
			return;

		TST_EXP_PASS(stat("/" TMP_FILENAME, &buf));
	}
}
> -
> -			exit(retval);
>  		}
> -
> -		/* parent */
> -		wait(&status);
> -		/* make sure the child returned a good exit status */
> -		if (WIFSIGNALED(status) ||
> -		    (WIFEXITED(status) && WEXITSTATUS(status) != 0))
> -			tst_resm(TFAIL, "chroot functionality incorrect");
> -		else
> -			tst_resm(TPASS, "chroot functionality correct");
>  	}
> -
> -	cleanup();
> -	tst_exit();
> -
>  }
> 
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void setup(void)
>  {
> -	tst_require_root();
> -
> -	tst_tmpdir();
> -	if ((fileHandle = creat(TMP_FILENAME, 0777)) == -1)
> -		tst_brkm(TBROK, cleanup, "failed to create temporary file "
> -			 TMP_FILENAME);
> -	if (stat(TMP_FILENAME, &buf) != 0)
> -		tst_brkm(TBROK, cleanup, TMP_FILENAME " does not exist");
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	fd = SAFE_CREAT(TMP_FILENAME, 0777);
> +	SAFE_STAT(TMP_FILENAME, &buf);

Why do we keep the fd open during the testrun?

Why do we stat the file in the setup?

All that has to be done here is:

	SAFE_TOUCH(TMP_FILENAME, 0666, NULL);

>  }
> 
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	/*
> -	 * print timing stats if that option was specified.
> -	 * print errno log if that option was specified.
> -	 */
> -	close(fileHandle);
> +	SAFE_CLOSE(fd);
> +}
> 
> -	tst_rmdir();
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.setup = setup,
> +	.test_all = verify_chroot,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +};
> 
> -}
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
