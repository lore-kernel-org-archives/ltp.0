From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2015 14:33:18 +0100
Subject: [LTP] [PATCH] commands/which: Added new testcase to test
 which(1).
In-Reply-To: <1448538955-1588-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1448538955-1588-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20151203133318.GE29110@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +setup()
> +{
> +	tst_require_root

Do we really need root for the test?

> +	tst_check_cmds which
> +
> +	tst_tmpdir
> +
> +	TST_CLEANUP="cleanup"
> +
> +	touch programname
> +	chmod +x programname
> +	PATH=$PATH:.
> +
> +	mkdir bin
> +	touch bin/programname
> +	chmod +x bin/programname
> +	PATH=$PATH:./bin
> +
> +	alias programname='programname -i'
> +}
> +
> +cleanup()
> +{
> +	tst_rmdir
> +}
> +
> +which_verify()
> +{
> +	local which_op=$1
> +	local prog_name=$2
> +
> +	if [ -z "$which_op" ]; then
> +		grep -q `pwd`/"$prog_name" temp
> +		if [ $? -ne 0 ]; then
> +			return 1
> +		fi
> +	elif [ "$which_op" = "--all" ] || [ "$which_op" = "-a" ]; then
> +		grep -q `pwd`/"$prog_name" temp
> +		if [ $? -ne 0 ]; then
> +			return 1
> +		fi
> +		grep -q `pwd`/bin/"$prog_name" temp
> +		if [ $? -ne 0 ]; then
> +			return 1
> +		fi
> +	elif [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ]; then
> +		grep -q "programname='programname -i'" temp
> +		if [ $? -ne 0 ]; then
> +			return 1
> +		fi
> +		grep -q `pwd`/"$prog_name" temp
> +		if [ $? -ne 0 ]; then
> +			return 1
> +		fi
> +	elif [ "$which_op" = "--skip-alias" ]; then
> +		grep -q "programname='programname -i'" temp
> +		if [ $? -eq 0 ]; then
> +			return 1
> +		fi
> +		grep -q `pwd`/"$prog_name" temp
> +		if [ $? -ne 0 ]; then
> +			return 1
> +		fi
> +	fi

Again, why don't we rather pass the expected paths as the parameters to
the which_test function? For example:

which_test "-a" "programname" "$PWD/programname" $PWD/bin/programname"

Then we will do shift twice in the which_test() and loop over the rest
of the $@ doing grep in the temp for each iteration.

-- 
Cyril Hrubis
chrubis@suse.cz
