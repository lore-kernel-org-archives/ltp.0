From: Sandeep Patil <sspatil@google.com>
Date: Fri, 22 Sep 2017 16:14:44 -0700
Subject: [LTP] [PATCH] syscalls/cma: Make process_vm_{readv,
 writev} tests bionic friendly
In-Reply-To: <a46801be-c84a-a37c-2788-10cac3cba184@redhat.com>
References: <20170921215755.85005-1-sspatil@google.com>
 <a46801be-c84a-a37c-2788-10cac3cba184@redhat.com>
Message-ID: <20170922231444.GA110151@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 22, 2017 at 10:26:05AM +0200, Jan Stancek wrote:
> On 09/21/2017 11:57 PM, Sandeep Patil wrote:
> > All testcases under testcases/kernel/syscalls/cma depend on SysV
> > semaphore to do event notification from parent<->child processes.
> > Since bionic / android doesn't have SysV IPC, the tests cant be built
> > against bionic.
> > 
> > Fix this by keeping the old behavior for non bionic builds and switch to
> > using eventfd(EFD_SEMAPHORE) when building against bionic.
> 
> Hi,
> 
> If we can, we should use LTP's checkpoints for synchronization.
> It's based on futexes and works well for simple cases, which
> should fit all cma tests.

Definitely, the eventfd(EFD_SEMAPHORE) was just an easier replacement since I
wanted to keep the semantics similar assuming there are other tests that use
SysV semaphores like these. Futex should definitely work for these tests ..

> 
> Something like patch below. Would that work for you?


Definitely, I'll re-spin and send out. Thanks for letting me know about the
TEST_ macros.

<snip>

- ssp
