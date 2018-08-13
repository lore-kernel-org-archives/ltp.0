From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Aug 2018 15:41:52 +0200
Subject: [LTP] [PATCH] Move getcwd05 to realpath01 and fix for old distro
In-Reply-To: <20180801134717.29909-1-mmoese@suse.de>
References: <20180801134717.29909-1-mmoese@suse.de>
Message-ID: <20180813134152.GA7239@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michael,

> The testcase getcwd05 is a regression test for cve-2018-1000001 [1].
> However, there were changes in the behavior of libc functions, that some older
> distributions refused to backport.
> The testcase was two testcases, one for getcwd() and one for realpath().
> While the behavior of getcwd() changed, it is totally independent from
> the thestcase for the vulnerability in realpath. So, this test should be
> moved to realpath/realpath01.c. In addition, the test of getcwd() is
> totally unneeded here to test realpath() for the fix.

> [1] https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commitdiff;h=52a713fdd0a30e1bd79818e2e3c4ab44ddca1a94

> Signed-off-by: Michael Moese <mmoese@suse.de>
Acked-by: Petr Vorel <pvorel@suse.cz>

Thanks for your patch. ACK with 2 minor issues bellow.
I can fix them (no need to repost a patch) if you agree.

>  rename testcases/kernel/syscalls/{getcwd/getcwd05.c => realpath/realpath01.c} (72%)
I wonder whether file should be named realpath_buffer_underflow.c to be more
descriptive.

> diff --git a/testcases/kernel/syscalls/realpath/Makefile b/testcases/kernel/syscalls/realpath/Makefile
> new file mode 100644
> index 000000000..bd617d806
> --- /dev/null
> +++ b/testcases/kernel/syscalls/realpath/Makefile
> @@ -0,0 +1,23 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2001
Copy paste error. + I'd prefer to use 'SPDX-License-Identifier: GPL-2.0-or-later' as it's shorter.
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
