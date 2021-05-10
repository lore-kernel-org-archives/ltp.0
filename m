From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 May 2021 19:15:08 +0200
Subject: [LTP] [PATCH v2] syscalls/bind03: Bugfix for running with
 option "-i"
In-Reply-To: <YJlJNdi039jziyCp@yuki>
References: <20210508021448.7390-1-zhaogongyi@huawei.com>
 <YJlJNdi039jziyCp@yuki>
Message-ID: <YJlqHBd+OVdqwEke@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> I was looking at the test wondering why do you try to unlink socket that
> wasn't bind properly and it looks like kernel creates the socket even in
> a case that the bind fails, which is strange and I would call it a bug.

> Looking at the kernel code it indeed does mknod before it takes locks
> and checks the socket. Even more it turns out that there is in-flight
> patchset that is fixing this:

> https://lore.kernel.org/netdev/YDQAmH9zSsaqf+Dg@zeniv-ca.linux.org.uk/

> Anyways for now moved the code initializing the sockets into a setup()
> function and the only call that had to stay in the run() function is the
> unlink(SNAME_B); with a comment that kernel is buggy.

> And we will have to write a regression test for this bug once upstream
> kernel is fixed.

> Also note that I use unlink() here since the test will fail otherwise
> once kernel is fixed and there is no socket to be unlinked.

FYI I created issue #817 for it, feel free to improve the description.

https://github.com/linux-test-project/ltp/issues/814

Kind regards,
Petr
