From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 7 Mar 2019 14:02:52 +0800
Subject: [LTP] [PATCH DRAFT] syscalls/stime: convert to new lib,
 use direct syscall
In-Reply-To: <20190301144831.GA16823@rei>
References: <20190202015923.189057-1-smuckle@google.com>
 <20190301144831.GA16823@rei>
Message-ID: <5C80B40C.7070106@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Steve

According to the source code of glibc, glibc implements stime() by 
__NR_settimeofday
instead of __NR_stime, and some arches(e.g. x86_64) don't define 
__NR_stime directly.
Therefore these updated tests will be skipped on some arches that don't 
define __NR_stime.

If glibc implements stime(), should we use it diectly?  If not, should 
we use __NR_stime or __NR_settimeofday?

Please see detail at sysdeps/unix/stime.c in glibc:
-------------------------------------------------------------------
int
stime (const time_t *when)
{
   struct timeval tv;

   if (when == NULL)
     {
       __set_errno (EINVAL);
       return -1;
     }

   tv.tv_sec = *when;
   tv.tv_usec = 0;
   return __settimeofday (&tv, (struct timezone *) 0);
-------------------------------------------------------------------

Best Regards,
Xiao Yang
On 2019/03/01 22:48, Cyril Hrubis wrote:
> Hi!
>> I set about cleaning up the stime tests but later realized I don't
>> have a platform that has the stime syscall so I cannot test this
>> patch fully. If someone else has such a platform (looks like 32-bit
>> x86 has it) and wants to take the patch over, feel free :) .
> I've taken over and finished the patchset, thanks.
>
> Also btw, you can test these testcases on x86_64 if you compile LTP with
> -m32 flag with:
>
> CFLAGS=-m32 LDFLAGS=-m32 ./configure
>



