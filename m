From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Mon, 5 Nov 2018 09:15:41 +0800
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Support mips
In-Reply-To: <da19c43f-39f7-81b4-7173-18fdec6ea1d9@windriver.com>
References: <1540348607-217391-1-git-send-email-hongzhi.song@windriver.com>
 <da19c43f-39f7-81b4-7173-18fdec6ea1d9@windriver.com>
Message-ID: <4ebbc29e-d46a-5954-2c2f-903126a48ab7@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Kindly ping

--Hongzhi


On 11/01/2018 09:49 AM, Hongzhi, Song wrote:
> Hi guys,
>
> Referring to POSIX spec, the return values, EINVAL and ENOMEM,
>
> are all right if MAP_FIXED is set. So I think Mips also keep to POSIX.
>
>
> Please review this patch.
>
>
> --Hongzhi
>
>
> On 10/24/2018 10:36 AM, Hongzhi.Song wrote:
>> Mips will return EINVAL instead of ENOMEM as expected
>> if MAP_FIXED is set and the range of [addr + len) exceeds
>> TASK_SIZE.
>>
>> Linux kernel code: arch/mips/mm/mmap.c
>> if (flags & MAP_FIXED) {
>>      /* Even MAP_FIXED mappings must reside within TASK_SIZE */
>>      if (TASK_SIZE - len < addr)
>>          return -EINVAL;
>>
>> The POSIX specification says:
>> "If MAP_FIXED is set, mmap() may return MAP_FAILED and set errno to
>> [EINVAL]."
>> [http://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html]
>>
>> So I think the mips kernel remains POSIX compliant.
>>
>> Relax the condition and accept both ENOMEM and EINVAL
>> as expected outcome.
>>
>> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
>> ---
>>   .../open_posix_testsuite/conformance/interfaces/mmap/24-2.c | 10 
>> +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git 
>> a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c 
>> b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c
>> index de51d43..810e5c8 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c
>> @@ -7,7 +7,7 @@
>>    * source tree.
>>    *
>>    * The mmap() function shall fail if:
>> - * [ENOMEM] MAP_FIXED was specified,
>> + * [ENOMEM or EINVAL] MAP_FIXED was specified,
>>    * and the range [addr,addr+len) exceeds that allowed
>>    * for the address space of a process; or, if MAP_FIXED was not 
>> specified and
>>    * there is insufficient room in the address space to effect the 
>> mapping.
>> @@ -15,7 +15,7 @@
>>    * Test Step:
>>    * 1. Map a shared memory object, with size exceeding the value get 
>> from
>>    *    rlim_cur of resource RLIMIT_AS, setting MAP_FIXED;
>> - * 3. Should get ENOMEM.
>> + * 3. Should get ENOMEM or EINVAL.
>>    */
>>     #define _XOPEN_SOURCE 600
>> @@ -93,8 +93,8 @@ int main(void)
>>              (unsigned long)len);
>>       pa = mmap(addr, len, PROT_READ | PROT_WRITE, MAP_FIXED | 
>> MAP_SHARED, fd,
>>             0);
>> -    if (pa == MAP_FAILED && errno == ENOMEM) {
>> -        printf("Got ENOMEM: %s\nTest PASSED\n", strerror(errno));
>> +    if (pa == MAP_FAILED && (errno == ENOMEM || errno == EINVAL)) {
>> +        printf("Got ENOMEM or EINVAL: %s\nTest PASSED\n", 
>> strerror(errno));
>>           exit(PTS_PASS);
>>       }
>>   @@ -103,6 +103,6 @@ int main(void)
>>       else
>>           munmap(pa, len);
>>       close(fd);
>> -    printf("Test Fail: Did not get ENOMEM as expected\n");
>> +    printf("Test Failed: Did not get ENOMEM or EINVAL as expected\n");
>>       return PTS_FAIL;
>>   }
>
>

