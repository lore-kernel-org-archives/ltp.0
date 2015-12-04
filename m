From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 4 Dec 2015 15:50:38 +0800
Subject: [LTP] [PATCH] commands/which: Added new testcase to test
	which(1).
In-Reply-To: <20151203133318.GE29110@rei.lan>
References: <1448538955-1588-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20151203133318.GE29110@rei.lan>
Message-ID: <566145CE.8070004@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Thanks for your review!

On 2015/12/03 21:33, Cyril Hrubis wrote:
> Hi!
>> +setup()
>> +{
>> +	tst_require_root
> 
> Do we really need root for the test?
> 

It's not necessary indeed, I'll drop it.

>> +	tst_check_cmds which
>> +
>> +	tst_tmpdir
>> +
>> +	TST_CLEANUP="cleanup"
>> +
>> +	touch programname
>> +	chmod +x programname
>> +	PATH=$PATH:.
>> +
>> +	mkdir bin
>> +	touch bin/programname
>> +	chmod +x bin/programname
>> +	PATH=$PATH:./bin
>> +
>> +	alias programname='programname -i'
>> +}
>> +
>> +cleanup()
>> +{
>> +	tst_rmdir
>> +}
>> +
>> +which_verify()
>> +{
>> +	local which_op=$1
>> +	local prog_name=$2
>> +
>> +	if [ -z "$which_op" ]; then
>> +		grep -q `pwd`/"$prog_name" temp
>> +		if [ $? -ne 0 ]; then
>> +			return 1
>> +		fi
>> +	elif [ "$which_op" = "--all" ] || [ "$which_op" = "-a" ]; then
>> +		grep -q `pwd`/"$prog_name" temp
>> +		if [ $? -ne 0 ]; then
>> +			return 1
>> +		fi
>> +		grep -q `pwd`/bin/"$prog_name" temp
>> +		if [ $? -ne 0 ]; then
>> +			return 1
>> +		fi
>> +	elif [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ]; then
>> +		grep -q "programname='programname -i'" temp
>> +		if [ $? -ne 0 ]; then
>> +			return 1
>> +		fi
>> +		grep -q `pwd`/"$prog_name" temp
>> +		if [ $? -ne 0 ]; then
>> +			return 1
>> +		fi
>> +	elif [ "$which_op" = "--skip-alias" ]; then
>> +		grep -q "programname='programname -i'" temp
>> +		if [ $? -eq 0 ]; then
>> +			return 1
>> +		fi
>> +		grep -q `pwd`/"$prog_name" temp
>> +		if [ $? -ne 0 ]; then
>> +			return 1
>> +		fi
>> +	fi
> 
> Again, why don't we rather pass the expected paths as the parameters to
> the which_test function? For example:
> 
> which_test "-a" "programname" "$PWD/programname" $PWD/bin/programname"
> 
> Then we will do shift twice in the which_test() and loop over the rest
> of the $@ doing grep in the temp for each iteration.
> 

Yeah, it sounds better, I'll rewrite this according to your suggestion.

Best Regards,
Guangwen Feng


