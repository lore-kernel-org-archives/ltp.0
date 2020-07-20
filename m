From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 20 Jul 2020 15:49:32 +0530
Subject: [LTP] [PATCH V7 00/19] Syscalls: Add support for time64 variants
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200720101932.rw2uy3twdfftttem@vireshk-mac-ubuntu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26-06-20, 11:52, Viresh Kumar wrote:
> Hi,
> 
> This updates the pending syscall tests that lacked the time64 updates.
> 
> V7:
> - Move all tst_timer.h changes to a single patch.
> - Provide more generic helpers for itimerspec and update the patches
>   accordingly.
> - Also include the y2038 patch in the series as that depends on the
>   first patch here.

Ping for a lot of patches from this series as well.

-- 
viresh
