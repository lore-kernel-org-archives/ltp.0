From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 19 Oct 2020 22:18:00 +0200
Subject: [LTP] [PATCH v2] sigwaitinfo: Do not run invalid/undefined test
 cases
In-Reply-To: <20200529014448.3815022-1-raj.khem@gmail.com>
References: <20200529014448.3815022-1-raj.khem@gmail.com>
Message-ID: <20201019201800.GA12642@dell5510>
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

Sorry for the delay. Could you please verify, if test still fails in the current
master? If yes, would you please update the patch?

Now, I dropped it from the latest update:
https://lists.openembedded.org/g/openembedded-core/topic/patch_1_1_ltp_update_to/77667273?p=,,,20,0,0,0::recentpostdate%2Fsticky,,,20,2,0,77667273

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
