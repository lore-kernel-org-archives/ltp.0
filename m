From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 15 Oct 2018 15:17:20 +0800
Subject: [LTP] [PATCH] sigwaitinfo01: recent glibc calls syscall directly
In-Reply-To: <dbe33b2d18cd674954668fa62ab61f0d57e0c704.1536739517.git.jstancek@redhat.com>
References: <dbe33b2d18cd674954668fa62ab61f0d57e0c704.1536739517.git.jstancek@redhat.com>
Message-ID: <5BC43F00.3080109@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/09/12 16:09, Jan Stancek wrote:
> glibc commit
>    8b0e795aaa44 ("Simplify Linux sig{timed}wait{info} implementations")
> changed sigwaitinfo to call sigtimedwait, which calls rt_sigtimedwait
> syscall directly.
>
> So, an invalid pointer no longer crashes child process and test
> reports failure. Fix it by accepting either crash or EFAULT.
>
> Signed-off-by: Jan Stancek<jstancek@redhat.com>
> ---
>   .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 29 +++++++++++++++++++---
>   1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
> index 95a9436a44c9..02730364db4d 100644
> --- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
> +++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
> @@ -371,19 +371,40 @@ void test_bad_address2(swi_func sigwaitinfo, int signo)
>   		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
>   	case 0:
>   		signal(SIGSEGV, SIG_DFL);
> +
> +		/*
> +		 * depending on glibc implementation we should
> +		 * either crash or get EFAULT
> +		 */
>   		TEST(sigwaitinfo((void *)1, NULL, NULL));
>
> -		_exit(0);
> +		if (TEST_RETURN == -1&&  TEST_ERRNO == EFAULT)
> +			_exit(0);
> +
> +		tst_resm(TINFO, "swi_func returned: %ld, errno: %d",
> +			TEST_RETURN, TEST_ERRNO);
Hi Jan,

Perhaps, just use tst_resm(TINFO | TTERRNO, "swi_func returned: %ld", TEST_RETURN);

Other than that this patch looks good to me, and it works well on glibc v2.28.

Thanks,
Xiao Yang

> +		_exit(1);
>   		break;
>   	default:
>   		break;
>   	}
>
>   	SUCCEED_OR_DIE(waitpid, "waitpid failed", pid,&status, 0);
> -	if (WIFSIGNALED(status)&&  WTERMSIG(status) == SIGSEGV)
> +
> +	if ((WIFSIGNALED(status)&&  WTERMSIG(status) == SIGSEGV)
> +		|| (WIFEXITED(status)&&  WEXITSTATUS(status) == 0)) {
>   		tst_resm(TPASS, "Test passed");
> -	else
> -		tst_resm(TFAIL, "Unrecognised child exit code");
> +		return;
> +	}
> +
> +	if (WIFEXITED(status)) {
> +		tst_resm(TFAIL, "Unrecognised child exit code: %d",
> +			WEXITSTATUS(status));
> +	}
> +	if (WIFSIGNALED(status)) {
> +		tst_resm(TFAIL, "Unrecognised child termsig: %d",
> +			WTERMSIG(status));
> +	}
>   }
>
>   void test_bad_address3(swi_func sigwaitinfo, int signo)



