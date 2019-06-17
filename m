From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 17 Jun 2019 12:59:05 +0800
Subject: [LTP] Linux-4.4: pwritev201.c:62: FAIL: pwritev2() failed:
	EINVAL
In-Reply-To: <CA+G9fYvg9va027oZELWkVVp5_YSyL0bZMy0iMVYweT2hh89xVg@mail.gmail.com>
References: <CA+G9fYvg9va027oZELWkVVp5_YSyL0bZMy0iMVYweT2hh89xVg@mail.gmail.com>
Message-ID: <9168a5c0-b3ee-e621-f55c-c5df0ba548ff@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Naresh,


Thank you for reporting the issue.

 From kernel code and manpage, pwritev2() has not been introduced on 
stable kernel v4.4.

glibc also provides pwritev2()  since glibc-2.26 so that you can still 
call pwritev2() by glibc.

But glibc doesn't handle 'offset == -1' correctly before glibc-2.28 
because it just replaces

pwritev2() with pwritev() and calling pwritev() with negative offset 
returns EINVAL.

See the following code in glibc:

----------------------------------------------------------------------------------------------------------------------- 


ssize_t
pwritev2 (int fd, const struct iovec *vector, int count, off_t offset,
           int flags)
{
# ifdef __NR_pwritev2
   ssize_t result = SYSCALL_CANCEL (pwritev2, fd, vector, count,
                                    LO_HI_LONG (offset), flags);
   if (result >= 0)
     return result;
# endif
   /* Trying to emulate the pwritev2 syscall flags is troublesome:

      * We can not temporary change the file state of the O_DSYNC and 
O_SYNC
        flags to emulate RWF_{D}SYNC (attempts to change the state of using
        fcntl are silently ignored).

      * IOCB_HIPRI requires the file opened in O_DIRECT and uses an 
internal
        semantic not provided by any other flag (O_NONBLOCK for 
instance).  */

   if (flags != 0)
     {
       __set_errno (ENOTSUP);
       return -1;
     }
   return pwritev (fd, vector, count, offset);
}
----------------------------------------------------------------------------------------------------------------------- 


This issue has been fixed by commit d4b4a00 since glibc-2.28, so I think 
you should use

glibc-2.28 or newer to test pwritev201 on stable kernel v4.4. Could you 
test pwritev201

with newer glibc again on stable kernel v4.4?

I think it is a known bug of glibc rather than a bug of test case.


Best Regards,

Xiao Yang

On 06/17/2019 10:30 AM, Naresh Kamboju wrote:
> Newly added tests pwritev201 and pwritev201_64 from LTP version
> 20190517 got failed on all devices for Linux 4.4
> do you test this on linux stable  4.4 branch ? do you notice this failure ?
>
> Test PASS on stable 4.9, 4.14 and 4.19 branches.
>
> tst_test.c:1096: INFO: Timeout per run is 0h 15m 00s
> pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
> content 'a' expectedly
> pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
> content 'a' expectedly
> pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
> content 'a' expectedly
> pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
> pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
> pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
> Summary:
> passed   3
> failed   3
> skipped  0
> warnings 0
>
> tst_test.c:1096: INFO: Timeout per run is 0h 15m 00s
> pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
> content 'a' expectedly
> pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
> content 'a' expectedly
> pwritev201.c:96: PASS: pwritev2() wrote 64 bytes successfully with
> content 'a' expectedly
> pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
> pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
> pwritev201.c:62: FAIL: pwritev2() failed: EINVAL
> Summary:
> passed   3
> failed   3
> skipped  0
> warnings 0
>
> Full test log,
> https://lkft.validation.linaro.org/scheduler/job/751027#L9608
>
> Test results comparison link,
> https://qa-reports.linaro.org/_/comparetest/?project=22&project=6&project=58&project=135&project=40&project=23&project=167&suite=ltp-syscalls-tests&test=pwritev201
>
> Best regards
> Naresh Kamboju
>

