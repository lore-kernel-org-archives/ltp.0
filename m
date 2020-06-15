From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 15 Jun 2020 23:38:43 +0200
Subject: [LTP] 303cc571d1: ltp.setns01.fail
In-Reply-To: <1101600340.15989438.1592229781375.JavaMail.zimbra@redhat.com>
References: <20200615085836.GR12456@shao2-debian>
 <20200615091850.GA3373@yuki.lan>
 <1101600340.15989438.1592229781375.JavaMail.zimbra@redhat.com>
Message-ID: <20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 15, 2020 at 10:03:01AM -0400, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > Hi!
> > > setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x20000)
> > > setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x40000000)
> > > setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x20000000)
> > > setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x4000000)
> > > setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > 
> > The messages here are a bit cryptic, I will fix that later on, but what
> > it means here is that the errno has changed from EINVAL to EBADF in a
> > case we pass file descriptor to a regular file to setns().
> 
> I posted a series that accepts both errnos about week ago:
>   https://lists.linux.it/pipermail/ltp/2020-June/017467.html

When you used to pass an fd that referred to an open file but the file
was not a nsfd the kernel would report EINVAL. Since the pidfd support
this now reports EBADF. While that is a user visible change it is not a
particular worrying one but something we should still fix. Here's the
patch that fixes this:

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b03df67621d0..cd356630a311 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -531,7 +531,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
        } else if (!IS_ERR(pidfd_pid(file))) {
                err = check_setns_flags(flags);
        } else {
-               err = -EBADF;
+               err = -EINVAL;
        }
        if (err)
                goto out;

I'll send a pr for this to Linus this week (or next since I'm on
vacation this week) and get this fixed. Thanks for spotting this. What's
the Reported-by: line format that LTP uses?

Christian
