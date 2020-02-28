From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 Feb 2020 12:48:01 +0100
Subject: [LTP] Query: Adding support for clone3()
In-Reply-To: <20200228102432.3kdhl4aqkla4akss@vireshk-i7>
References: <CAKohponuu3zpsQCv0v1_Yqb_tmqy5yyUejMoS1_M_UFf5FU2Mw@mail.gmail.com>
 <20200228085859.GA31181@rei>
 <20200228102432.3kdhl4aqkla4akss@vireshk-i7>
Message-ID: <20200228114801.GA8324@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > One of the challenges with the implementation of clone3() is that
> > > there is no glibc wrapper available. And in case of clone() glibc
> > > wrapper isn't ordinary as it takes care of calling fn() and handling
> > > few stack related things, apart from calling the real syscall.
> > > 
> > > I am confused now on how should I write support for clone3().
> > > 
> > > Any suggestions will be appreciated. Thanks.
> > 
> > Let's just add the code into lapi/clone.h, would that work for you?
> 
> Which code are you talking about ?
> 
> Here is some stuff about the glibc wrapper for clone() from an stackoverflow
> page [1]:
> 
> clone(void (*fn)(void *), void *stack_pointer)
> {
>     push fn onto stack_pointer
>     syscall_clone()
>     if (child) {
>         pop fn off of stack
>         fn();
>         exit();
>     }
> }
> 
> This takes care of calling fn() and doing some stack related stuff.
> The kernel syscall doesn't expect the fn() argument but only the
> userspace calls do. How should I handle the extra stuff that userspace
> expects for a clone() call ?

That depends I guess mostly on the clone() flags, right? Unless we pass
CLONE_VM the child lives in a separate copy of the memory space and we
do not have to do anything about the stack.

So for the most clone3() tests we can just need the struct clone_args
and the syscall number and we can treat it mostly like more complex
version of fork(), i.e. pass NULL and 0 for the stack and stack_size
parameters.

So I would start by adding the kernel version of the clone3() syscall,
the structure, and the V0 structure size into the lapi header and use
that for a basic testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
