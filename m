From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Aug 2021 11:25:45 +0200
Subject: [LTP] [PATCH v7 2/7] test/test_zero_hugepage.sh: Skip test on
 read-only file system
In-Reply-To: <20210802173536.19525-3-pvorel@suse.cz>
References: <20210802173536.19525-1-pvorel@suse.cz>
 <20210802173536.19525-3-pvorel@suse.cz>
Message-ID: <YQkLmb3pUPY8cKP8@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On GitHub Actions /proc/sys/vm/nr_hugepages is not allowed to be
> changed:
> 
> ./test_zero_hugepage.sh: line 9: can't create /proc/sys/vm/nr_hugepages: Read-only file system
> tst_hugepage.c:57: TBROK: Failed to open FILE '/proc/sys/vm/nr_hugepages' for writing: EROFS (30)
> tst_sys_conf.c:102: TWARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'

Hmm, it's rather strange to have proc mounted RO but I guess that we
can't do much about it. I guess that it wouldn't allow us to remount it
RW, so there is not much we can do about it.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v7.
> 
>  lib/newlib_tests/test_zero_hugepage.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/newlib_tests/test_zero_hugepage.sh b/lib/newlib_tests/test_zero_hugepage.sh
> index 10113006b..8a462478e 100755
> --- a/lib/newlib_tests/test_zero_hugepage.sh
> +++ b/lib/newlib_tests/test_zero_hugepage.sh
> @@ -1,12 +1,16 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
> +# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
>  
>  echo "Testing .request_hugepages = TST_NO_HUGEPAGES"
>  
>  orig_value=`cat /proc/sys/vm/nr_hugepages`
>  
> -echo "128" > /proc/sys/vm/nr_hugepages
> +if ! echo "128" > /proc/sys/vm/nr_hugepages; then
> +	echo "TCONF: failed to open /proc/sys/vm/nr_hugepages"
> +	exit 32
> +fi

I wonder if we should rather check if proc is mounted readonly
explicitly since this may hide all kinds of errors.

>  ./test_zero_hugepage
>  
> -- 
> 2.32.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
