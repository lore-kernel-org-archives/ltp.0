From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Dec 2015 04:45:18 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/creat/creat09: fix error check of create
 syscall
In-Reply-To: <330BE2030BD7834286495D8B7FCF1FB71D338D22@mbx01.itr.canon-is.co.jp>
References: <330BE2030BD7834286495D8B7FCF1FB71D338D22@mbx01.itr.canon-is.co.jp>
Message-ID: <1794007526.29656006.1450345518910.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "TAKAHASHI Tetsuya" <takahashi.tetsuya.cis@canon-is.co.jp>
> To: "ltp@lists.linux.it" <ltp@lists.linux.it>
> Cc: "TAKEISHI Kazuhiro" <takeishi.kazuhiro.cis@canon-is.co.jp>
> Sent: Thursday, 17 December, 2015 6:54:55 AM
> Subject: [LTP] [PATCH] syscalls/creat/creat09: fix error check of create syscall
> 
> Hello.
> 
> I think that a create syscall check of syscalls/creat/creat09 is wrong.
> 
> When create syscall cannot make a file, the test result becomes PASS.
> In this case, the test result becomes FAIL is right.

Pushed with modified commit message and your signed-off-by.

Regards,
Jan

> 
> 
> diff -uprN a/testcases/kernel/syscalls/creat/creat09.c
> b/testcases/kernel/syscalls/creat/creat09.c
> --- a/testcases/kernel/syscalls/creat/creat09.c	2015-12-03 05:53:41.000000000
> +0900
> +++ b/testcases/kernel/syscalls/creat/creat09.c	2015-12-06 01:48:34.757125367
> +0900
> @@ -139,9 +139,13 @@ int main(int ac, char **av)
>  
>  		TEST(creat(fname, 0700));
>  
> -		if (TEST_RETURN == -1) {
> +		if (TEST_RETURN != -1) {
>  			tst_resm(TPASS, "creat(%s, 0700) returned %ld",
>  				 fname, TEST_RETURN);
> +		} else {
> +			tst_resm(TFAIL | TTERRNO, "creat(%s, 0700) FAILED",
> +				 fname);
> +			continue;
>  		}
>  
>  		/* close and remove file, possibly for next loop */
> 
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
