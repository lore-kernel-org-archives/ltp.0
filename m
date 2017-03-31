From: Laurent GONZALEZ <ltp@gezedo.com>
Date: Fri, 31 Mar 2017 09:58:02 +0200
Subject: [LTP] Access02 and use of system() library function
In-Reply-To: <20170330141913.GA886@rei.lan>
References: <beacb487-181d-2d9c-380a-128b985b2250@gezedo.com>
 <20170320111128.GA3322@rei.lan>
 <1e809374-8b45-aae8-69b2-14a0728fc2d6@gezedo.com>
 <20170330141913.GA886@rei.lan>
Message-ID: <c5d9de57-9847-1471-210f-b4a053237ab1@gezedo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30/03/2017 16:19, Cyril Hrubis wrote:
> Hi!
>>> What LTP version is this? The access02 test was rewritten some time ago and
>>> there is no test_file3 since commit:
>>>
>>> commit adb3e23d9de5f8ff54d2395112f79f25c36cf598
>>> Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>>> Date:   Wed Jul 20 18:44:39 2016 +0800
>>>
>>>     syscalls/access02: reconstruct and convert to new API
>>>
>>> Which is included in last to stable releases....
>>>
>> You're right, i am using an old version of LTP (20160126).
>>
>> It does not change my remark anyway, newer test does X_OK test using
>> system() library function. The return value is checked against 0 for
>> success, whereas I suggest that it should check against any positive
>> value, or even against any value but -1.
> Hmm, we can always write a shebang to the file then the file should be
> recognized by shell, right?
>
> Does this fixes the issue:
>
> diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
> index 779e81a..86e0342 100644
> --- a/testcases/kernel/syscalls/access/access02.c
> +++ b/testcases/kernel/syscalls/access/access02.c
> @@ -187,6 +187,7 @@ static void setup(void)
>  	SAFE_TOUCH(FNAME_R, 0444, NULL);
>  	SAFE_TOUCH(FNAME_W, 0222, NULL);
>  	SAFE_TOUCH(FNAME_X, 0555, NULL);
> +	SAFE_FILE_PRINTF(FNAME_X, "#!/bin/sh\n");
>  
>  	SAFE_SYMLINK(FNAME_F, SNAME_F);
>  	SAFE_SYMLINK(FNAME_R, SNAME_R);
>
Yes it does, and the test passes.

IMHO returning explicitely 0 (exit 0) will make the test even more robust, because 0 is the value returned by the system() library function call, and expected by the test.

