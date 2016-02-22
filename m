From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Feb 2016 14:25:22 +0100
Subject: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
In-Reply-To: <283548158.25448265.1456145200825.JavaMail.zimbra@redhat.com>
References: <d0fb0cdbb9db3b4a1421b0b097b82997a8d6ed3f.1455893957.git.jstancek@redhat.com>
 <20160222113614.GB5704@rei.lan>
 <283548158.25448265.1456145200825.JavaMail.zimbra@redhat.com>
Message-ID: <20160222132522.GA6434@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And the same for is_numa(), it calls tst_brkm(TBROK | TERRNO, ...) in
> > case that get_allowed_nodes_arr() returned non-zero.
> 
> If get_allowed_nodes_arr() returned non-zero because of get_mempolicy,
> that means get_mempolicy is implemented but failed. I think that
> justifies TBROK.

Now I'm confused. You said that the syscall can exit -1 and ENOSYS. In
that case the filter_nodemask_mem() returns -2 which is propagated from
get_allowed_nodes_arr() to is_numa() where the test ends with TBROK
rather than with TCONF. Or did I miss something?

-- 
Cyril Hrubis
chrubis@suse.cz
