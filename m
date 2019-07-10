From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 10 Jul 2019 16:22:24 +0800
Subject: [LTP] [PATCH v3 2/3] syscalls/copy_file_range01: add
 cross-device test
In-Reply-To: <CAOQ4uxi-pv_RFVWOMoAPxzvRXh7KUOjs56wtPwoCLiW4GNOj0Q@mail.gmail.com>
References: <CAOQ4uxhjbaszcCL0=QAncBT3PzqJR_7oyR+_0-zNa-pt6JNQSA@mail.gmail.com>
 <1562743104-2705-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1562743104-2705-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxi-pv_RFVWOMoAPxzvRXh7KUOjs56wtPwoCLiW4GNOj0Q@mail.gmail.com>
Message-ID: <5D25A040.30105@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/07/10 15:50, Amir Goldstein wrote:

> On Wed, Jul 10, 2019 at 10:18 AM Yang Xu<xuyang2018.jy@cn.fujitsu.com>  wrote:
>> Amir has relaxed cross-device constraint since commit(vfs: allow
>> copy_file_range to copy across devices), I think we can remove it
>> in copy_file_range02 and test it in copy_file_range01.
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   .../copy_file_range/copy_file_range01.c       | 53 +++++++++++++++----
>>   1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
>> index a5bd5e7f7..aef626fce 100644
>> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
>> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
>> @@ -24,7 +24,17 @@
>>
>>   static int page_size;
>>   static int errcount, numcopies;
>> -static int fd_in, fd_out;
>> +static int fd_in, fd_out, cross_sup;
>> +char FILE_TARGET_PATH[40];
>> +
>> +static struct tcase {
>> +       char    *path;
>> +       int     flags;
>> +       char    *message;
>> +} tcases[] = {
>> +       {FILE_DEST_PATH,  0, "non cross-device"},
>> +       {FILE_MNTED_PATH, 1, "cross-device"},
>> +};
>>
>>   static int check_file_content(const char *fname1, const char *fname2,
>>          loff_t *off1, loff_t *off2, size_t len)
>> @@ -131,7 +141,7 @@ static void test_one(size_t len, loff_t *off_in, loff_t *off_out)
>>                  to_copy -= TST_RET;
>>          } while (to_copy>  0);
>>
>> -       ret = check_file_content(FILE_SRC_PATH, FILE_DEST_PATH,
>> +       ret = check_file_content(FILE_SRC_PATH, FILE_TARGET_PATH,
>>                  off_in, off_out, len);
>>          if (ret) {
>>                  tst_res(TFAIL, "file contents do not match");
>> @@ -152,7 +162,7 @@ static void test_one(size_t len, loff_t *off_in, loff_t *off_out)
>>   static void open_files(void)
>>   {
>>          fd_in  = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY);
>> -       fd_out = SAFE_OPEN(FILE_DEST_PATH, O_CREAT | O_WRONLY | O_TRUNC, 0644);
>> +       fd_out = SAFE_OPEN(FILE_TARGET_PATH, O_CREAT | O_WRONLY | O_TRUNC, 0644);
>>   }
>>
>>   static void close_files(void)
>> @@ -163,9 +173,18 @@ static void close_files(void)
>>                  SAFE_CLOSE(fd_in);
>>   }
>>
>> -static void copy_file_range_verify(void)
>> +static void copy_file_range_verify(unsigned int n)
>>   {
>>          int i, j, k;
>> +       struct tcase *tc =&tcases[n];
>> +
>> +       if (tc->flags&&  !cross_sup) {
>> +               tst_res(TCONF,
>> +                       "copy_file_range doesn't support cross-device, skip it");
>> +               return;
>> +       }
>> +
>> +       strcpy(FILE_TARGET_PATH, tc->path);
>>
>>          errcount = numcopies = 0;
>>          size_t len_arr[]        = {11, page_size-1, page_size, page_size+1};
>> @@ -190,25 +209,33 @@ static void copy_file_range_verify(void)
>>
>>          if (errcount == 0)
>>                  tst_res(TPASS,
>> -                       "copy_file_range completed all %d copy jobs successfully!",
>> -                       numcopies);
>> +                       "%s copy_file_range completed all %d copy jobs successfully!",
>> +                       tc->message, numcopies);
>>          else
>> -               tst_res(TFAIL, "copy_file_range failed %d of %d copy jobs.",
>> -                               errcount, numcopies);
>> +               tst_res(TFAIL, "%s copy_file_range failed %d of %d copy jobs.",
>> +                       tc->message, errcount, numcopies);
>>   }
>>
>>   static void setup(void)
>>   {
>> -       int i, fd;
>> +       int i, fd, fd1;
>>
>>          syscall_info();
>>
>>          page_size = getpagesize();
>> -
>> +       cross_sup = 1;
>>          fd = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
>>          /* Writing page_size * 4 of data into test file */
>>          for (i = 0; i<  (int)(page_size * 4); i++)
>>                  SAFE_WRITE(1, fd, CONTENT, CONTSIZE);
>> +
>> +       fd1 = SAFE_OPEN(FILE_MNTED_PATH, O_RDWR | O_CREAT, 0664);
>> +       TEST(sys_copy_file_range(fd, 0, fd1, 0, CONTSIZE, 0));
>> +       if (TST_RET == -1)
> I would restrict TCONF to errno == EXDEV.
> Otherwise, a proper test failure is in order IMO.
>
Yes.  It also fails because of other situations. We should restrict TCONF to TST_ERR==EXDEV.

>> +               cross_sup = 0;
>> +
>> +       SAFE_CLOSE(fd1);
>> +       remove(FILE_MNTED_PATH);
>>          SAFE_CLOSE(fd);
>>   }
>>
>> @@ -220,7 +247,11 @@ static void cleanup(void)
>>   static struct tst_test test = {
>>          .setup = setup,
>>          .cleanup = cleanup,
>> +       .tcnt = ARRAY_SIZE(tcases),
>>          .needs_tmpdir = 1,
>> -       .test_all = copy_file_range_verify,
>> +       .mount_device = 1,
>> +       .mntpoint = MNTPOINT,
>> +       .all_filesystems = 1,
>> +       .test = copy_file_range_verify,
>>          .test_variants = TEST_VARIANTS,
>>   };
>> --
>> 2.18.1
>>
>>
>>
>
> .
>



