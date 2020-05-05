From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 5 May 2020 11:15:54 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <87a72m4uqm.fsf@mid.deneb.enyo.de>
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
 <20200505083205.qwwdiotmmjl23aje@wittgenstein>
 <87a72m4uqm.fsf@mid.deneb.enyo.de>
Message-ID: <20200505091554.eq7kzvb4twe2wgvl@wittgenstein>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 05, 2020 at 11:05:37AM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > Hm, as you observed, the kernel always defines the flags argument as
> > unsigned long and afaict this has been the case since forever. So I'm
> > not sure why the userspace wrapper is defined as taking an int for
> > flags in the first place(?).
> 
> We have different types in many places.  Sometimes this is required by
> POSIX, sometimes not.  See the recent effort to fix the x32 interface
> (mostly for size_t arguments).
> 
> Flags arguments that depend on the word size are incompatible with
> portable system calls, so arguably what the kernel is doing here is
> wrong: the additional bits can never be used for anything.

I mean, the unsigned long is odd. Most syscalls are using unsigned int
and new ones are basically expected to.

> 
> > And I wonder if we should just do:
> >
> > if (clone_flags & ~CLONE_LEGACY_FLAGS) /* 
> > 	return -EINVAL;
> >
> > but that might be a change in behavior, as legacy clone _never_ failed
> > when invalid values where passed.
> 
> Have any flags been added recently?

/* Flags for the clone3() syscall. */
#define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */

> 
> > (Note, that CLONE_LEGACY_FLAGS is already defined as
> > #define CLONE_LEGACY_FLAGS 0xffffffffULL
> > and used in clone3().)
> >
> > So the better option might be to do what you suggested, Florian:
> > if (clone_flags & ~CLONE_LEGACY_FLAGS)
> > 	clone_flags = CLONE_LEGACY_FLAGS?
> > and move on?
> 
> Not sure what you are suggesting here.  Do you mean an unconditional
> masking of excess bits?
> 
>   clone_flags &= CLONE_LEGACY_FLAGS;
> 
> I think I would prefer this:
> 
>   /* Userspace may have passed a sign-extended int value. */
>   if (clone_flags != (int) clone_flags) /* 
>  	return -EINVAL;
>   clone_flags = (unsigned) clone_flags;

My worry is that this will cause regressions because clone() has never
failed on invalid flag values. I was looking for a way to not have this
problem. But given what you say below this change might be ok/worth
risking?

> 
> > (Btw, iiuc, this would've always been a problem, right? In the sense that
> > userspace only got away with this because there were no additional flags
> > defined and couldn't.)
> 
> It depends on how the clone system call wrapper is implemented, and
> what the C function call ABI is like.  In some cases, you probably get
> zero-extension, as expected by the kernel.
