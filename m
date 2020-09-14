From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Sep 2020 11:06:05 +0800
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200911145730.GA6157@yuki.lan>
References: <20200911035533.30538-1-liwang@redhat.com>
 <20200911130836.GA2582@yuki.lan>
 <CAEemH2fPRTh6drs=h=U7OG07SZDgpDfEB0xRadF8Y1FbaHR8Nw@mail.gmail.com>
 <20200911145730.GA6157@yuki.lan>
Message-ID: <CAEemH2cXY+-Dgq8PB-ZunzRnjM1iH0KiB5gK5=CLnFDSEiKLdQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 11, 2020 at 10:57 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > Well it's not wrong per se but as it is we do not use the pre-allocated
> > > part of the stack at all, we directly jump for the guard page as we use
> > >
> >
> > Really? But I think the pthread_attr_setstack(&attr, stack, stack_size)
> will
> > take use of the whole stack memory in function recursive performing.
> > How can we say NOT use the pre-allocated stack? I fell a bit confused
> > about your words here.
>
> I've been confused as well I looked at pthread_attr_setstack() function
> manual and it's expecting to get the lowest pointer of the stack. So I
> suppose that the stack really started at the stack + stack_size address.
>

I guess you probably misread the "lowest pointer of the stack", it is not
mean
the bottom of the stack, it is actually the lowest addressable byte of a
buffer of
stacksize. From what I understand, we should NOT pass the 'stack +
stack_size'
address to pthread_attr_setstack().



> But still the code wasn't exactly right, because the lowest address of
> the stack in the previous code was stack - stack_size, which would be
> start of the unmapped region and the size of the stack would be 2 *
> stack_size, as we expected the mapping to grow.
>

No, I don't think so, the lowest address of the stack in the previous code
is:
    stack = start + total_size - size;
and we pass this stack pointer to ptrehad_attr_setstack() is correct here,
indeed the stack really starts at stack + stack_size, that's internal steps.

If we go with 'stack + stack_size' as you suggested, that will easily get
segmental fault. So I stand by myself understanding unless someone can
give enough explanation/demo :).

PTHREAD_ATTR_SETSTACK(3) manual says:
  "stackaddr should point to the lowest addressable byte of a buffer of
stacksize bytes that was allocated by the caller.  The pages of the
allocated buffer should be both readable and writable."

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200914/871c9a83/attachment.htm>
