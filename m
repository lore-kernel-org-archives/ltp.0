From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Wed, 13 Jan 2016 12:30:12 +0800
Subject: [LTP] [PATCH] Clean up hugemmap02 testcase
In-Reply-To: <56939645.2080805@oracle.com>
References: <1452241254-4113-1-git-send-email-shuang.qiu@oracle.com>
 <56939645.2080805@oracle.com>
Message-ID: <5695D2D4.7010406@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/11/2016 07:47 PM, Alexey Kodanev wrote:
> Hi,
> On 01/08/2016 11:20 AM, shuang.qiu@oracle.com wrote:
>> From: Shuang Qiu <shuang.qiu@oracle.com>
>>
>> It misses the cleanup when continue in the loop.
>> And it also needs to munmap() addr2 for 32-bit.
>>
>> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
>> ---
>>   testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   14 
>> ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c 
>> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
>> index 1a44993..8c2a9b2 100644
>> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
>> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
>> @@ -155,24 +155,20 @@ int main(int ac, char **av)
>>           addr2 = mmap((void *)low_addr2, map_sz, PROT_READ | 
>> PROT_WRITE,
>>                    MAP_SHARED, fildes, 0);
>>   #if __WORDSIZE == 64        /* 64-bit process */
>> -        if (addr2 == MAP_FAILED) {
>> +        if (addr2 == MAP_FAILED)
>>               tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
>>                    " with %s (64-bit)", TEMPFILE);
>> -            close(fildes);
>> -            continue;
>> -        } else {
>> +        else {
>>               tst_resm(TPASS, "huge mmap succeeded (64-bit)");
>
> Looking at the test, there is one more fd ("nfildes") that stays not 
> closed after each loop iteration...  we can move 
> open("/dev/zero",...)  to setup() or close it in the end of the loop, 
> what do you think?
Yes,thanks for reminder.
I will send another patch to close it in the end of the loop.

Thanks
Shuang
>
> Best regards,
> Alexey
>

