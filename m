From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 13 Jul 2017 20:15:33 +0800
Subject: [LTP] [PATCH 2/3] commands/keyctl01: Fix getting key serial
 number
In-Reply-To: <ffc2e37b-0464-f2f5-4757-a4378b48f501@cn.fujitsu.com>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1494483656-15971-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170707130827.GC28534@rei.lan>
 <50b2e9a3-bf31-1765-c2e8-9487f7d09fa3@cn.fujitsu.com>
 <ffc2e37b-0464-f2f5-4757-a4378b48f501@cn.fujitsu.com>
Message-ID: <42df2a59-d9de-30dd-2aa7-486dba24452e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

在 07/13/2017 06:55 PM, Guangwen Feng 写道:
> Hi!
> 
> 在 07/11/2017 08:27 PM, Guangwen Feng 写道:
>> Hi!
>>
>> Thanks for your review.
>>
>> 在 07/07/2017 09:08 PM, Cyril Hrubis 写道:
>>> Hi!
>>>> So fix this by adding a match with "inaccessible".
>>>>
>>>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>>>> ---
>>>>  testcases/commands/keyctl/keyctl01.sh | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
>>>> index 5a97499..8ea2b25 100644
>>>> --- a/testcases/commands/keyctl/keyctl01.sh
>>>> +++ b/testcases/commands/keyctl/keyctl01.sh
>>>> @@ -77,6 +77,11 @@ do_test()
>>>>  		fi
>>>>  
>>>>  		local key=`keyctl show | awk '/debug:fred/ {print $1}'`
>>>> +		if [ -z "$key" ]; then
>>>> +			key=`keyctl show | \
>>>> +				awk -F ':' '/inaccessible/ {print $1}'`
>>>> +		fi
>>>
>>> Can't we rather split the keyctl request and keyctl negate operations
>>> into two and get the key after the key has been requested but before it
>>> was negated?
>>>
>>> Or is it required to do the request and negate operation in a signle
>>> keyctl command in order to reproduce the kernel crash?
>>
>> I think it is required to do the operations in one command...
>> I will try to split them and reproduce the kernel crash, thanks.
> 
> Without using a single keyctl command, this bug cannot be triggered,
> so I want to keep it this way.
> 
> I think the problem is that we cannot get the keyid by matching
> "debug:fred" via "keyctl show" when the key is expired, I find that
> in /proc/keys even the key is expired, we can still see the key's
> description, so we can just look it up this way.

Sorry, but there are also some old kernels like 2.6.18-398.el5 do not
show user key in /proc/keys: 

[root@rhel5 ~]# cat /proc/keys
00000001 I-----     1 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
00000002 I-----     3 perm 1f3f0000     0     0 keyring   _uid.0: empty
039d3f23 I--Q--     3 perm 1f3f0000     0     0 keyring   _ses.2742: 6/8
                                                                     ^
                                                        6 keys in this keyring

It only shows how many keys in a keyring, so this is unreliable...

Can we just use "keyctl show" to match "inaccessible" when this
happens?


Best Regards,
Guangwen Feng

> 
> I will send a V2 soon.
> 
> Best Regards,
> Guangwen Feng
> 
>>
>> Best Regards,
>> Guangwen Feng
>>
>>>
>>>>  		if [ -n "$key" ]; then
>>>>  			keyctl unlink $key @s >/dev/null
>>>>  			tst_sleep 50ms
>>>> -- 
>>>> 1.8.4.2
>>>>
>>>>
>>>>
>>>>
>>>> -- 
>>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>>
>>
>>
>>
> 
> 
> 


