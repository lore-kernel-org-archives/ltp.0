From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Nov 2015 10:02:44 -0500 (EST)
Subject: [LTP] [PATCH] mem/oom: don't fail if pthread_create hits EAGAIN
In-Reply-To: <20151126142612.GD9276@rei.lan>
References: <3c782728d90f07391df826231c7327a2ddf38540.1448451542.git.jstancek@redhat.com>
 <20151126142612.GD9276@rei.lan>
Message-ID: <1536996586.18060714.1448550164119.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 26 November, 2015 3:26:12 PM
> Subject: Re: [LTP] [PATCH] mem/oom: don't fail if pthread_create hits EAGAIN
> 
> Hi!
> > In a rare situation on system with many CPUs, small RAM
> > and overcommit_memory == 2, threads that are already started
> > can create memory pressure, that causes pthread_create
> > to hit EAGAIN. Don't fail the test, keep going with threads
> > that are already spawned.
> 
> It took me a while to figure out what are trying to fix, but I think I
> understand now.
> 
> The thing is that if we have many processors the threads running on
> background allocating and faulting memory would counsume available
> memory before the for() loop has chance to finish and the
> ptread_create() starts to fail with EAGAIN, right?

Correct, from my experience it's very rarely seen on powerpc
(probably because of its large page size).

I can trigger it easily on x86 KVM guest (1GB RAM, 4cpus, no swap)
if I modify the test slightly:

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 118b6c0..18a1aa1 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -32,8 +32,10 @@ static int alloc_mem(long int length, int testcase)
        long i, pagesz = getpagesize();
        int loop = 10;
 
+/*
        tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
                (unsigned long) pthread_self(), length);
+*/
 
        s = mmap(NULL, length, PROT_READ | PROT_WRITE,
                 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
@@ -65,7 +67,14 @@ static void *child_alloc_thread(void *args)
 
        /* keep allocating until there's an error */
        while (!ret)
-               ret = alloc_mem(LENGTH, (long)args);
+               ret = alloc_mem(1024*1024, (long)args);
+       ret = 0;
+       while (!ret)
+               ret = alloc_mem(4096, (long)args);
+
+       tst_resm(TINFO, "thread (%lx), done allocating");
+
+       sleep(5);
        exit(ret);
 }
 
@@ -92,6 +101,7 @@ static void child_alloc(int testcase, int lite, int threads)
                        tst_resm(TINFO | TRERRNO, "pthread_create");
                        goto out;
                }
+               sleep(5);
        }
 
        /* wait for one of threads to exit whole process */


# ./oom01 
oom01       0  TINFO  :  set overcommit_memory to 2
oom01       0  TINFO  :  expected victim is 30038.
oom01       0  TINFO  :  thread (ffffffff), done allocating
oom01       0  TINFO  :  pthread_create: TEST_RETURN=EAGAIN/EWOULDBLOCK(11): Resource temporarily unavailable
oom01       1  TFAIL  :  mem.c:163: victim unexpectedly ended with retcode: 1, expected: 12
...


> 
> In that case the fix looks good, acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
