From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Feb 2016 12:47:22 +0100
Subject: [LTP] [PATCH] syscalls/renameat202: initialize str with zero
In-Reply-To: <1455713810-21842-1-git-send-email-eguan@redhat.com>
References: <1455713810-21842-1-git-send-email-eguan@redhat.com>
Message-ID: <20160218114722.GC19157@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In renameat2_verify(), str is allocated on stack with size 8 (sizeof
> content) and filled with random data. Then file content (7 bytes) is
> read into str and the last byte in str is left unchanged with garbage,
> and test fails if that last byte is not zero.

Good catch.

> Fix it by initializing the str with zeros, make sure str is null
> terminated as long as correct data has been read in.

Looking at the code it may be easier to use write() to write the string
including the null byte in the setup. But either one is fine.

> Also remove the "str[strlen(content)] == '\0'" check, which is not
> necessary, because strcmp will catch the failure anyway.

This has been added there on purpose so that we are sure the test
wouldn't segfault in case that the str is not null terminated which is
unlikely but still possible. And it's still possible even when you zero
the str buffer since the read may overwrite whole str and passing
non-null terminated buffer to strcmp() is still undefined operation.

Maybe it would be much better to try to read a buffer larger than the
expected content, check that the value from read was size of the data
and then do memcmp() with explicit size.

BTW: The size of the str should be increased anyway since the read gets
     strlen(content) + 10 as a size parameter which is larger than
     sizeof(str). We should just change it to some arbitrary large value
     like 128.

> Also improve the failure message to print more useful debug message.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  testcases/kernel/syscalls/renameat2/renameat202.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
> index 3761391..9e2d12e 100644
> --- a/testcases/kernel/syscalls/renameat2/renameat202.c
> +++ b/testcases/kernel/syscalls/renameat2/renameat202.c
> @@ -118,7 +118,7 @@ static void cleanup(void)
>  
>  static void renameat2_verify(void)
>  {
> -	char str[sizeof(content)];
> +	char str[sizeof(content)] = { 0 };
>  	struct stat st;
>  	char *emptyfile;
>  	char *contentfile;
> @@ -152,11 +152,12 @@ static void renameat2_verify(void)
>  		tst_brkm(TERRNO | TFAIL, cleanup, "close fd failed");
>  	fd = 0;
>  
> -	if (str[strlen(content)] == '\0' && !strcmp(content, str)
> -		&& !st.st_size)
> -		tst_resm(TPASS,
> -			"renameat2() swapped the content of the two files");
> -	else
> -		tst_resm(TFAIL,
> -			"renameat2() didn't swap the content of the two files");
> +	if (strcmp(content, str)) {
> +		tst_resm(TFAIL, "file content changed after renameat2()");
> +		tst_resm(TFAIL, "expect \"%s\", got \"%s\"", content, str);

This adds two FAIL statements in the output for one failure. Either
print the message in one tst_resm() statement or change the second one
to TINFO.

> +	} else if (st.st_size) {
> +		tst_resm(TFAIL, "emptyfile has non-zero file size");

You should do return in the previous if() so that you don't have to do
the else if () spagetthi code here.

And if you do return here the TPASS message does not have to be in the
else block as well.

> +	} else {
> +		tst_resm(TPASS, "renameat2() test passed");
> +	}
>  }

-- 
Cyril Hrubis
chrubis@suse.cz
