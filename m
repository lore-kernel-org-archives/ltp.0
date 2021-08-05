From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Aug 2021 11:52:36 +0200
Subject: [LTP] [PATCH] [2/4] syscalls/chroot02: Convert to new API
In-Reply-To: <20210805073405.15310-1-zhanglianjie@uniontech.com>
References: <20210805073405.15310-1-zhanglianjie@uniontech.com>
Message-ID: <YQu05CxhjG8f5EJT@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*\
> + * [DESCRIPTION]
>   *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *	04/2003 Modified by Manoj Iyer - manjo@mail.utexas.edu

We usually move this part just after the IBM copyright.

> - *	Change testcase to chroot into a temporary directory
> - *	and stat() a known file.
> - *
> - * RESTRICTIONS
> - *	NONE
> + * Change root directory and then stat a file.
>   */
> -
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
> +int fileHandle = 0;

Uff, just use fd as we do everywhere else, also it should be static and
moreover global variables are already initialized to 0 so this really
should be just:

static int fd;

>  struct stat buf;

static as well.

> -void setup(void);
> -void cleanup(void);
> -
> -int main(int ac, char **av)
> +static void verify_chroot(void)
>  {
> -	int lc;
>  	int pid, status, retval;
> 
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
> +	if ((pid = SAFE_FORK()) == -1) {
> +		tst_brk(TBROK, "Could not fork");
> +	}

Again SAFE_ macros cannot fail.

> -		if (pid == 0) {
> -			retval = 0;
> +	if (pid == 0) {
> +		retval = 0;
> 
> -			if (chroot(tst_get_tmpdir()) == -1) {
> -				perror("chroot failed");
> +		if (chroot(tst_get_tmpdir()) == -1) {
> +			perror("chroot failed");
> +			retval = 1;

This should be TST_EXP_PASS().

> +		} else {
> +			if (stat("/" TMP_FILENAME, &buf) == -1) {
>  				retval = 1;
> -			} else {
> -				if (stat("/" TMP_FILENAME, &buf) == -1) {
> -					retval = 1;
> -					perror("stat failed");
> -				}
> +				perror("stat failed");
>  			}
> -
> -			exit(retval);
>  		}
> 
> -		/* parent */
> -		wait(&status);
> -		/* make sure the child returned a good exit status */
> -		if (WIFSIGNALED(status) ||
> -		    (WIFEXITED(status) && WEXITSTATUS(status) != 0))
> -			tst_resm(TFAIL, "chroot functionality incorrect");
> -		else
> -			tst_resm(TPASS, "chroot functionality correct");
> +		exit(retval);
>  	}
> 
> -	cleanup();
> -	tst_exit();
> +	/* parent */
> +	SAFE_WAIT(&status);
> +	/* make sure the child returned a good exit status */
> +	if (WIFSIGNALED(status) ||
> +			(WIFEXITED(status) && WEXITSTATUS(status) != 0))
> +		tst_res(TFAIL, "chroot functionality incorrect");
> +	else
> +		tst_res(TPASS, "chroot functionality correct");

New library testcases can call tst_res() from a child processes so there
is no reason to propagate the test result via process exit value. The
child should use tst_res() instead of the perror() calls and the parent
should just call tst_reap_children().

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
>  	if ((fileHandle = creat(TMP_FILENAME, 0777)) == -1)
> -		tst_brkm(TBROK, cleanup, "failed to create temporary file "
> -			 TMP_FILENAME);
> +		tst_brk(TBROK, "failed to create temporary file "
> +				TMP_FILENAME);
>  	if (stat(TMP_FILENAME, &buf) != 0)
> -		tst_brkm(TBROK, cleanup, TMP_FILENAME " does not exist");
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +		tst_brk(TBROK, TMP_FILENAME " does not exist");

We do have SAFE_CREAT() and SAFE_STAT() please use them here as well.

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
>  	close(fileHandle);

You should use SAFE_CLOSE() here as well.

> -
> -	tst_rmdir();
> -
>  }
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.setup = setup,
> +	.test_all = verify_chroot,
> +	.needs_root = 1,
> +	.forks_child = 1,
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
