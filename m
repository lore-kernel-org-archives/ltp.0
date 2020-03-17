From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 21:03:30 +0100
Subject: [LTP] [PATCH v4 1/3] Create separate .c file for
 include/tst_net.h
In-Reply-To: <20200317121057.13529-1-mdoucha@suse.cz>
References: <20200317121057.13529-1-mdoucha@suse.cz>
Message-ID: <20200317200330.GA22450@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

thanks for doing this cleanup, LGTM
(just lib/tst_net.c should get SPDX licence before merging).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Minor thoughts below.

>  #include <arpa/inet.h>
> -#include <errno.h>
>  #include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
BTW (not related to this change) tst_net.h and tst_private.h must be included
after tst_test.h. But that's probably ok (include/tst_safe_clocks.h includes it).

...
> +++ b/include/tst_private.h
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
> + *
> + * Internal helper functions for the shell library. Do not use directly
> + * in test programs.
> + */
> +
> +#ifndef TST_PRIVATE_H_
> +#define TST_PRIVATE_H_
This file is now just for tst_net_iface_prefix.c tst_net_ip_prefix.c and
tst_net_vars.c. And I bet that it stays like this, because most of code in lib/
is actually the API code, which is supposed to be exported. Therefore I'd chose
name specific to these 3 files, but tst_private.h is maybe better.

...
> +void tst_print_svar(const char *name, const char *val);
> +void tst_print_svar_change(const char *name, const char *val);
> +
> +int tst_get_prefix(const char *ip_str, int is_ipv6);
> +
> +#endif
> diff --git a/lib/tst_net.c b/lib/tst_net.c
> new file mode 100644
> index 000000000..b27ad3a5b
> --- /dev/null
> +++ b/lib/tst_net.c
> @@ -0,0 +1,147 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
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
Hm, this should be replaced by simple:
// SPDX-License-Identifier: GPL-2.0-or-later

Can be done during merge.

> +
> +#include <errno.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_net.h"
> +#include "tst_private.h"
> +
> +void tst_print_svar(const char *name, const char *val)
> +{
> +	if (name && val)
> +		printf("export %s=\"%s\"\n", name, val);
> +}
> +
> +void tst_print_svar_change(const char *name, const char *val)
> +{
> +	if (name && val)
> +		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
> +}
I'd be happy enough to have these functions not exported (i.e. in tst_private.h
as static inline), but I believe you that today's compilers strip out unused
code :).

Kind regards,
Petr
