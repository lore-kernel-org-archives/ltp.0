From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Nov 2018 14:23:17 +0100
Subject: [LTP] [PATCH] syscalls/ptrace05: skip internally used signals
In-Reply-To: <20181024220101.140311-1-smuckle@google.com>
References: <20181024220101.140311-1-smuckle@google.com>
Message-ID: <20181102132316.GB22411@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace05.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
> index 22261f3df..420330029 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace05.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
> @@ -71,6 +71,9 @@ int main(int argc, char **argv)
>  
>  	for (signum = start_signum; signum <= end_signum; signum++) {
>  
> +		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
> +			continue;

I'm a bit worried about using the libc internal __SIGRTMIN but I doubt
that we can get this information elsewhere.

Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
