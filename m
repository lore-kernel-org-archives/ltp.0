From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Oct 2017 12:04:08 +0100
Subject: [LTP] [PATCH 03/18] hugeshmctl01: Fix synchronisation with
 child processes
In-Reply-To: <20171026141447.26749-4-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
 <20171026141447.26749-4-punit.agrawal@arm.com>
Message-ID: <20171031110408.GC14550@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> hugeshmctl01 spawns child processes to perform shm operations and uses
> signal (SIGUSR1) to communicate the completion of test 1, to the
> children waiting at sigprocmask(). However, there is no guarantee that a
> child has reached sigprocmask() before the parent issues a SIGUSR1 and
> things go wrong.
> 
> This patch fixes this issue by 'stopping' the children, waiting for all
> of them and then issuing SIGCONT to communicate the completion.
> 
> While we are at it, also handle unknown signals as a hint to exit the
> test with TBROK.

We do have a checkpoint synchronization primitives in the test library
exactly for this kind of synchronization. Can you, pretty please, use
them instead?

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#229-fork-and-parent-child-synchronization

-- 
Cyril Hrubis
chrubis@suse.cz
