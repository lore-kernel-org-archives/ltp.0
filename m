From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 29 Apr 2021 09:29:06 +0000
Subject: [LTP] [PATCH] syscalls/chown03.c: Remove the redundant pass
 information
In-Reply-To: <60891F73.7020608@fujitsu.com>
References: <1619597275-12846-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <60891F73.7020608@fujitsu.com>
Message-ID: <608A7C80.6060708@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui
Thanks, merged!

Best Regards
Yang Xu
> Hi Jinhui
>
> Sound reasonable,
> Reviewed-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>
> Best Regards
> Yang Xu
>> When executing testcase chown03_16, the system will report pass information
>> even if 16-bit version of chown() is not supported, for example:
>> --------------------------------------------------------------------------
>> tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
>> chown03.c:48: TPASS: chown03_testfile: expected owner set to (uid=99, gid=0)
>> chown03.c:58: TPASS: chown03_testfile: expected mode permissions 0106770
>> /root/ltp/testcases/kernel/syscalls/chown/../utils/compat_tst_16.h:153: TCONF: 16-bit version of chown() is not supported on your platform
>>
>> Summary:
>> passed   2
>> failed   0
>> broken   0
>> skipped  1
>> warnings 0
>> --------------------------------------------------------------------------
>>
>> The redundant pass information may mislead testers, so we should remove them.
>>
>> Signed-off-by: Jinhui Huang<huangjh.jy@cn.fujitsu.com>
>> ---
>>    testcases/kernel/syscalls/chown/chown03.c | 6 ------
>>    1 file changed, 6 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
>> index 8ff2602..ff6e904 100644
>> --- a/testcases/kernel/syscalls/chown/chown03.c
>> +++ b/testcases/kernel/syscalls/chown/chown03.c
>> @@ -43,9 +43,6 @@ static void check_owner(struct stat *s, uid_t exp_uid, gid_t exp_gid)
>>    		tst_res(TFAIL, "%s: wrong owner set to (uid=%d, gid=%d),"
>>    			       " expected (uid=%d, gid=%d)",
>>    			FILENAME, s->st_uid, s->st_gid, exp_uid, exp_gid);
>> -	else
>> -		tst_res(TPASS, "%s: expected owner set to (uid=%d, gid=%d)",
>> -			FILENAME, exp_uid, exp_gid);
>>    }
>>
>>    static void check_mode(struct stat *s, mode_t exp_mode)
>> @@ -53,9 +50,6 @@ static void check_mode(struct stat *s, mode_t exp_mode)
>>    	if (s->st_mode != exp_mode)
>>    	      tst_res(TFAIL, "%s: wrong mode permissions %#o, expected %#o",
>>    		      FILENAME, s->st_mode, exp_mode);
>> -	else
>> -	      tst_res(TPASS, "%s: expected mode permissions %#o",
>> -		      FILENAME, s->st_mode);
>>    }
>>
>>    static void run(void)
>
