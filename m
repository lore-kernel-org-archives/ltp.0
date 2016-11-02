From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 17:13:52 +0100
Subject: [LTP] [PATCH v3 5/5] flistxattr and listxattr: added tests
In-Reply-To: <1478084391-30192-6-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478084391-30192-6-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102161351.GH28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#
> +#  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
> +#  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program.
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/flistxattr/flistxattr01.c b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
> new file mode 100644
> index 0000000..5084f7d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/flistxattr/flistxattr01.c
> @@ -0,0 +1,102 @@
> +/*
> +* Copyright (c) 2016 RT-RK Institute for Computer Based Systems
> +* Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
> +*
> +* This program is free software; you can redistribute it and/or modify it
> +* under the terms of version 2 of the GNU General Public License as
> +* published by the Free Software Foundation.

FYI the GPLv2+ (any later version) is slightly prefered (that is the one
in the Makefile above).

-- 
Cyril Hrubis
chrubis@suse.cz
