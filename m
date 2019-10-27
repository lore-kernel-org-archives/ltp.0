From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 27 Oct 2019 12:20:19 +0530
Subject: [LTP] LTP: mtest06: mmap1.c:204: BROK: mmap((nil), 2147483648, 3, 34,
 -1, 0) failed: ENOMEM (12)
Message-ID: <CA+G9fYvdOcsqZ8M4VfOinnGGiacSL9rms5cnSkPK-cuZKNNP=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP new release 20190930 mm test cases mtest06 started failing always
on beagle board x15 and intermittent failure on i386,
mmap1.c:204: BROK: mmap((nil),2147483648,3,34,-1,0) failed: ENOMEM (12)

Do you notice this failure ?

Strace output:
---------------------
[pid   383] mmap2(NULL, 2147483648, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
[pid   382] waitpid(383,  <unfinished ...>
[pid   383] <... mmap2 resumed> )       = -1 ENOMEM (Cannot allocate memory)
[pid   383] write(2, \"mmap1.c:204: \BROK: \mm\"..., 83mmap1.c:204:
BROK: mmap((nil),2147483648,3,34,-1,0) failed: ENOMEM (12)
) = 83

Device under test:
-------------------------
Architecture :  ARMv7 (32 bits)
Processor Family : AM5728
CPU model : DRA752-GP ES2.0
Cores : 2 x Cortex-A15

full test log:
-----------------
https://lkft.validation.linaro.org/scheduler/job/980108#L1676
https://lkft.validation.linaro.org/scheduler/job/980109#L1228

LTP version:
https://github.com/linux-test-project/ltp/releases/tag/20190930

Test case description:
------------------------------
/*
* Test: Spawn 2 threads. First thread maps, writes and unmaps
* an area. Second thread tries to read from it. Second thread
* races against first thread. There is no synchronization
* between threads, but each mmap/munmap increases a counter
* that is checked to determine when has read occurred. If a read
* hit SIGSEGV in between mmap/munmap it is a failure. If a read
* between mmap/munmap worked, then its value must match expected
* value.
*
* Can trigger panics/stalls since at least 4.14 on some arches:
* fc8efd2ddfed ("mm/memory.c: do_fault: avoid usage of stale vm_area_struct")
* Can trigger user-space stalls on aarch64:
* 7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range() for force flush")
* https://lore.kernel.org/linux-mm/1817839533.20996552.1557065445233.JavaMail.zimbra@redhat.com
* Can trigger "still mapped when deleted" BUG at mm/filemap.c:171, on
aarch64 since 4.20
* e1b98fa31664 ("locking/rwsem: Add missing ACQUIRE to read_slowpath
exit when queue is empty")
* 99143f82a255 ("lcoking/rwsem: Add missing ACQUIRE to read_slowpath
sleep loop")
*/

Best regards
Naresh Kamboju
