From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Apr 2017 14:23:27 +0800
Subject: [LTP] [PATCH v2] syscalls: add new test for copy_file_range(2)
In-Reply-To: <490333408.29064201.1492602930614.JavaMail.zimbra@redhat.com>
References: <20170419111529.15211-1-liwang@redhat.com>
 <490333408.29064201.1492602930614.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2c0Sn9Js7287So9Nan9Ho6BebV6xVT7aNkjKS0y44T6bw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 19, 2017 at 7:55 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
> ----- Original Message -----
>> Signed-off-by: Li Wang <liwang@redhat.com>
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
>> +static size_t len1 = 1;
>> +static size_t len2;       /* stat.st_size */
>> +static size_t len3;       /* stat.st_size - 1 */
>> +static size_t page_size1; /* pagesize - 1 */
>> +static size_t page_size2; /* pagesize     */
>> +static size_t page_size3; /* pagesize + 1 */
>> +
>> +static struct tcase {
>> +     loff_t *off_in;
>> +     loff_t *off_out;
>> +     size_t *len;
>> +} tcases[] = {
>> +     {NULL, NULL, &len1}, /* NULL, NULL, 1 */
>> +     {NULL, NULL, &len2}, /* NULL, NULL, stat.st_size */
>> +     {(loff_t *)&len3,             (loff_t *)&len3,      &len1}, /* stat.st_size
>> - 1, stat.st_size - 1, 1 */
>> +     {(loff_t *)&page_size1, (loff_t *)&page_size1, &page_size1}, /* pagesize -
>> 1, pagesize - 1, pagesize - 1 */
>> +     {(loff_t *)&page_size2, (loff_t *)&page_size2, &page_size2}, /* pagesize,
>> pagesize, pagesize */
>> +     {(loff_t *)&page_size3, (loff_t *)&page_size3, &page_size3}, /* pagesize +
>> 1, pagesize + 1, pagesize + 1 */
>> +};
>
> Hi,
>
> With -m32 and -D_FILE_OFFSET_BITS=64 you're in trouble, because you are
> treating (recasting) pointer to 4 bytes as pointer to 8 bytes.
>
> Make page_size[123] off_t and avoid pointer casts.

Good catch. I didn't noticed that cast issue.

>
>> +
>> +static loff_t copy_file_range(int fd_in, loff_t *off_in,
>> +             int fd_out, loff_t *off_out,
>> +             size_t len, unsigned int flags)
>> +{
>> +     return tst_syscall(__NR_copy_file_range, fd_in, off_in, fd_out,
>> +                     off_out, len, flags);
>> +}
>
> I'd use tst_syscall() directly. If you define copy_file_range
> won't that create conflict when glibc defines it too?

No confliction from my test, there probably because my glibc version
is low. But I think you are right. Let's remove this definition.

And no objection with the rest of comments, thanks for your quick response.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
