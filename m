From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 7 Nov 2018 13:50:58 -0200
Subject: [LTP] [PATCH v2 1/2] syscalls/fremovexattr: Add fremovexattr()
	tests
In-Reply-To: <20181107153855.GA8153@rei>
References: <CABdQkv_WgpXPyeNzKRBhkgRg4vMPU7oRCgC1i=tv_TSEkg7buw@mail.gmail.com>
 <20181105002536.29715-1-rafael.tinoco@linaro.org> <20181107153855.GA8153@rei>
Message-ID: <CABdQkv85Pq=Zg2yEifuE7cGWONaKLfda=THjrKHOeBN_SqmkAw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>> +static int fd = -1;
>> +static char *got_value;
>
> Why not just static char got_value[XATTR_TEST_VALUE_SIZE]?

Of course =o) !! Will do.

>> +static void cleanup(void)
>> +{
>> +     free(got_value);
>> +
>> +     close(fd);
>         ^
>         if (fd > 0)
>                 SAFE_CLOSE(fd);

Missed this.

>
>         would be slightly better here as it would emit
>         warning if the close() has failed.
>
>> +}
>> +
>> +static void setup(void)
>> +{
>> +     SAFE_TOUCH(FNAME, 0644, NULL);
>> +
>> +     fd = SAFE_OPEN(FNAME, O_RDWR, NULL);
>                                       ^
>                                       open() is a variable argument
>                                       function and the third argument is
>                                       an integer but only in a case that
>                                       we passed O_CREAT in the flags, if
>                                       we are not creating the file
>                                       it should be omitted

Sure! Auto mode, sorry.


>> +++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
>> ...
>> +     SAFE_TOUCH(FNAME, 0644, NULL);
>> +     fd = SAFE_OPEN(FNAME, O_RDWR, NULL);
>
> Here as well no need for the SAFE_TOUCH().

Same.

>> +static struct tst_test test = {
>> +     .setup = setup,
>> +     .test = verify_fremovexattr,
>> +     .cleanup = cleanup,
>> +     .tcnt = ARRAY_SIZE(tc),
>> +     .mntpoint = MNTPOINT,
>> +     .mount_device = 1,
>> +     .all_filesystems = 1,
>> +     .needs_tmpdir = 1,
>> +     .needs_root = 1,
>> +};
>
> I'm wondering if we need the all_filesystem here, I guess that the
> ENODATA test will reach down to the filesystem driver, so it's probably
> relevant here.

Yep.. that is what I though.

Tks a lot Cyril, will send a v3.

o/
