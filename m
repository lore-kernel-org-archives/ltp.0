From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 17 Apr 2020 14:44:14 +0800
Subject: [LTP] [PATCH 1/2] syscalls/{quotactl04,
 statx05}.c: Replace extra_opts[] with fs_opts[]
In-Reply-To: <46688436-6cd6-d5c5-4444-2e260686cc7e@cn.fujitsu.com>
References: <20200415080854.65971-1-yangx.jy@cn.fujitsu.com>
 <46688436-6cd6-d5c5-4444-2e260686cc7e@cn.fujitsu.com>
Message-ID: <5E99503E.5000501@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/4/17 12:43, Yang Xu wrote:
> Hi Xiao
>
>
>> extra_opts[] is to store the options which are passed after device name
>> (e.g. fs-size: mkfs -t ext4 /dev/sda1 <fs-size>) so perfer to use
>> fs_opts[] for quotactl04.c and statx05.c.
> Looks good to me, I guess we can add comment in
> test-writing-guidelines.txt ie:
> "If options can be passed before or after device name, 'fs_opts' is
> preferred."
Hi Xu,

Thanks for your comment.
I will add a hint to doc/test-writing-guidelines.txt.

Thanks,
Xiao Yang
>
> Best Regards
> Yang Xu
>>
>> References:
>> https://github.com/linux-test-project/ltp/blob/master/doc/test-writing-guidelines.txt
>>
>> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/mmap/mmap16.c
>>
>>
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
>> testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++--
>> testcases/kernel/syscalls/statx/statx05.c | 4 ++--
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c
>> b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> index 8dab83da0..b0db8fe5d 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
>> @@ -102,10 +102,10 @@ static struct tcase {
>> static void setup(void)
>> {
>> - const char *const extra_opts[] = {"-O quota,project", NULL};
>> + const char *const fs_opts[] = {"-O quota,project", NULL};
>> test_id = geteuid();
>> - SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, extra_opts);
>> + SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "quota");
>> mount_flag = 1;
>> }
>> diff --git a/testcases/kernel/syscalls/statx/statx05.c
>> b/testcases/kernel/syscalls/statx/statx05.c
>> index 42911fc17..77684e1ed 100644
>> --- a/testcases/kernel/syscalls/statx/statx05.c
>> +++ b/testcases/kernel/syscalls/statx/statx05.c
>> @@ -87,12 +87,12 @@ static void run(unsigned int i)
>> static void setup(void)
>> {
>> char opt_bsize[32];
>> - const char *const extra_opts[] = {"-O encrypt", opt_bsize, NULL};
>> + const char *const fs_opts[] = {"-O encrypt", opt_bsize, NULL};
>> int ret;
>> snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
>> - SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, extra_opts);
>> + SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
>> SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
>> mount_flag = 1;
>>
> .
>



