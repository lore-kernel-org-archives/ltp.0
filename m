From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 7 May 2018 15:30:57 +0800
Subject: [LTP] [PATCH 1/3] lib/tst_net.sh: Append 6 to the end of
	$TST_OPTS
In-Reply-To: <20180507064343.ahqhsbadjpho2xry@dell5510>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180507064343.ahqhsbadjpho2xry@dell5510>
Message-ID: <5AF000B1.9070106@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/05/07 14:43, Petr Vorel wrote:
> Hi,
>
>> If the first character of optstring is set to a colon(tcp_fastopen_run.sh,
>> nfs_lib.sh), getopts should be in silent mode rather than process it as
>> an argument of 6.
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   testcases/lib/tst_net.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
>> index 3a0fe01..32b4f09 100644
>> --- a/testcases/lib/tst_net.sh
>> +++ b/testcases/lib/tst_net.sh
>> @@ -19,7 +19,7 @@
>>   # Author: Alexey Kodanev<alexey.kodanev@oracle.com>
>
>> -TST_OPTS="6$TST_OPTS"
>> +TST_OPTS="${TST_OPTS}6"
>>   TST_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
>>   TST_PARSE_ARGS="tst_net_parse_args"
>>   TST_USAGE_CALLER="$TST_USAGE"
> Acked-by: Petr Vorel<pvorel@suse.cz>
>
> Good catch. Although I propose to get rid of ':' at the beginning for users of new shell
> API (as it's IMHO better to see errors).
Hi Petr,

If getopts is in silent mode,  the invalid option is  placed  in OPTARG, 
so we can see errors by printing
the value of OPTARG.  But it is reasonable for me to get rid of ':' at 
the beginning of optstring. :-)

Thanks,
Xiao Yang
>
> Kind regards,
> Petr
>
>
> .
>



