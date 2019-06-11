From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Jun 2019 05:58:48 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/ioctl_ns01: fix crash on aarch64
In-Reply-To: <CAEemH2fK7GnT5Pmo4r1ik4bV=7=F5ZOtM+UQYieeDUz4O1G0eQ@mail.gmail.com>
References: <2abbf8596a01ea056f6e7c9e6c481d67093cea0c.1560238866.git.jstancek@redhat.com>
 <CAEemH2fK7GnT5Pmo4r1ik4bV=7=F5ZOtM+UQYieeDUz4O1G0eQ@mail.gmail.com>
Message-ID: <750486973.27397698.1560247128601.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

----- Original Message -----

> On Tue, Jun 11, 2019 at 3:44 PM Jan Stancek < jstancek@redhat.com > wrote:

> > Test crashes with SIGBUS when using child stack. Align stack to 256 bytes,
> 
> > which is more than enough for any arch.
> 
> > Neither parent or library is waiting for child process. Add SIGCHLD to
> 
> > clone flags.
> 

> > Check return value of ltp_clone(), and TBROK on failure.
> 

> > Fix warning about unused *arg.
> 

> > Signed-off-by: Jan Stancek < jstancek@redhat.com >
> 
> > ---
> 
> > testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 10 +++++++---
> 
> > 1 file changed, 7 insertions(+), 3 deletions(-)
> 

> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> > b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> 
> > index dfde4da6c5d6..625de9bd832d 100644
> 
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> 
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> 
> > @@ -23,7 +23,7 @@
> 

> > #define STACK_SIZE (1024 * 1024)
> 

> > -static char child_stack[STACK_SIZE];
> 
> > +static char child_stack[STACK_SIZE] __attribute__((aligned(256)));
> 

> This patch makes sense. And maybe we'd better change that for ioctl_nfs05/06
> too?

Yes, you're right. Trying an unaligned address yields same result: 

Starting program: /root/ltp/testcases/kernel/syscalls/ioctl/ioctl_ns05 
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s 
[Attaching after process 19449 fork to child process 19452] 
[New inferior 2 (process 19452)] 
[Detaching after fork from parent process 19449] 
[Inferior 1 (process 19449) detached] 
0x4306a0 
[New LWP 19453] 
ioctl_ns05.c:80: PASS: child and parent are consistent 

Thread 2.2 received signal SIGBUS, Bus error. 
[Switching to LWP 19453] 
child (arg=0x0) at ioctl_ns05.c:37 
37 if (getpid() != 1) 
(gdb) disassemble 
Dump of assembler code for function child: 
=> 0x00000000004032e8 <+0>: stp x29, x30, [sp, #-32]! 
0x00000000004032ec <+4>: mov x29, sp 
0x00000000004032f0 <+8>: str x19, [sp, #16] 

I'll send v2. 

Thanks, 
Jan 

> BTW, another way we could try is to allocate the child_stack memory
> dynamically via malloc(STACK_SIZE) in setup() function.

> > static void setup(void)
> 
> > {
> 
> > @@ -53,7 +53,7 @@ static void test_ns_get_parent(void)
> 
> > }
> 
> > }
> 

> > -static int child(void *arg)
> 
> > +static int child(void *arg LTP_ATTRIBUTE_UNUSED)
> 
> > {
> 
> > test_ns_get_parent();
> 
> > return 0;
> 
> > @@ -61,10 +61,14 @@ static int child(void *arg)
> 

> > static void run(void)
> 
> > {
> 
> > + int child_pid;
> 
> > +
> 
> > test_ns_get_parent();
> 

> > - ltp_clone(CLONE_NEWPID, &child, 0,
> 
> > + child_pid = ltp_clone(CLONE_NEWPID | SIGCHLD, &child, 0,
> 
> > STACK_SIZE, child_stack);
> 
> > + if (child_pid == -1)
> 
> > + tst_brk(TBROK | TERRNO, "ltp_clone failed");
> 
> > }
> 

> > static struct tst_test test = {
> 
> > --
> 
> > 1.8.3.1
> 

> > --
> 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 

> --
> Regards,
> Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190611/4f053da3/attachment.html>
