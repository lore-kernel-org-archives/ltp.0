From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 11:46:18 +0100
Subject: [LTP] [PATCH] syscalls/truncate02: initialize read_len variable
 in loops
In-Reply-To: <1518574452-4643-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1518574452-4643-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180227104618.taak37bou7z54npv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> During running truncate02 in loops, the increasing value of
> read_len leads to failure. as below:
> ----------------------------------------------------------
> truncate02    1  TPASS  :  Functionality of truncate(2) on testfile successful
> truncate02    1  TFAIL  :  truncate02.c:208: Functionality of truncate(2) on testfile Failed
> ----------------------------------------------------------

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/truncate/truncate02.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/truncate/truncate02.c b/testcases/kernel/syscalls/truncate/truncate02.c
> index 4cbf0e4..6c91149 100644
> --- a/testcases/kernel/syscalls/truncate/truncate02.c
> +++ b/testcases/kernel/syscalls/truncate/truncate02.c
> @@ -100,7 +100,6 @@ int main(int ac, char **av)
>  	off_t file_length2;	/* test file length */
>  	off_t file_length1;	/* test file length */
>  	int rbytes;		/* bytes read from testfile */
> -	int read_len = 0;	/* total no. of bytes read from testfile */
>  	int err_flag = 0;	/* error indicator flag */

>  	tst_parse_opts(ac, av, NULL, NULL);
> @@ -110,6 +109,8 @@ int main(int ac, char **av)
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {

>  		tst_count = 0;
> +		/* total no. of bytes read from testfile */
> +		int read_len = 0;

>  		/*
>  		 * Call truncate(2) to truncate a test file to a

Pushed, thanks!

I fixed the same problem in ftruncate02.c and move declaration of read_len in
truncate02.c out of loop in next commit.


Kind regards,
Petr
