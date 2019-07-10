From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jul 2019 15:32:15 +0800
Subject: [LTP] [PATCH v2] syscalls/copy_file_range02: increase coverage
 and remove EXDEV test
In-Reply-To: <CAOQ4uxhjbaszcCL0=QAncBT3PzqJR_7oyR+_0-zNa-pt6JNQSA@mail.gmail.com>
References: <CAOQ4uxgUfhDL3kE_2xFKTnfs+Pgn5UJ38n2aFxz4XndfUeFX8A@mail.gmail.com>
 <1562359357-24526-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxhHOCb2fB_wSbBz8ekvm4S9_PsAXKD45=+MZNgt+Y-2gQ@mail.gmail.com>
 <5D243AD7.10401@cn.fujitsu.com>
 <CAOQ4uxhjbaszcCL0=QAncBT3PzqJR_7oyR+_0-zNa-pt6JNQSA@mail.gmail.com>
Message-ID: <5D25947F.8000700@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/07/09 18:06, Amir Goldstein wrote:

> On Tue, Jul 9, 2019 at 9:57 AM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
>> on 2019/07/08 23:17, Amir Goldstein wrote:
>>
>>> On Mon, Jul 8, 2019 at 1:46 PM Yang Xu<xuyang2018.jy@cn.fujitsu.com>   wrote:
>>>> Since Amir path for copy_file_range has been merged into linux-xfs,
>>>> I add test for swapfile, immutable file, bounds in ltp.  Also, add test
>>>> for block char pipe dev and remove EXDEV test(5.3 will relax the cross-device
>>>> constraint[2]).  I follow xfstests code[3][4][5] and increase it .
>>>>
>>>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=for-next-5.3&id=5dae222a5ff0c269730393018a5539cc970a4726
>>>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=for-next-5.3&id=96e6e8f4a68df2d94800311163faa67124df24e5
>>>> [3]https://patchwork.kernel.org/patch/10971759/
>>>> [4]https://patchwork.kernel.org/patch/10971747/
>>>> [5]https://patchwork.kernel.org/patch/10961421/
>>>>
>>>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>>>> ---
>>>>    .../copy_file_range/copy_file_range.h         |  11 +-
>>>>    .../copy_file_range/copy_file_range02.c       | 139 +++++++++++++++---
>>>>    2 files changed, 130 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>>>> index b6d132978..f9e2565d9 100644
>>>> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>>>> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>>>> @@ -9,6 +9,7 @@
>>>>
>>>>    #include<stdbool.h>
>>>>    #include<unistd.h>
>>>> +#include<sys/sysmacros.h>
>>>>    #include "lapi/syscalls.h"
>>>>
>>>>    #define TEST_VARIANTS  2
>>>> @@ -18,10 +19,18 @@
>>>>    #define FILE_DEST_PATH  "file_dest"
>>>>    #define FILE_RDONL_PATH "file_rdonl"
>>>>    #define FILE_DIR_PATH  "file_dir"
>>>> -#define FILE_MNTED_PATH        MNTPOINT"/file_mnted"
>>>> +#define FILE_IMMUTABLE_PATH "file_immutable"
>>>> +#define FILE_SWAP_PATH "file_swap"
>>>> +#define FILE_BLKDEV    "file_blk"
>>>> +#define FILE_CHRDEV    "file_chr"
>>>> +#define FILE_FIFO      "file_fifo"
>>>> +#define FILE_COPY_PATH  "file_copy"
>>>>
>>>>    #define CONTENT                "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345\n"
>>>>    #define CONTSIZE       (sizeof(CONTENT) - 1)
>>>> +#define MAX_LEN   ((long long)(~0ULL>>   1))
>>>> +#define MIN_OFF   65537
>>>> +#define MAX_OFF   (MAX_LEN - MIN_OFF)
>>> In the xfstest the value of MAX_OFF is ((1ULL<<   63) - MIN_OFF)
>>> Not sure why it was changed here?
>> Because the LONG LONG max value in kernel linux/limit.h is defined as" #define LLONG_MAX  ((long long)(~0ULL>>   1))".
>> I think it is a common usage.   If you don't like this way, I will use the xfstests vaule.
> No it makes sense. VFS max size is larger than XFS max size and
> I think btrfs is limited for the VFS max.
>
> Maybe it is better to define MAX_LFS_FILESIZE if it is not defined
> in some ltp header file and #define MAX_LEN MAX_LFS_FILESIZE
> leaving comments where due.
>
> Also, I now wonder if running this test on 32bit kernel and with test
> compiled for 32bit will yield the expected errors?
Hi Amir

I have sent a v3 patch. I split it into 3 patch.
lib: alter find_free_loopdev()
syscalls/copy_file_range01: add cross-device test
syscalls/copy_file_range02: increase coverage and remove EXDEV test

I don't have 32bit machine or vm.   It takes some time.  Please wait.
ps: If someone can help to test it, it will be great.

Thanks,
Yang Xu

> Thanks,
> Amir.
>
>
>



