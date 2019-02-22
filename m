From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Feb 2019 13:29:27 -0500 (EST)
Subject: [LTP] [PATCH v2 1/2] syscalls/cma: test case should return
 TCONF if syscall doesn't exist
In-Reply-To: <1937154233.1109562.1550312885136.JavaMail.zimbra@redhat.com>
References: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
 <1544017426-10669-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <CAEemH2fvR1WQBEmwPM_rpy4z3xN6Ueeqk9Ri8BHrFoPQgaAJqw@mail.gmail.com>
 <853398062.984884.1550238809858.JavaMail.zimbra@redhat.com>
 <CAEemH2cFhdjMMF9RTyRHTBcLR7SqXNWNf41R+RLbdOY7CBOwpQ@mail.gmail.com>
 <1937154233.1109562.1550312885136.JavaMail.zimbra@redhat.com>
Message-ID: <255283985.2485664.1550860167075.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> ----- Original Message -----
> > On Fri, Feb 15, 2019 at 9:53 PM Jan Stancek <jstancek@redhat.com> wrote:
> > 
> > >
> > >
> > > ------------------------------
> > >
> > > Hi Jason,
> > >
> > > A new failure was occured after applying this new patch.
> > >
> > > From our observation, the latest process_vm_readv03.c failed with
> > > process_vm_readv() Invalid argument error on rhel7.3 platfrom. We suspect
> > > that this problem maybe caused by glibc or compiler, because if compile
> > > the
> > > test program with -O0 it get pass, but with the ltp
> > > default optimization -O2 it get fail.  Also, if we revert this new patch,
> > > the test PASS whatever with -O2 and -O0, that's very strange.
> > >
> > >
> > > One difference is that the extra function promoted int to long.
> > >
> > 
> > Good catch.
> > 
> > > Can you try with patch below? (Note that I dropped also root requirement,
> > > man page
> > > says that it has same requirements as ptrace - you should be able to read
> > > from processes you own)
> > >
> > > This change works for me(one comment in below).
> > 
> > But there still have a tiny question, in the syscall tracing log, I noticed
> > a process_vm_readv() calling does not get this failure in function
> > fetch_remote_addrs, what makes it difference with other two calls is
> > something I'm thinking now.
> 
> "Garbage" on stack most likely. On x86_64, 6th parameter is passed
> via stack, glibc copies quadword:
> 
> ENTRY (syscall)
>         movq %rdi, %rax         /* Syscall number -> rax.  */
>         movq %rsi, %rdi         /* shift arg1 - arg5.  */
>         movq %rdx, %rsi
>         movq %rcx, %rdx
>         movq %r8, %r10
>         movq %r9, %r8
>         movq 8(%rsp),%r9        /* arg6 is on the stack.  */
>         syscall                 /* Do the system call.  */
> 
> > 
> > ====Tracing log without '0L' change====
> > 12211 process_vm_readv(12211, 0, 0, 0, 0, 140728898420736) = -1 EINVAL
> > (Invalid argument)
> > ...
> > 12213 process_vm_readv(12212,
> > [{"\300`\334\0\0\0\0\0`\2\335\0\0\0\0\0\340\26\335\0\0\0\0\0\220h\335\0\0\0\0\0"...,
> > 80}], 1, [{0xdc6060, 80}], 1, 0) = 80
> > ...
> > 12213 process_vm_readv(12212, 0x7ffecef1e330, 4, 0xdc60c0, 10,
> > 140728898420736) = -1 EINVAL (Invalid argument)
> > 
> > 
> > 
> > >
> > > diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > index 45f7c92e499c..1cec442b3456 100644
> > > --- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > +++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
> > > @@ -181,7 +181,7 @@ static long *fetch_remote_addrs(void)
> > >         remote.iov_len = len;
> > >
> > >         TEST(ltp_syscall(__NR_process_vm_readv, pids[0], &local,
> > > -                        1, &remote, 1, 0));
> > > +                        1, &remote, 1, 0L));
> > >
> > 
> > To make things more safely, probably we'd better change all the integer
> > parameter too?
> > 
> > -                        1, &remote, 1, 0));
> > +                        1L, &remote, 1L, 0L));
> 
> Agreed, let's match all parameters types as before commit:
>  9b02cd465f70 ("syscalls/cma: test case should return TCONF if syscall
>  doesn't exist")

So, it looks like this thread has stalled. I'll look into posting a patch,
unless I hear someone is already working on it.

Regards,
Jan

> 
> > 
> > --
> > Regards,
> > Li Wang
> > 
> 
