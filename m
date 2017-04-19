From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 19 Apr 2017 07:55:30 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls: add new test for copy_file_range(2)
In-Reply-To: <20170419111529.15211-1-liwang@redhat.com>
References: <20170419111529.15211-1-liwang@redhat.com>
Message-ID: <490333408.29064201.1492602930614.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Li Wang <liwang@redhat.com>
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <errno.h>
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "linux_syscall_numbers.h"
> +
> +#define TEST_FILE_1 "copy_file_range_ltp01.txt"
> +#define TEST_FILE_2 "copy_file_range_ltp02.txt"
> +#define STR "abcdefghijklmnopqrstuvwxyz12345\n"
> +
> +static size_t len1 = 1;
> +static size_t len2;       /* stat.st_size */
> +static size_t len3;       /* stat.st_size - 1 */
> +static size_t page_size1; /* pagesize - 1 */
> +static size_t page_size2; /* pagesize     */
> +static size_t page_size3; /* pagesize + 1 */
> +
> +static struct tcase {
> +	loff_t *off_in;
> +	loff_t *off_out;
> +	size_t *len;
> +} tcases[] = {
> +	{NULL, NULL, &len1}, /* NULL, NULL, 1 */
> +	{NULL, NULL, &len2}, /* NULL, NULL, stat.st_size */
> +	{(loff_t *)&len3,             (loff_t *)&len3,      &len1}, /* stat.st_size
> - 1, stat.st_size - 1, 1 */
> +	{(loff_t *)&page_size1, (loff_t *)&page_size1, &page_size1}, /* pagesize -
> 1, pagesize - 1, pagesize - 1 */
> +	{(loff_t *)&page_size2, (loff_t *)&page_size2, &page_size2}, /* pagesize,
> pagesize, pagesize */
> +	{(loff_t *)&page_size3, (loff_t *)&page_size3, &page_size3}, /* pagesize +
> 1, pagesize + 1, pagesize + 1 */
> +};

Hi,

With -m32 and -D_FILE_OFFSET_BITS=64 you're in trouble, because you are
treating (recasting) pointer to 4 bytes as pointer to 8 bytes.

Make page_size[123] off_t and avoid pointer casts.

> +
> +static loff_t copy_file_range(int fd_in, loff_t *off_in,
> +		int fd_out, loff_t *off_out,
> +		size_t len, unsigned int flags)
> +{
> +	return tst_syscall(__NR_copy_file_range, fd_in, off_in, fd_out,
> +			off_out, len, flags);
> +}

I'd use tst_syscall() directly. If you define copy_file_range
won't that create conflict when glibc defines it too?

> +
> +static void setup(void)
> +{
> +	int i, fd;
> +	struct stat stat;
> +
> +	page_size2 = getpagesize();
> +	page_size1 = page_size2 - 1;
> +	page_size3 = page_size2 + 1;
> +
> +	fd = SAFE_OPEN(TEST_FILE_1, O_RDWR | O_CREAT, 0664);
> +	/* Writing 1024 KB of random data into this file [32 * 32768 = 1048576] */

It doesn't look very random :-). Anyway, do we need 1MB? Seems like
page_size * 4 would suffice for all cases.

> +	for (i = 0; i < 32768; i++)
> +		SAFE_WRITE(1, fd, STR, strlen(STR));
> +
> +	SAFE_FSTAT(fd, &stat);
> +	len2 = stat.st_size;
> +	len3 = len2 - 1;
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void copy_file_range_verify(unsigned int i)
> +{
> +	int fd_in, fd_out;
> +	loff_t off_in_ori = 0;
> +	loff_t off_out_ori = 0;
> +
> +	struct tcase *tc = &tcases[i];
> +	loff_t len = *(tc->len);
> +
> +	if (tc->off_in) {
> +		/*
> +		 * off_in/off_out will be changed if it is not NULL,
> +		 * here save the original value first
> +		 */
> +		off_in_ori = *(tc->off_in);
> +		off_out_ori = *(tc->off_out);
> +	}
> +	loff_t len_ori = len;
> +
> +	fd_in = SAFE_OPEN(TEST_FILE_1, O_RDONLY);
> +	fd_out = SAFE_OPEN(TEST_FILE_2, O_CREAT | O_WRONLY | O_TRUNC, 0644);
> +
> +	/*
> +	 * copy_file_range() will return the number of bytes copied between files.
> +	 * This could be less than the length originally requested.
> +	 */
> +	do {
> +		TEST(copy_file_range(fd_in, tc->off_in, fd_out, tc->off_out, len, 0));
> +		if (TEST_RETURN == -1) {
> +			tst_res(TFAIL | TTERRNO, "copy_file_range() failed");
> +			SAFE_CLOSE(fd_in);
> +			SAFE_CLOSE(fd_out);
> +			return;
> +		}
> +
> +		len -= TEST_RETURN;
> +	} while (len > 0);
> +
> +	/* Compare these two file contents */
> +	FILE *fp1, *fp2;
> +	int ch1, ch2;
> +	loff_t count = 0;
> +
> +	fp1 = SAFE_FOPEN(TEST_FILE_1, "r");
> +	fseek(fp1, off_in_ori, SEEK_SET);
> +	fp2 = SAFE_FOPEN(TEST_FILE_2, "r");
> +	fseek(fp2, off_out_ori, SEEK_SET);
> +
> +	do {
> +		ch1 = getc(fp1);
> +		ch2 = getc(fp2);
> +		count++;
> +	} while ((count < len_ori) && (ch1 == ch2));
> +
> +	if (ch1 == ch2) {

I'd put TPASS here, that says content matches.

> +		/*
> +		 * If off_in is NULL, the file offset is adjusted by the number of bytes
> copied.
> +		 * If off_in is not NULL, the file offset of fd_in is not changed, but
> off_in is
> +		 * adjusted appropriately.
> +		 */
> +		if (!tc->off_in) {
> +			if (lseek(fd_in, 0, SEEK_CUR) == lseek(fd_out, 0, SEEK_CUR))

SAFE_LSEEK

> +				tst_res(TPASS, "copy_file_range() returned %ld", TEST_RETURN);

and this TPASS can say that offsets are as expected.

> +			else
> +				tst_res(TFAIL,"these two files offset are not same");
> +		} else {
> +			if (*(tc->off_in) == (off_in_ori + len_ori))
> +				tst_res(TPASS, "copy_file_range() returned %ld", TEST_RETURN);

same here

Regards,
Jan

> +			else
> +				tst_res(TFAIL,"these two file off_in have no adjusted");
> +		}
> +	} else {
> +		tst_res(TFAIL,"these two file contents are not match");
> +	}
> +
> +	SAFE_FCLOSE(fp1);
> +	SAFE_FCLOSE(fp2);
> +	SAFE_CLOSE(fd_in);
> +	SAFE_CLOSE(fd_out);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "copy_file_range01",
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = copy_file_range_verify,
> +};
> --
> 2.9.3
> 
> 
