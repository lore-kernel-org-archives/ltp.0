Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaON-0006Oz-Kt
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:15 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaOF-0005dQ-Tf
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:30:15 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UITjY6002107
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:29:45 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UIU2aD214546
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:30:02 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UIU1Ar017675
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 14:30:02 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A6E9905.5060300@cn.fujitsu.com>
References: <4A6E9905.5060300@cn.fujitsu.com>
Date: Thu, 30 Jul 2009 23:59:42 +0530
Message-Id: <1248978583.5788.67.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add new testcases for cpu controller
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, 2009-07-28 at 14:21 +0800, Shi Weihua wrote: 
> My workmate Miao Xie (miaox@cn.fujitsu.com) has created some testcases for 
> cgroup's subsystem "cpu" in the last year. And, He catched some kernel bugs 
> through these testcases. So we think you glad to push them into LTP.
> 
> There are total 22 testcases that have been added. These testcases contain 
> the basis operation test and part functionality test of cpu controller.
> 
> How to run this test:
> 	# runltp -f controllers
> 
> Result:
> cpuctl_test_fj    1  PASS  :  case1    PASS
> cpuctl_test_fj    1  PASS  :  case2    PASS
> cpuctl_test_fj    1  PASS  :  case3    PASS
> cpuctl_test_fj    1  PASS  :  case4    PASS
> cpuctl_fj_simple_echo: write error: Invalid argument
> cpuctl_test_fj    1  PASS  :  case5    PASS
> cpuctl_fj_simple_echo: write error: Invalid argument
> cpuctl_test_fj    1  PASS  :  case6    PASS
> cpuctl_fj_simple_echo: write error: Invalid argument
> cpuctl_test_fj    1  PASS  :  case7    PASS
> cpuctl_test_fj    1  PASS  :  case8    PASS
> cpuctl_test_fj    1  PASS  :  case9    PASS
> cpuctl_test_fj    1  PASS  :  case10    PASS
> cpuctl_test_fj    1  PASS  :  case11    PASS
> cpuctl_test_fj    1  PASS  :  case12    PASS
> cpuctl_test_fj    1  PASS  :  case13    PASS
> cpuctl_test_fj    1  PASS  :  case14    PASS
> cpuctl_fj_simple_echo: write error: Invalid argument
> cpuctl_test_fj    1  PASS  :  case15    PASS
> cpuctl_fj_simple_echo: write error: Invalid argument
> cpuctl_test_fj    1  PASS  :  case16    PASS
> cpuctl_fj_simple_echo: write error: Invalid argument
> cpuctl_test_fj    1  PASS  :  case17    PASS
> cpuctl_test_fj    1  PASS  :  case18    PASS
> pid 19840 cpu_usage 99
> cpuctl_test_fj    1  PASS  :  case19    PASS
> pid 19869 cpu_usage 99
> cpuctl_test_fj    1  PASS  :  case20    PASS
> pid 19898 cpu_usage 47
> pid 19898 cpu_usage 47
> pid 19898 cpu_usage 45
> pid 19898 cpu_usage 49
> pid 19898 cpu_usage 47
> pid 19898 cpu_usage 49
> pid 19898 cpu_usage 45
> pid 19898 cpu_usage 47
> pid 19898 cpu_usage 45
> pid 19898 cpu_usage 49
> cpuctl_test_fj    1  PASS  :  case21    PASS
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> pid 20056 cpu_usage 99
> cpuctl_test_fj    1  PASS  :  case22    PASS
> #The forward messages of "write error: Invalid argument" are expected result,
> #so don't worry about them.
> 
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>

Thanks for these test cases.

Regards--
Subrata

> ---
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_cpu-hog.c	2009-07-14 08:37:56.000000000 -0400
> @@ -0,0 +1,69 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Miao Xie <miaox@cn.fujitsu.com>                                    */
> +/* Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +#include <stdio.h>
> +#include <math.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <signal.h>
> +
> +#define __USE_GNU
> +#include <sched.h>
> +
> +#define UNUSED __attribute__ ((unused))
> +
> +unsigned long count;
> +volatile int start = 0;
> +volatile double f = 2744545.34456455;
> +
> +void sighandler(UNUSED int signo)
> +{
> +	start = !start;
> +}
> +
> +int main(void)
> +{
> +	sigset_t sigset;
> +	struct sigaction sa;
> +
> +	sa.sa_handler = sighandler;
> +	if (sigemptyset(&sa.sa_mask) < 0)
> +		err(1, "sigemptyset()");
> +
> +	sa.sa_flags = 0;
> +	if (sigaction(SIGUSR1, &sa, NULL) < 0)
> +		err(1, "sigaction()");
> +
> +	if (sigemptyset(&sigset) < 0)
> +		err(1, "sigemptyset()");
> +
> +	sigsuspend(&sigset);
> +	if (errno != EINTR)
> +		err(1, "sigsuspend()");
> +
> +	while (start) {
> +		f = sqrt(f * f);
> +	}
> +
> +	return 0;
> +}
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_simple_echo.c ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_simple_echo.c
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_simple_echo.c	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/cpuctl_fj_simple_echo.c	2009-07-14 08:37:58.000000000 -0400
> @@ -0,0 +1,72 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/* Author: Miao Xie <miaox@cn.fujitsu.com>                                    */
> +/* Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     */
> +/*                                                                            */
> +/******************************************************************************/
> +/*++ simple_echo.c
> + *
> + * DESCRIPTION:
> + *	The command "echo" can't return the errno. So we write this program to
> + * instead of "echo".
> + *
> + * Author:
> + * -------
> + * 2008/04/17 created by Miao Xie@FNST
> + *
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include <err.h>
> +#include <errno.h>
> +
> +int main(int argc, char **argv)
> +{
> +	int fd = 1;
> +	int ret = 0;
> +
> +	if (argc != 2 && argc != 3) {
> +		fprintf(stderr, "USAGE: %s STRING [ostream]\n", argv[0]);
> +		return 1;
> +	}
> +
> +	if (argc == 3) {
> +		fd = open(argv[2], O_RDWR | O_SYNC);
> +		if (fd == -1)
> +			err(errno, "%s", argv[2]);
> +	}
> +
> +	ret = write(fd, argv[1], strlen(argv[1]));
> +	if (ret  == -1)
> +		err(errno, "write error");
> +
> +	if (fd != 1) {
> +		ret = close(fd);
> +		if (ret == -1)
> +			err(errno, "close error");
> +	}
> +
> +	return 0;
> +}
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/Makefile ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/Makefile
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/Makefile	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/Makefile	2009-07-14 08:37:58.000000000 -0400
> @@ -0,0 +1,21 @@
> +CFLAGS += -Wall -O2 -Wextra
> +LOADLIBES+= -lm
> +CPPFLAGS += -I../../../../include -I../libcontrollers
> +LDLIBS += -L../../../../lib/ -lltp
> +
> +SRCS=$(wildcard *.c)
> +OBJECTS=$(patsubst %.c,%.o,$(SRCS))
> +TARGETS=$(patsubst %.c,%,$(SRCS))
> +
> +all: $(TARGETS)
> +
> +$(TARGETS): %: %.o
> +
> +test:
> +	@./runtest.sh
> +
> +clean:
> +	rm -f $(TARGETS) $(OBJECTS)
> +
> +install:
> +	@set -e; for i in $(TARGETS) *.sh; do ln -f $$i ../../../bin/$$i ; chmod +x $$i ; done
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/README ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/README
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/README	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/README	2009-07-28 06:00:01.000000000 -0400
> @@ -0,0 +1,41 @@
> +
> +TEST SUITE:
> +
> +The directory cpuctl_fj contains the tests related to the cpu controller.
> +
> +Cpu controller is a mechanism for assigning cpu resource (in percent) to 
> +a set of tasks.
> +
> +There are total 22 testcases that have been added. These testcases 
> +contain the basis operation test and part functionality test of cpu 
> +controller.
> +
> +NOTE: the test can be run by root only.
> +
> +TESTS AIM:
> +
> +The aim of the tests is to test the functionality of cpu controller.
> +
> +FILES DESCRIPTION:
> +
> +run_cpuctl_test_fj.sh
> +--------------------
> +This script runs all the 22 testcases.
> +
> +cpuctl_fj_cpu-hog.c
> +--------------------
> +The program does a calculation of sqrt till catched a signal.
> +
> +cpuctl_fj_simple_echo.c
> +--------------------
> +The command "echo" can't return the errno. So we write this program to
> +instead of "echo". 
> +
> +Makefile
> +--------------------
> +The usual makefile for this directory
> +
> +README
> +------
> +The one you have gone through.
> +
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh	1969-12-31 19:00:00.000000000 -0500
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh	2009-07-28 05:58:31.000000000 -0400
> @@ -0,0 +1,702 @@
> +#! /bin/sh
> +
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) 2009 FUJITSU LIMITED                                         ##
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
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +## Author: Miao Xie <miaox@cn.fujitsu.com>                                    ##
> +## Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>                     ##
> +##                                                                            ##
> +################################################################################
> +
> +cd $LTPROOT/testcases/bin
> +
> +export TCID="cpuctl_test_fj"
> +export TST_TOTAL=22
> +export TST_COUNT=1
> +
> +CPUCTL="/dev/cpuctl"
> +CPUCTL_TMP="/tmp/cpuctl_tmp"
> +SLEEP_SEC=5
> +
> +# Create $CPUCTL &  mount the cgroup file system with cpu controller
> +# clean any group created earlier (if any)
> +setup()
> +{
> +	if [ -e $CPUCTL ]
> +	then
> +		tst_resm TWARN "WARN:$CPUCTL already exist..overwriting"
> +		cleanup || {
> +			tst_resm TFAIL "Err: Can't cleanup... Exiting"
> +			exit -1;
> +		}
> +	fi
> +
> +	mkdir -p "$CPUCTL" || return 1
> +
> +	mount -t cgroup -o cpu cpuctl "$CPUCTL" || {
> +		tst_resm TFAIL "failed to mount cpu subsytem... Exiting"
> +		cleanup;
> +		return 1;
> +	}
> +}
> +
> +# Write the cleanup function
> +cleanup()
> +{
> +	mount | grep "$CPUCTL" &> /dev/null || {
> +		rm -rf "$CPUCTL" &> /dev/null
> +		return 0
> +	}
> +
> +	find $CPUCTL -type d | sort | sed -n '2,$p' | tac | while read tmpdir
> +	do
> +		while read tmppid
> +		do
> +			echo $tmppid > $CPUCTL/tasks
> +		done  < $tmpdir/tasks
> +		rmdir $tmpdir || return 1
> +	done
> +
> +	umount $CPUCTL || return 1
> +	rmdir $CPUCTL &> /dev/null
> +}
> +
> +creat_process()
> +{
> +	cat /dev/zero > /dev/null 2>/dev/null &
> +	taskset -p 1 $! &>/dev/null
> +	echo $!
> +}
> +
> +get_cpu_usage()
> +{
> +	top=($(top -b -n 1 -p $1 | tail -2 | head -1))
> +	top=${top[8]}
> +	top=`echo $top | awk -F "." '{print $1}'`
> +	echo "$top"
> +}
> +
> +kill_all_pid()
> +{
> +	while read pid_to_be_killed
> +	do
> +		kill -9 $pid_to_be_killed
> +	done
> +}
> +
> +TESTUSER="`whoami`"
> +if [ "$TESTUSER" != "root" ]
> +then
> +	tst_brkm TBROK ignored "Test must be run as root"
> +	exit 0
> +fi
> +
> +# only root directory
> +case1 ()
> +{
> +	[ -f "$CPUCTL/cpu.shares" ] || {
> +		tst_resm TFAIL "Err: No cpu.shares."
> +		return 1
> +	}
> +
> +	shares=`cat $CPUCTL/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		tst_resm TFAIL "Err: Init value is not 1024"
> +		return 1;
> +	fi
> +
> +	ps -eo pid,rtprio > /tmp/pids_file1 &
> +	pspid=$!
> +	wait $pspid
> +	cat /tmp/pids_file1 | grep '-' | tr -d '-' | tr -d ' ' | \
> +	grep -v "$pspid" > /tmp/pids_file2
> +
> +	while read pid
> +	do
> +		task=`cat $CPUCTL/tasks | grep "\b$pid\b"`
> +		if [ -z $task ]
> +		then
> +			tst_resm TFAIL  "Err: Some normal tasks aren't in the root group"
> +			return 1
> +		fi
> +	done < /tmp/pids_file2
> +}
> +
> +# create a child directory
> +case2 ()
> +{
> +	mkdir $CPUCTL/tmp
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	[ -d "$CPUCTL/tmp" ] || return 1
> +
> +	[ -f "$CPUCTL/tmp/cpu.shares" ] || return 1
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +
> +	task=`cat $CPUCTL/tmp/tasks`
> +	if [ "$task" != "" ]
> +	then
> +		return 1
> +	fi
> +}
> +
> +# create a grand-directory
> +case3 ()
> +{
> +	mkdir $CPUCTL/tmp
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	mkdir $CPUCTL/tmp/tmp1
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	[ -d "$CPUCTL/tmp/tmp1" ] || return 1
> +
> +	[ -f "$CPUCTL/tmp/tmp1/cpu.shares" ] || return 1
> +
> +	shares=`cat $CPUCTL/tmp/tmp1/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +
> +	task=`cat $CPUCTL/tmp/tmp1/tasks`
> +	if [ "$task" != "" ]
> +	then
> +		return 1
> +	fi
> +}
> +
> +# attach general process
> +case4 ()
> +{
> +	mkdir $CPUCTL/tmp
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	echo 1 > $CPUCTL/tmp/tasks
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	tasks=`cat $CPUCTL/tmp/tasks`
> +	if [ $tasks -ne 1 ]
> +	then
> +		return 1;
> +	fi
> +}
> +
> +# attach realtime process
> +case5 ()
> +{
> +	mkdir $CPUCTL/tmp
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_simple_echo 3 $CPUCTL/tmp/tasks
> +	if [ $? -ne 22 ]	# define EINVAL 22  /* Invalid argument */
> +	then
> +		return 1;
> +	fi
> +
> +	tasks=`cat $CPUCTL/tmp/tasks`
> +	if [ "$tasks" != "" ]
> +	then
> +		return 1;
> +	fi
> +}
> +
> +# modify the shares of the root group
> +case6 ()
> +{
> +	./cpuctl_fj_simple_echo 2048 $CPUCTL/cpu.shares
> +	if [ $? -ne 22 ]	# define EINVAL 22  /* Invalid argument */
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +}
> +
> +# echo negative into shares
> +case7 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	./cpuctl_fj_simple_echo -1 $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 22 ]	# define EINVAL 22  /* Invalid argument */
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo 0 into shares
> +case8 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo 0 > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 2 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo 1 into shares
> +case9 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo 1 > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 2 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo 2 into shares
> +case10 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo 2 > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 2 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo 3 into shares
> +case11 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo 3 > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 3 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo 2048 into shares
> +case12 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo 2048 > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 2048 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +max_shares=$((2**18))
> +
> +# echo MAX_SHARES into shares
> +case13 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo $max_shares > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ "$shares" != "$max_shares" ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo MAX_SHARES+1 into shares
> +case14 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	echo $(($max_shares+1)) > $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 0 ]
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ "$shares" != "$max_shares" ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo float number into shares
> +case15 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	./cpuctl_fj_simple_echo 2048.23 $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 22 ]	# define EINVAL 22  /* Invalid argument */
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo a string into shares. This string begins with some number, and ends with
> +# charactor.
> +case16 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	./cpuctl_fj_simple_echo 2048ABC $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 22 ]	# define EINVAL 22  /* Invalid argument */
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +# echo a string into shares. This string begins with charactors.
> +case17 ()
> +{
> +	mkdir $CPUCTL/tmp
> +
> +	./cpuctl_fj_simple_echo ABC $CPUCTL/tmp/cpu.shares
> +	if [ $? -ne 22 ]	 # define EINVAL 22  /* Invalid argument */
> +	then
> +		return 1;
> +	fi
> +
> +	shares=`cat $CPUCTL/tmp/cpu.shares`
> +	if [ $shares -ne 1024 ]
> +	then
> +		return 1;
> +	fi
> +
> +	./cpuctl_fj_cpu-hog &
> +	pid=$!
> +
> +	echo $pid > $CPUCTL/tmp/tasks
> +
> +	/bin/kill -s SIGUSR1 $pid
> +	sleep $SLEEP_SEC
> +	/bin/kill -s SIGUSR1 $pid
> +	wait $pid
> +}
> +
> +case18()
> +{
> +	mkdir "$CPUCTL/1"
> +	echo 0x8000000000000000 > "$CPUCTL/1/cpu.shares"
> +	pid=$(creat_process)
> +	echo $pid > "$CPUCTL/1/tasks"
> +	kill -9 $pid
> +	return 0
> +}
> +
> +case19()
> +{
> +	mkdir "$CPUCTL/1"
> +	pid=$(creat_process)
> +	pid_other=$(creat_process)
> +
> +	echo 2000000000 > "$CPUCTL/1/cpu.shares"
> +	echo $pid > "$CPUCTL/1/tasks"
> +	cpu_usage=$(get_cpu_usage $pid)
> +	echo "pid $pid cpu_usage $cpu_usage"
> +
> +	kill -9 $pid $pid_other
> +	expr 96 \< "$cpu_usage" \& "$cpu_usage" \< 103 &> /dev/null || return 1
> +	return 0
> +}
> +
> +case20()
> +{
> +	mkdir "$CPUCTL/1"
> +	pid=$(creat_process)
> +	pid_other=$(creat_process)
> +
> +	echo 20000000000 > "$CPUCTL/1/cpu.shares"
> +	echo $pid > "$CPUCTL/1/tasks"
> +	cpu_usage=$(get_cpu_usage $pid)
> +	echo "pid $pid cpu_usage $cpu_usage"
> +
> +	kill -9 $pid $pid_other
> +	expr 96 \< "$cpu_usage" \& "$cpu_usage" \< 103 &> /dev/null || return 1
> +	return 0
> +}
> +
> +case21()
> +{
> +	mkdir "$CPUCTL/1" "$CPUCTL/1/2"
> +	pid=$(creat_process)
> +	echo $pid > "$CPUCTL/1/tasks"
> +
> +	while ((1))
> +	do
> +		creat_process > "$CPUCTL/1/2/tasks"
> +		sleep 1
> +	done &
> +	loop_pid=$!
> +
> +	sleep 10
> +	ret=0
> +
> +	for ((top_times=0; top_times<10 && ret==0; top_times++))
> +	do
> +		cpu_usage=$(get_cpu_usage $pid)
> +		echo "pid $pid cpu_usage $cpu_usage"
> +		expr 44 \< "$cpu_usage" \& "$cpu_usage" \< 56 &> /dev/null
> +		ret=$?
> +	done
> +
> +	kill -9 $pid $loop_pid &> /dev/null
> +	wait $pid $loop_pid &>/dev/null
> +	sleep 2
> +	kill_all_pid < "$CPUCTL/1/2/tasks" &>/dev/null
> +	sleep 2
> +	return $ret
> +}
> +
> +case22()
> +{
> +	mkdir "$CPUCTL/1" "$CPUCTL/1/2"
> +	pid=$(creat_process)
> +	while ((1))
> +	do
> +		echo $pid > "$CPUCTL/1/tasks"
> +		echo $pid > "$CPUCTL/1/2/tasks"
> +		sleep 1
> +	done &
> +	loop_pid=$!
> +
> +	sleep 10
> +	ret=0
> +
> +	for ((top_times=0; top_times<10 && ret==0; top_times++))
> +	do
> +		cpu_usage=$(get_cpu_usage $pid)
> +		echo "pid $pid cpu_usage $cpu_usage"
> +		expr 94 \< "$cpu_usage" \& "$cpu_usage" \< 106 &> /dev/null
> +		ret=$?
> +	done
> +	
> +	kill -9 $pid $loop_pid &> /dev/null
> +	wait $pid $loop_pid &>/dev/null
> +	return $ret
> +}
> +
> +rm -rf "$CPUCTL_TMP" &>/dev/null || exit 1
> +mkdir -p "$CPUCTL_TMP" || exit 1
> +
> +# test
> +do_test ()
> +{
> +	for (( i=1; i<=$TST_TOTAL; i++ ))
> +	do
> +		setup || {
> +			tst_resm TFAIL "case$i    FAIL"
> +			continue
> +		}
> +
> +		case$i || {
> +			tst_resm TFAIL "case$i    FAIL"
> +			cleanup
> +			continue
> +		}
> +
> +		cleanup || {
> +			tst_resm TFAIL "case$i    FAIL"
> +		}
> +		
> +		tst_resm TPASS "case$i    PASS"
> +	done
> +}
> +
> +do_test
> +
> +rm -rf "$CPUCTL_TMP" &>/dev/null
> +
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/Makefile ltp-full-20090630/testcases/kernel/controllers/Makefile
> --- ltp-full-20090630.orig/testcases/kernel/controllers/Makefile	2009-06-15 14:53:06.000000000 -0400
> +++ ltp-full-20090630/testcases/kernel/controllers/Makefile	2009-07-28 06:18:00.000000000 -0400
> @@ -13,6 +13,7 @@ ifdef CROSS_COMPILE
>  ifeq ($(CHECK_CGROUP),cgroup)
>  SUBDIRS += cgroup
>  SUBDIRS += cpuctl
> +SUBDIRS += cpuctl_fj
>  SUBDIRS += memctl
>  SUBDIRS += io-throttle
>  SUBDIRS += freezer
> @@ -35,6 +36,7 @@ endif
> 
>  ifeq ($(CHECK_CPUCTL),cpu)
>  SUBDIRS += cpuctl
> +SUBDIRS += cpuctl_fj
>  else
>  $(info "Kernel is not compiled with cpu controller support")
>  endif
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/test_controllers.sh ltp-full-20090630/testcases/kernel/controllers/test_controllers.sh
> --- ltp-full-20090630.orig/testcases/kernel/controllers/test_controllers.sh	2009-05-11 06:02:46.000000000 -0400
> +++ ltp-full-20090630/testcases/kernel/controllers/test_controllers.sh	2009-07-28 06:18:39.000000000 -0400
> @@ -32,6 +32,7 @@
>  #                                                                                #
>  #  20/12/07  Sudhir Kumar <sudhirkumarmalik@in.ibm.com>   Created this test      #
>  #  02/03/09  Miao Xie     <miaox@cn.fujitsu.com>          Add cpuset testset     #
> +#  07/07/09  Shi Weihua   <shiwh@cn.fujitsu.com>      Add cpu testset of Fujitsu #
>  #                                                                                #
>  ##################################################################################
> 
> @@ -57,6 +58,8 @@ then
>  		# Add the latency testcase to be run
>  		$LTPROOT/testcases/bin/run_cpuctl_latency_test.sh 1;
>  		$LTPROOT/testcases/bin/run_cpuctl_latency_test.sh 2;
> +		# Add the testcases from Fujitsu
> +		$LTPROOT/testcases/bin/run_cpuctl_test_fj.sh
>  	else
>  		echo "CONTROLLERS TESTCASES: WARNING";
>  		echo "Kernel does not support for cpu controller";
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
