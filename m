From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 May 2019 15:29:36 +0200
Subject: [LTP] [PATCH] overcommit_memory: update for "mm: fix
 false-positive OVERCOMMIT_GUESS failures"
In-Reply-To: <dc7300409a949189aa4ce9ef555405e36bdb50ab.1558426636.git.jstancek@redhat.com>
References: <dc7300409a949189aa4ce9ef555405e36bdb50ab.1558426636.git.jstancek@redhat.com>
Message-ID: <20190521132936.GA19326@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> commit 8c7829b04c52 ("mm: fix false-positive OVERCOMMIT_GUESS failures")
> changes logic of __vm_enough_memory(), simplifying it to:
>     When in GUESS mode, catch wild allocations by comparing their request
>     size to total amount of ram and swap in the system.
> 
> Testcase currently allocates mem_total + swap_total, which doesn't trigger
> new condition. Make it more extreme, but assuming free_total / 2 will PASS,
> and sum_total * 2 will FAIL.

Looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
