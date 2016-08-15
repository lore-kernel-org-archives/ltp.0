From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 15 Aug 2016 09:27:40 +0800
Subject: [LTP] [PATCH] commands/passwd: Added new testcase to test passwd
In-Reply-To: <20160809145536.GC31315@rei.suse.cz>
References: <1468476664-16364-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160809145536.GC31315@rei.suse.cz>
Message-ID: <57B11A8C.8090301@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi !

Thanks for your review, i will rewrite it as what you suggested.

Regards,
Xiao Yang

On 2016/08/09 22:55, Cyril Hrubis wrote:
> Hi!
>> +top_srcdir		?= ../../..
>> +
>> +include $(top_srcdir)/include/mk/env_pre.mk
>> +
>> +INSTALL_TARGETS		:= passwd01.sh check_passwd
>                                                   ^
> 						 This should better be
> 						 passwd01_check so that
> 						 it's clear what test
> 						 uses this expect
> 						 script
>
> And maybe we can use .exp suffix for expect script (there does not seems
> to be any well defined suffix for expect though).
>
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/commands/passwd/check_passwd b/testcases/commands/passwd/check_passwd
>> new file mode 100755
>> index 0000000..1d27c7e
>> --- /dev/null
>> +++ b/testcases/commands/passwd/check_passwd
>> @@ -0,0 +1,67 @@
>> +#!/usr/bin/expect -f
>> +#
>> +# Copyright (c) 2016 Fujitsu Ltd.
>> +# Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> +# the GNU General Public License for more details.
>> +#
>> +# Test passwd command with some basic options.
>> +#
>> +
>> +set test_res 0
>> +set user_init [ lindex $argv 0 ]
>> +set cmd [ lindex $argv 1 ]
>> +set user_test [ lindex $argv 2 ]
>> +set passwd_test [ lindex $argv 3 ]
>> +
>> +set who_bf [ exec whoami ]
>> +if { $who_bf!=$user_init } {
>> +	send_user "ERROR: You must be not a root user before testing\n"
> This message is misleading, the code tesets for whoami != $argv[0] and
> not for $whoami != root.
>
>> +	exit 1
>> +}
>> +
>> +if { $cmd==2 } {
>> +        spawn /bin/su $user_test
>> +        expect "Password:" {
>> +                send "$passwd_test\n"
>> +                expect {
>> +			"su: Authentication failure" { set test_res 1 }
>> +			"su: incorrect password" { set test_res 1 }
> This is very fragile approach. This test will pass for instance when
> LC_ALL is set to something else than english.
>
> Looking at su manual page it should return 1 on autentication failure.
>
> We can instead just do:
>
> spawn su $test_usr -c true
>
> And fail the test if return value was not 0.
>
> We can avoid the whole expect script that way...
>
>> +		}
>> +        }
>> +}
>> +
>> +if { $cmd==1 } {
>> +	spawn /bin/su $user_test
>> +	expect "Password:" {
>> +		send "$passwd_test\n"
>> +		expect "$user_test" { set test_res 1 }
> So we fail the test if we get shell user@hostname: ?
>
> That is quite fragile as well.
>
> We should rather do the -c true here as well and fail the test if exit
> value was not 1.
>
>> +	}
>> +}
>> +
>> +if { $cmd==0 } {
>> +	spawn /bin/su $user_test
>> +	expect "$user_test" { set test_res 1 }
> Here as well.
>
>> +}
> This is whole if { $cmd == foo} is messy.
>
> Why can't we just create separate script for each test scenario?
>
>> +set who_af [ exec whoami ]
>> +if { $who_af!=$user_init } {
>> +        send_user "ERROR: You must be not a root user after testing\n"
>> +        exit 1
>> +}
> This is rather FAILURE than ERROR, right?
>
>> +if { $test_res==1 } {
>> +	send_user "test passes as expected\n"
>> +	exit 0
>> +} else {
>> +	send_user "test fails unexpectedly\n"
>> +	exit 1
>> +}
> The FAIL/PASS should rather be printed in the shell script using the
> tst_res API.
>
>> diff --git a/testcases/commands/passwd/passwd01.sh b/testcases/commands/passwd/passwd01.sh
>> new file mode 100755
>> index 0000000..8a304ce
>> --- /dev/null
>> +++ b/testcases/commands/passwd/passwd01.sh
>> @@ -0,0 +1,107 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2016 Fujitsu Ltd.
>> +# Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> +# the GNU General Public License for more details.
>> +#
>> +# Test passwd command with some basic options.
>> +#
>> +
>> +TCID=passwd01.sh
>> +TST_TOTAL=11
>> +. test.sh
>> +
>> +setup()
>> +{
>> +	tst_require_root
>> +
>> +	tst_check_cmds useradd userdel passwd su expect
>> +
>> +	tst_tmpdir
>> +
>> +	TST_CLEANUP="cleanup"
>> +
>> +	useradd ltp_init
>> +	if [ $? -ne 0 ]&&  [ ! -d /home/ltp_test ]; then
>> +		tst_brkm TBROK "useradd failed"
>> +	fi
>> +
>> +	useradd ltp_test
>> +	if [ $? -ne 0 ]&&  [ ! -d /home/ltp_test ]; then
>> +		tst_brkm TBROK "useradd failed"
>> +	fi
>> +}
>> +
>> +cleanup()
>> +{
>> +	userdel -r ltp_init
>> +	if [ $? -ne 0 ]&&  [ -d /home/ltp_test ]; then
>> +		tst_brkm TBROK "userdel -r failed"
>> +	fi
>> +
>> +	userdel -r ltp_test
>> +	if [ $? -ne 0 ]&&  [ -d /home/ltp_test ]; then
>> +		tst_brkm TBROK "userdel -r failed"
>> +	fi
>> +
>> +	tst_rmdir
>> +}
>> +
>> +passwd_test()
>> +{
>> +	local pw_cmd="$1 $2 $3"
>> +	local opt="$2"
>> +	local check_opt="$4 $3 $5"
>> +
>> +	eval $pw_cmd>  temp1 2>&1
>> +	if [ $? -ne 0 ]; then
>> +		grep -q -E "unrecognized option|invalid option|unknown option" temp1
>> +		if [ $? -eq 0 ]; then
>> +			tst_resm TCONF "$pw_cmd not supported"
>> +		else
>> +			tst_resm TFAIL "$pw_cmd failed"
>> +		fi
>> +		return
>> +	fi
>> +
>> +	if [ $# -ge 4 ]; then
>> +		su ltp_init -c "check_passwd ltp_init $check_opt">  temp2 2>&1
>> +
>> +		if [ $? -eq 0 ]; then
>> +			grep -q "test passes as expected" temp2
>> +			if [ $? -ne 0 ]; then
>> +				tst_resm TFAIL "passwd failed with $opt option."
>> +				return
>> +			fi
>> +		else
>> +			tst_resm TFAIL "passwd failed with $opt option."
>> +			return
>> +		fi
> Why can't we just trust the exit value here and fail the test when it
> was anything else than 0?
>
>> +	fi
>> +
>> +	tst_resm TPASS "passwd passed with $opt option."
>> +}
>> +
>> +setup
>> +
>> +passwd_test "passwd" "-d" "ltp_test" "0"
>> +passwd_test "echo test | passwd" "--stdin" "ltp_test" "1" "test"
>> +passwd_test "passwd" "-l" "ltp_test" "2" "test"
>> +passwd_test "passwd" "-u" "ltp_test" "1" "test"
>> +passwd_test "passwd" "--lock" "ltp_test" "2" "test"
>> +passwd_test "passwd" "--unlock" "ltp_test" "1" "test"
>> +passwd_test "passwd" "--delete" "ltp_test" "0"
>> +passwd_test "passwd" "-S" "ltp_test"
>> +passwd_test "passwd" "--status" "ltp_test"
>> +passwd_test "passwd" "--help"
>> +passwd_test "passwd" "--usage"
>> +
>> +tst_exit
>> -- 
>> 1.8.3.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



