From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 17 Nov 2020 12:48:18 +0100
Subject: [LTP] [PATCH 0/1] overcommit_memory: Remove unstable subtest
In-Reply-To: <873618p7ns.fsf@suse.de>
References: <20201116130915.18264-1-lkml@jv-coder.de> <875z64pc1r.fsf@suse.de>
 <648d7b53-2451-718b-6736-e6dffd4c72e8@jv-coder.de>
 <873618p7ns.fsf@suse.de>
Message-ID: <0d2a3cc5-e257-ebc5-1488-2a186411d8ad@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
> I think in general older versions are supported, at least back to 2.6
> (although you may need to compile in a newer user land). However it
> depends on the test, so we maybe could disable the test on older
> kernels, but changes like the above are often backported to older
> kernels...
>
> Possibly the test should be converted to check for regressions to the
> above commit? Which will probably also test whether setting overcommit
> works as a byproduct.
>
In that case, I would vote to either remove the subtest, or make it more 
permissive, by using something like 1.5x commit_limit. That might also 
fail, but is very less likely.

For the new change I would rather create a new test, that tests exactly 
this change, although the more accurate accounting is more or less a 
by-product of the change, that is not even documented there... This is 
all about changing the batch size. They just added the synchronization 
of the counters, because they enlarge the batch size for policies, but 
NEVER and that could lead to the situation I described even more frequently.
Now that code of mm_compute_batch before the change, I wonder how this 
was even possible... The batch size was constant, if no memory hotplug 
occurred. So normally allocations and deallocation should be accounted 
for in the same counter type (although maybe the cpu that does the 
accounting may differ; allocated on core 0 deallocated on 1).
But never allocated on a cpu counter and deallocated on the global counter.

Ohh this could be mremap:
If a memory region is allocated with mmap and then grown with mremap, 
this may lead to these small allocations being added to the per cpu 
counters and the deallocation of the bigger range subtracted from the 
global counter. This could be e.g. a stack, that had to grow.
I wonder if this could overflow the global counter, if done often enough.

J?rg

