From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 2 May 2016 04:35:44 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/umount2_{02,
 03}: Retry umount2() on EBUSY
In-Reply-To: <20160428163954.GA29437@rei>
References: <20160428163954.GA29437@rei>
Message-ID: <796579473.1980137.1462178144845.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Thursday, 28 April, 2016 6:39:54 PM
> Subject: [LTP] [PATCH] syscalls/umount2_{02,03}: Retry umount2() on EBUSY
> 
> This should be last fix for umount2() testcases failing with unexpected
> EBUSY.
> 
> This patch adds umount2.h header that defined inline umount2_retry()
> function that retries umount2() only in case of EBUSY.
> 
> The umount2_01 does not need to be fixed since it uses MNT_DETACH that
> does lazy umount and hence it does not race with background probing.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Is the culprit here also some background daemons? If so, ACK.

Regards,
Jan

> ---
> 
>  This is last patch needed to fix rare failures (the two obvious ones
>  were commited already). After applying this the failures couldn't be
>  reproduced, instead there were a few lines as:
> 
>  umount2_03    0  TINFO  :  umount('mntpoint', 8) failed with EBUSY, try 0...
> 
>  In the log created by running the testcase 100 times in a loop.
> 
>  Can somebody ack this so that it can go in before the release?
> 
>  testcases/kernel/syscalls/umount2/umount2.h    | 44
>  ++++++++++++++++++++++++++
>  testcases/kernel/syscalls/umount2/umount2_02.c |  4 ++-
>  testcases/kernel/syscalls/umount2/umount2_03.c |  4 ++-
>  3 files changed, 50 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/umount2/umount2.h
> 
> diff --git a/testcases/kernel/syscalls/umount2/umount2.h
> b/testcases/kernel/syscalls/umount2/umount2.h
> new file mode 100644
> index 0000000..65e4c24
> --- /dev/null
> +++ b/testcases/kernel/syscalls/umount2/umount2.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef UMOUNT2_H__
> +#define UMOUNT2_H__
> +
> +static inline int umount2_retry(const char *target, int flags)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < 50; i++) {
> +		ret = umount2(target, flags);
> +
> +		if (ret == 0 || errno != EBUSY)
> +			return ret;
> +
> +		tst_resm(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
> +			 target, flags, i);
> +
> +		usleep(100000);
> +	}
> +
> +	tst_resm(TWARN, "Failed to umount('%s', %i) after 50 retries",
> +	         target, flags);
> +
> +	errno = EBUSY;
> +	return -1;
> +}
> +
> +#endif	/* UMOUNT2_H__ */
> diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c
> b/testcases/kernel/syscalls/umount2/umount2_02.c
> index 33ea21d..7d558fa 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_02.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_02.c
> @@ -33,6 +33,8 @@
>  #include "safe_macros.h"
>  #include "lapi/mount.h"
>  
> +#include "umount2.h"
> +
>  #define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
>  #define MNTPOINT	"mntpoint"
>  
> @@ -131,7 +133,7 @@ static void test_umount2(int i)
>  			tst_brkm(TBROK | TERRNO, cleanup, "access(2) failed");
>  	}
>  
> -	TEST(umount2(MNTPOINT, test_cases[i].flag));
> +	TEST(umount2_retry(MNTPOINT, test_cases[i].flag));
>  
>  	if (test_cases[i].exp_errno != 0)
>  		verify_failure(i);
> diff --git a/testcases/kernel/syscalls/umount2/umount2_03.c
> b/testcases/kernel/syscalls/umount2/umount2_03.c
> index f2027cc..a8fddf6 100644
> --- a/testcases/kernel/syscalls/umount2/umount2_03.c
> +++ b/testcases/kernel/syscalls/umount2/umount2_03.c
> @@ -28,6 +28,8 @@
>  #include "safe_macros.h"
>  #include "lapi/mount.h"
>  
> +#include "umount2.h"
> +
>  #define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
>  #define MNTPOINT	"mntpoint"
>  #define SYMLINK	"symlink"
> @@ -110,7 +112,7 @@ static void test_umount2(int i)
>  	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
>  	mount_flag = 1;
>  
> -	TEST(umount2(test_cases[i].mntpoint, UMOUNT_NOFOLLOW));
> +	TEST(umount2_retry(test_cases[i].mntpoint, UMOUNT_NOFOLLOW));
>  
>  	if (test_cases[i].exp_errno != 0)
>  		verify_failure(i);
> --
> 2.7.3
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
