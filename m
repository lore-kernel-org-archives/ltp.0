From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Apr 2021 14:04:25 +0200
Subject: [LTP] [PATCH 1/2] syscalls/wait01.c: Convert to new API
In-Reply-To: <20210415140552.15762-1-gaozh.jy@fujitsu.com>
References: <20210415140552.15762-1-gaozh.jy@fujitsu.com>
Message-ID: <YHl9SfwsNyUz48XZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Nice cleanup.

Pushed with a minor fix for the [Description], thanks.

> diff --git a/testcases/kernel/syscalls/wait/wait01.c b/testcases/kernel/syscalls/wait/wait01.c
> index bd22c1191..3af95cf9b 100644
> --- a/testcases/kernel/syscalls/wait/wait01.c
> +++ b/testcases/kernel/syscalls/wait/wait01.c
> @@ -1,81 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2014 Fujitsu Ltd.
>   * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

Also note that this was originally GPL-2.0 only, but since the original
copyright is by fujitsu and you are fujitsu employees I keep the new
licence GPL-2.0-or-later.

-- 
Cyril Hrubis
chrubis@suse.cz
