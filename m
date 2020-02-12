From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 12 Feb 2020 13:53:14 +0800
Subject: [LTP] [PATCH] aio02: Use mounted filesystem instead of temp
 directory
In-Reply-To: <5E438D72.4020203@cn.fujitsu.com>
References: <1581484093-13127-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5E438D72.4020203@cn.fujitsu.com>
Message-ID: <45385664-ba72-dec2-7a86-47d2a3602e04@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2020/02/12 13:30, Xiao Yang wrote:
> On 2020/2/12 13:08, Yang Xu wrote:
>> tmpfs doesn't support O_DIRECT flag, open file with this flag on
>> tmpfs will report EINVAL error. I thin we should test this case on
>> ext2 filesystem instead of temp directory.
> Hi Xu,
> 
> Thanks for your quick fix. :-)
> 
> I don't want to use the fixed file system to run aio02.
> I perfer to just drop O_DIRECT flag for tmpfs, as below:
> 1) Drop O_DIRECT flag for tmpfs.
> 2) Keep O_DIRECT flag for other filesystem.
> In this case, user still can run aio02 with different filesystem by 
> mounting specified filesystem on $TMPDIR.
> 
Sound reasonable to me, I will filter O_DIRECT flag for tmpfs.
> Best Regards,
> Xiao Yang
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>> ? testcases/kernel/io/aio/aio02.c | 9 ++++++---
>> ? 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/testcases/kernel/io/aio/aio02.c 
>> b/testcases/kernel/io/aio/aio02.c
>> index e283afba9..205d1b088 100644
>> --- a/testcases/kernel/io/aio/aio02.c
>> +++ b/testcases/kernel/io/aio/aio02.c
>> @@ -17,7 +17,8 @@
>>
>> ? #define AIO_MAXIO 32
>> ? #define AIO_BLKSIZE (64*1024)
>> -
>> +#define MNTPOINT?? "mnt_point"
>> +#define FILE_TEST MNTPOINT"/file"
>> ? static int wait_count = 0;
>>
>> ? #define DESC_FLAGS_OPR(x, y) .desc = (x == IO_CMD_PWRITE ? "WRITE: " 
>> #y: "READ : " #y), \
>> @@ -206,7 +207,7 @@ static void test_io(unsigned int n)
>> ????? int status;
>> ????? struct testcase *tc = testcases + n;
>>
>> -??? status = io_tio("file", tc->flags, tc->operation);
>> +??? status = io_tio(FILE_TEST, tc->flags, tc->operation);
>> ????? if (status)
>> ????????? tst_res(TFAIL, "%s, status = %d", tc->desc, status);
>> ????? else
>> @@ -214,7 +215,9 @@ static void test_io(unsigned int n)
>> ? }
>>
>> ? static struct tst_test test = {
>> -??? .needs_tmpdir = 1,
>> +??? .mount_device = 1,
>> +??? .mntpoint = MNTPOINT,
>> +??? .needs_root = 1,
>> ????? .test = test_io,
>> ????? .tcnt = ARRAY_SIZE(testcases),
>> ? };
> 


