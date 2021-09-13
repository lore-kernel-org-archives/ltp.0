From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 13 Sep 2021 10:40:20 +0200
Subject: [LTP] [PATCH ltp v2] IMA: Add tests for uid, gid, fowner,
 and fgroup options
In-Reply-To: <20210910164448.28302-1-alexh@vpitech.com>
References: <20210910164448.28302-1-alexh@vpitech.com>
Message-ID: <YT8OdIYtP/FaC52z@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alex,

> Requires "ima: add gid support".

> v2:
> - Add sudo to list of required commands
> - Check policy writability
> - Check kernel version
> - Use `sudo sg` to test the gid option
> - Don't try to restore the original policy after testing

...
> -	check_policy_writable
> +	require_policy_writable
Good point to fix function name. But could you please do the rename and move to
ima_setup.sh in separate commit?

Also, why do you extending test3()? Wouldn't be more readable to add test4()?
See notes below.

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
...
> -TST_NEEDS_CMDS="awk cut sed"
> +TST_NEEDS_CMDS="awk cut sed sg sudo"
I'm sorry, I was wrong. sudo is needed just in the last test, thus
original check "tst_check_cmds sudo || return" is enough.
Having it TST_NEEDS_CMDS it requires it also for old kernels, which is necessary.

chgrp and sg you newly introduced, should be also tested by tst_check_cmds,
after checking kernel version.

>  TST_SETUP="setup"
>  TST_CNT=3
>  TST_NEEDS_DEVICE=1
> @@ -20,6 +20,8 @@ setup()
>  	TEST_FILE="$PWD/test.txt"
>  	POLICY="$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> +
> +	require_policy_writable
This changes test to require CONFIG_IMA_WRITE_POLICY=y. Most distributions does
not have it, thus you'd disable testing for most distros. Not having policy
readable and writeable everywhere greatly complicates IMA testing.
...
>  }

> @@ -103,7 +105,7 @@ test3()
>  	local file="$dir/test.txt"

>  	# Default policy does not measure user files
> -	tst_res TINFO "verify not measuring user files"
> +	tst_res TINFO "verify not measuring user files by default"
>  	tst_check_cmds sudo || return

>  	if ! id $user >/dev/null 2>/dev/null; then
> @@ -116,9 +118,38 @@ test3()
>  	cd $dir
>  	# need to read file to get updated $ASCII_MEASUREMENTS
>  	sudo -n -u $user sh -c "echo $(date) user file > $file; cat $file > /dev/null"
> +	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
>  	cd ..

> -	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
> +	tst_res TINFO "verify measuring user files when requested via uid"
> +	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
This is the reason for require_policy_writable.
Previously it was possible to run it without:

ima_measurements 1 TPASS: correct digest found
ima_measurements 2 TINFO: verify updating record in the IMA measurement list
ima_measurements 2 TINFO: computing digest for sha256 algorithm
ima_measurements 2 TPASS: correct digest found
ima_measurements 3 TINFO: verify not measuring user files
ima_measurements 3 TPASS: grep /tmp/LTP_ima_measurements.6nhS7ScgBn/user/test.txt /sys/kernel/security/ima/ascii_runtime_measurements failed as expected

I'd keep the old EXPECT_FAIL variant (suppose it's still valid and don't require
writable policy) and definitely separate new tests.
Remember, test should run the same on older kernels (we don't want to drop
coverage on older distros / enterprise distros).

> +	ROD echo "$(date) uid test" \> $TEST_FILE
> +	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
> +	ima_check
> +
> +	tst_res TINFO "verify measuring user files when requested via fowner"
> +	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
> +	ROD echo "$(date) fowner test" \> $TEST_FILE
> +	chown $user $TEST_FILE
> +	cat $TEST_FILE > /dev/null
> +	ima_check
> +
> +	if tst_kvcmp -lt 5.15; then
> +		tst_brk TCONF "gid and fgroup options require kernel 5.15 or newer"
> +	fi
> +
> +	tst_res TINFO "verify measuring user files when requested via gid"
> +	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
> +	ROD echo "$(date) gid test" \> $TEST_FILE
> +	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
> +	ima_check
> +
> +	tst_res TINFO "verify measuring user files when requested via fgroup"
> +	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
> +	ROD echo "$(date) fgroup test" \> $TEST_FILE
> +	chgrp $user $TEST_FILE
> +	cat $TEST_FILE > /dev/null
> +	ima_check
>  }
...

Kind regards,
Petr
