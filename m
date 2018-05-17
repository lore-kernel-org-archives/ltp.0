From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 May 2018 17:10:01 +0200
Subject: [LTP] [PATCH 1/2] syscalls/prctl01: Rewrite to the new library
In-Reply-To: <1524106257-4711-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1524106257-4711-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180517151001.to2boenybprcchgz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
Reviewed-by: Petr Vorel <pvorel@suse.cz>
>  testcases/kernel/syscalls/prctl/prctl01.c | 197 ++++++------------------------
>  1 file changed, 40 insertions(+), 157 deletions(-)

> diff --git a/testcases/kernel/syscalls/prctl/prctl01.c b/testcases/kernel/syscalls/prctl/prctl01.c
> index 1857dfb..58e0ae7 100644
> --- a/testcases/kernel/syscalls/prctl/prctl01.c
> +++ b/testcases/kernel/syscalls/prctl/prctl01.c
> @@ -1,174 +1,57 @@
>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
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
If you want, you can use SPDX license identifier (it's much shorter):
// SPDX-License-Identifier: GPL-2.0-or-later

...
> +	TEST(prctl(PR_SET_PDEATHSIG, SIGUSR2));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_SET_PDEATHSIG) failed");
> +		return;
>  	}
Maybe report here that PR_SET_PDEATHSIG succeed?

...
> +	TEST(prctl(PR_GET_PDEATHSIG, &get_sig));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "prctl(PR_GET_PDEATHSIG) failed");
> +		return;
> +	}

> +	if (get_sig == SIGUSR2) {
> +		tst_res(TPASS,
> +			"prctl(PR_GET_PDEATHSIG) got expected death signal");
> +	} else {
> +		tst_res(TFAIL, "prctl(PR_GET_PDEATHSIG) got death signal %d,"
> +			" expected %d", get_sig, SIGUSR2);
> +	}
>  }


> -/*
> - *cleanup() -  performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.test_all = verify_prctl,
> +};


Kind regards,
Petr
