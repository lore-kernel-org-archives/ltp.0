From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 03 May 2018 09:45:11 +0200
Subject: [LTP] LTP master testing on arm64 hikey
In-Reply-To: <CA+G9fYs7gNR1PF-0iBZSDwMvhcao9Q-3FXyY4o_rXOJp7Eg-wQ@mail.gmail.com>
References: <CA+G9fYtDbxYEjA6T=0cf5wL-9VentRkmKZPHP7dxGCwk-NBOXQ@mail.gmail.com>
 <878t92l2i9.fsf@rpws.prws.suse.cz>
 <CA+G9fYs7gNR1PF-0iBZSDwMvhcao9Q-3FXyY4o_rXOJp7Eg-wQ@mail.gmail.com>
Message-ID: <876045kws8.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Naresh Kamboju writes:

> On 2 May 2018 at 16:59, Richard Palethorpe <rpalethorpe@suse.de> wrote:
>> Hello,
>>
>> Naresh Kamboju writes:
>>
>>> LTP master branch tested on arm64 Hikey device and we have noticed
>>> following observations,
>>>
>>>
>>> LTP Syscalls,
>>> -------------------
>>> utimensat01 1 TBROK: can't read /etc/sudoers
>>> https://lkft.validation.linaro.org/scheduler/job/203110#L12218
>>>
>>> LTP fs,
>>>
>>> The newly added test cases failed.
>>>
>>> read_all_dev: fail
>>> read_all_proc: fail
>>> read_all_sys: fail
>>
>> Well the retrying messages are definitely not helpful, I think we should
>> remove them.
>>
>> My guess is that one or more of the read_all tests read one or more
>> buggy sys files causing the stack traces (probably one which is exposed
>> by a driver). On the other hand it could just be that the board can not
>> handle having so many files read in parallel.
>>
>> I would start by running "./read_all -d /dev -e '/dev/watchdog?(0)'"
>> manually. See ./read_all --help and the fs runtest file.
>
> I have run these steps manually on the board here is the output.
> read_all is reading all /dev/ entries.
>
>
> + ./read_all -d /dev -e '/dev/watchdog?(0)'
> tst_test.c:1015: [1;34mINFO: [0mTimeout per run is 0h 05m 00s
> read_all.c:221: [1;34mINFO: [0mread(/dev/dri/card0): EAGAIN/EWOULDBLOCK
> read_all.c:221: [1;34mINFO: [0mread(/dev/rfkill): EAGAIN/EWOULDBLOCK
> [   26.533620] tun: Universal TUN/TAP device driver, 1.6
> read_all.c:221: [1;34mINFO: [0mread(/dev/net/tun): EBADFD
> [   26.621183] raid6: int64x1  gen()   350 MB/s
> [   26.693131] raid6: int64x1  xor()   437 MB/s
> <>
> read_all.c:221: [1;34mINFO: [0mread(/dev/tty0): EAGAIN/EWOULDBLOCK
> read_all.c:221: [1;34mINFO: [0mread(/dev/console): EAGAIN/EWOULDBLOCK
> read_all.c:221: [1;34mINFO: [0mread(/dev/tty): EIO
> tst_test.c:339: [1;31mBROK: [0mChild (3156) killed by signal SIGSEGV
> Summary:
> passed   0
> failed   0
> skipped  0
> warnings 0
>
>
> https://pastebin.com/G698sFP6
>
>
> LTP fs read_all test log,
> https://lkft.validation.linaro.org/scheduler/job/203359#L1340
>
> - Naresh

It is still not clear which file is the problem. So we should limit it
to one thread and print all the reads:

./read_all -v -w 1 -d /dev -e '/dev/watchdog?(0)'

You may need to run it on sub directories in /dev to limit the number of
files which are queued for reading.

--
Thank you,
Richard.
