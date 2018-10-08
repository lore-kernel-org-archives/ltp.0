From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 8 Oct 2018 10:25:19 -0400 (EDT)
Subject: [LTP] [PATCH v4] syscalls/membarrier: Add membarrier() initial
 test
In-Reply-To: <75dc7e79-ddc2-f5ee-4fb5-dfcb7385e4df@linaro.org>
References: <243767154.55279006.1538383679362.JavaMail.zimbra@redhat.com>
 <20181008132914.8246-1-rafael.tinoco@linaro.org>
 <1320883984.56890565.1539007652586.JavaMail.zimbra@redhat.com>
 <75dc7e79-ddc2-f5ee-4fb5-dfcb7385e4df@linaro.org>
Message-ID: <357830099.56894195.1539008719156.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 10/8/18 11:07 AM, Jan Stancek wrote:
> > 
> > 
> > ----- Original Message -----
> >> Fixes: #265
> >>
> >> Initial test for membarrier() syscall. It tests all existing membarrier
> >> "commands" (or features), including the need (or not) for previous
> >> registration for the call to work.
> >>
> >> Some features did not exist in older kernels and that is covered by
> >> skipping some calls, flagging test as skipped & okay, and forcing
> >> others, making sure that return codes and errno are set right in those
> >> cases.
> >>
> >> Tests are done in a child process due to inexistent kernel interface to
> >> "unregister" the process from being affected by membarrier() call.
> >>
> >> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> > 
> > Looks good to me.
> > 
> > We probably can drop linux/membarrier.h configure check, right?
> > (since v4 doesn't include it and unsupported kernel should
> > hit ENOSYS and TCONF)
> 
> Ooops, true. No need to check HAVE_LINUX_MEMBARRIER_H if we are
> declaring all CMDs and will be given ENOSYS. Want me to send a v5 ?

Let's give a couple days to other potential reviewers. If nothing
else comes up, I can drop it before push.

Thanks,
Jan
