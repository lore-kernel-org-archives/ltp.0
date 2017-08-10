From: Jiri Jaburek <jjaburek@redhat.com>
Date: Thu, 10 Aug 2017 13:50:46 +0200
Subject: [LTP] [PATCH 2/2] syscalls/pselect: Add a zero latency
	constraint
In-Reply-To: <1502352088-10136-2-git-send-email-daniel.lezcano@linaro.org>
References: <1502352088-10136-1-git-send-email-daniel.lezcano@linaro.org>
 <1502352088-10136-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1cbcc5dd-e060-94df-982e-198b3b342ec6@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/10/17 10:01, Daniel Lezcano wrote:
> The pselect_01 testcase works well on an x86 as it is a fast platform, with
> fast exit latency idle routine.
> 
> However on ARM[64] the idle routine can take much more time, for example
> 1500us.
> 
> The pselect fails on the ARM[64] platforms because of these slow exit latencies,
> the delay between the expected expiration and the observed one is not
> acceptable.
> 
> The fix could be to increase the deviation on ARM64 but that wouldn't make
> sense as some platforms, for the same architecture, can have faster or
> different delays, hence we can potentially miss a bug.
> 
> The simplest solution is to set the cpu_dma latency constraint to zero, so the
> idle driver will always choose the fastest idle state, thus fixing the issue
> above. The latency constraint will apply only for this test.

I think a more generic LTP-wide solution could be made; there are more
tests that fail ie. on virtualized environments because of CPU over-
provisioning on the host (x86, s390, ppc, etc.) and I can imagine ie.
networking tests having similar needs as well (probably currently worked
around using big timeouts).

Basically some system that would allow a user to set some "latency
multiplier" based on the system under test, so that ie. dedicated x86
machines with fairly deterministic CPU/net/etc. scheduling could have it
set low, and so that other systems could still run tests that are now
deemed unsuitable for such hardware.

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  testcases/kernel/syscalls/pselect/pselect01.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/kernel/syscalls/pselect/pselect01.c
> index a2b5339..42027b6 100644
> --- a/testcases/kernel/syscalls/pselect/pselect01.c
> +++ b/testcases/kernel/syscalls/pselect/pselect01.c
> @@ -44,6 +44,9 @@ int sample_fn(int clk_id, long long usec)
>  }
>  
>  static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_latency = 1,
> +	.latency = 0,
>  	.tid = "pselect()",
>  	.sample = sample_fn,
>  };
> 

