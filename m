From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 19 Mar 2020 13:10:06 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/fcntl30: clean up && add more
 range test
In-Reply-To: <20200318110212.GA1690@haruka.lan>
References: <20200127162016.GD30831@rei.lan>
 <1580969073-27367-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200221160351.GA26393@rei.lan>
 <8d1a7c73-7122-2c3d-6a73-024bed066966@cn.fujitsu.com>
 <20200224142034.GA2210@rei>
 <1d62bf3e-3f34-fd05-8662-08ff16523673@cn.fujitsu.com>
 <9e73a02e-7169-7229-8bc0-2ac84129bf31@cn.fujitsu.com>
 <20200318110212.GA1690@haruka.lan>
Message-ID: <0bde87a1-c4c4-c9fc-4656-cfcc0ed262a5@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>> Ping.
>> diff as below:
>> diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c
>> b/testcases/kernel/syscalls/fcntl/fcntl30.c
>> index 860d42e8d..28cdee165 100644
>> --- a/testcases/kernel/syscalls/fcntl/fcntl30.c
>> +++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
>> @@ -31,8 +31,7 @@ static struct tcase {
>>           {0, 0, 0, 1, "set a value of below page size"},
>>           {0, 0, 0, 1, "set a normal value"},
>>           {0, 0, 1, 1, "set a value of below page size"},
>> -       {0, 0, 1, 1, "set a normal value"},
>> -       {0, 0, 1, 1, "set a max value"},
>> +       {0, 0, 1, 1, "set a normal value(8M)"},
>>           {0, 0, 1, 0, "set a value beyond max"},
>>    };
>>
>> @@ -145,13 +144,10 @@ static void setup(void)
>>           tcases[2].setsize = (1 << pg_shift) - 1;
>>           tcases[2].expsize = 1 << pg_shift;
>>
>> -       tcases[3].setsize = 2 << pg_shift;
>> -       tcases[3].expsize = 2 << pg_shift;
>> +       tcases[3].setsize = 1 << 23;
>> +       tcases[3].expsize = 1 << 23;
>>
>> -       tcases[4].setsize = 1 << shift;
>> -       tcases[4].expsize = 1 << shift;
>> -
>> -       tcases[5].setsize = (1 << shift) + 1;
>> +       tcases[4].setsize = (1 << shift) + 1;
>>
>>           pw = SAFE_GETPWNAM("nobody");
>>    }
> 
> Do we have to keep the shift in here?
> 
> Given that we are not aiming at a precise value now, we should be fine
> as long as we request the buffer to be a few megabytes in lenght and we
> can drop all the arch specific code from here, right?
Yes, if we don't want to test ENOMEM error, this arch specific code can 
be removed. Since only few people will set so large pipe size and 
trigger this error, I think we can remove this.

Best Regards
Yang Xu
> 


