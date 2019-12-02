From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 2 Dec 2019 07:30:59 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E3?=
 =?utf-8?q?=2E13-3b5f971=2Ecki_=28stable-queue=29?=
In-Reply-To: <8736e3ffen.fsf@mpe.ellerman.id.au>
References: <cki.6C6A189643.3T2ZUWEMOI@redhat.com>
 <1738119916.14437244.1575151003345.JavaMail.zimbra@redhat.com>
 <8736e3ffen.fsf@mpe.ellerman.id.au>
Message-ID: <1420623640.14527843.1575289859701.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> Jan Stancek <jstancek@redhat.com> writes:
> > ----- Original Message -----
> >> 
> >> Hello,
> >> 
> >> We ran automated tests on a recent commit from this kernel tree:
> >> 
> >>        Kernel repo:
> >>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
> >>             Commit: 3b5f97139acc - KVM: PPC: Book3S HV: Flush link stack
> >>             on
> >>             guest exit to host kernel
> 
> I can't find this commit, I assume it's roughly the same as:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.3.y&id=0815f75f90178bc7e1933cf0d0c818b5f3f5a20c

Hi,

yes, that looks like same one:
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?h=3b5f97139acc

Looking at CKI reports for past 2 weeks, there were 3 (unexplained) SIGBUS related failures:

5.3.13-3b5f971.cki@upstream-stable
LTP genpower Bus error

5.4.0-rc8-4b17a56.cki@upstream-stable
LTP genatan Bus error

5.3.11-200.fc30
xfstests
+/var/lib/xfstests/tests/generic/248: line 38: 161943 Bus error               (core dumped) $TEST_PROG $TESTFILE

All 3 are from ppc64le, all power9 systems.

> 
> >> The results of these automated tests are provided below.
> >> 
> >>     Overall result: FAILED (see details below)
> >>              Merge: OK
> >>            Compile: OK
> >>              Tests: FAILED
> >> 
> >> All kernel binaries, config files, and logs are available for download
> >> here:
> >> 
> >>   https://artifacts.cki-project.org/pipelines/314344
> >> 
> >> One or more kernel tests failed:
> >> 
> >>     ppc64le:
> >>      ? LTP
> >
> > I suspect kernel bug.
> 
> Looks that way, but I can't reproduce it on a machine here.
> 
> I have the same CPU revision and am booting the exact kernel binary &
> modules linked above.

I can semi-reliably reproduce it with:
(where LTP is installed to /mnt/testarea/ltp)

while [ True ]; do
        echo 3 > /proc/sys/vm/drop_caches
        rm -f /mnt/testarea/ltp/results/RUNTEST.log /mnt/testarea/ltp/output/RUNTEST.run.log
        ./runltp -p -d results -l RUNTEST.log -o RUNTEST.run.log -f math
        grep FAIL /mnt/testarea/ltp/results/RUNTEST.log && exit 1
done

and some stress activity in other terminal (e.g. kernel build).
Sometimes in minutes, sometimes in hours. I did try couple
older kernels and could reproduce it with v4.19 and v5.0 as well.

v4.18 ran OK for 2 hours, assuming that one is good, it could be
related to xfs switching to iomap in 4.19-rc1.

Tracing so far led me to filemap_fault(), where it reached this -EIO,
before returning SIGBUS.

page_not_uptodate:
        /*
         * Umm, take care of errors if the page isn't up-to-date.
         * Try to re-read it _once_. We do this synchronously,
         * because there really aren't any performance issues here
         * and we need to check for errors.
         */
        ClearPageError(page);
        fpin = maybe_unlock_mmap_for_io(vmf, fpin);
        error = mapping->a_ops->readpage(file, page);
        if (!error) {
                wait_on_page_locked(page);
                if (!PageUptodate(page))
                        error = -EIO;
        }

...
        return VM_FAULT_SIGBUS;

> 
> > There were couple of 'math' runtest related failures in recent couple days.
> > In all cases, some data file used by test was missing. Presumably because
> > binary that generates it crashed.
> >
> > I managed to reproduce one failure with this CKI build, which I believe
> > is the same problem.
> >
> > We crash early during load, before any LTP code runs:
> >
> > (gdb) r
> > Starting program: /mnt/testarea/ltp/testcases/bin/genasin
> 
> What is this /mnt/testarea? Looks like it's setup by some of the beaker
> scripts or something?

Correct, it's where beaker script installs LTP. It's not a real mount,
just a directory on /. In my case it's xfs. It should match default
Fedora-31 Server ppc64le installation.

> 
> I'm running LTP out of /home, which is ext4 directly on disk.
> 
> I tried getting the tests-beaker stuff working on my machine, but I
> couldn't find all the libraries and so on it requires.
> 
> 
> > Program received signal SIGBUS, Bus error.
> > dl_main (phdr=0x10000040, phnum=<optimized out>, user_entry=0x7fffffffe760,
> > auxv=<optimized out>) at rtld.c:1362
> > 1362        switch (ph->p_type)
> > (gdb) bt
> > #0  dl_main (phdr=0x10000040, phnum=<optimized out>,
> > user_entry=0x7fffffffe760, auxv=<optimized out>) at rtld.c:1362
> > #1  0x00007ffff7fcf3c8 in _dl_sysdep_start (start_argptr=<optimized out>,
> > dl_main=0x7ffff7fb37b0 <dl_main>) at ../elf/dl-sysdep.c:253
> > #2  0x00007ffff7fb1d1c in _dl_start_final (arg=arg@entry=0x7fffffffee20,
> > info=info@entry=0x7fffffffe870) at rtld.c:445
> > #3  0x00007ffff7fb2f5c in _dl_start (arg=0x7fffffffee20) at rtld.c:537
> > #4  0x00007ffff7fb14d8 in _start () from /lib64/ld64.so.2
> > (gdb) f 0
> > #0  dl_main (phdr=0x10000040, phnum=<optimized out>,
> > user_entry=0x7fffffffe760, auxv=<optimized out>) at rtld.c:1362
> > 1362        switch (ph->p_type)
> > (gdb) l
> > 1357      /* And it was opened directly.  */
> > 1358      ++main_map->l_direct_opencount;
> > 1359
> > 1360      /* Scan the program header table for the dynamic section.  */
> > 1361      for (ph = phdr; ph < &phdr[phnum]; ++ph)
> > 1362        switch (ph->p_type)
> > 1363          {
> > 1364          case PT_PHDR:
> > 1365            /* Find out the load address.  */
> > 1366            main_map->l_addr = (ElfW(Addr)) phdr - ph->p_vaddr;
> >
> > (gdb) p ph
> > $1 = (const Elf64_Phdr *) 0x10000040
> >
> > (gdb) p *ph
> > Cannot access memory at address 0x10000040
> >
> > (gdb) info proc map
> > process 1110670
> > Mapped address spaces:
> >
> >           Start Addr           End Addr       Size     Offset objfile
> >           0x10000000         0x10010000    0x10000        0x0
> >           /mnt/testarea/ltp/testcases/bin/genasin
> >           0x10010000         0x10030000    0x20000        0x0
> >           /mnt/testarea/ltp/testcases/bin/genasin
> >       0x7ffff7f90000     0x7ffff7fb0000    0x20000        0x0 [vdso]
> >       0x7ffff7fb0000     0x7ffff7fe0000    0x30000        0x0
> >       /usr/lib64/ld-2.30.so
> >       0x7ffff7fe0000     0x7ffff8000000    0x20000    0x20000
> >       /usr/lib64/ld-2.30.so
> >       0x7ffffffd0000     0x800000000000    0x30000        0x0 [stack]
> >
> > (gdb) x/1x 0x10000040
> > 0x10000040:     Cannot access memory at address 0x10000040
> 
> Yeah that's weird.
> 
> > # /mnt/testarea/ltp/testcases/bin/genasin
> > Bus error (core dumped)
> >
> > However, as soon as I copy that binary somewhere else, it works fine:
> >
> > # cp /mnt/testarea/ltp/testcases/bin/genasin /tmp
> > # /tmp/genasin
> > # echo $?
> > 0
> 
> Is /tmp a real disk or tmpfs?

tmpfs

Filesystem                           Type      1K-blocks     Used  Available Use% Mounted on
devtmpfs                             devtmpfs  254530176        0  254530176   0% /dev
tmpfs                                tmpfs     267992768        0  267992768   0% /dev/shm
tmpfs                                tmpfs     267992768     9152  267983616   1% /run
/dev/mapper/fedora_ibm--p9b--03-root xfs        15718400 13029284    2689116  83% /
tmpfs                                tmpfs     267992768        0  267992768   0% /tmp
/dev/sda1                            xfs         1038336   944588      93748  91% /boot
tmpfs                                tmpfs      53598528        0   53598528   0% /run/user/0

