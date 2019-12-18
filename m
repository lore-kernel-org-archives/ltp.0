From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Dec 2019 09:44:06 +0100
Subject: [LTP] [PATCH v2 2/2] network/iptables: add new test for
 iptables-tranlsate and nft
In-Reply-To: <20191217171918.10237-2-alexey.kodanev@oracle.com>
References: <20191217171918.10237-1-alexey.kodanev@oracle.com>
 <20191217171918.10237-2-alexey.kodanev@oracle.com>
Message-ID: <20191218084406.GA10966@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
one more fix below.

> +++ b/testcases/network/iptables/nft01.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2019 Oracle and/or its affiliates. All Rights Reserved.
> +
> +TST_CNT=6
> +TST_SETUP="do_setup"
> +TST_TESTFUNC="test"
> +TST_CLEANUP="do_cleanup"
> +TST_NEEDS_TMPDIR=1
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="nft iptables-translate grep ping telnet"
> +TST_NEEDS_DRIVERS="nf_tables"
> +use_iptables=0
> +
> +. iptables_lib.sh
> +. tst_test.sh
> +
> +cleanup_tables=0
cleanup_table=0

Otherwise it fails:
nft01 1 TCONF: 'nft' not found
/opt/ltp/testcases/bin/nft01.sh: line 37: [: -eq: unary operator expected

+ nit (code style comments, feel free to ignore):

1) I'd use empty variable instead of 0 (and [ "$cleanup_chain" = 1 ]),
we discuss it with previous patches.

2) I'd move TST_CNT=6 to iptables_lib.sh (if test function adds more tests, all
iptables_lib.sh uses would have to update it). Maybe all but these could be
there: TST_SETUP, TST_CLEANUP and use_iptables.

3) I'd move cleanup_table and cleanup_chain below use_iptables
(or use_iptables below, just to have all 3 variables together).

Kind regards,
Petr
