From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 5 May 2020 09:59:38 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <87pnbi4y8x.fsf@mid.deneb.enyo.de>
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 <87pnbi4y8x.fsf@mid.deneb.enyo.de>
Message-ID: <20200505075938.slkllo2awlop33pu@wittgenstein>
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

Let me take a quick look. This just affects legacy clone it seems. Maybe
we can do something to avoid that breakage without having to change
extensions. Legacy clone shouldn't care about invalid flag checking
since it never used to do that anyway, only clone3() does.

Christian
