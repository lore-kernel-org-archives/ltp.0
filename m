From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 12:07:11 +0100
Subject: [LTP] [PATCH] syscalls/creat08.c: Do not move temporary
 directory in loops
In-Reply-To: <1519379303-2306-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1519379303-2306-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180227110711.fw72g5jlnnmtb2gq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> During running creat08 in loops, the deletion of temporary
> directory leads to failure. as below:
> ----------------------------------------------------------
> creat08     1  TPASS  :  Test passed in block0.
> creat08     2  TPASS  :  Test passed in block1.
> creat08     3  TPASS  :  Test passed in block2.
> creat08     4  TPASS  :  Test passed in block3
> creat08     5  TFAIL  :  creat08.c:143: Creation of testdir.A.24370 failed
> ...
> ----------------------------------------------------------

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/creat/creat08.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
> index 284ae5f..50f2b39 100644
> --- a/testcases/kernel/syscalls/creat/creat08.c
> +++ b/testcases/kernel/syscalls/creat/creat08.c
> @@ -70,6 +70,7 @@ int local_flag;
>  #define ROOT_SETGID	"root_setgid"
>  #define	MSGSIZE		150

> +static void tst_cleanup(void);
>  static void cleanup(void);
>  static void setup(void);

> @@ -423,8 +424,9 @@ int main(int ac, char **av)
>  		} else {
>  			tst_resm(TFAIL, "Test failed in block3");
>  		}
> -		cleanup();
> +		tst_cleanup();
>  	}
> +	cleanup();
>  	tst_exit();
>  }

> @@ -434,7 +436,7 @@ static void setup(void)
>  	tst_tmpdir();
>  }

> -static void cleanup(void)
> +static void tst_cleanup(void)
>  {
>  	if (unlink(setgid_A) == -1) {
>  		tst_resm(TBROK, "%s failed", setgid_A);
> @@ -447,6 +449,9 @@ static void cleanup(void)
>  	SAFE_UNLINK(NULL, root_setgid_B);
>  	SAFE_UNLINK(NULL, nosetgid_B);
>  	SAFE_RMDIR(NULL, DIR_B);
> +}

> +static void cleanup(void)
> +{
>  	tst_rmdir();
>  }
Pushed, thanks!


Kind regards,
Petr
