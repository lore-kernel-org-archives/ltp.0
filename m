From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Sep 2020 22:41:49 +0800
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200911130836.GA2582@yuki.lan>
References: <20200911035533.30538-1-liwang@redhat.com>
 <20200911130836.GA2582@yuki.lan>
Message-ID: <CAEemH2fPRTh6drs=h=U7OG07SZDgpDfEB0xRadF8Y1FbaHR8Nw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 11, 2020 at 9:08 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> > +static void allocate_stack(size_t size)
> > +{
> > +     void *start;
> > +
> > +     /*
> > +      * Since the newer kernel does not allow a MAP_GROWSDOWN mapping
> to grow
> > +      * closer than 'stack_guard_gap' pages away from a preceding
> mapping.
> > +      * The guard then ensures that the next-highest mapped page
> remains more
> > +      * than 'stack_guard_gap' below the lowest stack address, and if
> not then
> > +      * it will trigger a segfault. So, here adding 256 pages memory
> spacing
> > +      * for stack growing safely.
> > +      *
> > +      * Btw, kernel default 'stack_guard_gap' size is '256 *
> getpagesize()'.
> > +      */
> > +     long total_size = 256 * getpagesize() + size * 2;
> > +
> > +     start = SAFE_MMAP(NULL, total_size, PROT_READ | PROT_WRITE,
> > +                     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     SAFE_MUNMAP(start, total_size);
> > +
> > +     /* start                             stack
> > +      * +-----------+---------------------+----------------------+
> > +      * | 256 pages | unmapped (size)     | mapped (size)        |
> > +      * +-----------+---------------------+----------------------+
> > +      *
> > +      */
> > +     stack = SAFE_MMAP((start + total_size - size), size, PROT_READ |
> PROT_WRITE,
> > +                       MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS |
> MAP_GROWSDOWN,
> > +                       -1, 0);
>
> Well it's not wrong per se but as it is we do not use the pre-allocated
> part of the stack at all, we directly jump for the guard page as we use
>

Really? But I think the pthread_attr_setstack(&attr, stack, stack_size) will
take use of the whole stack memory in function recursive performing.
How can we say NOT use the pre-allocated stack? I fell a bit confused
about your words here.

> the stack pointer as a base for the pthread stack. The actual pointer
> that points to the start of the region is stack - stack_size.
>

If that's true, it might belong to the internal operation of stack grows,
should we take care of it in the userspace case?

> There is no point in adding size * 2 here. We can as well reserve 256 *
> page_size + size. Then map() a single page at the end, which would be at
> start + total_size - page_size and finally return start + total_size
> from this function and pass that to pthread_attr_setstack().
>

I guess that will be work, but sounds a bit stingy. Since the modern system
does not short of such memory for testing:). And if we decide to go with
this,
the code design comments above should be all rewrite.


>
> That way it would look like:
>
> | 256 pages | unmapped | 1 mapped page |
>
>             | - - -  stack_size  - - - |
>
>
> ...
> > +     SAFE_PTHREAD_CREATE(&test_thread, &attr, check_depth_recursive,
> limit);
> > +     SAFE_PTHREAD_JOIN(test_thread, NULL);
> > +
> > +     if (stack)
> > +             SAFE_MUNMAP(stack, stack_size);
>
> I'ts a bit unexpected to unmap the stack here. I guess that unamping it
> in the run_test() after the grow_stack() call would be a bit cleaner but
> we would have to move the exit(0) there as well.
>

I agree with this.


> > +     /* Test 2 */
> > +     child_pid = SAFE_FORK();
> > +     if (!child_pid) {
> > +             tst_no_corefile(0);
>                   ^
>                  This should go to the test setup.
>

Only the child_2 will get SIGSEGV, why should we move it to affect the
whole test?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200911/b204a692/attachment.htm>
