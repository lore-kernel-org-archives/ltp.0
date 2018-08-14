From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Aug 2018 15:10:07 +0200
Subject: [LTP] [PATCH] [RFC] [WORK-IN-PROGRESS] syscalls: Add
 set_mempolicy numa tests.
In-Reply-To: <531762042.40419801.1534248925760.JavaMail.zimbra@redhat.com>
References: <20180809152308.18982-1-chrubis@suse.cz>
 <531762042.40419801.1534248925760.JavaMail.zimbra@redhat.com>
Message-ID: <20180814131007.GB22915@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Why not use get_mempolicy(.., MPOL_F_NODE | MPOL_F_ADDR) to get node id,
> for the page we just allocated?

Good point, I will try to look into that.

> This kinda overlaps with numa_helper in some aspects. Which reminds me
> of some issues we had to address there:
> - memory-less nodes
> - nodes with little to no free memory

I'm aware of the overlap and we should definitely merge these two into a
single library later on.

As far as I can tell the library I wrote covers the case of memory-less
nodes, these should the the ones that does not have the membind flag set
in the default mask that is returned by numa_get_membind().

We should probably add API for specifying minimal amount of free memory
per node as well, which would fix the second problem. We may add
min_free parameter to the tst_get_nodemap() function that would be used
if passed the TST_NUMA_MEM flag.

-- 
Cyril Hrubis
chrubis@suse.cz
