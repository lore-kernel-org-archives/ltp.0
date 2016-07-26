From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 18:03:30 +0200
Subject: [LTP] [PATCH V3 07/23] ptrace: Use int instead of enum
 __ptrace_request
In-Reply-To: <20160722042656.22346-7-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-7-raj.khem@gmail.com>
Message-ID: <20160726160329.GD5868@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> __ptrace_request is only available with glibc
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace03.c           | 2 +-
>  testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
> index a4028fc..f326b83 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace03.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
> @@ -102,7 +102,7 @@ static pid_t unused_pid;
>  static pid_t zero_pid;
>  
>  struct test_case_t {
> -	enum __ptrace_request request;
> +	int request;
>  	pid_t *pid;
>  	int exp_errno;
>  } test_cases[] = {
> diff --git a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
> index ae538e9..83de9b4 100644
> --- a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
> +++ b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
> @@ -130,7 +130,7 @@ static char *strings[] = {
>  	SPT(KILL)
>  	SPT(SINGLESTEP)
>  };
> -static inline char *strptrace(enum __ptrace_request request)
> +static inline char *strptrace(int request)
>  {
>  	return strings[request];
>  }

The enum __ptrace_request is used to describe the function prototype in
the ptrace() manual page so one can argue that it's part of the official
API.

If I remeber right, it's missing in musl libc and the code in question
fails to compile.

CCing glibc ML and also man-pages ML to see if the type is used in
manual page intentionally or not.

-- 
Cyril Hrubis
chrubis@suse.cz
