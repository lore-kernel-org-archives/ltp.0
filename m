From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Aug 2018 08:15:25 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] [WORK-IN-PROGRESS] syscalls: Add
 set_mempolicy numa tests.
In-Reply-To: <20180809152308.18982-1-chrubis@suse.cz>
References: <20180809152308.18982-1-chrubis@suse.cz>
Message-ID: <531762042.40419801.1534248925760.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This is initial attempt to replace numa.sh tests that despite having
> been fixed several times have still many shortcommings that wouldn't
> easy to fix. It's not finished nor 100% replacement but I'm sending this
> anyway because I would like to get feedback at this point.

Hi,

Why not use get_mempolicy(.., MPOL_F_NODE | MPOL_F_ADDR) to get node id,
for the page we just allocated?

This kinda overlaps with numa_helper in some aspects. Which reminds me
of some issues we had to address there:
- memory-less nodes
- nodes with little to no free memory

Regards,
Jan

> 
> The main selling points of these testcases are:
> 
> The memory allocated for the testing is tracked exactly. We make sure
> that the mapping has separate record in /proc/$PID/numa_maps by mapping
> a region, then unmapping hole at the start and at the end of the
> mapping, then we fault the pages in the middle of the original mapping.
> We carefuly avoid doing anything that would cause the mapping to expand
> in the child process while the parent takes the measurements, even
> opening a file with fopen() may cause buffers to be allocated which may
> expand the mapping which is the reason we fork and take the measurements
> in the parent after the child process has faulted the pages.
> 
> The tests for file based shared interleaved mappings are no longer
> mapping a single small file but rather than that we accumulate statistic
> for larger amount of files over longer period of time and we also allow
> for small offset (currently 10%). We should probably also increase the
> number of samples we take as currently it's about 5MB in total on x86
> although I haven't managed to make this test fail so far. This also
> fixes the test on Btrfs where the synthetic test that expects the pages
> to be distributed exactly equally fails.
> 
> What is not finished is compilation without libnuma, that will fail
> currently, but that is only a matter of adding a few ifdefs. And the
> coverage is still lacking, ideas for interesting testcases are welcomed
> as well.
> 
