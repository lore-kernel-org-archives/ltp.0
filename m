From: Caspar Zhang <caspar@linux.alibaba.com>
Date: Sat, 23 Feb 2019 14:21:35 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/cma: test case should return
 TCONF if syscall doesn't exist
In-Reply-To: <255283985.2485664.1550860167075.JavaMail.zimbra@redhat.com>
References: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
 <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <CAEemH2fvR1WQBEmwPM_rpy4z3xN6Ueeqk9Ri8BHrFoPQgaAJqw@mail.gmail.com>
 <853398062.984884.1550238809858.JavaMail.zimbra@redhat.com>
 <CAEemH2cFhdjMMF9RTyRHTBcLR7SqXNWNf41R+RLbdOY7CBOwpQ@mail.gmail.com>
 <1937154233.1109562.1550312885136.JavaMail.zimbra@redhat.com>
 <255283985.2485664.1550860167075.JavaMail.zimbra@redhat.com>
Message-ID: <20190223062135.GB49700@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 22, 2019 at 01:29:27PM -0500, Jan Stancek wrote:
>
>
> ----- Original Message -----
[snip]
> > > > diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > > b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > > index 45f7c92e499c..1cec442b3456 100644
> > > > --- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > > +++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > > @@ -181,7 +181,7 @@ static long *fetch_remote_addrs(void)
> > > >         remote.iov_len = len;
> > > >
> > > >         TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
> > > > -                        1, &remote, 1, 0));
> > > > +                        1, &remote, 1, 0L));
> > > >
> > >
> > > To make things more safely, probably we'd better change all the integer
> > > parameter too?
> > >
> > > -                        1, &remote, 1, 0));
> > > +                        1L, &remote, 1L, 0L));
> >
> > Agreed, let's match all parameters types as before commit:
> >  9b02cd465f70 ("syscalls/cma: test case should return TCONF if syscall
> >  doesn't exist")
>
> So, it looks like this thread has stalled. I'll look into posting a patch,
> unless I hear someone is already working on it.

Hi Jan,

Jason told me he was looking into it, I'll double confirm with him about
the progress. Will update ASAP.

Thanks,
Caspar
