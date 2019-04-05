From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 Apr 2019 15:01:19 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/acct01: convert to new library
In-Reply-To: <20190328114700.189583-2-sspatil@android.com>
References: <20190328114700.189583-1-sspatil@android.com>
 <20190328114700.189583-2-sspatil@android.com>
Message-ID: <20190405130119.GB7540@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with cosmetic changes, thanks.

> -static void setup2(void)
> +static void verify_acct(unsigned int nr)
>  {
> -	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> -}
> +	struct test_case *tcase = &tcases[nr];
>  
> -static void cleanup2(void)
> -{
> -	SAFE_SETEUID(cleanup, 0);
> -}
> +	if (tcase->setupfunc)
> +		tcase->setupfunc();
>  
> -static void cleanup(void)
> -{
> -	if (acct(NULL) == -1)
> -		tst_resm(TWARN | TERRNO, "acct(NULL) failed");
> +	TEST(acct(tcase->filename));
>  
> -	if (mount_flag && tst_umount("mntpoint") < 0) {
> -		tst_resm(TWARN | TERRNO,
> -			 "umount device:%s failed", device);
> -	}
> +	if (tcase->cleanfunc)
> +		tcase->cleanfunc();
>  
> -	if (device)
> -		tst_release_device(device);
> +	if (TST_RET != -1)
> +		tst_res(TFAIL, "acct(%s) succeeded unexpectedly",
> +				tcase->filename);

I've put this block inside curly braces and added return; after the
tst_res() here so that the code flow is more clear.

> -	tst_rmdir();
> +	if (TST_ERR == tcase->exp_errno)
> +		tst_res(TPASS | TTERRNO, "acct() failed as expected");
> +	else
> +		tst_res(TFAIL | TTERRNO,
> +				"acct() failed, expected: %s",
> +				tst_strerrno(tcase->exp_errno));

And also added curly braces around these blocks, since LKML prefers to
have them when at least one block spans across multiple lines.

-- 
Cyril Hrubis
chrubis@suse.cz
