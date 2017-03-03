From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Mar 2017 15:05:41 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_timedreceive: convert to new
	API
In-Reply-To: <20170303134342.qmzaxdgrwmlviom7@x230>
References: <20170301201331.22402-1-pvorel@suse.cz>
 <20170303130342.GA16323@rei.lan>
 <20170303134342.qmzaxdgrwmlviom7@x230>
Message-ID: <20170303140541.GB16323@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also we should use SAFE_OPEN() for opening the file. And we may as well
> > add safe_posix_ipc.h with SAFE_MQ_OPEN().
> Ok I'll do it. I was thinking about it some time ago, but thought it wouldn't be worth
> just for these few mq_* related tests.
> 
> BTW: I suppose tests in testcases/kernel/containers/mqns/ which are using mq_open() via
> ltp_syscall should use mq_open() directly, don't they?

Hmm, these were changed to syscalls in:

commit be3fdcfb86982af9836b5ffea136a3a65c12d718
Author: yaberauneya <yaberauneya>
Date:   Sat Nov 14 17:52:51 2009 +0000

    Use linux_syscall_numbers.h instead of the syscalls. Need to add the
    __NR_ defs to the .in files still.

No description why these were changed at all and I doubt that it
actually matters, the queues should not be reachable from the new
namespace regardless if we called glibc wrapper or raw kernel syscall.

And I guess that since we have the test results in IPC we can get rid of
the pipes to propagate results from child process and simplify the code
as well.

-- 
Cyril Hrubis
chrubis@suse.cz
