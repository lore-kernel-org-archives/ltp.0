From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Jun 2019 06:16:28 -0400 (EDT)
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <1b6ddab9cd8e3620da9e37b1132e911280c22e32.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
Message-ID: <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Thu, Jun 13, 2019 at 3:25 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > Test crashes (SIGBUS) when using child stack have been observed for
> > ioctl_ns01. This is because stack isn't aligned. Use ltp_alloc_stack()
> > for stack allocation.
> >
> > Add SIGCHLD to clone flags, so that LTP library can reap all children
> > and check their return code.  Also check ltp_clone() return value.
> >
> > Suppress warning for unused *arg in child().
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 13 +++++++++----
> >  testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 12 +++++++++---
> >  testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 15 +++++++++++----
> >  3 files changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> > b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> > index dfde4da6c5d6..d241a5d0fa53 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> > @@ -23,7 +23,7 @@
> >
> >  #define STACK_SIZE (1024 * 1024)
> >
> > -static char child_stack[STACK_SIZE];
> > +static char *child_stack;
> >
> >  static void setup(void)
> >  {
> > @@ -31,6 +31,10 @@ static void setup(void)
> >
> >         if (exists < 0)
> >                 tst_res(TCONF, "namespace not available");
> > +
> > +       child_stack = ltp_alloc_stack(STACK_SIZE);
> >
> 
> As you commented that "User is responsible for freeing allocated memory",
> but you forget to do that in each of these test cases :).

I omitted it on purpose. OS will clean it up on exit, since it's called
only in setup() it's not going to keep leaking more memory.

> 
> We need free(child_stack) in the cleanup function.

Can you elaborate?

> 
> --
> Regards,
> Li Wang
> 
