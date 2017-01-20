From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 20 Jan 2017 19:14:03 +0300
Subject: [LTP] [PATCH 3/3] test_net.sh: netns as default in tst_rhost_run
In-Reply-To: <20170119175049.de6ocki7ebyxnbpa@x230>
References: <20161221230422.26696-1-pvorel@suse.cz>
 <20161221230422.26696-3-pvorel@suse.cz>
 <20170119175049.de6ocki7ebyxnbpa@x230>
Message-ID: <5375d1aa-9d0c-884d-6c54-03019847bd6d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 01/19/2017 08:50 PM, Petr Vorel wrote:
>>   	local output=
>>   	local ret=0
>> -	if [ -n "$TST_USE_SSH" ]; then
>> -		output=`ssh -n -q $user@$RHOST "sh -c \
>> -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
>> -	elif [ -n "$TST_USE_NETNS" ]; then
>> +	if [ -n "$TST_USE_NETNS" ]; then
>>   		output=`$LTP_NETNS sh -c \
>>   			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
>> +	elif [ -n "$TST_USE_SSH" ]; then
>> +		output=`ssh -n -q $user@$RHOST "sh -c \
>> +			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
>>   	else
>>   		output=`rsh -n -l $user $RHOST "sh -c \
>>   			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> How about this patch? (just this one, please ignore 1st and 2nd) NACK?

With this patch, if user wants to use ssh (explicitly set this variable) 
but forgot
to set remote host variable, the test will continue with netns and the user
might not even notice it.

Thanks,
Alexey
