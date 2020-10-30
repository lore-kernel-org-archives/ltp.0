From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Oct 2020 16:32:23 +0100
Subject: [LTP] [PATCH] Convert dup01 to new API and clean up
In-Reply-To: <20201030145350.23829-2-radoslav.kolev@suse.com>
References: <20201030145350.23829-1-radoslav.kolev@suse.com>
 <20201030145350.23829-2-radoslav.kolev@suse.com>
Message-ID: <20201030153223.GA2962@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + * Copyright (c) 2020 SUSE LLC
> + * 
> + * 03/30/1992 AUTHOR: William Roske CO-PILOT: Dave Fenner
> + * 30/10/2020 Convert to new api Radoslav Kolev <radoslav.kolev@suse.com>

While I tend to keep the historical changelog in the tests I do not add
new entries since that information is being kept in git metadata now.

> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  
> -void setup();
> -void cleanup();
> +static int fd;
> +static int dup_fd;
>  
> -char *TCID = "dup01";
> -int TST_TOTAL = 1;
> -
> -char filename[255];
> -int fd;
> -
> -int main(int ac, char **av)
> +static void verify_dup(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/*
> -		 * Call dup(2)
> -		 */
> -		TEST(dup(fd));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "dup(%s) Failed, errno=%d : %s",
> -				 filename, TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS, "dup(%s) returned %ld",
> -				 filename, TEST_RETURN);
> -
> -			/* close the new file so loops do not open too many files */
> -			SAFE_CLOSE(cleanup, TEST_RETURN);
> -		}
> -
> +	TEST(dup_fd = dup(fd));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TERRNO, "dup(%d) Failed, %s",
> +			fd);

This line does not seem to be over 80 characters, why it's broken before
the fd?

Also the format string does not match parameters.

And maybe we should be more pedantic with the check here, since any
negative value != -1 will be caught at the SAFE_CLOSE() which less than
optimal.

> +	} else {
> +		tst_res(TPASS, "dup(%d) returned %ld",
> +			fd, TST_RET);

Here as well, the line does not need to be broken.

> +		SAFE_CLOSE(dup_fd);

What's wrong with SAFE_CLOSE(TST_RET) ?

>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }
>  
> -void setup(void)
> +static void setup(void)
>  {
> -	fd = -1;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	sprintf(filename, "dupfile");
> -	if ((fd = open(filename, O_RDWR | O_CREAT, 0700)) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
> +	fd = SAFE_OPEN("dupfile", O_RDWR | O_CREAT, 0700);
>  }
>  
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	if (fd != -1)
> -		if (close(fd) == -1)
> -			tst_resm(TWARN | TERRNO, "closing %s failed", filename);
> -
> -	tst_rmdir();
> -
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = verify_dup,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};

Other than these the rest looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
