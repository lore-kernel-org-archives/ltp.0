From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 Jan 2021 17:20:57 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls: Remove unused include <fcntl.h>
In-Reply-To: <5FFEBA89.5040001@cn.fujitsu.com>
References: <20210113075110.31628-1-pvorel@suse.cz>
 <20210113075110.31628-4-pvorel@suse.cz> <5FFEBA89.5040001@cn.fujitsu.com>
Message-ID: <5FFEBB79.4010807@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

? 2021/1/13 17:16, Xiao Yang ??:
> On 2021/1/13 15:51, Petr Vorel wrote:
>> Tests should always use lapi/fcntl.h instead of<fcntl.h>  to fix
>> possible missing definitions.
>>
>> But in this case removing include, because fanotify tests include
>> <fcntl.h>  in lapi/fcntl.h (via fanotify.h) and
>> {name_to,open_by}_handle_at tests include lapi/fcntl.h in
>> lapi/name_to_handle_at.h.
> Hi Petr,
>
> This patchset looks good to me.
> Reviewed-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>
> Only one monir question:
> Why do we remove<fcntl.h>  header for all fanotify tests?

Sorry, correct one word(do =>don't)

> Of course, just four fanotify tests take use of struct file_handle.
>
> Best Regards,
> Xiao Yang
>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>> ---
>>   testcases/kernel/syscalls/fanotify/fanotify09.c                  | 1 -
>>   testcases/kernel/syscalls/fanotify/fanotify13.c                  | 1 -
>>   testcases/kernel/syscalls/fanotify/fanotify15.c                  | 1 -
>>   testcases/kernel/syscalls/fanotify/fanotify16.c                  | 1 -
>>   .../kernel/syscalls/name_to_handle_at/name_to_handle_at01.c      | 1 -
>>   .../kernel/syscalls/name_to_handle_at/name_to_handle_at02.c      | 1 -
>>   .../kernel/syscalls/open_by_handle_at/open_by_handle_at01.c      | 1 -
>>   .../kernel/syscalls/open_by_handle_at/open_by_handle_at02.c      | 1 -
>>   8 files changed, 8 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
>> index 30e212f44..918e40274 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
>> @@ -30,7 +30,6 @@
>>   #include<stdio.h>
>>   #include<sys/stat.h>
>>   #include<sys/types.h>
>> -#include<fcntl.h>
>>   #include<errno.h>
>>   #include<string.h>
>>   #include<sys/mount.h>
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
>> index c9cf10555..6d812cdd1 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
>> @@ -21,7 +21,6 @@
>>   #include<sys/statfs.h>
>>   #include<sys/types.h>
>>   #include<sys/stat.h>
>> -#include<fcntl.h>
>>   #include<errno.h>
>>   #include<unistd.h>
>>   #include "tst_test.h"
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
>> index ba8259c7c..fe143823e 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify15.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
>> @@ -19,7 +19,6 @@
>>
>>   #include<string.h>
>>   #include<errno.h>
>> -#include<fcntl.h>
>>   #include<sys/statfs.h>
>>   #include<sys/types.h>
>>   #include "tst_test.h"
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
>> index 5ffaec92f..c4b8a5abc 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify16.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
>> @@ -18,7 +18,6 @@
>>   #include<stdio.h>
>>   #include<sys/stat.h>
>>   #include<sys/types.h>
>> -#include<fcntl.h>
>>   #include<errno.h>
>>   #include<string.h>
>>   #include<sys/mount.h>
>> diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
>> index 84ac32eab..1ac9d8214 100644
>> --- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
>> +++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
>> @@ -15,7 +15,6 @@
>>   \*/
>>
>>   #define _GNU_SOURCE
>> -#include<fcntl.h>
>>   #include<sys/stat.h>
>>   #include "lapi/name_to_handle_at.h"
>>
>> diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
>> index 7c0d57485..020b25531 100644
>> --- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
>> +++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
>> @@ -10,7 +10,6 @@
>>   \*/
>>
>>   #define _GNU_SOURCE
>> -#include<fcntl.h>
>>   #include "lapi/name_to_handle_at.h"
>>
>>   #define TEST_FILE "test_file"
>> diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
>> index c1b08f1b8..0d09e1ed8 100644
>> --- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
>> +++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
>> @@ -15,7 +15,6 @@
>>   \*/
>>
>>   #define _GNU_SOURCE
>> -#include<fcntl.h>
>>   #include<sys/stat.h>
>>   #include "lapi/name_to_handle_at.h"
>>
>> diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
>> index 3c8f06d85..0f60752c4 100644
>> --- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
>> +++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
>> @@ -10,7 +10,6 @@
>>   \*/
>>   #define _GNU_SOURCE
>>   #include<linux/capability.h>
>> -#include<fcntl.h>
>>   #include "tst_capability.h"
>>   #include "lapi/name_to_handle_at.h"
>>
>
>
>



