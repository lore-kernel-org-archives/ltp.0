From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 9 Jul 2019 14:57:27 +0800
Subject: [LTP] [PATCH v2] syscalls/copy_file_range02: increase coverage
 and remove EXDEV test
In-Reply-To: <CAOQ4uxhHOCb2fB_wSbBz8ekvm4S9_PsAXKD45=+MZNgt+Y-2gQ@mail.gmail.com>
References: <CAOQ4uxgUfhDL3kE_2xFKTnfs+Pgn5UJ38n2aFxz4XndfUeFX8A@mail.gmail.com>
 <1562359357-24526-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxhHOCb2fB_wSbBz8ekvm4S9_PsAXKD45=+MZNgt+Y-2gQ@mail.gmail.com>
Message-ID: <5D243AD7.10401@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/07/08 23:17, Amir Goldstein wrote:

> On Mon, Jul 8, 2019 at 1:46 PM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
>> Since Amir path for copy_file_range has been merged into linux-xfs,
>> I add test for swapfile, immutable file, bounds in ltp.  Also, add test
>> for block char pipe dev and remove EXDEV test(5.3 will relax the cross-device
>> constraint[2]).  I follow xfstests code[3][4][5] and increase it .
>>
>> [1]https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=for-next-5.3&id=5dae222a5ff0c269730393018a5539cc970a4726
>> [2]https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=for-next-5.3&id=96e6e8f4a68df2d94800311163faa67124df24e5
>> [3]https://patchwork.kernel.org/patch/10971759/
>> [4]https://patchwork.kernel.org/patch/10971747/
>> [5]https://patchwork.kernel.org/patch/10961421/
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   .../copy_file_range/copy_file_range.h         |  11 +-
>>   .../copy_file_range/copy_file_range02.c       | 139 +++++++++++++++---
>>   2 files changed, 130 insertions(+), 20 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>> index b6d132978..f9e2565d9 100644
>> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range.h
>> @@ -9,6 +9,7 @@
>>
>>   #include<stdbool.h>
>>   #include<unistd.h>
>> +#include<sys/sysmacros.h>
>>   #include "lapi/syscalls.h"
>>
>>   #define TEST_VARIANTS  2
>> @@ -18,10 +19,18 @@
>>   #define FILE_DEST_PATH  "file_dest"
>>   #define FILE_RDONL_PATH "file_rdonl"
>>   #define FILE_DIR_PATH  "file_dir"
>> -#define FILE_MNTED_PATH        MNTPOINT"/file_mnted"
>> +#define FILE_IMMUTABLE_PATH "file_immutable"
>> +#define FILE_SWAP_PATH "file_swap"
>> +#define FILE_BLKDEV    "file_blk"
>> +#define FILE_CHRDEV    "file_chr"
>> +#define FILE_FIFO      "file_fifo"
>> +#define FILE_COPY_PATH  "file_copy"
>>
>>   #define CONTENT                "ABCDEFGHIJKLMNOPQRSTUVWXYZ12345\n"
>>   #define CONTSIZE       (sizeof(CONTENT) - 1)
>> +#define MAX_LEN   ((long long)(~0ULL>>  1))
>> +#define MIN_OFF   65537
>> +#define MAX_OFF   (MAX_LEN - MIN_OFF)
> In the xfstest the value of MAX_OFF is ((1ULL<<  63) - MIN_OFF)
> Not sure why it was changed here?
Because the LONG LONG max value in kernel linux/limit.h is defined as" #define LLONG_MAX  ((long long)(~0ULL>>  1))".
I think it is a common usage.   If you don't like this way, I will use the xfstests vaule.


> [...]
>> +
>>   static void verify_copy_file_range(unsigned int n)
>>   {
>>          struct tcase *tc =&tcases[n];
>> +       if (tc->exp_err == ETXTBSY&&  chattr_i_nsup) {
> if (tc->copy_to_fd ==&fd_immutable&&  chattr_i_nsup)
>
> Would have made much more sense to code readers.
Yes.

>> +               tst_res(TCONF, "filesystem doesn't support chattr +i, skip it");
>> +               return;
>> +       }
>> +       if (tc->exp_err == EPERM&&  swap_nsup) {
> Same here.
OK.

>> +               tst_res(TCONF, "filesystem doesn't support swapfile, skip it");
>> +               return;
>> +       }
>>
>>          TEST(sys_copy_file_range(fd_src, 0, *tc->copy_to_fd,
>> -                               0, CONTSIZE, tc->flags));
>> +&tc->dst, tc->len, tc->flags));
>>
> [...]
>
>>   static void setup(void)
>>   {
>>          syscall_info();
>> +       dev_t dev[2];
>> +
>> +       dev[1] = makedev(7, 127);
> As I wrote before, while it is probable the loop127 is free it is not safe
> programming to assume it is free, especially not if you are trying to overwrite
> its content!
> I suggest that you alter  find_free_loopdev() to return the free loopdev minor
> (and -1 for no free loopdev) and then you can safely use the minor number
> that find_free_loopdev() returned in this test.
> If there is no free loopdev you can return TCONF.
Hi Amir

Thank for you mentionation.  Befor this, I don't know the find_free_loopdev api in ltp. 
If I alter it, I think we can add find_free_loopdev document in doc/test-writing-guidelines.txt.

I will send  a v3 patch for your comment.

>> +       dev[2] = makedev(1, 3);
> What I meant was
> #define FILE_CHRDEV "/dev/null"
>
> Obviously, no need to mknod nor unlink it on cleanup...
OK. This way is great.

> Thanks,
> Amir.
>
>
> .
>



