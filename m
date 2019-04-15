From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Apr 2019 13:39:37 +0200
Subject: [LTP] [PATCH 1/1] tst_test.h: Include common headers to fix
 missing function declaration
In-Reply-To: <20190414130329.14607-1-pvorel@suse.cz>
References: <20190414130329.14607-1-pvorel@suse.cz>
Message-ID: <20190415113907.GA9404@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> [1] https://patchwork.ozlabs.org/patch/1084064/
> [2] https://patchwork.ozlabs.org/patch/1084370/
> ---
>  include/tst_test.h | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index cf2447fe3..69629caff 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -1,18 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
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
>   */
>  
>  #ifndef TST_TEST_H__
> @@ -24,6 +13,9 @@
>  
>  #include <unistd.h>
>  #include <limits.h>
> +#include <string.h>
> +#include <strings.h>
> +#include <stdlib.h>

Can we please get rid of the deprecated functions from strings.h instead
of simply including it?

>  #include "tst_common.h"
>  #include "tst_res_flags.h"
> -- 
> 2.20.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
