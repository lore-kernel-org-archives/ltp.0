From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 24 Jun 2021 17:07:46 +0200
Subject: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
In-Reply-To: <018a369f-473b-524d-f81b-eb8be4df49bb@suse.cz>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <018a369f-473b-524d-f81b-eb8be4df49bb@suse.cz>
Message-ID: <b39dd931-5f3d-51c3-dd0f-3181b2035037@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 24/06/2021 15:33, Martin Doucha wrote:
> On 24. 06. 21 15:22, Krzysztof Kozlowski wrote:
>> On big memory systems, e.g. 196 GB RAM machine, the ioctl_sg01 test was
>> failing because of OoM killer during memory pollution:
>>
>> ...
>>
>> It seems leaving hard-coded 128 MB free memory works for small or medium
>> systems, but for such bigger machine it creates significant memory
>> pressure triggering the out of memory reaper.
>>
>> The memory pressure usually is defined by ratio between free and total
>> memory, so adjust the safety/spare memory similarly to keep always 0.5%
>> of memory free.
> 
> Hi,
> I've sent a similar patch for the same issue a while ago. It covers a
> few more edge cases. See [1] for the discussion about it.
> 

Thanks for the pointer. I see partially we used similar solution -
always leave some percentage of free memory.

Different kernels might have different limits here, for example v5.11
where this happened has two additional restrictions:

1. vm.min_free_kbytes = 90112
The min_free_kbytes will grow non-linearly up to 256 MB (still for v5.11).

2. vm.lowmem_reserve_ratio = 256	256	32	0	0
Which is a ratio 1/X for specific zones and since it was highmem
allocation, it does not matter here (machine has plenty of normal zone
memory).

Therefore it OoM seems to be caused by min_free_kbytes. The machine has
two nodes and the limit looks like to be spread between them:

[76578.062366] Node 0 Normal free:44536kB min:44600kB ...
[76578.062373] Node 1 Normal free:44824kB min:45060kB ...

The rest of free memory is in other zones (11 MB DMA and 380 MB in
DMA32), which were not used for this allocation.  Therefore to be
accurate, the safety limit should process /proc/zoneinfo and count
amount of free memory in Normal zone. This 128 MB safety limit should
not be counted from total memory, but from Normal zone.

But this is much more complex task and simple limit of 0.5% usually does
the trick.

P.S. For 32-bit systems the Highmem zone should also be included in Normal.

Best regards,
Krzysztof
