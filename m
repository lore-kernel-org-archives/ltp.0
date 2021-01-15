From: Petr Vorel <petr.vorel@gmail.com>
Date: Fri, 15 Jan 2021 07:42:06 +0100
Subject: [LTP] [PATCH v2] sigwaitinfo: Do not run invalid/undefined test
 cases
In-Reply-To: <20200529014448.3815022-1-raj.khem@gmail.com>
References: <20200529014448.3815022-1-raj.khem@gmail.com>
Message-ID: <YAE5PnVdLD0nmN/H@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

> These testcases run for eternity on musl

> test_bad_address* cases are passing invalid pointers to a function; that's always UB
> empty_set and timeout rely on the implementation-defined "may fail" for EINTR in sigtimedwait [1]

> normally "may fail" is an "unspecified" but here the impl
> is supposed to document it so it's "impl-defined"

> [1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/sigtimedwait.html

I tested sigtimedwait01.c, sigwaitinfo01.c and rt_sigtimedwait01.c on Alpine
3.12.3 on RPI on current LTP master.

rt_sigtimedwait01.c os PL am cam be left as it is.
sigtimedwait01.c and sigwaitinfo01.c is blocked just by first test:
{ test_empty_set, SIGUSR1}
removing it is enough to fix test.

$ strace ./sigwaitinfo01
getpid()                                = 27859
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=300, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}) = 0
rt_sigaction(SIGINT, {sa_handler=0x5570b661e8, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fa0385a6c}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
clone(child_stack=NULL, flags=SIGCHLD)  = 27860
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=27860, si_uid=0} ---
setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=300, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=299, tv_usec=989256}}) = 0
rt_sigreturn({mask=[]})                 = 0
wait4(27860,

I haven't look into musl implementation what could be wrong.

Kind regards,
Petr

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Rich Felker <dalias@aerifal.cx>
> ---
> v2: Extend same fixes to include sigwaitinfo01

>  .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c      | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

> --- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
> +++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
> @@ -422,15 +422,10 @@ struct test_desc {
>  } tests[] = {
>  #ifdef TEST_RT_SIGTIMEDWAIT
>  	{
> -	test_empty_set, my_rt_sigtimedwait, SIGUSR1}, {
>  	test_unmasked_matching, my_rt_sigtimedwait, SIGUSR1}, {
>  	test_masked_matching, my_rt_sigtimedwait, SIGUSR1}, {
>  	test_unmasked_matching_noinfo, my_rt_sigtimedwait, SIGUSR1}, {
> -	test_masked_matching_noinfo, my_rt_sigtimedwait, SIGUSR1}, {
> -	test_bad_address, my_rt_sigtimedwait, SIGUSR1}, {
> -	test_bad_address2, my_rt_sigtimedwait, SIGUSR1}, {
> -	test_bad_address3, my_rt_sigtimedwait, SIGUSR1}, {
> -	test_timeout, my_rt_sigtimedwait, 0},
> +	test_masked_matching_noinfo, my_rt_sigtimedwait, SIGUSR1}, 
>  	    /* Special cases */
>  	    /* 1: sigwaitinfo does respond to ignored signal */
>  	{
> @@ -452,25 +447,17 @@ struct test_desc {
>  #endif
>  #if defined TEST_SIGWAITINFO
>  	{
> -	test_empty_set, my_sigwaitinfo, SIGUSR1}, {
>  	test_unmasked_matching, my_sigwaitinfo, SIGUSR1}, {
>  	test_masked_matching, my_sigwaitinfo, SIGUSR1}, {
>  	test_unmasked_matching_noinfo, my_sigwaitinfo, SIGUSR1}, {
> -	test_masked_matching_noinfo, my_sigwaitinfo, SIGUSR1}, {
> -	test_bad_address, my_sigwaitinfo, SIGUSR1}, {
> -	test_bad_address2, my_sigwaitinfo, SIGUSR1},
> +	test_masked_matching_noinfo, my_sigwaitinfo, SIGUSR1},
>  #endif
>  #if defined TEST_SIGTIMEDWAIT
>  	{
> -	test_empty_set, my_sigtimedwait, SIGUSR1}, {
>  	test_unmasked_matching, my_sigtimedwait, SIGUSR1}, {
>  	test_masked_matching, my_sigtimedwait, SIGUSR1}, {
>  	test_unmasked_matching_noinfo, my_sigtimedwait, SIGUSR1}, {
> -	test_masked_matching_noinfo, my_sigtimedwait, SIGUSR1}, {
> -	test_bad_address, my_sigtimedwait, SIGUSR1}, {
> -	test_bad_address2, my_sigtimedwait, SIGUSR1}, {
> -	test_bad_address3, my_sigtimedwait, SIGUSR1}, {
> -	test_timeout, my_sigtimedwait, 0},
> +	test_masked_matching_noinfo, my_sigtimedwait, SIGUSR1},
>  #endif
>  };
