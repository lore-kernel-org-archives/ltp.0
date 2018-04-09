From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Apr 2018 15:14:47 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add test cmd helper
 tst_test_cmds()
In-Reply-To: <20180406064204.9252-1-pvorel@suse.cz>
References: <20180406064204.9252-1-pvorel@suse.cz>
Message-ID: <20180409131447.GC26048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  doc/test-writing-guidelines.txt | 17 +++++++++++++++++
>  testcases/lib/tst_test.sh       | 22 ++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index cbbfe6c0f..bf59a178c 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1519,6 +1519,23 @@ existence each of them and exits the test with 'TCONF' on first misssing.
>  Alternatively the 'tst_check_cmds()' function can be used to do the same on
>  runtime, since sometimes we need to the check at runtime too.
>  
> +'tst_test_cmds()' can be used for requirements just for a particular test
> +as it doesn't exit. Supposed usage is:
                         ^
			 Expected

Also we really should say that the call will issue TCONF here, because
it's not clear that it would.

> +...
> +
> +TST_TESTFUNC=do_test
> +. tst_test.sh
> +
> +do_test()
> +{
> +	tst_test_cmds cmd || return
> +	cmd --foo
> +	...
> +}
> +
> +tst_run
> +...
> +
>  Locating kernel modules
>  +++++++++++++++++++++++
>  
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 48afb9cc4..5ebe32edf 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -201,12 +201,30 @@ tst_mkfs()
>  	ROD_SILENT mkfs.$fs_type $fs_opts $device
>  }
>  
> +tst_cmd_available()
> +{
> +	if type command > /dev/null 2>&1; then
> +		command -v $1 > /dev/null 2>&1 || return 1
> +	else
> +		which $1 > /dev/null 2>&1 || return 1
> +	fi
> +}

We are falling back to which if command is not available here?

Are you aware of any shell that is lacking command?

Also we should probably add return 0 at the end of the function, as it
is the code is correct, since the return value would be return value of
the last executed line, which is guaranteed to be 0 because of the
|| return 1 but it's kind of confusing to omit it.

>  tst_check_cmds()
>  {
>  	local cmd
>  	for cmd in $*; do
> -		if ! command -v $cmd > /dev/null 2>&1; then
> -			tst_brk TCONF "'$cmd' not found"
> +		tst_cmd_available $cmd || tst_brk TCONF "'$cmd' not found"
> +	done
> +}
> +
> +tst_test_cmds()
> +{
> +	local cmd
> +	for cmd in $*; do
> +		if ! tst_cmd_available $cmd; then
> +			tst_res TCONF "'$cmd' not found"
> +			return 1
>  		fi
>  	done
>  }

Here as well, explicit return 0 will help code readability a bit.

-- 
Cyril Hrubis
chrubis@suse.cz
