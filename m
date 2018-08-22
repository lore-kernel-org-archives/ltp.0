From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 22 Aug 2018 09:17:40 +0800
Subject: [LTP] [PATCH] syscalls/execveat03: Fix compiler errors
In-Reply-To: <1642007852.41615039.1534852963645.JavaMail.zimbra@redhat.com>
References: <1534740597-4896-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1642007852.41615039.1534852963645.JavaMail.zimbra@redhat.com>
Message-ID: <5B7CB9B4.9000405@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2018/08/21 20:02, Jan Stancek wrote:
>
> ----- Original Message -----
>> According to open(2) and linkat(2) manpages, O_PATH and AT_EMPTY_PATH
>> flags were added since kernel v2.6.39, so these undefined flags led
>> to the following errors on older kernels(e.g. v2.6.32):
>> ---------------------------------------------------------
>> execveat03.c:66: error: ‘O_PATH’ undeclared (first use in this function)
>> execveat03.c:69: error: ‘AT_EMPTY_PATH’ undeclared (first use in this
>> function)
>> ---------------------------------------------------------
>>
>> 1) Add AT_EMPTY_PATH into lapi/fcntl.h
>> 2) Include lapi/fcntl.h in execveat03.c
> Agreed with 1 and 2.
>
>> 3) Check if open(2) supports O_PATH
> Do we need to worry about this one? execveat() has been introduced [1]
> around v3.19. Those kernels should already support O_PATH.
>
> [1] 51f39a1f0cea ("syscalls: implement execveat() system call")
Hi Jan,

Thanks for your review.
It is reasonable to drop this check as you explained.

Thanks,
Xiao Yang
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   include/lapi/fcntl.h                            |  4 ++++
>>   testcases/kernel/syscalls/execveat/execveat03.c | 10 +++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
>> index 849439d..358230f 100644
>> --- a/include/lapi/fcntl.h
>> +++ b/include/lapi/fcntl.h
>> @@ -103,6 +103,10 @@
>>   # define AT_SYMLINK_NOFOLLOW 0x100
>>   #endif
>>
>> +#ifndef AT_EMPTY_PATH
>> +# define AT_EMPTY_PATH 0x1000
>> +#endif
>> +
>>   #ifndef AT_REMOVEDIR
>>   # define AT_REMOVEDIR 0x200
>>   #endif
>> diff --git a/testcases/kernel/syscalls/execveat/execveat03.c
>> b/testcases/kernel/syscalls/execveat/execveat03.c
>> index df27273..701784e 100644
>> --- a/testcases/kernel/syscalls/execveat/execveat03.c
>> +++ b/testcases/kernel/syscalls/execveat/execveat03.c
>> @@ -49,6 +49,7 @@
>>   #include<fcntl.h>
>>   #include "tst_test.h"
>>   #include "lapi/execveat.h"
>> +#include "lapi/fcntl.h"
>>
>>   #define OVL_MNT "ovl"
>>   #define TEST_APP "execveat_child"
>> @@ -63,7 +64,14 @@ static void do_child(void)
>>
>>   	SAFE_CP(TEST_APP, TEST_FILE_PATH);
>>
>> -	fd = SAFE_OPEN(TEST_FILE_PATH, O_PATH);
>> +	fd = open(TEST_FILE_PATH, O_PATH);
>> +	if (fd == -1) {
>> +		if (errno == EINVAL)
>> +			tst_brk(TCONF, "open() did not support O_PATH");
>> +		else
>> +			tst_brk(TBROK, "open() failed");
>> +	}
>> +
>>   	SAFE_UNLINK(TEST_FILE_PATH);
>>
>>   	TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
>> --
>> 1.8.3.1
>>
>>
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>
>
> .
>



