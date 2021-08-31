From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Tue, 31 Aug 2021 12:15:34 +0800
Subject: [LTP] [PATCH] gettid:Convert gettid01 to new API
In-Reply-To: <20210831024617.246758-1-threefifteen.wangkunfeng@huawei.com>
References: <20210831024617.246758-1-threefifteen.wangkunfeng@huawei.com>
Message-ID: <OSZP286MB08712631399F14EC1329DFEDCCCC9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Kunfeng,

> Convert gettid01 to new API
>
> Signed-off-by: Wang Kunfeng <threefifteen.wangkunfeng@huawei.com>
> ---
>   testcases/kernel/syscalls/gettid/gettid01.c | 95 ++++-----------------
>   1 file changed, 15 insertions(+), 80 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
> index 7e5b6b175..2e45be588 100644
> --- a/testcases/kernel/syscalls/gettid/gettid01.c
> +++ b/testcases/kernel/syscalls/gettid/gettid01.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
The license here should be GPL-2.0-later.
>   /*
>    * Crackerjack Project
>    *
> @@ -6,91 +7,25 @@
>    *            Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
>    *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
>    *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> - *
> - * $Id: gettid01.c,v 1.5 2009/10/26 14:55:47 subrata_modak Exp $
> - *
> + * Porting from Crackerjack to LTP is done
> + * by Masatake YAMATO <yamato@redhat.com>
>    */
>
> -/* Porting from Crackerjack to LTP is done
> -   by Masatake YAMATO <yamato@redhat.com> */
> +/*\
> + * [Description]
> + *
> + * Basic test for gettid() function.
> + */
>
>   #include <sys/types.h>
> -#include <linux/unistd.h>
> -#include <errno.h>
> -
> -#include "test.h"
> -
> -void setup();
> -void cleanup();
> -
> -char *TCID = "gettid01";
> -
> -int TST_TOTAL = 1;
> -
> -pid_t my_gettid(void)
> -{
> -	return (pid_t) syscall(__NR_gettid);
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
>
> -	setup();
> -
> -	/*
> -	 * The following loop checks looping state if -c option given
> -	 */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(my_gettid());
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "gettid() Failed, errno=%d: %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			tst_resm(TPASS, "gettid() returned %ld",
> -				 TEST_RETURN);
> -		}
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void verify_gettid(void)
>   {
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> +	TST_EXP_POSITIVE(tst_syscall(__NR_gettid), "gettid()");
>   }
>
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.test_all = verify_gettid,
> +};
> --
> 2.17.1
>
>
-- 
Best Regards,
Xie Ziyao
E-mail: ziyaoxie@outlook.com

