From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Apr 2017 17:53:23 +0800
Subject: [LTP] [PATCH v3] syscalls: add new test for copy_file_range(2)
In-Reply-To: <917701187.946745.1493024025288.JavaMail.zimbra@redhat.com>
References: <20170420082416.25508-1-liwang@redhat.com>
 <917701187.946745.1493024025288.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fKm5nrMj=ubnE1_D=o5M+1f0deBrstoAjyR9ASN1VLjA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Apr 24, 2017 at 4:53 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> +
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <errno.h>
>> +#include "tst_test.h"
>> +#include "tst_safe_stdio.h"
>> +#include "linux_syscall_numbers.h"
>> +
>> +#define TEST_FILE_1 "copy_file_range_ltp01.txt"
>> +#define TEST_FILE_2 "copy_file_range_ltp02.txt"
>> +#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
>> +
>> +static off_t len1 = 1;   /* 1 */
>> +static off_t len2;       /* stat.st_size */
>> +static off_t len3;       /* stat.st_size - 1 */
>> +static off_t page_size1; /* pagesize - 1 */
>> +static off_t page_size2; /* pagesize     */
>> +static off_t page_size3; /* pagesize + 1 */
>> +
>> +static struct tcase {
>> +     off_t *off_in;
>> +     off_t *off_out;
>> +     off_t *len;
>> +} tcases[] = {
>> +     {NULL,  NULL,  &len1}, /* NULL, NULL, 1 */
>> +     {NULL,  NULL,  &len2}, /* NULL, NULL, stat.st_size */
>> +     {&len3, &len3, &len1}, /* stat.st_size - 1, stat.st_size - 1, 1 */
>> +     {&page_size1, &page_size1, &page_size1}, /* pagesize - 1, pagesize - 1,
>> pagesize - 1 */
>> +     {&page_size2, &page_size2, &page_size2}, /* pagesize,     pagesize,
>> pagesize */
>> +     {&page_size3, &page_size3, &page_size3}, /* pagesize + 1, pagesize + 1,
>> pagesize + 1 */
>> +};
>
> Hi,
>
> These variables names are a bit confusing. But larger problem is
> that the values are not stable between iterations. Try:
>
> $ ./copy_file_range01 -i 5
>
> ^^ this hangs for me.

That's because variables have been changed in each loop. A simple way
to solve that is re-run setup() function before the test.

something like:

--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -66,6 +66,9 @@ static void setup(void)

 static void copy_file_range_verify(unsigned int i)
 {
+       if (i > 0)
+               setup();
+
        int fd_in, fd_out;
        off_t off_in_ori = 0;
        off_t off_out_ori = 0;
@@ -134,7 +137,7 @@ static void copy_file_range_verify(unsigned int i)
                        else
                                tst_res(TFAIL, "file offset are not same");
                } else {
-                       if (*(tc->off_in) == (off_in_ori + len_ori))
+                       if (*(tc->off_in) == (off_in_ori + len_ori) &&
*(tc->off_in) == *(tc->off_out)  )
                                tst_res(TPASS, "file off_in changed correctly");
                        else
                                tst_res(TFAIL, "file off_in changed
incorrectly");



>> +             } else {
>> +                     if (*(tc->off_in) == (off_in_ori + len_ori))
>> +                             tst_res(TPASS, "file off_in changed correctly");
>
> What about off_out?

off_out should be detected too. After change in above, test pass from my side:

# ./copy_file_range01 -i 5
tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
copy_file_range01.c:128: PASS: file contents match 1 bytes
copy_file_range01.c:136: PASS: file offset are same
copy_file_range01.c:128: PASS: file contents match 524288 bytes
copy_file_range01.c:136: PASS: file offset are same
...
copy_file_range01.c:141: PASS: file off_in changed correctly
copy_file_range01.c:128: PASS: file contents match 4096 bytes
copy_file_range01.c:141: PASS: file off_in changed correctly
copy_file_range01.c:128: PASS: file contents match 4097 bytes
copy_file_range01.c:141: PASS: file off_in changed correctly

Summary:
passed   60
failed   0
skipped  0
warnings 0




-- 
Regards,
Li Wang
Email: liwang@redhat.com
