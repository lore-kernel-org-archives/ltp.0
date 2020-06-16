From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jun 2020 16:29:58 +0200
Subject: [LTP] [PATCH V2 0/6] syscalls: Add tests to verify the
 _time_high fields
In-Reply-To: <20200616131014.GB2790@yuki.lan>
References: <cover.1592302358.git.viresh.kumar@linaro.org>
 <20200616131014.GB2790@yuki.lan>
Message-ID: <20200616142958.GA25688@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at the travis it looks like we do have a problem with missing
__kernel_ulong_t on older kernel headers:

https://api.travis-ci.org/v3/job/698929344/log.txt

Also looking into kernel headers it looks like it's defined to unsigned
long unless on x32 which has unsigned long long. It seems that the types
__kernel_long_t and __kernel_ulong_t firstly appeared in 3.4 along with
the x32 so I guess that we will need a fallback definition in UAPI as
well. And given that __kernel_long_t is defined we may need something
as lapi/posix_types.h with:

#include "linux/posix_types.h"

#ifndef __kernel_long_t
# if (defined(__x86_64__) && defined(__ILP32__))
typedef long          __kernel_long_t
typedef unsigned long __kernel_ulong_t
# else
typedef long long          __kernel_long_t
typedef unsigned long long __kernel_ulong_t
# endif
#endif


Is that all or do I miss some 32bit ABI with 64bit syscalls?

-- 
Cyril Hrubis
chrubis@suse.cz
