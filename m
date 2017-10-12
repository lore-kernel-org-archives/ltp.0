From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 13:03:18 +0200
Subject: [LTP] [PATCH] shmctl: enable subtest SHM_LOCK SHM_UNLOCK only
 if kernel < 2.6.9
In-Reply-To: <1507804613-18349-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1507804613-18349-1-git-send-email-lizhijian@cn.fujitsu.com>
Message-ID: <20171012110318.GC10492@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <linux/version.h>
>  #include "ipcshm.h"
>  #include <pwd.h>
>  
> @@ -90,11 +91,13 @@ struct test_case_t {
>  	{
>  	&shm_id_2, -1, &buf, EINVAL},
>  	    /* EPERM - the command is only valid for the super-user */
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 9)
>  	{
>  	&shm_id_2, SHM_LOCK, &buf, EPERM},
>  	    /* EPERM - the command is only valid for the super-user */
>  	{
>  	&shm_id_2, SHM_UNLOCK, &buf, EPERM}
> +#endif

First of all, this approach horribly broken. It assumes that the kernel
we are running on has the same version as the kernel-headers package,
which is almost never true.

Secondly the test issues TCONF in case that we don't get this error, so
there is actually nothing to worry about.

What can be done for the test though is to temporary set RLIMIT_MEMLOCK
to 0 in the test setup() so that the we can actually test that code
path.

-- 
Cyril Hrubis
chrubis@suse.cz
