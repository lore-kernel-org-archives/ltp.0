From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 Oct 2020 22:30:11 +0530
Subject: [LTP] mmstress[1309]: segfault at 7f3d71a36ee8 ip
 00007f3d77132bdf sp 00007f3d71a36ee8 error 4 in
 libc-2.27.so[7f3d77058000+1aa000]
In-Reply-To: <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
References: <CA+G9fYvHze+hKROmiB0uL90S8h9ppO9S9Xe7RWwv808QwOd_Yw@mail.gmail.com>
 <CAHk-=wg5-P79Hr4iaC_disKR2P+7cRVqBA9Dsria9jdVwHo0+A@mail.gmail.com>
 <CA+G9fYv=DUanNfL2yza=y9kM7Y9bFpVv22Wd4L9NP28i0y7OzA@mail.gmail.com>
 <CA+G9fYudry0cXOuSfRTqHKkFKW-sMrA6Z9BdQFmtXsnzqaOgPg@mail.gmail.com>
 <CAHk-=who8WmkWuuOJeGKa-7QCtZHqp3PsOSJY0hadyywucPMcQ@mail.gmail.com>
 <CAHk-=wi=sf4WtmZXgGh=nAp4iQKftCKbdQqn56gjifxWNpnkxw@mail.gmail.com>
 <CAEUSe78A4fhsyF6+jWKVjd4isaUeuFWLiWqnhic87BF6cecN3w@mail.gmail.com>
 <CAHk-=wgqAp5B46SWzgBt6UkheVGFPs2rrE6H4aqLExXE1TXRfQ@mail.gmail.com>
Message-ID: <CA+G9fYu5aGbMHaR1tewV9dPwXrUR5cbGHJC1BT=GSLsYYwN6Nw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 23 Oct 2020 at 08:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 22, 2020 at 6:36 PM Daniel D?az <daniel.diaz@linaro.org> wrote:
> >
> > The kernel Naresh originally referred to is here:
> >   https://builds.tuxbuild.com/SCI7Xyjb7V2NbfQ2lbKBZw/
>
> is unnecessary (because the 8-byte case is still just a single
> register, no %eax:%edx games needed), it would be interesting to hear
> if the attached patch fixes it. That would confirm that the problem
> really is due to some register allocation issue interaction (or,
> alternatively, it would tell me that there's something else going on).

[Old patch from yesterday]

After applying your patch on top on linux next tag 20201015
there are two observations,
  1) i386 build failed. please find build error build
  2) x86_64 kasan test PASS and the reported error not found.


i386 build failure,
----------------------
make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=i386 HOSTCC=gcc
CC="sccache gcc" O=build
#
In file included from ../include/linux/uaccess.h:11,
                 from ../arch/x86/include/asm/fpu/xstate.h:5,
                 from ../arch/x86/include/asm/pgtable.h:26,
                 from ../include/linux/pgtable.h:6,
                 from ../include/linux/mm.h:33,
                 from ../include/linux/memblock.h:13,
                 from ../fs/proc/page.c:2:
../fs/proc/page.c: In function ?kpagecgroup_read?:
../arch/x86/include/asm/uaccess.h:217:2: error: inconsistent operand
constraints in an ?asm?
  217 |  asm volatile("call __" #fn "_%P[size]"    \
      |  ^~~
../arch/x86/include/asm/uaccess.h:244:44: note: in expansion of macro
?do_put_user_call?
  244 | #define put_user(x, ptr) ({ might_fault();
do_put_user_call(put_user,x,ptr); })
      |                                            ^~~~~~~~~~~~~~~~
../fs/proc/page.c:307:7: note: in expansion of macro ?put_user?
  307 |   if (put_user(ino, out)) {
      |       ^~~~~~~~
make[3]: *** [../scripts/Makefile.build:283: fs/proc/page.o] Error 1
make[3]: Target '__build' not remade because of errors.
make[2]: *** [../scripts/Makefile.build:500: fs/proc] Error 2
In file included from ../include/linux/uaccess.h:11,
                 from ../include/linux/sched/task.h:11,
                 from ../include/linux/sched/signal.h:9,
                 from ../include/linux/rcuwait.h:6,
                 from ../include/linux/percpu-rwsem.h:7,
                 from ../include/linux/fs.h:33,
                 from ../include/linux/cgroup.h:17,
                 from ../include/linux/memcontrol.h:13,
                 from ../include/linux/swap.h:9,
                 from ../include/linux/suspend.h:5,
                 from ../kernel/power/user.c:10:
../kernel/power/user.c: In function ?snapshot_ioctl?:
../arch/x86/include/asm/uaccess.h:217:2: error: inconsistent operand
constraints in an ?asm?
  217 |  asm volatile("call __" #fn "_%P[size]"    \
      |  ^~~
../arch/x86/include/asm/uaccess.h:244:44: note: in expansion of macro
?do_put_user_call?
  244 | #define put_user(x, ptr) ({ might_fault();
do_put_user_call(put_user,x,ptr); })
      |                                            ^~~~~~~~~~~~~~~~
../kernel/power/user.c:340:11: note: in expansion of macro ?put_user?
  340 |   error = put_user(size, (loff_t __user *)arg);
      |           ^~~~~~~~
../arch/x86/include/asm/uaccess.h:217:2: error: inconsistent operand
constraints in an ?asm?
  217 |  asm volatile("call __" #fn "_%P[size]"    \
      |  ^~~
../arch/x86/include/asm/uaccess.h:244:44: note: in expansion of macro
?do_put_user_call?
  244 | #define put_user(x, ptr) ({ might_fault();
do_put_user_call(put_user,x,ptr); })
      |                                            ^~~~~~~~~~~~~~~~
../kernel/power/user.c:346:11: note: in expansion of macro ?put_user?
  346 |   error = put_user(size, (loff_t __user *)arg);
      |           ^~~~~~~~
../arch/x86/include/asm/uaccess.h:217:2: error: inconsistent operand
constraints in an ?asm?
  217 |  asm volatile("call __" #fn "_%P[size]"    \
      |  ^~~
../arch/x86/include/asm/uaccess.h:244:44: note: in expansion of macro
?do_put_user_call?
  244 | #define put_user(x, ptr) ({ might_fault();
do_put_user_call(put_user,x,ptr); })
      |                                            ^~~~~~~~~~~~~~~~
../kernel/power/user.c:357:12: note: in expansion of macro ?put_user?
  357 |    error = put_user(offset, (loff_t __user *)arg);
      |            ^~~~~~~~


x86_64 Kasan tested and the reported issue not found.
https://lkft.validation.linaro.org/scheduler/job/1868029#L2374

- Naresh
