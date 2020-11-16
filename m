From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Nov 2020 19:41:43 +0100
Subject: [LTP] [PATCH] net/host: update to new api
In-Reply-To: <20201116101840.15433-1-kory.maincent@bootlin.com>
References: <20201116101840.15433-1-kory.maincent@bootlin.com>
Message-ID: <20201116184143.GA171432@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

thanks for your patch.
...
>  do_test()
>  {

> -    tst_resm TINFO "test basic functionality of the \`$TC' command."
> +    tst_res TINFO "test basic functionality of the host command."

> -    while [ $TST_COUNT -lt $NUMLOOPS ]; do
> +    while [ $TST_COUNT -le $NUMLOOPS ]; do
IMHO there is no need to have loop like this.
If required, we'd just add -iN parameter to it in the runtest file (where N is
<1,max int), but IMHO it's enough to test host only once.

>          if rhost_addr=$(host $RHOST); then
> -            rhost_addr=$(echo "$rhost_addr" | awk -F, '{print $NF}') >/dev/null 2>&1
> -            if ! host $rhost_addr >/dev/null 2>&1; then
> -                end_testcase "reverse lookup with host failed"
> -            fi
> -
> +            rhost_addr=$(echo "$rhost_addr" | awk '{print $NF}') >/dev/null 2>&1
> +            EXPECT_PASS host $rhost_addr \>/dev/null 2>&1
We need to redirect also second > and &:
EXPECT_PASS host $rhost_addr \>/dev/null 2\>\&1

>          else
> -            end_testcase "host $RHOST on local machine failed"
> +            tst_brk TFAIL "host $RHOST on local machine failed"
>          fi

> -        incr_tst_count
> +        TST_COUNT=$((TST_COUNT + 1))
>          sleep $SLEEPTIME
Also sleep time is not really needed.

...

Can I merge this simplified variant?

Kind regards,
Petr

#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (c) K?ry Maincent <kory.maincent@bootlin.com> 2020
# Copyright (c) Manoj Iyer <manjo@mail.utexas.edu> 2003
# Copyright (c) Robbie Williamson <robbiew@us.ibm.com> 2001
# Copyright (c) International Business Machines  Corp., 2000

TST_TESTFUNC="do_test"
TST_NEEDS_CMDS="awk host hostname"

. tst_net.sh

do_test()
{
	local rhost=${RHOST:-$(hostname)}
	local rhost_addr

    tst_res TINFO "test basic functionality of the host command"

	if rhost_addr=$(host $rhost); then
		rhost_addr=$(echo "$rhost_addr" | awk '{print $NF}')
		EXPECT_PASS host $rhost_addr \>/dev/null 2\>\&1
	else
		tst_brk TFAIL "host $rhost on local machine failed"
	fi
}

tst_run
