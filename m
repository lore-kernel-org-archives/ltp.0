From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Nov 2020 11:22:01 +0530
Subject: [LTP] [PATCH] syscalls: Add tests for name_to_handle_at() and
 open_by_handle_at()
In-Reply-To: <20201120104105.GB4910@yuki.lan>
References: <9c4453f49394a7864ec9c84ccd561663f54bae51.1605862411.git.viresh.kumar@linaro.org>
 <20201120104105.GB4910@yuki.lan>
Message-ID: <20201123055201.tvouwhjydn46jjps@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-11-20, 11:41, Cyril Hrubis wrote:
> We does not seem to use it in any way, I guess that we should add
> fallback definitions to a lapi header in the same way we do for example
> in lapi/setns.h so that these tests would compile on older libcs.

These syscalls were added long back in 2.6.38 and so I stayed away
from adding a header and userspace (where we care) must already have
the definitions. Should I add that header ?

-- 
viresh
