From: James Morse <james.morse@arm.com>
Date: Fri, 4 May 2018 19:20:11 +0100
Subject: [LTP] LTP master testing on arm64 hikey
In-Reply-To: <876045kws8.fsf@rpws.prws.suse.cz>
References: <CA+G9fYtDbxYEjA6T=0cf5wL-9VentRkmKZPHP7dxGCwk-NBOXQ@mail.gmail.com>
 <878t92l2i9.fsf@rpws.prws.suse.cz>
 <CA+G9fYs7gNR1PF-0iBZSDwMvhcao9Q-3FXyY4o_rXOJp7Eg-wQ@mail.gmail.com>
 <876045kws8.fsf@rpws.prws.suse.cz>
Message-ID: <d82981ae-7fe6-9376-6e17-b58b47170e69@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello!

On 03/05/18 08:45, Richard Palethorpe wrote:
> Naresh Kamboju writes:
>> On 2 May 2018 at 16:59, Richard Palethorpe <rpalethorpe@suse.de> wrote:
>>> Naresh Kamboju writes:
>>>> LTP master branch tested on arm64 Hikey device and we have noticed
>>>> following observations,

>>>> The newly added test cases failed.
>>>>
>>>> read_all_dev: fail
>>>> read_all_proc: fail
>>>> read_all_sys: fail
>>>
>>> Well the retrying messages are definitely not helpful, I think we should
>>> remove them.
>>>
>>> My guess is that one or more of the read_all tests read one or more
>>> buggy sys files causing the stack traces (probably one which is exposed
>>> by a driver). On the other hand it could just be that the board can not
>>> handle having so many files read in parallel.
>>>
>>> I would start by running "./read_all -d /dev -e '/dev/watchdog?(0)'"
>>> manually. See ./read_all --help and the fs runtest file.
>>
>> I have run these steps manually on the board here is the output.
>> read_all is reading all /dev/ entries.

(...this doesn't sound like a great plan...)


>> + ./read_all -d /dev -e '/dev/watchdog?(0)'
>> tst_test.c:1015: [1;34mINFO: [0mTimeout per run is 0h 05m 00s
>> read_all.c:221: [1;34mINFO: [0mread(/dev/dri/card0): EAGAIN/EWOULDBLOCK
>> read_all.c:221: [1;34mINFO: [0mread(/dev/rfkill): EAGAIN/EWOULDBLOCK
>> [   26.533620] tun: Universal TUN/TAP device driver, 1.6
>> read_all.c:221: [1;34mINFO: [0mread(/dev/net/tun): EBADFD
>> [   26.621183] raid6: int64x1  gen()   350 MB/s
>> [   26.693131] raid6: int64x1  xor()   437 MB/s
>> <>
>> read_all.c:221: [1;34mINFO: [0mread(/dev/tty0): EAGAIN/EWOULDBLOCK
>> read_all.c:221: [1;34mINFO: [0mread(/dev/console): EAGAIN/EWOULDBLOCK
>> read_all.c:221: [1;34mINFO: [0mread(/dev/tty): EIO
>> tst_test.c:339: [1;31mBROK: [0mChild (3156) killed by signal SIGSEGV

> It is still not clear which file is the problem. So we should limit it
> to one thread and print all the reads:

I've hit this with read_all touching /dev/port on a system that doesn't have any
PCI IO space.

If you disable CONFIG_DEVPORT does this go away?


Thanks,

James
