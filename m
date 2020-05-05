From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 5 May 2020 10:32:05 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <87pnbi4y8x.fsf@mid.deneb.enyo.de>
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
Message-ID: <20200505083205.qwwdiotmmjl23aje@wittgenstein>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 05, 2020 at 09:49:50AM +0200, Florian Weimer wrote:
> * Jan Stancek via Libc-alpha:
> 
> > I'm seeing an issue with CLONE_IO and libc' clone() on ppc64le,
> > where flags parameter appears to be sign extended before it's passed
> > to kernel syscall.
> 
> Interesting, thanks for reporting this.  The manual page clearly
> documents the interface as;
> 
>        int clone(int (*fn)(void *), void *child_stack,
>                  int flags, void *arg, ...
>                  /* pid_t *ptid, void *newtls, pid_t *ctid */ );
> 
> But the kernel uses unsigned long for clone_flags.  This looks like an
> unintended userspace ABI breakage.
> 
> Rather than dropping the invalid flags check in the kernel (having the
> check is valuable), I think the parameter should be changed to int or
> unsigned int, or the flags check should be written in such a way that
> it disregards bits that result from sign extensions: fail if
> clone_flags != (int) clone_flags, otherwise set clone_flags = 0xFFFFFFFF.

Hm, as you observed, the kernel always defines the flags argument as
unsigned long and afaict this has been the case since forever. So I'm
not sure why the userspace wrapper is defined as taking an int for
flags in the first place(?).
Be that as it may, the current legacy clone syscall has been switched
over a while ago to do:

 {
	struct kernel_clone_args args = {
		.flags		= (clone_flags & ~CSIGNAL),
		.pidfd		= parent_tidptr,
		.child_tid	= child_tidptr,
		.parent_tid	= parent_tidptr,
		.exit_signal	= (clone_flags & CSIGNAL),
		.stack		= newsp,
		.tls		= tls,
	};

	if (!legacy_clone_args_valid(&args))
		return -EINVAL;

	return _do_fork(&args);
}

where legacy_clone_args_valid() does:

bool legacy_clone_args_valid(const struct kernel_clone_args *kargs)
{
	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
	if ((kargs->flags & CLONE_PIDFD) &&
	    (kargs->flags & CLONE_PARENT_SETTID))
		return false;

	return true;
}

And I wonder if we should just do:

if (clone_flags & ~CLONE_LEGACY_FLAGS) /* 
	return -EINVAL;

but that might be a change in behavior, as legacy clone _never_ failed
when invalid values where passed.

(Note, that CLONE_LEGACY_FLAGS is already defined as
#define CLONE_LEGACY_FLAGS 0xffffffffULL
and used in clone3().)

So the better option might be to do what you suggested, Florian:
if (clone_flags & ~CLONE_LEGACY_FLAGS)
	clone_flags = CLONE_LEGACY_FLAGS?
and move on?

(Btw, iiuc, this would've always been a problem, right? In the sense that
userspace only got away with this because there were no additional flags
defined and couldn't.)

Christian
