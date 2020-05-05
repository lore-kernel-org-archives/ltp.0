From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 5 May 2020 11:58:13 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <871rny4taz.fsf@mid.deneb.enyo.de>
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
 <20200505083205.qwwdiotmmjl23aje@wittgenstein>
 <87a72m4uqm.fsf@mid.deneb.enyo.de>
 <20200505091554.eq7kzvb4twe2wgvl@wittgenstein>
 <871rny4taz.fsf@mid.deneb.enyo.de>
Message-ID: <20200505095813.z7kakdbiwq7ewnmx@wittgenstein>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 05, 2020 at 11:36:36AM +0200, Florian Weimer wrote:
> * Christian Brauner:
> >> Have any flags been added recently?
> >
> > /* Flags for the clone3() syscall. */
> > #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
> > #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
> 
> Are those flags expected to be compatible with the legacy clone
> interface on 64-bit architectures?

No, they are clone3() only. clone() is deprecated wrt to new features.

> 
> >> > (Note, that CLONE_LEGACY_FLAGS is already defined as
> >> > #define CLONE_LEGACY_FLAGS 0xffffffffULL
> >> > and used in clone3().)
> >> >
> >> > So the better option might be to do what you suggested, Florian:
> >> > if (clone_flags & ~CLONE_LEGACY_FLAGS)
> >> > 	clone_flags = CLONE_LEGACY_FLAGS?
> >> > and move on?
> >> 
> >> Not sure what you are suggesting here.  Do you mean an unconditional
> >> masking of excess bits?
> >> 
> >>   clone_flags &= CLONE_LEGACY_FLAGS;
> >> 
> >> I think I would prefer this:
> >> 
> >>   /* Userspace may have passed a sign-extended int value. */
> >>   if (clone_flags != (int) clone_flags) /* 
> >>  	return -EINVAL;
> >>   clone_flags = (unsigned) clone_flags;
> >
> > My worry is that this will cause regressions because clone() has never
> > failed on invalid flag values. I was looking for a way to not have this
> > problem. But given what you say below this change might be ok/worth
> > risking?
> 
> I was under the impression that current kernels perform such a check,
> causing the problem with sign extension.

No, it doesn't, it never did. It only does it for clone3(). Legacy
clone() _never_ reported an error no matter if you passed garbage flags
or not. That's why we can't re-use clone() flags that have essentially
been removed in kernel version before I could even program. :) Unless
I'm misunderstanding what check you're referring to.

If I understood the original mail correctly, then the issue is caused by
an interaction with sign extension and a the new flag value
CLONE_INTO_CGROUP being defined.
So from what I gather from Jan's initial mail is that when clone() is
called on ppc64le with the CLONE_IO|SIGCHLD flag:
clone(do_child, stack+1024*1024, CLONE_IO|SIGCHLD, NULL, NULL, NULL, NULL);
that the sign extension causes bits to be set that raise the
CLONE_INTO_CGROUP flag. And since the do_fork() codepath is the same for
legacy clone() and clone3() the kernel will think that someone requested
CLONE_INTO_CGROUP but hasn't passed a valid fd to a cgroup. If that is
the only issue here then couldn't we just do:

clone_flags &= ~CLONE3_ONLY_FLAGS?

and move on, i.e. all future clone3() flags we'll just remove since we
can assume that they have been accidently set. Even if they have been
intentionally set we can just ignore them since that's in line with
legacy clone()'s (questionable) tradition of ignoring unknown flags.
Thoughts? Or am I missing some subtlety here?

Christian
