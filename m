From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 9 May 2018 19:01:57 +0800
Subject: [LTP] [RFC PATCH 1/1] net/ipsec: Fix getopts parsing -s
	parameter
In-Reply-To: <20180508075025.kiwhybpeticscmbh@dell5510>
References: <20180507193234.6810-1-pvorel@suse.cz>
 <20180507193234.6810-2-pvorel@suse.cz> <5AF11310.1010509@cn.fujitsu.com>
 <20180508075025.kiwhybpeticscmbh@dell5510>
Message-ID: <5AF2D525.7090401@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/05/08 15:50, Petr Vorel wrote:
> Hi Xiao,
>
>> On 2018/05/08 3:32, Petr Vorel wrote:
>>> legacy API in tst_net.sh is not able to detect quoted parameters,
>>> because input parameters for getopts are passing as '$*' to tst_net_read_opts.
>>> This drops quotes so only first number from -s is taken.
>>> The solution is to use ':' as array separator.
>> Hi Petr,
>> Can we solve this issue by passing "$@" to tst_net_read_opts, as below:
>> ---------------------------------------------------------------------------
>> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
>> index 32b4f09..df850a0 100644
>> --- a/testcases/lib/tst_net.sh
>> +++ b/testcases/lib/tst_net.sh
>> @@ -78,7 +78,7 @@ if [ -z "$TST_LIB_LOADED" ]; then
>> fi
>> if [ -n "$TST_USE_LEGACY_API" ]; then
>> - tst_net_read_opts $*
>> + tst_net_read_opts "$@"
>> ipver=${TST_IPV6:-4}
>> fi
>> ----------------------------------------------------------------------------
> Thank you for the fix. This is much simpler =>  better as fix.
> Unless anyone objects, I'll apply it on Wednesday.
>
> Actually missing quotes caused that (i.e. working: "$*" or "$@", not working: $* or $@), I
> got into common trap of different behavior with/without quotes as I tested only both variants
> without quotes. Using "$@" instead of "$*" is IMHO better, as it's similar to new API in
> tst_test.sh.
>
> Either I miss something in the new API, or it'll need to be changed for new API anyway:
Hi Petr,

It seems that "$@" is treated as an array by default, and declaring 
TST_ARGS as an array could fix this issue.

Thanks,
Xiao Yang
> $ df01.sh -f ext2 -s "100 500 1000"
> df01 1 TINFO: parse_args: 1:'s', 2:'100' (@:'s 100')
> ...
>
> Tested with following patch:
> ---
> diff --git testcases/commands/df/df01.sh testcases/commands/df/df01.sh
> index fbf1e2f2a..08e2af9de 100755
> --- testcases/commands/df/df01.sh
> +++ testcases/commands/df/df01.sh
> @@ -20,7 +20,7 @@ TST_CNT=12
>   TST_SETUP=setup
>   TST_CLEANUP=cleanup
>   TST_TESTFUNC=test
> -TST_OPTS="f:"
> +TST_OPTS="f:s:"
>   TST_USAGE=usage
>   TST_PARSE_ARGS=parse_args
>   TST_NEEDS_ROOT=1
> @@ -44,7 +44,10 @@ FS_TYPE=ext2
>
>   parse_args()
>   {
> -	FS_TYPE="$2"
> +	case $1 in
> +	s) tst_res TINFO "parse_args: 1:'$1', 2:'$2' (@:'$@')";;
> +	f) FS_TYPE="$2";;
> +	esac
>   }
>
>   setup()
> ---
>
>> Thanks,
>> Xiao Yang
>
> Kind regards,
> Petr
>
>
> .
>



