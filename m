From: $rik@nth  <srikanth007m@gmail.com>
Date: Sat, 10 Oct 2015 09:32:16 +0530
Subject: [LTP] Fwd: proc01 causing kernel panic
In-Reply-To: <CACwVHNqchOYTKoPWJdLzEvjhJZLAqYCQkuikh5sGqR3Xd7ozog@mail.gmail.com>
References: <CANKSX+HCdoZ2+fk7eTkiiysAHhOds-Vdy87ONhC5ecrHD0C8iw@mail.gmail.com>
 <CANKSX+GV4bFEu1t2OGL1Vww04vzjpWx-5xr9yYwCsZZsM6tUHw@mail.gmail.com>
 <CACwVHNqchOYTKoPWJdLzEvjhJZLAqYCQkuikh5sGqR3Xd7ozog@mail.gmail.com>
Message-ID: <CANKSX+HG56FSN0ovAVspr1OfEXoQLw1+vinBpXBPhnAACDXx_Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I'm trying it on snapdragon 810C dragon board with Linaro Juno android
build. I've compiled two stable versions of 3.10 and 3.18 and
integrated it into android.

Test passed on 3.10 without any issues and on 3.18 i have seen a kernel panic.

tail of strace log
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
lstat64("/proc/tty/ldisc", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
openat(AT_FDCWD, "/proc/tty/ldisc",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 6
getdents(6, /* d_reclen < sizeof(struct kernel_dirent) *//* 1 entries
*/, 32768) = 32
getdents(6, /* 0 entries */, 32768)     = 0
close(6)                                = 0
getdents(5, /* 0 entries */, 32768)     = 0
close(5)                                = 0
lstat64("/proc/driver", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
openat(AT_FDCWD, "/proc/driver",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|O_CLOEXEC) = 5
getdents(5, /* d_reclen < sizeof(struct kernel_dirent) *//* 1 entries
*/, 32768) = 72
lstat64("/proc/driver/rtc", {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
open("/proc/driver/rtc", O_RDONLY|O_NONBLOCK) = 6
read(6, "rtc_time\t: 08:49:41\nrtc_date\t: 1"..., 1024) = 236
read(6, "", 1024)                       = 0
close(6)                                = 0
lstat64("/proc/driver/rndis-000", {st_mode=S_IFREG|0660, st_size=0, ...}) = 0
open("/proc/driver/rndis-000", O_RDONLY|O_NONBLOCK) = 6
read(6,
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

On Sat, Oct 10, 2015@9:01 AM, Sandy Sun <a22017@motorola.com> wrote:
> Hi Srikanth,
>
> Which HW are you testing? Most of time, /proc can't be ready on some HW. It
> would cause kernel panic.
>
> BRs,
> Sandy
>
> On Fri, Oct 9, 2015 at 9:36 PM, $rik@nth <srikanth007m@gmail.com> wrote:
>>
>> Hi LTP,
>>
>> Can anyone help in debugging the proc01 test which is causing the kernel
>> panic.
>>
>> Kernel verison: 3.18
>> LTP Version: LTP-09042015
>>
>> Find the attached kernel signatures. strace file greater than 2MB and
>> i can't forward it to the group.
>>
>> --
>> Thanks & Regards,
>> M.Srikanth Kumar.
>>
>>
>> --
>> Mailing list info: http://lists.linux.it/listinfo/ltp
>>
>



-- 
Thanks & Regards,
M.Srikanth Kumar.
