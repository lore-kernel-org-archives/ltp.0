From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Mar 2020 16:24:18 +0100
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <20200324121742.7130-1-gengcixi@gmail.com>
References: <20200324121742.7130-1-gengcixi@gmail.com>
Message-ID: <20200325152418.GA23610@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cixi,

...
> +++ b/testcases/kernel/device-drivers/uart/serialcheck.sh
> @@ -0,0 +1,68 @@
> +#!/bin/sh
> +###############################################################################
> +#
Please avoid these '####...'

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
> +# Copyright (C) 2019, Unisoc Communications Inc.
> +#
> +# Test UART ports using git://git.breakpoint.cc/bigeasy/serialcheck.git
> +#
> +###############################################################################
> +
> +TST_TESTFUNC=do_test
> +TST_POS_ARGS=3
> +TST_USAGE=usage
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="serialcheck"
> +TST_NEEDS_CMDS="lsof"
> +TST_NEEDS_CMDS="dd"
Note, this is a normal shell variable, so you'd request only dd. You need to
use:
TST_NEEDS_CMDS="serialcheck lsof dd"

> +TST_NEEDS_TMPDIR=1
> +
> +. tst_test.sh
> +
> +usage()
> +{
> +    echo "usage: ./${0} [-r UART_RATE] [-l LOOPS] [-h|k to enable HW flow control or loopback]"
> +    exit 1
> +}
BTW, you use positional arguments, so this help is wrong.
IMHO it's better to use getopts parameters (positional parameters are rarely
used + use "k" as a parameter looks strange), but of course it's not a
mistake. If you want to keep them, it should be:

usage()
{
    echo "usage: $0 {UART_RATE} {LOOPS} {h|k to enable HW flow control or loopback}"
}

The convention in unix/linux program is:
[ foo ] => foo is optional argument
{ bar } => bar is mandatory argument

> +
> +UART_RATE=$1
> +UART_LOOPS=$2
> +UART_HWFLOW=$3
> +
> +create_test_file()
> +{
> +    temp_test_file=`mktemp`
We both Cyril and me mentioned that you don't need to use mktemp (+ it'd be
unnecessary dependency).

> +    dd if=/dev/urandom of=$temp_test_file count=1 bs=$((UART_RATE / 2))
> +}
> +
> +test_serial()
> +{
> +    create_test_file
> +    { sleep 1; serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l $UART_LOOPS -m t -${UART_HWFLOW}; }&
Cyril already mentioned the need to use proper locks instead of sleep.
> +    PID=$!
> +    serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l $UART_LOOPS -m r -${UART_HWFLOW}
> +    if [ $? ];  then
This is always true. Use either:
serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l $UART_LOOPS -m r -${UART_HWFLOW}
if [ $? -eq 0 ];  then
...

or put the command itself into if:

if serialcheck -b $UART_RATE -d $1 -f $temp_test_file -l $UART_LOOPS -m r -${UART_HWFLOW}; then
...

> +        kill -- -$PID 2>/dev/null
> +        tst_res TFAIL "uart test failed"
> +    else
> +        tst_res TPASS "uart test passed"
> +    fi
> +    rm $temp_test_file
> +}
> +
> +do_test()
> +{
You re supposed to declare non-global variables:
local i

> +    for i in /sys/class/tty/*/uartclk ;do
> +        PORT=`echo $i |cut -d '/' -f 5`
> +        # Activate port in case it will be initialized only when startup
> +        echo "UART TESTING">${PORT} 2>/dev/null
> +        if [ `cat /sys/class/tty/${PORT}/uartclk` -ne 0 ]; then
> +            lsof | grep "/dev/${PORT}" &> /dev/null || PORT_TO_TEST="/dev/${PORT}"
> +            tst_res TINFO "start test on ${PORT_TO_TEST} ${UART_RATE}"
> +            test_serial ${PORT_TO_TEST}
> +        fi
> +    done
> +}
> +
> +tst_run

Kind regards,
Petr
