From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Apr 2017 18:46:58 +0800
Subject: [LTP] [PATCH v3] syscalls: add new test for copy_file_range(2)
In-Reply-To: <CAEemH2fKm5nrMj=ubnE1_D=o5M+1f0deBrstoAjyR9ASN1VLjA@mail.gmail.com>
References: <20170420082416.25508-1-liwang@redhat.com>
 <917701187.946745.1493024025288.JavaMail.zimbra@redhat.com>
 <CAEemH2fKm5nrMj=ubnE1_D=o5M+1f0deBrstoAjyR9ASN1VLjA@mail.gmail.com>
Message-ID: <CAEemH2fPXez4K=hY+8hC3jMOfGkqL14PkhKF0VmrtsayzQASQw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Apr 24, 2017 at 5:53 PM, Li Wang <liwang@redhat.com> wrote:
> On Mon, Apr 24, 2017 at 4:53 PM, Jan Stancek <jstancek@redhat.com> wrote:
>>
>>
>> ----- Original Message -----
>>> +
>>> +#define _GNU_SOURCE
>>> +#include <stdio.h>
>>> +#include <errno.h>
>>> +#include "tst_test.h"
>>> +#include "tst_safe_stdio.h"
>>> +#include "linux_syscall_numbers.h"
>>> +
>>> +#define TEST_FILE_1 "copy_file_range_ltp01.txt"
>>> +#define TEST_FILE_2 "copy_file_range_ltp02.txt"
>>> +#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
>>> +
>>> +static off_t len1 = 1;   /* 1 */
>>> +static off_t len2;       /* stat.st_size */
>>> +static off_t len3;       /* stat.st_size - 1 */
>>> +static off_t page_size1; /* pagesize - 1 */
>>> +static off_t page_size2; /* pagesize     */
>>> +static off_t page_size3; /* pagesize + 1 */
>>> +
>>> +static struct tcase {
>>> +     off_t *off_in;
>>> +     off_t *off_out;
>>> +     off_t *len;
>>> +} tcases[] = {
>>> +     {NULL,  NULL,  &len1}, /* NULL, NULL, 1 */
>>> +     {NULL,  NULL,  &len2}, /* NULL, NULL, stat.st_size */
>>> +     {&len3, &len3, &len1}, /* stat.st_size - 1, stat.st_size - 1, 1 */
>>> +     {&page_size1, &page_size1, &page_size1}, /* pagesize - 1, pagesize - 1,
>>> pagesize - 1 */
>>> +     {&page_size2, &page_size2, &page_size2}, /* pagesize,     pagesize,
>>> pagesize */
>>> +     {&page_size3, &page_size3, &page_size3}, /* pagesize + 1, pagesize + 1,
>>> pagesize + 1 */
>>> +};
>>
>> Hi,
>>
>> These variables names are a bit confusing. But larger problem is

Currently have no idea to improve the confusing issue.

>> that the values are not stable between iterations. Try:
>>
>> $ ./copy_file_range01 -i 5
>>
>> ^^ this hangs for me.
>
> That's because variables have been changed in each loop. A simple way
> to solve that is re-run setup() function before the test.
>
> something like:
>
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> @@ -66,6 +66,9 @@ static void setup(void)
>
>  static void copy_file_range_verify(unsigned int i)
>  {
> +       if (i > 0)
> +               setup();
> +

Repeat setup() when i > 0 is not wise, after thinking over, a better
fix come to mind:

--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -134,7 +134,7 @@ static void copy_file_range_verify(unsigned int i)
                        else
                                tst_res(TFAIL, "file offset are not same");
                } else {
-                       if (*(tc->off_in) == (off_in_ori + len_ori))
+                       if (*(tc->off_in) == *(tc->off_out) &&
*(tc->off_in) == (off_in_ori + len_ori))
                                tst_res(TPASS, "file off_in changed correctly");
                        else
                                tst_res(TFAIL, "file off_in changed
incorrectly");
@@ -147,6 +147,10 @@ static void copy_file_range_verify(unsigned int i)
        SAFE_FCLOSE(fp2);
        SAFE_CLOSE(fd_in);
        SAFE_CLOSE(fd_out);
+
+       /* Reset the test values between iterations */
+       if (i == test.tcnt - 1)
+               setup();
 }



-- 
Regards,
Li Wang
Email: liwang@redhat.com
