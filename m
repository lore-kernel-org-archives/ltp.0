From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 14:09:14 +0100
Subject: [LTP] [PATCH 0/1] overcommit_memory: Remove unstable subtest
Message-ID: <20201116130915.18264-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

this is something like an RFC. (I think I mixed my thoughts
between this and the patch description. Maybe read the patch
description first).
I found the overcommit_memory test, that tries to allocate
all alocatable memory for overcommit policy never, failed 
a lot and a lot more often, if the system has more memory.
When looking at the kernel source I found the reason: 
The percpu counter that counts the used memory uses a 
counter for every cpu, if the allocation or deallocations 
are very small. The more memory the system has, 
the bigger "small" is defined. See mm_compute_batch.

I started seeing this issue a lot after upgrading to 20200930
comming from 20190115. Some changes in the framework may have
led to this.

I don't think this is a kernel bug, but a result from switching
between overcommit modes. In overcommit mode never, the batch
size is a lot smaller than in the other modes
(ram_pages/cpus/256 instead of ra,_pages/cpus/4).
This leads to allocations done before switching the mode to be
accounted in the per cpu counters, and deallocated after in the
global counter, making the global counter negative. If the
overcommit mode was the same all the time, it should all have
been accounted in the same counters and the global counter
wouldn't be negative.

J?rg

