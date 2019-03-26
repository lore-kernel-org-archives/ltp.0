From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 17:11:55 +0100
Subject: [LTP] [PATCH 4/4] syscalls/acct01: convert to new library
In-Reply-To: <20190325232012.67123-5-sspatil@android.com>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190325232012.67123-5-sspatil@android.com>
Message-ID: <20190326161154.GC11086@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
>  			 S_IXGRP|S_IROTH|S_IXOTH)
> @@ -48,169 +28,106 @@
>  #define TEST_FILE5	"./tmpfile"
>  #define TEST_FILE6	"test_file_eloop1"
>  #define TEST_FILE7	nametoolong
> -#define TEST_FILE8	"mntpoint/tmp"
> +#define TEST_FILE8	"mntpoint/file"

Maybe it would be better to name these after the error they cause i.e.
FILE_EISDIR etc. Also some of these do point outside of the test
temporary directory and even if it's unlikely to mess up with the system
that way we should use "." instead of "/", create a file in PWD instead
of /etc/fstab/ etc.

...

> -	tst_rmdir();
> +	if (TST_ERR == tcase->exp_errno)
> +		tst_res(TPASS | TTERRNO, "acct() failed as expected");
> +	else
> +		tst_res(TFAIL | TTERRNO,
> +				"acct() failed, expected: %d - %s",
> +				tcase->exp_errno, strerror(tcase->exp_errno));

As in previous test you should use tst_strerrno() to print errno
instead.


Other than these two minor points the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
