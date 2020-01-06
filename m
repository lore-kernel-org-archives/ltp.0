From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 6 Jan 2020 15:32:48 +0800
Subject: [LTP] [PATCH v2] syscalls/userfaultfd01: add hint about
 unprivileged_userfaultfd
In-Reply-To: <1576641763-18305-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576641763-18305-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <0ec6817b-8b78-40ac-11c3-39ab4c1c87a7@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
Ping.
> Since commit cefdca0a86be ("userfaultfd/sysctl: add vm.unprivileged_userfaultfd").
> , it adds a global sysctl knob "vm.unprivileged_userfaultfd" to control whether
> unprivileged users can use the userfaultfd system calls. Set this to 1 to allow
> unprivileged users to use the userfaultfd system calls, or set this to 0 to
> restrict userfaultfd to only privileged users (with SYS_CAP_PTRACE capability). The
> default value is 1. Add hint about it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   .../syscalls/userfaultfd/userfaultfd01.c      | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> index a5e142209..4e178b4f8 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> @@ -82,12 +82,19 @@ static void run(void)
>   
>   	set_pages();
>   
> -	uffd = sys_userfaultfd(O_CLOEXEC | O_NONBLOCK);
> -
> -	if (uffd == -1)
> -		tst_brk(TBROK | TERRNO,
> -			"Could not create userfault file descriptor");
> -
> +	TEST(sys_userfaultfd(O_CLOEXEC | O_NONBLOCK));
> +
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EPERM) {
> +			tst_res(TCONF, "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
> +			tst_brk(TCONF | TTERRNO,
> +				"userfaultfd() requires CAP_SYS_PTRACE on this system");
> +		} else
> +			tst_brk(TBROK | TTERRNO,
> +				"Could not create userfault file descriptor");
> +	}
> +
> +	uffd = TST_RET;
>   	uffdio_api.api = UFFD_API;
>   	uffdio_api.features = 0;
>   	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> 


