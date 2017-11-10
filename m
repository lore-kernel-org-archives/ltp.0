From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 04:14:30 -0500 (EST)
Subject: [LTP] [PATCH v2 1/6] syscalls/cma: Make process_vm_{readv,
 writev} tests bionic friendly
In-Reply-To: <20171109003438.130802-2-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
 <20171109003438.130802-2-sspatil@google.com>
Message-ID: <208847401.38716462.1510305270622.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> All testcases under testcases/kernel/syscalls/cma depend on SysV
> semaphore to do event notification from parent<->child processes.
> Since bionic / android doesn't have SysV IPC, the tests can't be built
> against bionic.
> 
> Fix this by using the ltp TST_SAFE_CHECKPOINT APIs taht are based on
> futexes. The change enables following tests for Android devices.
> 
>    process_vm01, process_vm_readv0[23], process_vm_writev02
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
> v1->v2
> ------
> - Use TST_CHECKPOINT APIs instead of eventfd as suggested by Jan
> 

Pushed.

Thanks,
Jan
