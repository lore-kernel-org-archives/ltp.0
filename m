From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Aug 2016 13:39:05 +0200
Subject: [LTP] [PATCH V2 09/11] syscalls/waitpid: adapt reap_children()
 to test stopped children
In-Reply-To: <1472041679-29759-10-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1472041679-29759-10-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160825113904.GF10490@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If the pid returned by waitpid() is the pid of a stopped child,
> we send it the SIGCONT signal.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
> This is a new patch in the series, extracted from V1 of waitpid13.c
> 
>  testcases/kernel/syscalls/waitpid/waitpid_common.h |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/waitpid/waitpid_common.h b/testcases/kernel/syscalls/waitpid/waitpid_common.h
> index f724a17..7b67a06 100644
> --- a/testcases/kernel/syscalls/waitpid/waitpid_common.h
> +++ b/testcases/kernel/syscalls/waitpid/waitpid_common.h
> @@ -131,6 +131,23 @@ static int reap_children(pid_t wp_pid, int wp_opts, pid_t *children, int len)
>  			return -1;
>  		}
>  
> +		if (WIFSTOPPED(status)) {
> +			if (WSTOPSIG(status) != SIGSTOP) {
> +				tst_res(TFAIL,
> +					"Pid %d: expected SIGSTOP, got %d",
> +					pid, WSTOPSIG(status));
> +				return -1;
> +			}

Maybe we should print tst_res(TINFO, "Seding SIGCONT to %i", pid); here.

> +			if (kill(pid, SIGCONT) < 0) {
> +				tst_res(TFAIL | TERRNO,
> +					"kill(%d, SIGCONT) failed", pid);
> +				return -1;
> +			}
> +
> +			continue;
> +		}
> +
>  		for (i = 0; i < len; i++) {
>  			if (pid == children[i]) {
>  				children[i] = 0;

Otherwise it looks good.

I guess that there is no real chance that some of the children in
testcases that use this function would be SIGSTOPed accidentally and
this code will make that bug disappear...

-- 
Cyril Hrubis
chrubis@suse.cz
