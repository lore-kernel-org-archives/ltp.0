From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jan 2019 19:06:17 +0100
Subject: [LTP] [PATCH] syscalls/ustat: convert to new lib,
 use direct syscall
In-Reply-To: <20190129023714.191820-1-smuckle@google.com>
References: <20190129023714.191820-1-smuckle@google.com>
Message-ID: <20190129180617.GD14252@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve, Cyril,

> +++ b/include/lapi/ustat.h
> @@ -0,0 +1,8 @@
> +#include <sys/types.h>
I'd put here at least
//SPDX-License-Identifier: GPL-2.0-or-later
> +
> +struct ustat {
> +	daddr_t f_tfree;
> +	ino_t f_tinode;
> +	char f_fname[6];
> +	char f_fpack[6];
> +};
Thinking about it twice, wouldn't be better to include <sys/ustat.h> and detect
with autotools whether struct ustat is defined and use this only if it's not
defined? The same approach we use for struct statx?


> +++ b/testcases/kernel/syscalls/ustat/ustat01.c
> @@ -1,21 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
@Cyril: can we use GPL-2.0-or-later? Original was GPL only.

>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2003.  All Rights Reserved.
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
> - */

Kind regards,
Petr
