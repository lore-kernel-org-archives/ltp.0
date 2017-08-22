From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Aug 2017 15:09:53 +0200
Subject: [LTP] [PATCH] [dynamic debug] - Check interface and
	functionality
In-Reply-To: <20170822102244.6266-1-vkabatov@redhat.com>
References: <20170822102244.6266-1-vkabatov@redhat.com>
Message-ID: <20170822130953.GA23381@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# Test description: Test functionality of dynamic debug feature by enabling
> +#                   and disabling traces with available flags. Check that these
> +#                   settings don't cause issues by searching dmesg.
> +#
> +#                   This test handles changes of dynamic debug interface from
> +#                   commits 5ca7d2a6 (dynamic_debug: describe_flags with
> +#                   '=[pmflt_]*') and 8ba6ebf5 (Dynamic debug: Add more flags)
> +#
> +# Usage
> +# ./dynamic_debug01.sh
> +
> +TST_TESTFUNC=ddebug_test
> +TST_NEEDS_CMDS="awk"
> +TST_NEEDS_TMPDIR=1
> +TST_NEEDS_ROOT=1
> +TST_SETUP=setup
> +TST_CLEANUP=cleanup
> +
> +. tst_test.sh
> +
> +
> +DEBUGFS_WAS_MOUNTED=0
> +DEBUGFS_PATH=""
> +DEBUGFS_CONTROL=""
> +DYNDEBUG_STATEMENTS="./debug_statements"
> +EMPTY_FLAG=""
> +NEW_INTERFACE=0
> +
> +
> +mount_debugfs()
> +{
> +	if grep -q debugfs /proc/mounts ; then
> +		DEBUGFS_WAS_MOUNTED=1
> +		DEBUGFS_PATH=$(grep debugfs /proc/mounts | awk '{print $2}')
                                    ^
				  $(awk /debugfs/ '{print $2}' /proc/mounts)


> +		tst_res TINFO "debugfs already mounted at $DEBUGFS_PATH"
> +	else
> +		if ! grep -q debugfs /proc/filesystems ; then
> +			tst_res TCONF "debugfs not supported"
> +		fi
> +		DEBUGFS_PATH="$(pwd)/tst_debug"
                                  ^
				$PWD/tst_debug

Or we may as well use relative path i.e. just ./tst_debugfs/

> +		mkdir "$DEBUGFS_PATH"
> +		if mount -t debugfs xxx "$DEBUGFS_PATH" ; then
> +			tst_res TINFO "debugfs mounted at $DEBUGFS_PATH"
> +		else
> +			tst_res TFAIL "Unable to mount debugfs"
> +		fi
> +	fi
> +}
> +
> +setup()
> +{
> +	if tst_kvcmp -lt 2.6.30 ; then
> +		tst_brk TCONF "Dynamic debug is available since version 2.6.30"
> +	fi
> +
> +	mount_debugfs
> +	if [ ! -d "$DEBUGFS_PATH/dynamic_debug" ] ; then
> +		tst_res TBROK "Unable to find $DEBUGFS_PATH/dynamic_debug"
                ^
		tst_brk?
> +	fi
> +	DEBUGFS_CONTROL="$DEBUGFS_PATH/dynamic_debug/control"
> +	if [ ! -e "$DEBUGFS_CONTROL" ] ; then
> +		tst_res TBROK "Unable to find $DEBUGFS_CONTROL"
                ^
		here as well?
> +	fi
> +
> +	# Both patches with changes were backported to RHEL6 kernel 2.6.32-547
> +	if tst_kvcmp -ge '3.4 RHEL6:2.6.32-547' ; then
> +		NEW_INTERFACE=1
> +	fi
> +
> +	EMPTY_FLAG=$([ $NEW_INTERFACE -eq 1 ] && echo "=_" || echo "-")

Now, why don't we set empty flag to the old value on the top and set it
to the new value in the if that sets the NEW_INTERFACE variable.

We could even use the EMPTY_FLAG content in the conditions below, but I
guess that having NEW_INTERFACE variable is more readable.

> +	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
> +}
> +
> +do_flag()
> +{
> +	FLAG="$1"
> +	OPTION_TO_SET="$2"
> +	OPTION_VALUE="$3"

It would be a sligtly better to declare these variables as local.

> +	if ! echo "$OPTION_TO_SET $OPTION_VALUE $FLAG" > \
> +		"$DEBUGFS_CONTROL" ; then
> +		tst_res TFAIL "Setting '$OPTION_TO_SET $OPTION_VALUE " \
> +			"$FLAG' failed with $?!"
> +	fi

We do have EXPECT_PASS and EXPECT_FAIL functions in the test library:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#expect_pass-and-expect_fail

> +}
> +
> +do_all_flags()
> +{
> +	OPTION="$1"
> +	ALL_INPUTS="$2"
> +
> +	echo "$ALL_INPUTS" | while read -r INPUT_LINE ; do

You can do just for input_line in $ALL_INPUTS; do here instead, the
newlines were converted to spaces once the output from the awk/sort/uniq
pipeline was assigned into a variable.

> +		do_flag "+p" "$OPTION" "$INPUT_LINE"
> +		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
> +			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
> +			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
> +		fi
> +		do_flag "-p" "$OPTION" "$INPUT_LINE"
> +	done
> +
> +	if awk -v emp="$EMPTY_FLAG" '$3 != emp' "$DEBUGFS_CONTROL" \
> +		| grep -v -q "^#" ; then
> +		tst_res TFAIL "Failed to remove all set flags"
> +	fi
> +
> +}
> +
> +ddebug_test()
> +{
> +	dmesg > ./dmesg.old
> +
> +	DD_FUNCS=$(awk -F " |]" '{print $3}' "$DYNDEBUG_STATEMENTS" \
> +		| sort | uniq)
> +	DD_FILES=$(awk -F " |:" '{print $1}' "$DYNDEBUG_STATEMENTS" \
> +		| sort | uniq)
> +	DD_LINES=$(awk -F " |:" '{print $2}' "$DYNDEBUG_STATEMENTS" \
> +		| sort | uniq)
> +	DD_MODULES=$(awk -F [][] '{print $2}' "$DYNDEBUG_STATEMENTS" \
> +		| sort | uniq)
> +
> +	do_all_flags "func" "$DD_FUNCS"
> +	do_all_flags "file" "$DD_FILES"
> +	do_all_flags "line" "$DD_LINES"
> +	do_all_flags "module" "$DD_MODULES"
> +
> +	dmesg > ./dmesg.new
> +	sed -i -e 1,`wc -l < ./dmesg.old`d ./dmesg.new
> +	if grep -q -e "Kernel panic" -e "Oops" -e "general protection fault" \
> +		-e "general protection handler: wrong gs" -e "\(XEN\) Panic" \
> +		-e "fault" -e "warn" -e "BUG" ./dmesg.new ; then
> +		tst_res TFAIL "Issues found in dmesg!"
> +	else
> +		tst_res TPASS "Dynamic debug OK"
> +	fi
> +}
> +
> +cleanup()
> +{
> +	if [ $DEBUGFS_WAS_MOUNTED -eq 0 ] ; then
> +		tst_umount "$DEBUGFS_PATH"
> +	else
> +		FLAGS_SET=$(awk -v emp="$EMPTY_FLAG" '$3 != emp' \
> +			$DYNDEBUG_STATEMENTS)
> +		if [ "$FLAGS_SET" ] ; then
> +			FLAG_PREFIX=$([ $NEW_INTERFACE -eq 1 ] \
> +				&& echo "" || echo "+")
> +			echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
> +				echo -n "$FLAG_LINE" \
> +					| awk -v prf="$FLAG_PREFIX" -F " |:" \
> +					'{print "file "$1" line "$2" "prf $4}' \
> +					> "$DEBUGFS_CONTROL"
> +			done
> +		fi
> +	fi

I wonder if we should attempt to restore the values even if debugfs
wasn't mounted and then umount it if it wasn't mounted once we are done.

On my machine I have 45 values set to =p by default, although debugfs is
mounted there...

> +}
> +
> +tst_run

-- 
Cyril Hrubis
chrubis@suse.cz
