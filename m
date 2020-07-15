From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 15 Jul 2020 15:03:12 +0530
Subject: [LTP] [PATCH] tst_timer: pass kernel_timer_t type to syscalls
In-Reply-To: <bd80f928abee6dac85d051c022afe559f5da8d0a.1594758146.git.jstancek@redhat.com>
References: <bd80f928abee6dac85d051c022afe559f5da8d0a.1594758146.git.jstancek@redhat.com>
Message-ID: <20200715093312.5dbxlmkmolrha5vd@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14-07-20, 22:24, Jan Stancek wrote:
> timer_[gs]etttime tests are failing on s390, which is big endian
> system, because tests are passing timer_t type, which is glibc
> type (void *). Kernel expects and sets only int portion, so the
> tests fail for all but first (0) timer id.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_timer.h                                       | 8 ++++----
>  testcases/kernel/syscalls/timer_gettime/timer_gettime01.c | 6 +++---
>  testcases/kernel/syscalls/timer_settime/timer_settime01.c | 6 +++---
>  testcases/kernel/syscalls/timer_settime/timer_settime02.c | 8 ++++----
>  4 files changed, 14 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
