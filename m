From: Steve Muckle <smuckle@google.com>
Date: Wed, 30 Jan 2019 15:02:23 -0800
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190130112826.7157-1-petr.vorel@gmail.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
Message-ID: <56309f29-d63c-2975-eb2c-1294f55e37e8@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 01/30/2019 03:28 AM, Petr Vorel wrote:
> some obvious failures for Android.
> 
> Kind regards,
> Petr
> 
> Petr Vorel (3):
>    lib: Add missing <string.h> and <strings.h> includes
>    lib/tst_kernel.c: Use <sys/personality.h>
>    lib: Build tst_path_has_mnt_flags.c also on Android
> 
>   lib/Makefile                         | 2 +-
>   lib/newlib_tests/tst_strstatus.c     | 1 +
>   lib/tst_kconfig.c                    | 1 +
>   lib/tst_kernel.c                     | 2 +-
>   lib/tst_sys_conf.c                   | 1 +
>   lib/tst_timer_test.c                 | 1 +
>   utils/sctp/func_tests/test_getname.c | 1 +
>   7 files changed, 7 insertions(+), 2 deletions(-)

How did you come across these issues? We have yet to see them. Did you 
merge tip of LTP into an Android AOSP tree and build it that way?

thanks,
Steve
