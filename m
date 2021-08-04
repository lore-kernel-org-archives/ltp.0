From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Wed, 04 Aug 2021 00:52:52 -0400
Subject: [LTP] [PATCH 6/7] syscalls/fanotify20: Test file event with
 broken inode
In-Reply-To: <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
 (Amir Goldstein's message of "Tue, 3 Aug 2021 12:08:11 +0300")
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-7-krisman@collabora.com>
 <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
Message-ID: <87k0l1hkuz.fsf@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> This test corrupts an inode entry with an invalid mode through debugfs
>> and then tries to access it.  This should result in a ext4 error, which
>> we monitor through the fanotify group.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> index e7ced28eb61d..0c63e90edc3a 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> @@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
>>                    MS_REMOUNT|MS_RDONLY, "abort");
>>  }
>>
>> +#define TCASE2_BASEDIR "tcase2"
>> +#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
>> +
>> +static unsigned int tcase2_bad_ino;
>> +static void tcase2_prepare_fs(void)
>> +{
>> +       struct stat stat;
>> +
>> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
>> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
>> +
>> +       SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
>> +       tcase2_bad_ino = stat.st_ino;
>> +
>> +       SAFE_UMOUNT(MOUNT_PATH);
>> +       do_debugfs_request(tst_device->dev, "sif " TCASE2_BAD_DIR " mode 0xff");
>> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
>> +}
>> +
>> +static void tcase2_trigger_lookup(void)
>> +{
>> +       int ret;
>> +
>> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
>> +       ret = open(MOUNT_PATH"/"TCASE2_BAD_DIR, O_RDONLY, 0);
>> +       if (ret != -1 && errno != EUCLEAN)
>> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
>> +                       ret, TCASE2_BAD_DIR, errno, EUCLEAN);
>> +}
>> +
>>  static const struct test_case {
>>         char *name;
>>         int error;
>> @@ -92,6 +122,14 @@ static const struct test_case {
>>                 .error_count = 1,
>>                 .error = EXT4_ERR_ESHUTDOWN,
>>                 .inode = NULL
>> +       },
>> +       {
>> +               .name = "Lookup of inode with invalid mode",
>> +               .prepare_fs = tcase2_prepare_fs,
>> +               .trigger_error = &tcase2_trigger_lookup,
>> +               .error_count = 1,
>> +               .error = 0,
>> +               .inode = &tcase2_bad_ino,
>
> Why is error 0?
> What's the rationale?

Hi Amir,

That is specific to Ext4.  Some ext4 conditions report bogus error codes.  I will
come up with a kernel patch changing it.

-- 
Gabriel Krisman Bertazi
