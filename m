From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 8 Apr 2021 02:02:53 +0000
Subject: [LTP] [PATCH 3/3] syscalls/semctl01: Convert into new api
In-Reply-To: <46e7a46a-f3d2-078d-1126-5a8679cea7be@oracle.com>
References: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1616497037-19158-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <46e7a46a-f3d2-078d-1126-5a8679cea7be@oracle.com>
Message-ID: <606E7268.8000603@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey
> On 23.03.2021 13:57, Yang Xu wrote:
>> From: Yang Xu<xuyang2018.jy@fujitsu.com>
>>   /*
>>    * These are the various setup and check functions for the 10 different
>>    * commands that are available for the semctl() call.
>> @@ -67,363 +29,171 @@ static void func_gval(int);
>>   static void sall_setup(void), func_sall(void);
>>   static void func_sval(void);
>>   static void func_rmid(void);
>> -static void child_cnt(void);
>> -static void child_pid(void);
>>   static void func_iinfo(int);
>>   static void func_sinfo(void);
>>   static void func_sstat(int);
>>
>
> We could drop all these declarations by moving tcases struct
> just before verify_semctl().
Yes. Thanks for catching this.

>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test = verify_semctl,
>> +	.tcnt = ARRAY_SIZE(tests),
>> +	.needs_root = 1,
>
> Does it really require root?
See ftok(3) manpage, it said "The  ftok()  function uses the identity of 
the file named by the given pathname (which must refer to an existing, 
accessible file)".
ftok source code
key_t
ftok (const char *pathname, int proj_id)
{
   struct stat64 st;
   key_t key;

   if (__stat64 (pathname, &st) < 0)
     return (key_t) -1;

   key = ((st.st_ino & 0xffff) | ((st.st_dev & 0xff) << 16)
          | ((proj_id & 0xff) << 24));

   return key;
}

To ensure ftok succeed, we must require root. Or, modify GETIPCKEY api, 
we can use tmp directory. Anyhow, I will send a v2 to remove useless 
funtion declartion firstly.

Best Regards
Yang Xu
>
>> +	.forks_child = 1,
>> +};
>>
>
>
