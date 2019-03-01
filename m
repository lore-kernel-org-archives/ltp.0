From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2019 14:05:35 +0800
Subject: [LTP] [RFC PATCH] mm: rewrite mtest01 with new API
In-Reply-To: <646940042.3510845.1551391739985.JavaMail.zimbra@redhat.com>
References: <20190228074002.14351-1-liwang@redhat.com>
 <646940042.3510845.1551391739985.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2d1NFFP8aQs96W-4r-OSBoXkd86TD92wp3ZZxzrhygQyw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 1, 2019 at 6:09 AM Jan Stancek <jstancek@redhat.com> wrote:

Current behaviour varies a lot depending on system. I'm thinking if we
> should
> just set it to 80% of free RAM. We already have number of OOM tests,
> so maybe we don't need to worry about memory pressure here too.
>

Yes, I'm ok with that change. Since if we decrease the allocated
consumption to 50% mem+swap, that probably only do allocating in the part
of free mem too.


> > +
> > +     act.sa_handler = handler;
> > +     act.sa_flags = 0;
> > +     sigemptyset(&act.sa_mask);
> > +     sigaction(SIGRTMIN, &act, 0);
>
> I was thinking if we can't "abuse" tst_futexes a bit. It's a piece of
> shared memory we already have and could use for an atomic counter.
>
> <snip>
>
> > +     /* waits in the loop for all children finish allocating*/
> > +     while(pid_count < pid_cntr)
> > +             sleep(1);
>
> What happens if one child hits OOM?
>

LTP new API does wait and check child status for the test, if one
child_A(allocating finished and status paused) hits OOM, it will just break
and report status, but that's ok for this event, because other children
which still allocating will keep running after system reclaiming memory
from child_A. So parent process will recieve all of children's SIGRTMIN
signal and break from the while loop correctly.

Anthoer situation(I haven't hit), is one child_B(still allocating and not
finishes) was killed by OOM. that will make parent fall into an infinite
loop here. From OOM mechanism, oom-killer likes to choose high score
process, so this situation maybe not easy to reproduce. But that not mean
it will not, since oom-killer is not perfect.

Anyway, to avoid the second situation occuring, I'd like to take you advice
to make parent exiting loop safly with many check actions.


> >
> > -             if (sigchld_count) {
> > -                     tst_resm(TFAIL, "child process exited
> unexpectedly");
> > -             } else if (dowrite) {
> > -                     tst_resm(TPASS, "%llu kbytes allocated and used.",
> > -                              original_maxbytes / 1024);
> > -             } else {
> > -                     tst_resm(TPASS, "%llu kbytes allocated only.",
> > -                              original_maxbytes / 1024);
> > -             }
> > +     if (dowrite) {
> > +             sysinfo(&sstats);
> > +             /* Total Free Post-Test RAM */
> > +             post_mem = (unsigned long long)sstats.mem_unit *
> sstats.freeram;
> > +             post_mem = post_mem + (unsigned long long)sstats.mem_unit *
> > sstats.freeswap;
> >
> > +             if (((pre_mem - post_mem) < original_maxbytes))
> > +                     tst_res(TFAIL, "kbytes allocated and used less
> than expected %llu",
> > +                                     original_maxbytes / 1024);
> > +             else
> > +                     tst_res(TPASS, "%llu kbytes allocated and used",
> > +                                     original_maxbytes / 1024);
> > +     } else {
> > +             tst_res(TPASS, "%llu kbytes allocated only",
> > +                             original_maxbytes / 1024);
> > +     }
> > +
> > +     i = 0;
> > +     while (pid_list[i] > 0) {
> > +             kill(pid_list[i], SIGCONT);
> > +             i++;
> >       }
> > -     cleanup();
> > -     tst_exit();
> >  }
> > +
> > +static struct tst_test test = {
> > +     .forks_child = 1,
> > +     .options = mtest_options,
> > +     .setup = setup,
> > +     .cleanup = cleanup,
> > +     .test_all = mem_test,
>
> Is default timeout going to work on large boxes (256GB+ RAM)?
>

No.

I had the same worries before, but in this test, the number of
children(max_pids) will be increased dynamically with the system total
memory size. And each child allocating won't beyond the 'alloc_bytes'
(alloc_bytes = MIN(THREE_GB, alloc_maxbytes)) limitaion, so an extra time
consumption part is just by forking, but from my evaluation on a 4T ram
system, mtest01 finishes very faster(99% mem+swap, 2m22sec) than I
expected. So the default timeout is not trigger at all.

# cat /proc/meminfo  | grep Mem
MemTotal:       4227087524 kB
MemFree:        4223159948 kB
MemAvailable:   4213257308 kB

# time ./mtest01 -p99 -w
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
mtest01.c:113: INFO: Total memory already used on system = 3880348 kbytes
mtest01.c:120: INFO: Total memory used needed to reach maximum = 4188969005
kbytes
mtest01.c:134: INFO: Filling up 99% of ram which is 4185088657 kbytes
...
mtest01.c:185: INFO: ... 3221225472 bytes allocated and used in child 41779
mtest01.c:281: PASS: 4185132681 kbytes allocated and used
...

real 2m22.213s
user 79m52.390s
sys 351m56.059s


>
> Thinking loud, what if...
> - we define at the start of test how much memory we want to allocate
> (target == 80% of free RAM)
> - we allocate a shared memory for counter, that each child increases
>   as it allocates memory (progress)
>   (or we abuse tst_futexes)
>   we could use tst_atomic_add_return() to count allocated chunks globally
> - once child finishes allocation it will pause()
> - we set timeout to ~3 minutes
> - main process runs in loop, sleeps, and periodically checks
>   - if progress reached target, PASS, break
>   - if progress hasn't increased in last 15 seconds, FAIL, break
>   - if we are 15 seconds away from timeout, end test early, PASS, break
>     (reason is to avoid running too long on big boxes)
> - kill all children, exit
>
>
Real good suggestions, I will try to take some of them in V2.


> Regards,
> Jan
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190301/65522666/attachment.html>
