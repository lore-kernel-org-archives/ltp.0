From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 3 Feb 2021 17:47:43 +0800
Subject: [LTP] [PATCH v1 2/3] syscalls/mallinfo02: Add a basic test to
 check use mmap or sbrk
In-Reply-To: <YBLaQvt2g3z8Xy1A@yuki.lan>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <YBLaQvt2g3z8Xy1A@yuki.lan>
Message-ID: <601A713F.7020301@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
>> "The number of bytes in blocks currently allocated using mmap(2).".
>> For allocations greater than or equal to 128K and that can't be satisfied from
>> the free list, the memory-allocation functions employ mmap(2) instead of increasing
>> the program break using sbrk(2).
>>
>> In this case, we test 20k size to use sbrk and 128k size to use mmap.
>
> The size when glibc uses mmap() instead of heap is libc implementation
> detail. I'm not sure that we want to have that value hardcoded in a LTP test.
Here has some wrong description, I use "MAX(info.fordblks, 131072) + 
reuse_size" size to test instead of 128K.
>
> Also glibc documentation says:
>
> The default value is set to `131072' bytes and the threshold is adjusted
> dynamically to suit the allocation patterns of the program.

IMO, the threshold is adjusted dynamically because of two things if we 
don't use mallopt with  M_MMAP_THRESHOLD
1) fordblks;  /* Total free space (bytes) */
2) the previous mmap regin space


 From mallopt man-page for  M_MMAP_THRESHOLD option, it said
" For allocations greater  than  or  equal  to  the  limit  specified 
(in  bytes)  by M_MMAP_THRESHOLD  that  can't be satisfied from the free 
list, the memory-allocation functions employ mmap(2) instead of 
increasing the program break using sbrk(2)."

So I use this code "MAX(info.fordblks, 131072)" to get the right value 
to trigger mmap.

mallopt man-page for  M_MMAP_THRESHOLD option also said "On  the
  other hand, there are some disadvantages to the use of mmap(2): 
deallocated space is not placed on the free list for reuse by later 
allocations; " .

I guess it means mmap area  is not counted int info.fordblks(free list ) 
and can be used for the next sbrk(increase the heap). That is why I add 
reuse_size when I get the corrcet mmap size. Or, I miss something?

If we can't ensure it , I will remove this patch. Or, other advise?


Best Regards
Yang Xu

>



