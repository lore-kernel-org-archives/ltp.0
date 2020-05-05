From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 5 May 2020 13:26:07 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <87pnbi3ai5.fsf@mid.deneb.enyo.de>
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
 <20200505083205.qwwdiotmmjl23aje@wittgenstein>
 <87a72m4uqm.fsf@mid.deneb.enyo.de>
 <20200505091554.eq7kzvb4twe2wgvl@wittgenstein>
 <871rny4taz.fsf@mid.deneb.enyo.de>
 <20200505095813.z7kakdbiwq7ewnmx@wittgenstein>
 <87pnbi3ai5.fsf@mid.deneb.enyo.de>
Message-ID: <20200505112555.no6xiwndrj723q7t@wittgenstein>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 05, 2020 at 01:08:02PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > On Tue, May 05, 2020 at 11:36:36AM +0200, Florian Weimer wrote:
> >> * Christian Brauner:
> >> >> Have any flags been added recently?
> >> >
> >> > /* Flags for the clone3() syscall. */
> >> > #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
> >> > #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
> >> 
> >> Are those flags expected to be compatible with the legacy clone
> >> interface on 64-bit architectures?
> >
> > No, they are clone3() only. clone() is deprecated wrt to new features.
> 
> But without masking the clone_flags argument, won't it be passed down
> to the implementation which is also used to back clone3?

Yeah, the masking fix should definitely go in. That problem wasn't on
our radar initially at all.

> 
> > If I understood the original mail correctly, then the issue is caused by
> > an interaction with sign extension and a the new flag value
> > CLONE_INTO_CGROUP being defined.
> 
> Could be, but for that to happen, the flag would have to be passed
> down, no?

The strace output Jan posted:

clone(child_stack=0x1011ffe0, flags=CLONE_IO|0xffffffff00000000|SIGCHLD) = -1 EBADF (Bad file descriptor)

seems to suggest that 0xffffffff00000000 is filled in
CLONE_IO|0xffffffff00000000|SIGCHLD
which means

int main(int argc, char *argv[])
{
#define DUMMY_FLAG (CLONE_IO | 0xffffffff00000000 | SIGCHLD)
#ifndef CLONE_INTO_CGROUP
#define CLONE_INTO_CGROUP 0x200000000ULL
#endif

	printf("%d\n", (DUMMY_FLAG & CLONE_INTO_CGROUP) > 0);

	exit(EXIT_SUCCESS);
}

will return 1. In fact, it will also return 1 with CLONE_CLEAR_SIGHAND,
I believe.

> 
> > So from what I gather from Jan's initial mail is that when clone() is
> > called on ppc64le with the CLONE_IO|SIGCHLD flag:
> > clone(do_child, stack+1024*1024, CLONE_IO|SIGCHLD, NULL, NULL, NULL, NULL);
> > that the sign extension causes bits to be set that raise the
> > CLONE_INTO_CGROUP flag. And since the do_fork() codepath is the same for
> > legacy clone() and clone3() the kernel will think that someone requested
> > CLONE_INTO_CGROUP but hasn't passed a valid fd to a cgroup. If that is
> > the only issue here then couldn't we just do:
> >
> > clone_flags &= ~CLONE3_ONLY_FLAGS?
> >
> > and move on, i.e. all future clone3() flags we'll just remove since we
> > can assume that they have been accidently set. Even if they have been
> > intentionally set we can just ignore them since that's in line with
> > legacy clone()'s (questionable) tradition of ignoring unknown flags.
> > Thoughts? Or am I missing some subtlety here?
> 
> What's the difference between
> 
>   clone_flags &= ~CLONE3_ONLY_FLAGS;
> 
> and
> 
>   clone_flags &= (unsigned) -1;
> 
> in this context?

Yeah, I just used CLONE3_ONLY_FLAGS as more descriptive example. Wdyt,
about the patch I proposed in the follow up mail?

Christian
