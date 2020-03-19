From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Mar 2020 11:28:42 +0100
Subject: [LTP] [PATCH] uart: add uart testcase in kernel device-driver
In-Reply-To: <CAF12kFsKiR8XFW2WhMuNs7VYEGh8Sj=oaQHC05uc689vAcmarA@mail.gmail.com>
References: <CAF12kFsKiR8XFW2WhMuNs7VYEGh8Sj=oaQHC05uc689vAcmarA@mail.gmail.com>
Message-ID: <20200319102842.GA440@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cixi,

> Porting UART test from ltp-ddt back to ltp. only test 115200 UART_RATE.
Thanks for your effort. There are several problems with this test, I'll try to
address them all.

> [TODO] support more rate, and add test HWFLOW function test.
Could this be in v2?

> diff --git a/runtest/kernel_ddt b/runtest/kernel_ddt
> new file mode 100644
> index 000000000..30e9a0269
> --- /dev/null
> +++ b/runtest/kernel_ddt
> @@ -0,0 +1 @@
> +uart serialcheck.sh
I wonder if there needs to be in it's own runtest file.
Maybe yes, but I'd propose more meaningful name (serial, uart).
What is ddt anyway?

> diff --git a/testcases/kernel/device-drivers/Makefile
> b/testcases/kernel/device-drivers/Makefile
> index 55e0d25a0..a214f211b 100644
> --- a/testcases/kernel/device-drivers/Makefile
> +++ b/testcases/kernel/device-drivers/Makefile
> @@ -27,6 +27,7 @@ SUBDIRS := acpi \
>     rtc \
>     tbio \
>     uaccess \
> +   uart \
>     zram

>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/device-drivers/uart/Makefile
> b/testcases/kernel/device-drivers/uart/Makefile
> new file mode 100644
> index 000000000..0d73f6635
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/uart/Makefile
> @@ -0,0 +1,22 @@
> +# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
Please next time instead of verbose GPL text ^ use just:
# SPDX-License-Identifier: GPL-2.0-or-later

> +
> +top_srcdir ?= ../../../..
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS := *.sh
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/device-drivers/uart/serialcheck.sh
> b/testcases/kernel/device-drivers/uart/serialcheck.sh
> new file mode 100755
> index 000000000..f4cf13e02
> --- /dev/null
> +++ b/testcases/kernel/device-drivers/uart/serialcheck.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh
> +###############################################################################
> +#
> +# Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
> +# Copyright (C) 2019, Unisoc Communications Inc.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation version 2.
> +#
> +# This program is distributed "as is" WITHOUT ANY WARRANTY of any
> +# kind, whether express or implied; without even the implied warranty
> +# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +###############################################################################
And here ^:
# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# @desc Test UART ports using git://
> git.breakpoint.cc/bigeasy/serialcheck.git
It looks your mailer wraps lines, that's unusable for applying.
Could you use git format-patch and git send-email for generating patches and
sending them?

> +
> +#### Functions definitions ####
Please avoid these useless comments.

> +usage()
> +{
> +    echo "usage: ./${0##*/} [-r UART_RATE] [-l LOOPS] [-x to enable HW
> flow control]"
Also here is wrapped.

But you're supposed to use TST_OPTS TST_PARSE_ARGS and TST_USAGE from The API
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#233-optional-command-line-parameters

> +    exit 1
> +}
> +
> +# Default values
> +: ${UART_RATE:=115200}
> +: ${UART_LOOPS:=5}
> +: ${UART_HWFLOW:=0}
Even this is a valid syntax, please use more convinient:
UART_RATE="${UART_RATE:=115200}"

> +
> +PORTS_TO_TEST=();
> +UART_PORTS=();
> +ARRAY=(`find /sys/class/tty/*/uartclk`);
Arrays are bashisms (bash specific), we don't allow them in LTP, as we require
POSIX shell syntax, which is portable (some systems doesn't have bash, but dash
or other shell e.g. toybox or busybox on Android. I guess you target embedded
system with this test):
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style

Most of the time arrays can be replaced by string separated by space.
If you need these devices, in /sys/class/tty/*/uartclk, it could be done like:
ports=$(for i in /sys/class/tty/*/uartclk ; do echo $i | cut -d '/' -f 5; done)

> +
> +check_requirements()
> +{
> + which serialcheck


> + ret=$?
> + if [ $ret -eq 0 ];then
> + tst_res TINFO "serialcheck command is in system,continue to test"
> + else
> + tst_brk TCONF "test failed for lack of requirement,returned is $ret"
> + fi
> +
Useless blank line here.
> +}
TINFO is not much useful, I'd avoid that. And check_requirements should be a setup function, not called directly in do_test:
TST_SETUP=check_requirements

But given that whole function just check serialcheck, whole function should be
replaced just by:

TST_NEEDS_CMDS="serialcheck"
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#232-library-environment-variables-for-shell

BTW serialcheck source isn't probably packaged in distros
https://git.breakpoint.cc/cgit/bigeasy/serialcheck.git/tree/serialcheck.c
Maybe we could just adapt it to LTP and include it as well (if we consider whole
testing useful).

> +
> +create_test_file()
> +{
> +    temp_test_file=`mktemp`
I guess you need to use TST_NEEDS_TMPDIR=1
and then just any file in it. Or use $$ (e.g. file.$$) if you want to have
concurrency, but we usually don't care).
> +    dd if=/dev/urandom of=$temp_test_file count=1 bs=$((UART_RATE / 2))
You also need to add dd to TST_NEEDS_CMDS.

> +}
> +
> +get_uart_ports()
> +{
> +for i in ${ARRAY[@]}; do
> +    PORT=/dev/`echo $i | cut -d'/' -f 5`
Well, you use cut yourself, so why that complicated code with arrays?

> +    # Activate port in case it will be initialized only when startup
> +    echo "DDT TESTING" > $PORT 2>/dev/null
> +    if [ `cat $i` -ne 0 ]; then
> +        UART_PORTS=("${UART_PORTS[@]}" "$PORT")
> +    fi
> +done
> +}
> +
> +filter_out_used_ports()
> +{
> + which lsof
> + ret=$?
> + if [ $ret -eq 0 ];then
> + tst_res TINFO "lsof command exist, filter out used ports";
> + else
> + tst_brk TCONF "test failed for lack of requirement,returned is $ret"
> + fi
Again whole block is useless, just add lsof into TST_NEEDS_CMDS.

> +
> +    for i in ${UART_PORTS[@]}; do
> +        lsof | grep $i &> /dev/null ||
> PORTS_TO_TEST=("${PORTS_TO_TEST[@]}" $i)
> +    done
> +}
> +
> +run_serial_test()
> +{
> + create_test_file
create_test_file should be just 2 lines of code in setup function.

> +    for i in ${PORTS_TO_TEST[@]}; do
Array => bashism :(.

> +        if [ $UART_HWFLOW -eq 0 ]; then
> +            { sleep 1; serialcheck -b $UART_RATE -d $i -f $temp_test_file
> -l $UART_LOOPS -m t -k; }&
Again line wrapped :(

> +            PID=$!
> +            serialcheck -b $UART_RATE -d $i -f $temp_test_file -l
Hm, why do you run 2 instances?

> $UART_LOOPS -m r -k || { kill -- -$PID 2>/dev/null; tst_res TFAIL "TEST
> FAILED"; }
Using complicated code in { } isn't much readable. I'd put it into:
if ! $UART_LOOPS -m r -k; then
	kill ...
fi

> +        else
> +            { sleep 1; serialcheck -b $UART_RATE -d $i -f $temp_test_file
> -l $UART_LOOPS -m t -h; } &
> +            PID=$!
> +            serialcheck -b $UART_RATE -d $i -f $temp_test_file -l
> $UART_LOOPS -m r -h || { kill -- -$PID 2>/dev/null; tst_res TFAIL "TEST
> FAILED"; }

This can be written better to not repeat much yourself.
Whole if and else block is the same exept -h and -k parameter are different.
Why not put this extra parameter into variable?
Why sleep added into {} block?

> +        fi
> +    done
> +    rm $temp_test_file
> + tst_res TPASS "uart test passed"
> +}
> +
> +
> +TST_TESTFUNC=do_test
> +. tst_test.sh
We usually put this at the beginning of the test.
Please see some tests as examples (testcases/commands/df/df01.sh,
testcases/commands/mkfs/mkfs01.sh, testcases/commands/lsmod/lsmod01.sh, ...)

> +
> +do_test()
> +{
> + check_requirements

> + get_uart_ports
> + filter_out_used_ports
> + run_serial_test
> +}
> +
> +tst_run

Kind regards,
Petr
