From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 9 Apr 2020 10:43:56 +0530
Subject: [LTP] [PATCH] syscalls/clone301: Fix the test race this time
 for real
In-Reply-To: <20200408114007.4096-1-chrubis@suse.cz>
References: <20200408114007.4096-1-chrubis@suse.cz>
Message-ID: <20200409051356.5p6xwi4ttsz2zzzg@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08-04-20, 13:40, Cyril Hrubis wrote:
> I have messed up the first fix, sorry, the signal handler has to be
> estabilished before the clone3() call, not just before the if ().
> 
> This also makes the test more verbose in case of failure, we print what
> exactly went wrong which saves time on debugging.
> 
> Fixes: f17b3862dceb (syscalls/clone301: Fix race between parent and child)
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Richard Palethorpe <rpalethorpe@suse.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/clone3/clone301.c | 65 +++++++++++++++------
>  1 file changed, 48 insertions(+), 17 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
