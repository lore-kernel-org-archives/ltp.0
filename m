From: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Date: Wed, 17 Aug 2016 13:08:29 +1200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <1471390910.2680.20.camel@poochiereds.net>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
 <1471390910.2680.20.camel@poochiereds.net>
Message-ID: <CAKgNAki43uuQ7tqTkKkUo30Fq3iZGgMsb4fWZ+N2oFFJUXqXLQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jeff,

Thanks for jumping in.

On 17 August 2016 at 11:41, Jeff Layton <jlayton@poochiereds.net> wrote:
> On Wed, 2016-08-17 at 08:04 +1200, Michael Kerrisk (man-pages) wrote:
>> [Jeff, can you comment?]
>>
>> Hi Cyril,
>>
>> On 08/16/2016 11:55 PM, Cyril Hrubis wrote:
>> >
>> > If we pass struct flock to the F_OFD_XXX fcntl() it will fail with
>> > EINVAL with a 32bit binary. That is because glibc uses fcntl64() by
>> > default but the struct flock uses 32bit off_t for 32bit binaries (unless
>> > _FILE_OFFSET_BITS=64) and kernel always expect flock64 for F_OFD_XXX in
>> > fcntl64(). Hence kernel will read some garbage that is a few bytes after
>> > the 32bit flock structure in this case which will likely end up with the
>> > syscall returning EINVAL.
>>
>> Okay -- I confirm the problem you report. I'm just not sure that the
>> patch below is the best fix. So, to summarize:
>>
>> * On 64-bit, flock{} and flock64{} are the same structure.
>> * On 32-bit, flock{} and flock64{} are different.
>> * On 32-bit, F_OFD operations require flock64{}, but the traditional
>>   F_* lock operations do not.
>> * To use flock64{} with F_OFD operations, we can either explicitly use
>>   flock64{} or we can compile with -D_FILE_OFFSET_BITS=64
>>
>> One solution would be your patch below, but it feels wrong: on 64-bit
>> flock{} suffices, and is consistent with the traditional F_* operations.
>> An alternative would be a note in the man page that says something along
>> the lines that on 32-bit, one must compile with -D_FILE_OFFSET_BITS=64
>> when using the F_OFD operations.
>>
>> Your thoughts?
>>
>> Cheers,
>>
>> Michael
>>
>
> This sounds like a regular old bug, rather than a documentation issue.
>
> The way the kernel works is that if you call fcntl(), then you need to
> pass in a struct flock. If you call fcntl64() then you need to pass in
> a struct flock64. Of course this is only on 32-bit arches. On 64-bit,
> it's there is no flock64 or fcntl64.
>
> Typically, glibc papers over all of this by deciding which syscall it's
> going to use based on -D_FILE_OFFSET_BITS. IIRC, it basically redefines
> the fields in struct flock to be like the one in struct flock64, so you
> shouldn't need to do anything special here.
>
> It sounds here like you got a mismatch, somehow and were calling
> fcntl64() with the smaller struct flock? Or was it vice versa?
>
> What would be ideal would be a small reproducer program, and
> instructions on how to build it. With that we should be able to nail
> down why this is happening.
>
> Also, what arch are you using here?

x86 is enough.

8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef F_OFD_GETLK     /* In case we are on a system with glibc version
                           earlier than 2.20 */
#define F_OFD_GETLK     36
#define F_OFD_SETLK     37
#define F_OFD_SETLKW    38
#endif


#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

#define usageErr(msg, progName) \
                        do { fprintf(stderr, "Usage: "); \
                             fprintf(stderr, msg, progName); \
                             exit(EXIT_FAILURE); } while (0)
int
main(int argc, char *argv[])
{
    int fd;
    struct flock fl;

    if (argc < 2)
        usageErr("%s file\n", argv[0]);

    fd = open(argv[1], O_CREAT | O_RDWR, 0600);
    if (fd == -1)
        errExit("open");

    memset(&fl, 99, sizeof(fl));        /* Ensure any uninitialized
                                           bytes contain junk */

    fl.l_start = 0;
    fl.l_len = 1;
    fl.l_type = F_WRLCK;
    fl.l_whence = SEEK_CUR;
    fl.l_pid = 0;
    if (fcntl(fd, F_OFD_SETLK, &fl) == -1)
        errExit("fcntl");
}

8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---8x---

$ cc -m32 prog.c
$ ./a.out /tmp/x
fcntl: Invalid argument

Cheers,

Michael
