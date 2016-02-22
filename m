From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 22 Feb 2016 15:03:05 +0100
Subject: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
Message-ID: <56CB1519.4040902@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 22 February, 2016 2:25:22 PM
> Subject: Re: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
> 
> Hi!
> > > And the same for is_numa(), it calls tst_brkm(TBROK | TERRNO, ...) in
> > > case that get_allowed_nodes_arr() returned non-zero.
> > 
> > If get_allowed_nodes_arr() returned non-zero because of get_mempolicy,
> > that means get_mempolicy is implemented but failed. I think that
> > justifies TBROK.
> 
> Now I'm confused. You said that the syscall can exit -1 and ENOSYS.

Correct, get_mempolicy is not implemented on aarch64.

> In that case the filter_nodemask_mem() returns -2 which is propagated from
> get_allowed_nodes_arr() to is_numa() where the test ends with TBROK
> rather than with TCONF.

It won't return -2 for ENOSYS, because of this line:
+        if (ret < 0 && errno != ENOSYS)
                 return -2;

> Or did I miss something?

I didn't make it clear in commit message that patch now silently ignores ENOSYS
from get_mempolicy. In this case get_allowed_nodes should return success, but
returned node set should be empty (I'll double check that this is the case on aarch64).

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
