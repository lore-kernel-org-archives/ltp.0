From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu, 5 Aug 2021 18:06:04 +0800
Subject: [LTP] [PATCH] [1/4] syscalls/chroot01: Convert to new API
In-Reply-To: <YQuzZYA3B3zBuVKh@yuki>
References: <20210805073339.15027-1-zhanglianjie@uniontech.com>
 <YQuzZYA3B3zBuVKh@yuki>
Message-ID: <73bcb0d8-11ef-63e1-f73a-e452d72f7b3c@uniontech.com>+DE18549BB37B8268
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi:
I will resubmit, thank you for your guidance.

> Hi!
>> +static void verify_chroot(void)
>>   {
>> -	int lc;
>> +	TEST(chroot(path));
>>
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		TEST(chroot(path));
>> -
>> -		if (TEST_RETURN != -1)
>> -			tst_resm(TFAIL, "call succeeded unexpectedly");
>> -		else if (errno != EPERM)
>> -			tst_resm(TFAIL | TTERRNO, "chroot failed unexpectedly");
>> -		else
>> -			tst_resm(TPASS, "chroot set errno to EPERM.");
>> -	}
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	if (TST_RET != -1)
>> +		tst_res(TFAIL, "call succeeded unexpectedly");
>> +	else if (errno != EPERM)
>> +		tst_res(TFAIL | TTERRNO, "chroot failed unexpectedly");
>> +	else
>> +		tst_res(TPASS, "chroot set errno to EPERM.");
> 
> Just use the TST_EXP_FAIL() here instead.
> 
>>   }
>>
>> -void setup(void)
>> +static void setup(void)
>>   {
>> -	tst_require_root();
>> -
>> -	tst_tmpdir();
>>   	path = tst_get_tmpdir();
>> +	if (path == NULL)
>> +		tst_brk(TBROK | TERRNO, "tst_get_tmpdir failed");
> 
> Hmm I guess that we should add tst_brkm() to the lib/tst_tmpdir.c
> instead to check if the strdup has failed, which would be far easier
> than adding error handling to all tests.
> 
> Something as:
> 
> diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
> index 0c39eb89f..35b376478 100644
> --- a/lib/tst_tmpdir.c
> +++ b/lib/tst_tmpdir.c
> @@ -108,12 +108,18 @@ int tst_tmpdir_created(void)
> 
>   char *tst_get_tmpdir(void)
>   {
> +       char *ret;
> +
>          if (TESTDIR == NULL) {
>                  tst_brkm(TBROK, NULL, "you must call tst_tmpdir() first");
>                  return NULL;
>          }
> 
> -       return strdup(TESTDIR);
> +       ret = strdup(TESTDIR);
> +       if (!ret)
> +               tst_brkm(TBROK, NULL, "strdup() failed");
> +
> +       return ret;
>   }
> 
> 
>> -	if ((ltpuser = getpwnam(nobody_uid)) == NULL)
>> -		tst_brkm(TBROK | TERRNO, cleanup,
>> -			 "getpwnam(\"nobody\") failed");
>> -
>> -	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
>> +	if ((ltpuser = SAFE_GETPWNAM(nobody_uid)) == NULL)
>> +		tst_brk(TBROK | TERRNO, "getpwnam(\"nobody\") failed");
> 
> SAFE_SETEUID() cannot fail, there is no need to check the return value.
> 
> 
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> +	SAFE_SETEUID(ltpuser->pw_uid);
>>   }
>>
>> -void cleanup(void)
>> +static void cleanup(void)
>>   {
>> -	SAFE_SETEUID(NULL, 0);
>> +	SAFE_SETEUID(0);
> 
> There is actually no need to reset the UID in new library tests, since
> the cleanup for temporary directory is carried on with the test library
> process.
> 
>> -	free(path);
>> -	tst_rmdir();
>> +	if (path) {
>> +		free(path);
>> +		path = NULL;
>> +	}
> 
> free(NULL) is no-op, no need for the if () here.
> 
> All that has to be done in the cleanup is actually:
> 
> static void cleanup(void)
> {
> 	free(path);
> }
> 
>>   }
>> +
>> +static struct tst_test test = {
>> +	.cleanup = cleanup,
>> +	.setup = setup,
>> +	.test_all = verify_chroot,
>> +	.needs_root = 1,
>> +	.needs_tmpdir = 1,
>> +};
>> --
>> 2.20.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


