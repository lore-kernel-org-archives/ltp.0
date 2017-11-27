From: Na Nha <minhnhan0801@gmail.com>
Date: Mon, 27 Nov 2017 14:16:27 +0700
Subject: [LTP] <Failling_on_memcg_usage_in_bytes_test.sh>
In-Reply-To: <CAEemH2ccstsUJm+YgGhNy00S54Uki0qDJoKdafHGtsvKJ5CukQ@mail.gmail.com>
References: <CAPiF6Th1sDgRJH2bFb3jX-cBJNVO0s4zmMSH3ezifK7Y9nQCWw@mail.gmail.com>
 <CAEemH2c08B6QaXuqV=a3FT8V6O-yd8WPqR4=d+yME6iubF70Xw@mail.gmail.com>
 <CAPiF6TgVWEt4u+5TmoePBb2=T91j54cFao6LUB2n+jyKT=AatQ@mail.gmail.com>
 <CAEemH2ccstsUJm+YgGhNy00S54Uki0qDJoKdafHGtsvKJ5CukQ@mail.gmail.com>
Message-ID: <CAPiF6Tip6RnQeyEOZLLbf-XZjhTjaFgbWMTUz3Q2X4Jms1j6SA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello Li,



It’s still failed for both cases. Please take a look on result for both:

============================================================
=========================================



root@mx6q:/opt/ltp/testcases/bin# echo 0 > /sys/fs/cgroup/memory/memory.
use_hierarchy

root@mx6q:/opt/ltp/testcases/bin# ./memcg_max_usage_in_bytes_test.sh

memcg_max_usage_in_bytes_test 1 TINFO: Starting test 1

memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 708

memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up:
708

memcg_max_usage_in_bytes_test 1 TPASS: memory.max_usage_in_bytes is 4194304
as expected

memcg_max_usage_in_bytes_test 2 TINFO: Starting test 2

memcg_max_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 2 TINFO: Warming up pid: 728

memcg_max_usage_in_bytes_test 2 TINFO: Process is still here after warm up:
728

memcg_max_usage_in_bytes_test 2 TPASS: memory.memsw.max_usage_in_bytes is
4194304 as expected

memcg_max_usage_in_bytes_test 3 TINFO: Starting test 3

memcg_max_usage_in_bytes_test 3 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 3 TINFO: Warming up pid: 748

memcg_max_usage_in_bytes_test 3 TINFO: Process is still here after warm up:
748

memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is
4325376, 4194304 expected

memcg_max_usage_in_bytes_test 4 TFAIL: memory.max_usage_in_bytes is 131072,
0 expected

memcg_max_usage_in_bytes_test 5 TINFO: Starting test 4

memcg_max_usage_in_bytes_test 5 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 5 TINFO: Warming up pid: 767

memcg_max_usage_in_bytes_test 5 TINFO: Process is still here after warm up:
767

memcg_max_usage_in_bytes_test 5 TPASS: memory.memsw.max_usage_in_bytes is
4194304 as expected

memcg_max_usage_in_bytes_test 6 TPASS: memory.memsw.max_usage_in_bytes is 0
as expected

============================================================
=========================================



root@mx6q:/opt/ltp/testcases/bin# echo 1 > /sys/fs/cgroup/memory/memory.
use_hierarchy

root@mx6q:/opt/ltp/testcases/bin# ./memcg_max_usage_in_bytes_test.sh

memcg_max_usage_in_bytes_test 1 TINFO: Starting test 1

memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 1014

memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up:
1014

memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is
4325376, 4194304 expected

/opt/ltp/testcases/bin/memcg_lib.sh: line 477: echo: write error: Device or
resource busy

memcg_max_usage_in_bytes_test 2 TINFO: restore  /dev/memcg/memory.use_hierarchy
failed

memcg_max_usage_in_bytes_test 2 TINFO: Starting test 2

memcg_max_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 2 TINFO: Warming up pid: 1034

memcg_max_usage_in_bytes_test 2 TINFO: Process is still here after warm up:
1034

memcg_max_usage_in_bytes_test 2 TFAIL: memory.memsw.max_usage_in_bytes is
4325376, 4194304 expected

memcg_max_usage_in_bytes_test 3 TINFO: Starting test 3

memcg_max_usage_in_bytes_test 3 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 3 TINFO: Warming up pid: 1054

memcg_max_usage_in_bytes_test 3 TINFO: Process is still here after warm up:
1054

memcg_max_usage_in_bytes_test 3 TPASS: memory.max_usage_in_bytes is 4194304
as expected

memcg_max_usage_in_bytes_test 4 TPASS: memory.max_usage_in_bytes is 0 as
expected

memcg_max_usage_in_bytes_test 5 TINFO: Starting test 4

memcg_max_usage_in_bytes_test 5 TINFO: Running memcg_process --mmap-anon -s
4194304

memcg_max_usage_in_bytes_test 5 TINFO: Warming up pid: 1075

memcg_max_usage_in_bytes_test 5 TINFO: Process is still here after warm up:
1075

memcg_max_usage_in_bytes_test 5 TPASS: memory.memsw.max_usage_in_bytes is
4194304 as expected

memcg_max_usage_in_bytes_test 6 TPASS: memory.memsw.max_usage_in_bytes is 0
as expected

root@mx6q:/opt/ltp/testcases/bin#



Please help me to resolve the problem!


Trân trọng / Best regards,

*Nhan Le Minh*

On Nov 24, 2017 6:15 PM, "Li Wang" <liwang@redhat.com> wrote:

> On Thu, Nov 23, 2017 at 1:38 AM, Na Nha <minhnhan0801@gmail.com> wrote:
> > Hello Li,
> >
> >
> >
> > Actually, I saw the below log:
>
> That's it. I doubt you hit the same problem as this:
>   https://github.com/linux-test-project/ltp/issues/93
>
> >
> >
> >
> > /opt/ltp/testcases/bin/memcg_lib.sh: line 514: echo: write error:
> > Device or resource busy
> >
> > Or
> >
> > Something like:
> > # mount -t cgroup -omemory memcg /dev/memcg/
> > # mkdir -p /dev/memcg/ltp-test
> > # echo 0 >/dev/memcg/memory.use_hierarchy
> > -bash: echo: write error: Device or resource busy
> >
> >
> >
> > But so strangle, it has just appeared for the first time and it has been
> > passed not failed.
>
> Can you, confirm that whether this test is still failed when
> memory.use_hierarchy is 0?
>
>
> Test A:
> 1, reboot your system
> 2, ehco 0 >/sys/fs/cgroup/memory/memory.use_hierarchy
> 3, Run the ltp testcase: memcg_usage_in_bytes_test.sh
>
>
> Test B:
> 1, reboot
> 2, ehco 1 >/sys/fs/cgroup/memory/memory.use_hierarchy
> 3, Run the ltp testcase: memcg_usage_in_bytes_test.sh
>
>
> Which one(Test A or B?) you can get PASS on your ARM board?
>
>
> >
> > And the following times, it’s still passed. But sometime it’s failed.
> >
> > As mentioned previously, it is a dangling falling, sometimes the test
> result
> > is pass and sometimes is failed
> >
> >
> >
> > I have attached 2 logs file (1 failed, 1 passed log) when I run command
> : sh
> > –x  memcg_usage_in_bytes_test.sh for more detail log.
> >
> > Could you please review those and let me know what I should do next?
> >
> >
> >
> > Trân trọng / Best regards,
> >
> > Nhan Le Minh
> >
>
> Btw, please CC' LTP maillist when response email related to ltp thing. :)
>
> --
> Li Wang
> liwang@redhat.com
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171127/256b10a7/attachment.html>
