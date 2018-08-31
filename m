From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Aug 2018 12:30:44 +0200
Subject: [LTP] [Query] With THP  numa01 - test5() fails
In-Reply-To: <88657699-0FEF-45B4-84FC-9517A099F0B0@caviumnetworks.com>
References: <7B4A451B-BE27-4659-A205-E9B5010678A8@caviumnetworks.com>
 <20180830132134.GA18401@rei>
 <88657699-0FEF-45B4-84FC-9517A099F0B0@caviumnetworks.com>
Message-ID: <20180831103044.GE16417@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> While running LTP test suite with 4.18 kernel ( arm64 ).
> >> I see the below failure with THP (Transparent Hugepages) enabled.
> >> test5 -  Verification of shared memory interleaved on all nodes
> >> 
> >> numa01 1 TINFO: The system contains 2 nodes: 0 1
> >> numa01 1 TPASS: NUMA local node and memory affinity
> >> numa01 2 TPASS: NUMA preferred node policy
> >> numa01 3 TPASS: NUMA share memory allocated in preferred node
> >> numa01 4 TPASS: NUMA interleave policy
> >> numa01 5 TFAIL: NUMA interleave share memory allocated in node1 is less than expected
> > 
> > There are some problems with the test5. It also fails frequenty if /tmp
> > is on btrfs, the problem here is that file based mappings that are
> > (faulted) allocated by the filesystem driver do not tend to be
> > distributed fully evenly for various reasons (e.g. metadata blocks are
> > allocated in batches on btrfs).
> > 
> > So my guess here would be that THP causes some part(s) of the file, be
> > it metadata or the actuall data, backed up by a transparent huge page,
> > which causes the pages to be distributed unevely.
> > 
> > The solution is to take more than one sample and see if data are
> > distributed more or less evenly over sum of the samples,
> 
> The test randomly passes/fails. I am not sure if THP is related or not.
> I see test passing without adding any code with

That is another problem with the testcase my new tests fix, the old test
only takes into an account the sum of memory allcated on a node, so
depending on where the rest of the unrelated memory was allocated on it
can pass/fail randomly.

> linux-lr84:/opt/ltp # cat /sys/kernel/mm/transparent_hugepage/enabled
> [always] madvise never
> 
> > which is what
> > I'm working on in replacement for this test that would fix this problem
> > along with a few more, see:
> > 
> > http://lists.linux.it/pipermail/ltp/2018-August/009109.html
> > 
> > Can try the tests from that patchset to see if these are working fine
> > for you?
> 
> Getting errors with this patch.
> 
> ../../../../lib/libltp.a(tst_numa.o): In function `tst_numa_alloc_parse':
> /root/ltp/lib/tst_numa.c:78: undefined reference to `get_mempolicy'
> ../../../../lib/libltp.a(tst_numa.o): In function `tst_get_nodemap':
> /root/ltp/lib/tst_numa.c:108: undefined reference to `numa_get_membind'
> /root/ltp/lib/tst_numa.c:133: undefined reference to `numa_bitmask_free'
> /root/ltp/lib/tst_numa.c:112: undefined reference to `numa_bitmask_isbitset'
> /root/ltp/lib/tst_numa.c:127: undefined reference to `numa_bitmask_isbitset'
> /root/ltp/lib/tst_numa.c:108: undefined reference to `numa_get_membind'
> collect2: error: ld returned 1 exit status

You need libnuma devel packages installed to compile the code.

-- 
Cyril Hrubis
chrubis@suse.cz
