From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 05 May 2020 09:49:50 +0200
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
 (Jan Stancek via Libc-alpha's message of "Tue, 5 May 2020 03:28:34
 -0400 (EDT)")
References: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
Message-ID: <87pnbi4y8x.fsf@mid.deneb.enyo.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Jan Stancek via Libc-alpha:

> I'm seeing an issue with CLONE_IO and libc' clone() on ppc64le,
> where flags parameter appears to be sign extended before it's passed
> to kernel syscall.

Interesting, thanks for reporting this.  The manual page clearly
documents the interface as;

       int clone(int (*fn)(void *), void *child_stack,
                 int flags, void *arg, ...
                 /* pid_t *ptid, void *newtls, pid_t *ctid */ );

But the kernel uses unsigned long for clone_flags.  This looks like an
unintended userspace ABI breakage.

Rather than dropping the invalid flags check in the kernel (having the
check is valuable), I think the parameter should be changed to int or
unsigned int, or the flags check should be written in such a way that
it disregards bits that result from sign extensions: fail if
clone_flags != (int) clone_flags, otherwise set clone_flags = 0xFFFFFFFF.
