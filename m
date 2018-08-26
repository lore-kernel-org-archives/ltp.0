From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 27 Aug 2018 07:51:16 +0800
Subject: [LTP] [PATCH] newlib_tests/test_exec.c: Fix compiler error
 before glibc v2.11
In-Reply-To: <20180824145656.GA5131@rei>
References: <1535015214-4033-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180824145656.GA5131@rei>
Message-ID: <5B833CF4.1030609@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/24 22:56, Cyril Hrubis wrote:
> Hi!
>> Before glibc v2.11, execvpe() was not introduced and resulted in
>> compiler error, so we replace execvpe() with execve() and update
>> test-writing-guidelines.txt.
>>
>> Signed-off-by: xiao yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   doc/test-writing-guidelines.txt | 11 ++++++++---
>>   lib/newlib_tests/test_exec.c    | 11 ++++++++---
>>   2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
>> index a169724..f62e16e 100644
>> --- a/doc/test-writing-guidelines.txt
>> +++ b/doc/test-writing-guidelines.txt
>> @@ -696,15 +696,20 @@ a non zero exit code.
>>   [source,c]
>>   -------------------------------------------------------------------------------
>>   /* test.c */
>> -#define _GNU_SOURCE
>> -#include<stdlib.h>
>> +#include<unistd.h>
>>   #include "tst_test.h"
>>
>> +extern char **environ;
> Looking at this the only change here should be:
>
>> -#include<stdlib.h>
>> +#include<unistd.h>
> As man 7 environ says:
>
> (This variable must be declared in the user program, but is declared in
> the header file<unistd.h>  if the _GNU_SOURCE feature test macro is
> defined.)
>
> Or is environ not defined with _GNU_SOURCE for older libc?
Hi, Cyril

Older libc declares environ when _GNU_SOURCE is defined, so only
repalcing stdlib.h with unistd.h seems simpler.

I will send the v2 patch soon.

Thanks,
Xiao Yang
>>   static void do_test(void)
>>   {
>>   	char *const argv[] = {"test_exec_child", NULL};
>> +	char path[4096];
>> +
>> +	if (tst_get_path("test_exec_child", path, sizeof(path)))
>> +		tst_brk(TCONF, "Couldn't find test_exec_child in $PATH");
>>
>> -	execvpe(argv[0], argv, environ);
>> +	execve(path, argv, environ);
>>   	tst_res(TBROK | TERRNO, "EXEC!");
>>   }
>> diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
>> index 8aef621..e70080e 100644
>> --- a/lib/newlib_tests/test_exec.c
>> +++ b/lib/newlib_tests/test_exec.c
>> @@ -24,15 +24,20 @@
>>    * $ PATH=$PATH:$PWD ./test_exec
>>    */
>>
>> -#define _GNU_SOURCE
>> -#include<stdlib.h>
>> +#include<unistd.h>
>>   #include "tst_test.h"
>>
>> +extern char **environ;
> Here as well.
>
>>   static void do_test(void)
>>   {
>>   	char *const argv[] = {"test_exec_child", NULL};
>> +	char path[4096];
>> +
>> +	if (tst_get_path("test_exec_child", path, sizeof(path)))
>> +		tst_brk(TCONF, "Couldn't find test_exec_child in $PATH");
>>
>> -	execvpe(argv[0], argv, environ);
>> +	execve(path, argv, environ);
>>
>>   	tst_res(TBROK | TERRNO, "EXEC!");
>>   }
> Otherwise it looks good.
>



