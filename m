From: Li Wang <liwang@redhat.com>
Date: Sat, 5 Dec 2015 16:04:11 +0800
Subject: [LTP] [PATCH] hugetlb: add new testcase hugeshmat05.c
In-Reply-To: <5661BF34.2090305@oracle.com>
References: <1448619845-7867-1-git-send-email-liwang@redhat.com>
 <5661BF34.2090305@oracle.com>
Message-ID: <CAEemH2f_zkdmGDGgMc-VFu9AoyzR3HGmc7y4ZCc=TG4f2i3tUA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Sat, Dec 5, 2015 at 12:28 AM, Alexey Kodanev <alexey.kodanev@oracle.com>
wrote:

> Hi,
>
>
> On 11/27/2015 01:24 PM, Li Wang wrote:
>
>> shmget()/shmat() fails to allocate huge pages shared memory segment
>> with EINVAL if its size is not in the range [ N*HUGE_PAGE_SIZE - 4095,
>> N*HUGE_PAGE_SIZE ]. This is a problem in the memory segment size round
>> up algorithm. The requested size is rounded up to PAGE_SIZE (4096), but
>> if this roundup does not match HUGE_PAGE_SIZE (2Mb) boundary - the
>> allocation fails.
>>
>> This bug is present in all RHEL6 versions, but not in RHEL7. It looks
>> like this was fixed in mainstream kernel > v3.3 by the following patches:
>>
>> 091d0d5 shm: fix null pointer deref when userspace specifies invalid
>> hugepage size
>> af73e4d hugetlbfs: fix mmap failure in unaligned size request
>> 42d7395 mm: support more pagesizes for MAP_HUGETLB/SHM_HUGETLB
>> 40716e2 hugetlbfs: fix alignment of huge page requests
>>
>> Signed-off-by: Li Wang <liwang@redhat.com>
>> ---
>>   runtest/hugetlb                                    |   1 +
>>
>> + *
>> + * AUTHOR
>>
> Authors

got.


>
>
>> +void shm_test(int size)
>> +{
>> +       int shmid;
>> +       char *shmaddr;
>> +       key_t key = 5;
>> +
>> +       shmid = shmget(key, size, SHM_R | SHM_W | IPC_CREAT |
>> SHM_HUGETLB);
>>
>
> Why not just "shmid = shmget(IPC_PRIVATE, size, 0600 | IPC_CREAT |
> SHM_HUGETLB);"? Do we need a key_t for the test?
>

ok, good! I tried to remove the key, it still works.


>
> +       if (shmid < 0)
>> +               tst_brkm(TBROK | TERRNO, cleanup, "shmget");
>>
>
> The message should be at least "shmget failed".

got.


>
> +                       tst_resm(TPASS, "No regression found.");
>> +               }
>>
>
> These two loops look very similar.
> We can just call the test with -i 15 iterations in runtest, no need for
> such a redundancy.
>
yeah, that would be simpler. agreed.


>
> Otherwise it looks good.
>
thanks for reviewing this patch. I will sent V2 next week.


>
> Best regards,
> Alexey
>
>
> +       }
>> +
>> +       cleanup();
>> +       tst_exit();
>> +}
>>
>
>


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151205/bbdc4097/attachment-0001.html>
