From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2017 17:15:07 +0800
Subject: [LTP] [PATCH] syscalls: add new test for copy_file_range(2)
In-Reply-To: <1294959175.28252852.1492517193554.JavaMail.zimbra@redhat.com>
References: <20170417054839.24444-1-liwang@redhat.com>
 <1294959175.28252852.1492517193554.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eBbULv1bX3Ymm991c6HeyenyCeppTgpOZi=c6E7rk_RQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 18, 2017 at 8:06 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>
> <snip>
>
>> +static void copy_file_range_verify(void)
>> +{
>> +     int fd_in, fd_out;
>> +     struct stat stat;
>> +     loff_t len;
>> +
>> +     fd_in = SAFE_OPEN(TEST_FILE_1, O_RDONLY);
>> +     SAFE_FSTAT(fd_in, &stat);
>> +     len = stat.st_size;
>> +     fd_out = SAFE_OPEN(TEST_FILE_2, O_CREAT | O_WRONLY | O_TRUNC, 0644);
>> +
>> +     /*
>> +      * copy_file_range() will return the number of bytes copied between files.
>> +      * This could be less than the length originally requested.
>> +      */
>> +     do {
>> +             TEST(copy_file_range(fd_in, NULL, fd_out, NULL, len, 0));
>> +             if (TEST_RETURN == -1)
>> +                     tst_res(TFAIL | TTERRNO, "copy_file_range() failed");
>
> break here? Otherwise this will loop for a while (until len overflows).

Ah, yes.

>
>> +
>> +             len -= TEST_RETURN;
>> +     } while (len > 0);
>> +
>> +     tst_res(TPASS, "copy_file_range() returned %ld", TEST_RETURN);
>
> This currently doesn't check anything. How about we at least check:
> - that file offset is adjusted in both files by same amount
> - compare that data in fd_out equals to original data
>
> Or better, define interesting values for each parameter
> and test all combinations. For example:
>
> off_in: NULL, 1, getpagesize()-1, getpagesize(), getpagesize()+1
> off_out: NULL, 1, getpagesize()-1, getpagesize(), getpagesize()+1
> len: 0, 1, getpagesize()-1, getpagesize(), getpagesize()+1
>
> And for each combination check that file offsets have expected value
> and file contents match.

Good proposal! I'm going to achieve this better way in Patch V2. Thanks!

>
> Regards,
> Jan
>
>> +
>> +     SAFE_CLOSE(fd_in);
>> +     SAFE_CLOSE(fd_out);
>> +}
>> +
>> +static struct tst_test test = {
>> +     .tid = "copy_file_range01",
>> +     .setup = setup,
>> +     .needs_tmpdir = 1,
>> +     .test_all = copy_file_range_verify,
>> +};
>> --
>> 2.9.3
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
