From: Li Wang <liwang@redhat.com>
Date: Sun, 11 Apr 2021 12:47:35 +0800
Subject: [LTP] [OVERCOMMIT_GUESS] Broken mmap() for MAP_FAILED (ENOMEM)
Message-ID: <CAEemH2c63GXZosG+e3=c9FgisYdgx02PnV7pknMpWg6EyjM-AQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Johannes, Roman, and MM experts,

Both Xinpeng and PaulB reports that LTP/ioctl_sg01 always gets OOM killed
on aarch64
( confirmed "x86_64 + kernel-v5.12-rc6" influenced as well) when system
MemAvailable
less than MemFree. With help of Eirik and Chunyu, we found that the problem
only
occurred since below kernel commit:

    commit 8c7829b04c523cdc732cb77f59f03320e09f3386
    Author: Johannes Weiner <hannes@cmpxchg.org>
    Date:   Mon, 13 May 2019 17:21:50 -0700

        mm: fix false-positive OVERCOMMIT_GUESS failures

The mmap() behavior changed in GUESS mode from that, we can NOT receive
MAP_FAILED on ENOMEM in userspace anymore unless the process one-time
allocating memory larger than "total_ram+ total_swap" explicitly, hence, it
does
not look like a heuristics way in memory allocation.

Chunyu and I concern that might be more trouble for users in memory
allocation.

mmap2
 ksys_mmap_pgoff
  vm_mmap_pgoff
   do_mmap
    mmap_region
     // Private writeable mmaping: check memory availability
     security_vm_enough_memory_mm
     __vm_enough_memory

"
   872    int __vm_enough_memory(struct mm_struct *mm, long pages, int
cap_sys_admin)
             ...
   884    if (sysctl_overcommit_memory == OVERCOMMIT_GUESS) {
   885       if (pages > totalram_pages() + total_swap_pages)
   886           goto error;
   887        return 0;
   888    }
"

As __vm_enough_memory() using a consistent upbound on return ENOMEM which
only
make sense for the one-time requested memory size larger than "total_ram +
total_swap",
so all processes in userspace will more easily hit OOM (in
OVERCOMMIT_GUESS) roughly.

Maybe the acceptable way should be to dynamically detect the available/free
memory
according to the running system "free_pages + free_swap_pages" as before.

Any thoughts or suggestions?

=================
To simply show the above issue, I extract a C reproducer as:

Without the kernel commit
# ./mmap_failed
...
map_blocks[1493] = 0xffc525c60000
PASS: MAP_FAILED as expected

After the kernel commit:
# ./mmap_failed
...
map_blocks[1617] = 0x3c0836b0000
map_blocks[1618] = 0x3c0796b0000
Killed                <===== Always Killed by OOM-Killer

-------------------------
# cat mmap_failed.c

#include <stdio.h>
#include <sys/sysinfo.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

#define BLOCKSIZE (160 * 1024 * 1024)

void main(void)
{
    size_t i, maxsize, map_count = 0, blocksize = BLOCKSIZE;
    void **map_blocks;
    struct sysinfo info;

    sysinfo(&info);
    maxsize = (info.freeram + info.freeswap) * info.mem_unit;

    map_count = maxsize / blocksize;
    map_blocks = malloc(map_count * sizeof(void *));

    for (i = 0; i < map_count; i++) {
            map_blocks[i] = mmap(NULL, blocksize, PROT_READ | PROT_WRITE,
            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

            // we'd better get MAP_FAILED and break here but not OOM
instantly
            if (map_blocks[i] == MAP_FAILED) {
                map_count = i;
                printf("PASS: MAP_FAILED as expected\n");
                break;
        }

        printf("map_blocks[%d] = %p\n", i, map_blocks[i]);
        memset(map_blocks[i], 1, blocksize);
    }

    for (i = 0; i < map_count; i++)
    munmap(map_blocks[i], blocksize);

    free(map_blocks);
}


--
P.s there is another issue about MemAvailable < MemFree because of reserve
ing
by khugepaged for allocating transparent hugepage, but I don't want to mix
them
in this thread to make things complicated.  @Chunyu, if you can start a new
email
thread that'd be appreciated.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210411/d0f70c74/attachment.htm>
