From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Feb 2016 12:36:15 +0100
Subject: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
In-Reply-To: <d0fb0cdbb9db3b4a1421b0b097b82997a8d6ed3f.1455893957.git.jstancek@redhat.com>
References: <d0fb0cdbb9db3b4a1421b0b097b82997a8d6ed3f.1455893957.git.jstancek@redhat.com>
Message-ID: <20160222113614.GB5704@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Li reported, that some oom tests on aarch64 exit with TCONF
> during is_numa() call, because get_mempolicy syscall is not
> implemented. And because numa_helper used ltp_syscall() it
> terminated the test in all instances.
> 
> Switch to syscall() and let the tests decide what should happen
> if system doesn't support NUMA.

Looking at the code the return value from filter_nodemask_mem() can be
propagated to get_allowed_nodes() and doing git grep "get_allowed_nodes"
suggets that most of the testcases does tst_brkm(TBROK | TERRNO, ...) if
the call returned non-zero. Have you checked that they exit with TCONF
on non-numa system before they reach the call to get_allowed_nodes()?

And the same for is_numa(), it calls tst_brkm(TBROK | TERRNO, ...) in
case that get_allowed_nodes_arr() returned non-zero.

Or am I missing something?

-- 
Cyril Hrubis
chrubis@suse.cz
