From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Mar 2018 08:48:34 +0100
Subject: [LTP] [PATCH 1/3] syscalls/fchmod*: Fix compiler warnings
In-Reply-To: <1519977744-1595-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1519977744-1595-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180305074833.ed3ijclfyryipoyn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/fchmod/fchmod05.c | 4 ++--
>  testcases/kernel/syscalls/fchmod/fchmod07.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
> index 7a27028..cdd3d07 100644
> --- a/testcases/kernel/syscalls/fchmod/fchmod05.c
> +++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
> @@ -220,8 +220,8 @@ void cleanup(void)
>  	/* Close the test directory opened in the setup() */
>  	SAFE_CLOSE(NULL, fd);

> -	setegid(0);
> -	seteuid(0);
> +	SAFE_SETEGID(NULL, 0);
> +	SAFE_SETEUID(NULL, 0);

>  	tst_rmdir();

> diff --git a/testcases/kernel/syscalls/fchmod/fchmod07.c b/testcases/kernel/syscalls/fchmod/fchmod07.c
> index 66032e4..6973555 100644
> --- a/testcases/kernel/syscalls/fchmod/fchmod07.c
> +++ b/testcases/kernel/syscalls/fchmod/fchmod07.c
> @@ -83,7 +83,7 @@ int fd;				/* file descriptor for testfile */
>  char *TCID = "fchmod07";
>  int TST_TOTAL = 8;		/* Total number of test conditions */

> -int Modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };
> +mode_t Modes[] = { 0, 07, 070, 0700, 0777, 02777, 04777, 06777 };

>  void setup();			/* setup function for the test */
>  void cleanup();			/* cleanup function for the test */
> @@ -93,7 +93,7 @@ int main(int ac, char **av)
>  	struct stat stat_buf;	/* stat(2) struct contents */
>  	int lc;
>  	int ind;		/* counter variable for chmod(2) tests */
> -	int mode;		/* file mode permission */
> +	mode_t mode;		/* file mode permission */

>  	TST_TOTAL = sizeof(Modes) / sizeof(int);
Pushed, thanks!


Kind regards,
Petr
