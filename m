From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 24 Aug 2021 14:35:29 +0300
Subject: [LTP] [PATCH 2/3] network/tst_net.sh: fix busybox/sysctl in
 tst_set_sysctl()
In-Reply-To: <YR+HXE01R1RE8TTH@pevik>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
 <20210804120446.32835-2-aleksei.kodanev@bell-sw.com> <YR+HXE01R1RE8TTH@pevik>
Message-ID: <48500320-6cc6-591a-fc3d-708e88fd8640@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20.08.2021 13:43, Petr Vorel wrote:
> Hi Alexey,
> 
>> busybox/sysctl expects -e option to be set before 'name=value'.
>> This can easily be fixed by splitting the string in tst_set_sysctl(),
>> so that 'rparam' with '-e' option is added in between.
> Good catch.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> ...
>> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
>> index 511fb7eb1..bb30c13ec 100644
>> --- a/testcases/lib/tst_net.sh
>> +++ b/testcases/lib/tst_net.sh
>> @@ -918,7 +918,7 @@ tst_set_sysctl()
>>  	local rparam=
>>  	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"
> 
>> -	tst_net_run $safe $rparam "sysctl -q -w $name=$value"
>> +	tst_net_run $safe $rparam "sysctl -q -w" "$name=$value"
> 
> I wonder if it were a bit clearer if we moves all params to second arg:
> 	tst_net_run $safe "sysctl" "$name=$value -q -w"

OK, but changed to "sysctl" "-q -w $name=$value" because the other
options should also be placed before the key/value pair:

    Usage: sysctl -p [-enq] [FILE...] / [-enqaw] [KEY[=VALUE]]...


Thanks for review Petr! Applied the patches.
