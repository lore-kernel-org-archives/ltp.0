From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Apr 2018 09:52:12 +0200
Subject: [LTP] [PATCH] add ip6tables test case
In-Reply-To: <42e1043e-a0b0-a55c-d55f-be5561bbcdb1@cn.fujitsu.com>
References: <42e1043e-a0b0-a55c-d55f-be5561bbcdb1@cn.fujitsu.com>
Message-ID: <20180423075212.o5yifzur2rtvolrt@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lianwen Sun,

> Add ip6tables test case base on case of iptables

> Signed-off-by: sunlw <sunlw.fnst@cn.fujitsu.com>
> ---
>  runtest/net.tcp_cmds                          |   1 +
>  testcases/network/iptables/Makefile           |   2 +-
>  testcases/network/iptables/ip6tables_tests.sh | 386 ++++++++++++++++++
>  3 files changed, 388 insertions(+), 1 deletion(-)
>  create mode 100755 testcases/network/iptables/ip6tables_tests.sh

Thanks for your patch. IMHO instead of adding ip6tables_tests.sh, file iptables_tests.sh
could be easily extended to support both IPv4/IPv6, using TST_IPV6 to distinguish. Most of
other network tests is using that. This reduces duplicity of code and helps further
changes (e.g. migration to new shell API).

> --- /dev/null
> +++ b/testcases/network/iptables/ip6tables_tests.sh
> @@ -0,0 +1,386 @@
> +#!/bin/sh
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2001                 ##
> +## Copyright (c) 2018 Lianwen Sun <Sunlw.fnst@cn.fujitsu.com>
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software Foundation,   ##
> +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
> +##                                                                            ##
> +################################################################################
> +#  Author:	Jan 20 2004 Hubert Lin <linux02NOSPAAAM@tw.ibm.com>
> +#				       <hubertNOSPAAAM@symbio.com.tw>
> +#               Apr 21 2018 Lianwen Sun <Sunlw.fnst@cn.fujitsu.com>
Also a bit of cleanup of test would help, at least the licence header (remove "border"
from hashes, use link to license instead of post address (see lib/tst_safe_posix_ipc.c),
remove whitespace.


Kind regards,
Petr
