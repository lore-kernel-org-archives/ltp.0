From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 11 Jul 2017 19:48:33 +0800
Subject: [LTP] [PATCH 1/3] commands/keyctl01: Fix potential infinite loop
In-Reply-To: <20170707125546.GB28534@rei.lan>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170707125546.GB28534@rei.lan>
Message-ID: <f5e0db40-9fac-13d9-8ecf-5ecaab9e6131@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

Thanks for your review.

在 07/07/2017 08:55 PM, Cyril Hrubis 写道:
> Hi!
>> diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
>> index 076a130..5a97499 100644
>> --- a/testcases/commands/keyctl/keyctl01.sh
>> +++ b/testcases/commands/keyctl/keyctl01.sh
>> @@ -62,15 +62,17 @@ cleanup()
>>  
>>  do_test()
>>  {
>> +	local quota_excd=0
>>  	local maxkeysz=$((ORIG_KEYSZ + 100))
>>  
>> -	while true
>> +	while [ $maxkeysz -gt $ORIG_KEYSZ ]
> 
> This may still be incorrect if some keys has been deleted after we
> executed the setup() function though. This is quite unlikely but still
> may happen. What about we ended the loop once $maxkeysz < 0?

Yes, it sounds more reasonable,
I got it, thanks.

Best Regards,
Guangwen Feng

> 
> Otherwise it looks fine.
> 


