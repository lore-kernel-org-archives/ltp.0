From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 22 Feb 2016 07:46:40 -0500 (EST)
Subject: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
In-Reply-To: <20160222113614.GB5704@rei.lan>
References: <d0fb0cdbb9db3b4a1421b0b097b82997a8d6ed3f.1455893957.git.jstancek@redhat.com>
 <20160222113614.GB5704@rei.lan>
Message-ID: <283548158.25448265.1456145200825.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 22 February, 2016 12:36:15 PM
> Subject: Re: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
> 
> Hi!
> > Li reported, that some oom tests on aarch64 exit with TCONF
> > during is_numa() call, because get_mempolicy syscall is not
> > implemented. And because numa_helper used ltp_syscall() it
> > terminated the test in all instances.
> > 
> > Switch to syscall() and let the tests decide what should happen
> > if system doesn't support NUMA.
> 
> Looking at the code the return value from filter_nodemask_mem() can be
> propagated to get_allowed_nodes() and doing git grep "get_allowed_nodes"
> suggets that most of the testcases does tst_brkm(TBROK | TERRNO, ...) if
> the call returned non-zero.

This patch hides ENOSYS returned from get_mempolicy. So the callers
won't get any more failures than before. Callers should still check
how many nodes have been returned and if that numbers works for
the test or not.

> Have you checked that they exit with TCONF
> on non-numa system before they reach the call to get_allowed_nodes()?

They should be free to call get_allowed_nodes(), at worst all they get
back is empty set.

We could add extra call of numa_available() to setup() before call to
get_allowed_nodes(), but since its implementation relies on same
syscall I'm not sure it's worth it:

int numa_available(void)
{
        if (get_mempolicy(NULL, NULL, 0, 0, 0) < 0 && errno == ENOSYS)
                return -1;
        return 0;
}

> 
> And the same for is_numa(), it calls tst_brkm(TBROK | TERRNO, ...) in
> case that get_allowed_nodes_arr() returned non-zero.

If get_allowed_nodes_arr() returned non-zero because of get_mempolicy,
that means get_mempolicy is implemented but failed. I think that
justifies TBROK.

Regards,
Jan
