From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Nov 2018 11:16:16 +0100
Subject: [LTP] [PATCH] syscalls/statx06.c: Fix compiler errors on old
 distros
In-Reply-To: <1542769532-7487-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1542769532-7487-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181120101616.GA22768@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/syscalls/statx/statx06.c
> +++ b/testcases/kernel/syscalls/statx/statx06.c
> @@ -36,6 +36,9 @@
>  #include <stdio.h>
>  #include "tst_test.h"
>  #include "lapi/stat.h"
> +#include "lapi/mount.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/posix_clocks.h"
>  #include "tst_safe_clocks.h"
>  #include "tst_safe_macros.h"
>  #include "tst_timer.h"

I had to move the lapi headers down so that they are included after the
sys ones (especially sys/mount.h), othewrise the test would fail to
compile if these definitions were present in the respective sys headers.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
