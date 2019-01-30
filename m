From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Jan 2019 14:01:14 -0500 (EST)
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190130112826.7157-1-petr.vorel@gmail.com>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
Message-ID: <702828121.99655176.1548874873997.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi,
> 
> some obvious failures for Android.

ack

> 
> Kind regards,
> Petr
> 
> Petr Vorel (3):
>   lib: Add missing <string.h> and <strings.h> includes
>   lib/tst_kernel.c: Use <sys/personality.h>
>   lib: Build tst_path_has_mnt_flags.c also on Android
> 
>  lib/Makefile                         | 2 +-
>  lib/newlib_tests/tst_strstatus.c     | 1 +
>  lib/tst_kconfig.c                    | 1 +
>  lib/tst_kernel.c                     | 2 +-
>  lib/tst_sys_conf.c                   | 1 +
>  lib/tst_timer_test.c                 | 1 +
>  utils/sctp/func_tests/test_getname.c | 1 +
>  7 files changed, 7 insertions(+), 2 deletions(-)
> 
> --
> 2.20.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
