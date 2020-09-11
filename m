From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Sep 2020 16:57:30 +0200
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <CAEemH2fPRTh6drs=h=U7OG07SZDgpDfEB0xRadF8Y1FbaHR8Nw@mail.gmail.com>
References: <20200911035533.30538-1-liwang@redhat.com>
 <20200911130836.GA2582@yuki.lan>
 <CAEemH2fPRTh6drs=h=U7OG07SZDgpDfEB0xRadF8Y1FbaHR8Nw@mail.gmail.com>
Message-ID: <20200911145730.GA6157@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Well it's not wrong per se but as it is we do not use the pre-allocated
> > part of the stack at all, we directly jump for the guard page as we use
> >
> 
> Really? But I think the pthread_attr_setstack(&attr, stack, stack_size) will
> take use of the whole stack memory in function recursive performing.
> How can we say NOT use the pre-allocated stack? I fell a bit confused
> about your words here.

I've been confused as well I looked at pthread_attr_setstack() function
manual and it's expecting to get the lowest pointer of the stack. So I
suppose that the stack really started at the stack + stack_size address.
But still the code wasn't exactly right, because the lowest address of
the stack in the previous code was stack - stack_size, which would be
start of the unmapped region and the size of the stack would be 2 *
stack_size, as we expected the mapping to grow.

> > There is no point in adding size * 2 here. We can as well reserve 256 *
> > page_size + size. Then map() a single page at the end, which would be at
> > start + total_size - page_size and finally return start + total_size
> > from this function and pass that to pthread_attr_setstack().
> >
> 
> I guess that will be work, but sounds a bit stingy. Since the modern system
> does not short of such memory for testing:). And if we decide to go with
> this, the code design comments above should be all rewrite.

I do find this layout to be a bit more straighforward.

> >
> > That way it would look like:
> >
> > | 256 pages | unmapped | 1 mapped page |
> >
> >             | - - -  stack_size  - - - |
> >
> >
> > > +     /* Test 2 */
> > > +     child_pid = SAFE_FORK();
> > > +     if (!child_pid) {
> > > +             tst_no_corefile(0);
> >                   ^
> >                  This should go to the test setup.
> >
> 
> Only the child_2 will get SIGSEGV, why should we move it to affect the
> whole test?

It's not like we do expect any part of the test to produce core-dump so
there is no point in disabling them on each iteration only for the
child. But I guess that it's fine either way.

-- 
Cyril Hrubis
chrubis@suse.cz
