From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Dec 2018 03:54:01 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/cma: test case should return TCONF if
 syscall doesn't exist
In-Reply-To: <5C05EB31.1030707@linux.alibaba.com>
References: <1543830227-15605-1-git-send-email-kerneljasonxing@linux.alibaba.com>
 <1599893739.81506187.1543831094598.JavaMail.zimbra@redhat.com>
 <5C05EB31.1030707@linux.alibaba.com>
Message-ID: <1514394255.82007574.1543913641122.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> 
> On 2018/12/3 下午5:58, Jan Stancek wrote:
> >
> >
> > ----- Original Message -----
> >> The original code returns TFAIL when process_vm_readv/_writev syscalls
> >> do not exist, while we are expecting a TCONF. During investigation, we
> >> find it is due to '#if defined(__NR_process_vm_readv/_writev)' fails to
> >> work as expected.  We fix this issue by using ltp_syscall() function in
> >> setup function. BTW, we don't use new tst_syscall() interface due to
> >> compatibility issue exists between old apis and new ones.
> >
> > Fine by me, but then you should also add syscall numbers to
> > include/lapi/syscalls:
> >
> 
> Thanks.
> I have TWO questions:
> 
> 1. If I use this command #./strip_syscall.awk
> /usr/include/asm/unistd_64.h > x86_64.in, it will update and add more
> new syscall numbers into x86_64.in file which includes many other
> syscall numbers not only process_vm_readv/_writev. To solve this
> problem, can I just add the process_vm_readv/_writev syscall numbers and
> let go of other numbers?

Yes, I think updating only syscalls your patch is touching would be preferred.

> 
> 2. I don't have so many types of machines that support different
> architectures like hppa and s390x. So what should I do to know this
> syscall number on other architectures. I'm running the tests on x86_64 arch.

You can find it in kernel sources, e.g. grep for it, or usually
one of first commits mentioning the syscall will also add number.

Regards,
Jan


> 
> Jason
> 
> > process_vm01.c: In function ‘setup’:
> > process_vm01.c:97: warning: unused parameter ‘argv’
> > process_vm01.c: In function ‘cma_test_params_read’:
> > process_vm01.c:127: error: ‘__NR_process_vm_readv’ undeclared (first use in
> > this function)
> > process_vm01.c:127: error: (Each undeclared identifier is reported only
> > once
> > process_vm01.c:127: error: for each function it appears in.)
> > process_vm01.c: In function ‘cma_test_params_write’:
> > process_vm01.c:136: error: ‘__NR_process_vm_writev’ undeclared (first use
> > in this function)
> >
> > Regards,
> > Jan
> >
> 
