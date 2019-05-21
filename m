From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 May 2019 09:38:13 -0400 (EDT)
Subject: [LTP] [PATCH] overcommit_memory: update for "mm: fix
 false-positive OVERCOMMIT_GUESS failures"
In-Reply-To: <20190521132936.GA19326@rei.lan>
References: <dc7300409a949189aa4ce9ef555405e36bdb50ab.1558426636.git.jstancek@redhat.com>
 <20190521132936.GA19326@rei.lan>
Message-ID: <911848816.23841590.1558445893494.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > commit 8c7829b04c52 ("mm: fix false-positive OVERCOMMIT_GUESS failures")
> > changes logic of __vm_enough_memory(), simplifying it to:
> >     When in GUESS mode, catch wild allocations by comparing their request
> >     size to total amount of ram and swap in the system.
> > 
> > Testcase currently allocates mem_total + swap_total, which doesn't trigger
> > new condition. Make it more extreme, but assuming free_total / 2 will PASS,
> > and sum_total * 2 will FAIL.
> 
> Looks good, acked.

Pushed.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
