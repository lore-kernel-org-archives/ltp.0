From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Mon, 15 Apr 2019 10:13:41 +0800
Subject: [LTP] [PATCH 1/1] tst_test.h: Include common headers to fix
 missing function declaration
In-Reply-To: <20190414130329.14607-1-pvorel@suse.cz>
References: <20190414130329.14607-1-pvorel@suse.cz>
Message-ID: <68e74dca-7c4b-8f25-8f95-06cdc09f65a2@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,


-------- Original Message --------
From: Petr Vorel
Sent: Sun, 14 Apr 2019 15:03:29 +0200
To: Ltp
Cc: Petr Vorel, Sandeep Patil, Steve Muckle, Zhengwang Ruan, Cyril Hrubis
Subject: [PATCH 1/1] tst_test.h: Include common headers to fix missing 
function declaration
> This fixes build errors caused by -Werror-implicit-function-declaration
> defined for android. Due often missing when using common memory and
> string related functions added <string.h>, <strings.h> and <stdlib.h>.
>
> Including headers here seems to be better than handling implicit
> function declaration error every now and then.
>
> + update copyright, use SPDX-License-Identifier.
>
> Suggested-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> IMHO better than previous patches [1] [2] to handle this.
> I decided to include also <strings.h> (there other non-deprecated
> functions besides to deprecated bzero) and <stdlib.h> (for malloc).
>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/patch/1084064/
> [2] https://patchwork.ozlabs.org/patch/1084370/
> ---
>   include/tst_test.h | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index cf2447fe3..69629caff 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -1,18 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
> - *
> - * This program is free software: you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation, either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + * Copyright (c) Linux Test Project, 2016-2019
>    */
>   
>   #ifndef TST_TEST_H__
> @@ -24,6 +13,9 @@
>   
>   #include <unistd.h>
>   #include <limits.h>
> +#include <string.h>
> +#include <strings.h>
> +#include <stdlib.h>

Looks better now. :-)


Regards,

Zhengwang

>   
>   #include "tst_common.h"
>   #include "tst_res_flags.h"
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190415/eb6df481/attachment.html>
