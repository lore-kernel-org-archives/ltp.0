From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Mar 2019 04:54:48 -0400 (EDT)
Subject: [LTP] [PATCH] kernel/numa01.sh: Remove file based tests
In-Reply-To: <20190313121242.5257-1-chrubis@suse.cz>
References: <20190313121242.5257-1-chrubis@suse.cz>
Message-ID: <1574820135.8166436.1552553688274.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This is follow up on:
> 
> commit 55ee8a5adcf32d46372b32c0e470e42a82165c67
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Wed Mar 6 17:16:33 2019 +0100
> 
>     syscalls: Add set_mempolicy numa tests.
> 
> Tests 3 and 5 were using a single file mmaped into test memory to check
> NUMA allocation policy. Using a single small file for this kind of tests
> is wrong for several reasons, among other things filesystems tends to
> allocate pages in batches (to have better performance), which means that
> interleave policy has to sample several slightly larger files to check
> for fairness of the memory placements.
> 
> The testcase 5 was failing often on Btrfs and testcase 3 was failing
> rarely so this commit removes these two.
> 
> The test 3 is now reimplemented as subset of set_mempolicy03 the only
> difference is that test 3 tries to fiddle with cpu affinity to keep the
> test running on different node than is the one we requested allocation
> on but given that we try to allocate memory on all memory nodes it's
> unlikely that we will actually always run on the same node we want to
> allocate the memory on and if we ever wanted we can add another variant
> for the set_mempolicy03 test easily as well.
> 
> The test 5 is reimplemented as set_mempolicy04 with the difference that
> set_mempolicy04 runs on all supported filesystems and samples several
> files as well.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

ack
