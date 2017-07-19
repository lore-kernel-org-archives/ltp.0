From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 19 Jul 2017 11:42:39 +0800
Subject: [LTP] [PATCH v2 3/3] commands/keyctl01: Check keyctl support
 instead of kernel version
In-Reply-To: <20170718132719.GA22620@rei.lan>
References: <20170717114235.GB11059@rei.lan>
 <20170718063144.18856-1-fenggw-fnst@cn.fujitsu.com>
 <20170718063144.18856-3-fenggw-fnst@cn.fujitsu.com>
 <20170718132719.GA22620@rei.lan>
Message-ID: <f659c98f-f3bc-72f8-0c51-14dc956beba8@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi!

在 07/18/2017 09:27 PM, Cyril Hrubis 写道:
> Hi!
> I've pushed the first two patches, thanks.

Thanks!

> 
>>  setup()
>>  {
>> -	if tst_kvcmp -le 2.6.33; then
>> -		tst_brk TCONF "Kernel newer than 2.6.33 is needed"
>> +	keyctl 2>&1 | tr '\n' ' ' | grep "request2" | grep "negate" | \
>> +		grep "show" | grep "unlink" >/dev/null
> 
> Uh, what are we grepping here for exactly?

We need to check the keyctl operations "request2", "negate",
"show", "unlink" are all available...

> Can't we do that with a single regular expression?

Yes, we can do:

keyctl 2>&1 | sort | tr '\n' ' ' | grep -P "\bnegate\b.*\brequest2\b.*\bshow\b.*\bunlink\b" >/dev/null


Best Regards,
Guangwen Feng

> 
>> +	if [ $? -ne 0 ]; then
>> +		tst_brk TCONF "keyctl operations not supported"
>>  	fi
>>  
>>  	PATH_KEYSTAT="/proc/key-users"
>> -- 
>> 2.9.4
>>
>>
>>
> 


