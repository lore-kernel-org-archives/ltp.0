From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Sep 2020 15:13:27 +0200
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
 <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
Message-ID: <20200909131327.GA3241@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Sounds reasonable. I tried to reserve more space for the mapping grows,
> > and that works for me:).
> >
> 
> To precisely, we could reserve 256 pages size at the end of the free-range
> memory to let the stack keep away from a preceding mapping in its growing
> then.
> (my only concern is the stack_guard_gap can be changed via kernel command
> line, but I assume that happen rarely, so here use the default 256 pages)
> 
> If there is no objection, I'd make these changes in patch V4.
> 
> --------
> 
> static void *find_free_range(size_t size)
> {
>     void *mem;
>     long stack_guard_gap = 256 * getpageszie();
> 
>     /*
>     * Since the newer kernel does not allow a MAP_GROWSDOWN mapping to grow
>     * closer than stack_guard_gap pages away from a preceding mapping.
>     * The guard then ensures that the next-highest mapped page remains more
>     * than stack_guard_gap below the lowest stack address, and if not then
>     * it will trigger a segfault. So, here let's reserve 256 pages memory
>     * spacing for stack growing safely.
>     */
>     mem = SAFE_MMAP(NULL, size + stack_guard_gap, PROT_READ | PROT_WRITE,
>                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>     SAFE_MUNMAP(mem, size + stack_guard_gap);
> 
>     return mem;
> }
> 
> static void split_unmapped_plus_stack(void *start, size_t size)
> {
>     /* start           start + size
>     * +---------------------+----------------------+-----------+
>     * + unmapped            | mapped               | 256 pages |
>     * +---------------------+----------------------+-----------+
>     *                       stack
>     */

Shouldn't the 256 pages follow the unmapped part?

If I'm not mistaken if stack grows down the address decreases with stack
allocations, so it should be as:

| 256 pages | unmapped | mapped |


That would also mean that we should map the stack at address start +
total_size - size if I'm not mistaken. I guess that we can put all the
mess into a single function as well and have just allocate_stack() that
will find a suitable address, mmap the stack together, splitting this
into two functions is unnecessary confusing.

>     stack = SAFE_MMAP(start + size, size, PROT_READ | PROT_WRITE,
>                              MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS |
> MAP_GROWSDOWN,
>                              -1, 0);
> }

Also I would like to get rid of the -fno-optimize-sibling-calls in the
Makefile, this makes the test a bit fragile and less portable.

-- 
Cyril Hrubis
chrubis@suse.cz
