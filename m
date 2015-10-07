From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Oct 2015 14:27:44 +0200
Subject: [LTP] [PATCH] syscall/renameat2: Fix filesystem
In-Reply-To: <1444220011-11327-1-git-send-email-chnyda@suse.com>
References: <1444220011-11327-1-git-send-email-chnyda@suse.com>
Message-ID: <20151007122744.GA2608@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -136,6 +139,12 @@ static void renameat2_verify(const struct test_case *test)
>  	TEST(renameat2(*(test->olddirfd), test->oldpath,
>  			*(test->newdirfd), test->newpath, test->flags));
>  
> +	if (TEST_ERRNO == EINVAL && fs_type == TST_BTRFS_MAGIC) {
> +		tst_brkm(TCONF, cleanup,
> +			"RENAME_EXCHANGE flag is not implemeted on %s",
> +			tst_fs_type_name(fs_type));
> +	}

We should check here that the test->flags == RENAME_EXCHANGE here as
well, otherwise we may issue the message even for RENAME_NOREPLACE which
would be a confusing.

And I would just tst_resm(TCONF, ...) then return; so that we carry on
with the rest of the test.

I'm unsure if we should issue PASS or CONF here if we are on btrfs and
the expected errno is EINVAL. Either way we cannot say from which kernel
part we actually got the EINVAL and if that was the expected or the
unexpected one.

>  	if (test->exp_errno && TEST_RETURN != -1) {
>  		tst_resm(TFAIL, "renameat2() succeeded unexpectedly");
>  		return;
> diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
> index e695e85..c9731f5 100644
> --- a/testcases/kernel/syscalls/renameat2/renameat202.c
> +++ b/testcases/kernel/syscalls/renameat2/renameat202.c
> @@ -25,6 +25,7 @@
>  #define _GNU_SOURCE
>  
>  #include "test.h"
> +#include "tst_fs_type.h"
>  #include "safe_macros.h"
>  #include "lapi/fcntl.h"
>  #include "renameat2.h"
> @@ -43,6 +44,7 @@ static int fd = -1;
>  static int cnt;
>  
>  static const char content[] = "content";
> +static long fs_type;
>  
>  
>  int TST_TOTAL = 1;
> @@ -85,6 +87,8 @@ static void setup(void)
>  
>  	tst_tmpdir();
>  
> +	fs_type = tst_fs_type(cleanup, ".");
> +
>  	SAFE_MKDIR(cleanup, TEST_DIR, 0700);
>  	SAFE_MKDIR(cleanup, TEST_DIR2, 0700);
>  
> @@ -120,6 +124,12 @@ static void renameat2_verify(void)
>  	char *emptyfile;
>  	char *contentfile;
>  
> +	if (TEST_ERRNO == EINVAL && fs_type == TST_BTRFS_MAGIC) {
> +		tst_brkm(TCONF, cleanup,
> +			"RENAME_EXCHANGE flag is not implemeted on %s",
> +			tst_fs_type_name(fs_type));
> +	}
> +
>  	if (TEST_RETURN != 0) {
>  		tst_resm(TFAIL, "renameat2() failed unexpectedly");
>  		return;
> @@ -148,6 +158,6 @@ static void renameat2_verify(void)
>  		tst_resm(TPASS,
>  			"renameat2() swapped the content of the two files");
>  	else
> -		tst_resm(TFAIL,
> +		tst_resm(TFAIL | TTERRNO,
>  			"renameat2() didn't swap the content of the two files");

Why do we add the TTERRNO here? It should be rather added to the
tst_resm(TFAIL, "renameat2() failed unexpectedly"); shouldn't it?

-- 
Cyril Hrubis
chrubis@suse.cz
