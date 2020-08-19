From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Aug 2020 18:03:45 +0530
Subject: [LTP] [PATCH v2] clock_settime03: change to use CLOCK_REALTIME
In-Reply-To: <20200819083843.26435-1-liwang@redhat.com>
References: <20200819083843.26435-1-liwang@redhat.com>
Message-ID: <20200819123345.guu63kqd6zob5oir@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19-08-20, 08:38, Li Wang wrote:
> CLOCK_REALTIME_ALARM requires an RTC with alarm support, which may not be
> present on a system. In that case, the kernel will return EOPNOTSUPP, which
> is defined as ENOTSUP in userspace.
> 
> Here use CLOCK_REALTIME instead of the CLOCK_REALTIME_ALARM because we do
> NOT need suspend the SUT during test.
> 
> For issue #712:
>   https://github.com/linux-test-project/ltp/issues/712
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Viresh Kumar<viresh.kumar@linaro.org>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Cc: Jan Stancek <jstancek@redhat.com>
> Tested-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/clock_settime/clock_settime03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
