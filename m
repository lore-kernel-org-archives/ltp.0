From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 12:44:41 +0200
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <20210429125255.31510-1-zhaogongyi@huawei.com>
References: <20210429125255.31510-1-zhaogongyi@huawei.com>
Message-ID: <YJPImeHT9rVsVtON@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao, Cyril,

> diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt01.c
...
> @@ -149,15 +132,13 @@ int main(int ac, char **av)
>  		(void)waitpid(pid, &status, 0);

>  		if (WEXITSTATUS(status) != 0) {
> -			flag = FAILED;
>  			tst_resm(TFAIL, "Did not generate SEGV, child returned "
>  				 "unexpected status");
> -		}
> -
> -		if (flag) {
> -			tst_resm(TINFO, "block 2 FAILED");
>  		} else {
> -			tst_resm(TINFO, "block 2 PASSED");
> +			if (WIFSIGNALED(status) && (WTERMSIG(status) == SIGSEGV))
> +				tst_resm(TPASS, "generate SEGV as expected");
> +			else
> +				tst_resm(TFAIL, "Did not generate SEGV");
FYI: since merging this patch (f5e8e6b11) test fails on this. Is it expected?
I haven't looked closer whether it's a test bug or real issue.

Kind regards,
Petr
