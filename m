From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Dec 2018 04:58:14 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/cma: test case should return TCONF if
 syscall doesn't exist
In-Reply-To: <1543830227-15605-1-git-send-email-kerneljasonxing@linux.alibaba.com>
References: <1543830227-15605-1-git-send-email-kerneljasonxing@linux.alibaba.com>
Message-ID: <1599893739.81506187.1543831094598.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> The original code returns TFAIL when process_vm_readv/_writev syscalls
> do not exist, while we are expecting a TCONF. During investigation, we
> find it is due to '#if defined(__NR_process_vm_readv/_writev)' fails to
> work as expected.  We fix this issue by using ltp_syscall() function in
> setup function. BTW, we don't use new tst_syscall() interface due to
> compatibility issue exists between old apis and new ones.

Fine by me, but then you should also add syscall numbers to
include/lapi/syscalls:

process_vm01.c: In function ‘setup’:
process_vm01.c:97: warning: unused parameter ‘argv’
process_vm01.c: In function ‘cma_test_params_read’:
process_vm01.c:127: error: ‘__NR_process_vm_readv’ undeclared (first use in this function)
process_vm01.c:127: error: (Each undeclared identifier is reported only once
process_vm01.c:127: error: for each function it appears in.)
process_vm01.c: In function ‘cma_test_params_write’:
process_vm01.c:136: error: ‘__NR_process_vm_writev’ undeclared (first use in this function)

Regards,
Jan
