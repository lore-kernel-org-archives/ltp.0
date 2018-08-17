From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Aug 2018 09:28:02 +0200
Subject: [LTP] [PATCH v5] Testing statx syscall
In-Reply-To: <20180817055702.2731-1-vaishnavi.d@zilogic.com>
References: <20180817055702.2731-1-vaishnavi.d@zilogic.com>
Message-ID: <20180817072802.GA7459@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

tiny issues with copyright (no need to repost just because them, we can change
them before merge).

> +++ b/include/lapi/fs.h
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + * Referred from linux kernel -github/torvalds/linux
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email: code@zilogic.com
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
Whole copyright is supposed to be (you can left the text as that's why
SPDX-License-Identifier is here):
// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
 * Email: code@zilogic.com
 */
IMHO If it's directly taken from somewhere from kernel, you may want to say
exactly from which file).

There some more checkpatch.pl warnings:
include/lapi/stat.h:37: WARNING: please, no space before tabs

> +++ b/testcases/kernel/syscalls/statx/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2001
Here is copy paste error (year). Again, just SPDX-License-Identifier make
the things shorter.
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
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


Kind regards,
Petr
