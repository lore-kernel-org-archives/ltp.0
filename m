From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 9 Mar 2021 15:15:25 +0530
Subject: [LTP] [PATCh v2] clock_gettime04: print more info to help
 debugging
In-Reply-To: <20210309080028.16284-1-liwang@redhat.com>
References: <20210309080028.16284-1-liwang@redhat.com>
Message-ID: <20210309094525.4ggmppfpvavsvjzl@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09-03-21, 08:00, Li Wang wrote:
> We catch some sporadically failures[1] like below, but we don't know which
> test loop it comes from. So adding more prints to help locate issue.
> 
>   tst_test.c:1286: TINFO: Timeout per run is 0h 05m 00s
>   vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
>   clock_gettime04.c:157: TPASS: CLOCK_REALTIME: Difference between successive readings is reasonable
>   clock_gettime04.c:150: TFAIL: CLOCK_REALTIME_COARSE: Difference between successive readings greater than 5 ms (1): 8
>   clock_gettime04.c:157: TPASS: CLOCK_MONOTONIC: Difference between successive readings is reasonable
>   clock_gettime04.c:150: TFAIL: CLOCK_MONOTONIC_COARSE: Difference between successive readings greater than 5 ms (0): 5
>   clock_gettime04.c:157: TPASS: CLOCK_MONOTONIC_RAW: Difference between successive readings is reasonable
>   clock_gettime04.c:157: TPASS: CLOCK_BOOTTIME: Difference between successive readings is reasonable
> 
> After patching, it will show more details about the iteration:
> 
>   tst_test.c:1288: TINFO: Timeout per run is 0h 05m 00s
>   vdso_helpers.c:76: TINFO: Couldn't find vdso_gettime64()
>   clock_gettime04.c:158: TPASS: CLOCK_REALTIME: Difference between successive readings is reasonable for following variants:
>   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
>   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
>   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
>   clock_gettime04.c:162: TINFO:   - gettimeofday
>   clock_gettime04.c:158: TPASS: CLOCK_REALTIME_COARSE: Difference between successive readings is reasonable for following variants:
>   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
>   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
>   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
>   clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC: Difference between successive readings is reasonable for following variants:
>   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
>   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
>   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
>   clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_COARSE: Difference between successive readings is reasonable for following variants:
>   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
>   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
>   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
>   clock_gettime04.c:158: TPASS: CLOCK_MONOTONIC_RAW: Difference between successive readings is reasonable for following variants:
>   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
>   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
>   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
>   clock_gettime04.c:158: TPASS: CLOCK_BOOTTIME: Difference between successive readings is reasonable for following variants:
>   clock_gettime04.c:162: TINFO:   - vDSO or syscall with libc spec
>   clock_gettime04.c:162: TINFO:   - syscall with old kernel spec
>   clock_gettime04.c:162: TINFO:   - vDSO with old kernel spec
> 
> [1] it occurs on a x86_64 (not virtualized) with kernel 5.11.0.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  .../kernel/syscalls/clock_gettime/clock_gettime04.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
