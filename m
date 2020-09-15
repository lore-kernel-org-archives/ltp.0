From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Sep 2020 15:40:23 +0200
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <CAEemH2cXY+-Dgq8PB-ZunzRnjM1iH0KiB5gK5=CLnFDSEiKLdQ@mail.gmail.com>
References: <20200911035533.30538-1-liwang@redhat.com>
 <20200911130836.GA2582@yuki.lan>
 <CAEemH2fPRTh6drs=h=U7OG07SZDgpDfEB0xRadF8Y1FbaHR8Nw@mail.gmail.com>
 <20200911145730.GA6157@yuki.lan>
 <CAEemH2cXY+-Dgq8PB-ZunzRnjM1iH0KiB5gK5=CLnFDSEiKLdQ@mail.gmail.com>
Message-ID: <20200915134023.GA18311@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > But still the code wasn't exactly right, because the lowest address of
> > the stack in the previous code was stack - stack_size, which would be
> > start of the unmapped region and the size of the stack would be 2 *
> > stack_size, as we expected the mapping to grow.
> >
> 
> No, I don't think so, the lowest address of the stack in the previous code
> is:
>     stack = start + total_size - size;
> and we pass this stack pointer to ptrehad_attr_setstack() is correct here,
> indeed the stack really starts at stack + stack_size, that's internal steps.
> 
> If we go with 'stack + stack_size' as you suggested, that will easily get
> segmental fault. So I stand by myself understanding unless someone can
> give enough explanation/demo :).

No I mean to pass stack - stack_size as a stack lowest addres since that
is the real end of the stack, i.e. the thread touches the memory close
to that address and technically we overflow the stack when we pass stack
as an address to pthread_attr_setstack().

Or we can change the memory layout so that only first page of the stack
is mapped as I proposed which is much less confusing that this.

> PTHREAD_ATTR_SETSTACK(3) manual says:
>   "stackaddr should point to the lowest addressable byte of a buffer of
> stacksize bytes that was allocated by the caller.  The pages of the
> allocated buffer should be both readable and writable."

I would say that what we actually do here is in the gray zone, nobody
really expected that growable stack would be used with pthreads and
hence the manual page does not take growable mappings into an account.

It works because libc does really use the stack size only to calculate
start of the stack, i.e. highest address of the stack, but still I do
find the code a bit confusing, since the real test starts after we
overflow the stack we passed to the pthread_attr_setstack().

I.e. regardless if we pass addr=stack size=stack_size or
addr=stack-stack_size and size=2*stack_size the glibc will end up with
the same address which is stack + stack_size. But the second one is a
bit more clear in where the real end of the stack is supposed to be.

-- 
Cyril Hrubis
chrubis@suse.cz
