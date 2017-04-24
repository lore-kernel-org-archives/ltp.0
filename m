From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Apr 2017 04:53:45 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscalls: add new test for copy_file_range(2)
In-Reply-To: <20170420082416.25508-1-liwang@redhat.com>
References: <20170420082416.25508-1-liwang@redhat.com>
Message-ID: <917701187.946745.1493024025288.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
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
> +static off_t len1 = 1;   /* 1 */
> +static off_t len2;       /* stat.st_size */
> +static off_t len3;       /* stat.st_size - 1 */
> +static off_t page_size1; /* pagesize - 1 */
> +static off_t page_size2; /* pagesize     */
> +static off_t page_size3; /* pagesize + 1 */
> +
> +static struct tcase {
> +	off_t *off_in;
> +	off_t *off_out;
> +	off_t *len;
> +} tcases[] = {
> +	{NULL,  NULL,  &len1}, /* NULL, NULL, 1 */
> +	{NULL,  NULL,  &len2}, /* NULL, NULL, stat.st_size */
> +	{&len3, &len3, &len1}, /* stat.st_size - 1, stat.st_size - 1, 1 */
> +	{&page_size1, &page_size1, &page_size1}, /* pagesize - 1, pagesize - 1,
> pagesize - 1 */
> +	{&page_size2, &page_size2, &page_size2}, /* pagesize,     pagesize,
> pagesize */
> +	{&page_size3, &page_size3, &page_size3}, /* pagesize + 1, pagesize + 1,
> pagesize + 1 */
> +};

Hi,

These variables names are a bit confusing. But larger problem is
that the values are not stable between iterations. Try:

$ ./copy_file_range01 -i 5

^^ this hangs for me.

> +static void copy_file_range_verify(unsigned int i)
> +{
> +	int fd_in, fd_out;
> +	off_t off_in_ori = 0;
> +	off_t off_out_ori = 0;
> +
> +	struct tcase *tc = &tcases[i];
> +	off_t len = *(tc->len);
> +
> +	if (tc->off_in) {
> +		/*
> +		 * off_in/off_out will be changed if it is not NULL,
> +		 * here save the original value first
> +		 */
> +		off_in_ori = *(tc->off_in);
> +		off_out_ori = *(tc->off_out);
> +	}
> +	off_t len_ori = len;
> +
> +	fd_in = SAFE_OPEN(TEST_FILE_1, O_RDONLY);
> +	fd_out = SAFE_OPEN(TEST_FILE_2, O_CREAT | O_WRONLY | O_TRUNC, 0644);
> +
> +	/*
> +	 * copy_file_range() will return the number of bytes copied between files.
> +	 * This could be less than the length originally requested.
> +	 */
> +	do {
> +		TEST(tst_syscall(__NR_copy_file_range, fd_in, tc->off_in, fd_out,
> tc->off_out, len, 0));
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
> +	off_t count = 0;
> +
> +	fp1 = SAFE_FOPEN(TEST_FILE_1, "r");
> +	if (fseek(fp1, off_in_ori, SEEK_SET))
> +		tst_brk(TBROK | TERRNO, "fseek() failed");
> +
> +	fp2 = SAFE_FOPEN(TEST_FILE_2, "r");
> +	if (fseek(fp2, off_out_ori, SEEK_SET))
> +		tst_brk(TBROK | TERRNO, "fseek() failed");
> +
> +	do {
> +		ch1 = getc(fp1);
> +		ch2 = getc(fp2);
> +		count++;
> +	} while ((count < len_ori) && (ch1 == ch2));
> +
> +	if (ch1 == ch2) {
> +		tst_res(TPASS, "file contents match %ld bytes", len_ori);
> +		/*
> +		 * If off_in is NULL, the file offset is adjusted by the number of bytes
> copied.
> +		 * If off_in is not NULL, the file offset of fd_in is not changed, but
> off_in is
> +		 * adjusted appropriately.
> +		 */
> +		if (!tc->off_in) {
> +			if (SAFE_LSEEK(fd_in, 0, SEEK_CUR) == SAFE_LSEEK(fd_out, 0, SEEK_CUR))
> +				tst_res(TPASS, "file offset are same");
> +			else
> +				tst_res(TFAIL, "file offset are not same");
> +		} else {
> +			if (*(tc->off_in) == (off_in_ori + len_ori))
> +				tst_res(TPASS, "file off_in changed correctly");

What about off_out?

Regards,
Jan
