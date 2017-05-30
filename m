From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 May 2017 09:11:10 -0400 (EDT)
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <20170530115032.GB24720@rei.lan>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
 <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
 <364825081.12577806.1494944124022.JavaMail.zimbra@redhat.com>
 <20170516142924.GE2897@rei.lan>
 <877971945.23275711.1496063572967.JavaMail.zimbra@redhat.com>
 <20170530115032.GB24720@rei.lan>
Message-ID: <555141962.23713496.1496149870415.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > I'm sporadically running into SIGBUS in this testcase, not sure if it's
> > because of low memory or something else. Do you see it too?
> 
> None so far, but I haven't been running the test on anything else than
> machines with just two numa nodes so far.
> 
> > I wonder if we should replace memset with MAP_POPULATE.
> 
> Isn't MAP_POPULATE best effort only?

It's a readahead for file mappings, not sure about anonymous.

As alternative commit [1] gave me idea to try mlock, and that seems
to work too. If a node doesn't have enough memory I get ENOMEM.

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index e1d956dba67e..4c7d5c2c01b0 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -165,9 +165,15 @@ static void alloc_free_huge_on_node(unsigned int node, size_t size)
                tst_brk(TBROK | TERRNO, "mbind() failed");
        }
 
-       numa_bitmask_free(bm);
+       TEST(mlock(mem, size));
+       if (TEST_RETURN) {
+               SAFE_MUNMAP(mem, size);
+               if (TEST_ERRNO == ENOMEM || TEST_ERRNO == EAGAIN)
+                       tst_brk(TCONF, "Cannot lock huge pages");
+               tst_brk(TBROK | TTERRNO, "mlock failed");
+       }
 
-       memset(mem, 0, size);
+       numa_bitmask_free(bm);
 
        SAFE_MUNMAP(mem, size);
 }


[1] 04f2cbe35699 "hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed"

> 
> I guess that we can then call mincore() to check if MAP_POPULATE really
> populated the pages and possibly try dropping system caches and retry
> again then produce TCONF if we happen to fail again.
> 
> > (gdb) bt
> > #0  0x00003fffb16ac620 in .__memset_power8 () from /lib64/libc.so.6
> > #1  0x0000000010003344 in memset (__len=67108864, __ch=0,
> > __dest=0x3efffc000000) at /usr/include/bits/string3.h:84
> > #2  alloc_free_huge_on_node (node=<optimized out>, size=67108864) at
> > move_pages12.c:170
> > #3  0x0000000010003648 in setup () at move_pages12.c:235
> > #4  0x0000000010006ad4 in do_test_setup () at tst_test.c:705
> > #5  testrun () at tst_test.c:778
> > #6  tst_run_tcases (argc=<optimized out>, argv=0x3fffd1c7e488,
> > self=<optimized out>) at tst_test.c:884
> > #7  0x0000000010002f58 in main (argc=<optimized out>, argv=<optimized out>)
> > at ../../../../include/tst_test.h:189
> > 
> > [pid 48425] 08:45:57.151242 write(2, "move_pages12.c:143:
> > \33[1;34mINFO:"..., 82move_pages12.c:143: INFO: Allocating and freeing 4
> > hug
> > epages on node 2
> > ) = 82
> > [pid 48425] 08:45:57.151287 mmap(NULL, 67108864, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS|MAP_HUGETLB, -1, 0) = 0x3efffc000000
> > [pid 48425] 08:45:57.151442 mbind(0x3efffc000000, 67108864, MPOL_BIND,
> > [0x0000000000000004, 000000000000000000, 000000000000000000, 00
> > 0000000000000000], 257, 0) = 0
> > [pid 48425] 08:45:57.167377 munmap(0x3efffc000000, 67108864) = 0
> > [pid 48425] 08:45:57.167486 write(2, "move_pages12.c:143:
> > \33[1;34mINFO:"..., 82move_pages12.c:143: INFO: Allocating and freeing 4
> > hug
> > epages on node 3
> > ) = 82
> > [pid 48425] 08:45:57.167554 mmap(NULL, 67108864, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS|MAP_HUGETLB, -1, 0) = 0x3efffc000000
> > [pid 48425] 08:45:57.167648 mbind(0x3efffc000000, 67108864, MPOL_BIND,
> > [0x0000000000000008, 000000000000000000, 000000000000000000, 00
> > 0000000000000000], 257, 0) = 0
> > [pid 48425] 08:45:57.172293 --- SIGBUS {si_signo=SIGBUS,
> > si_code=BUS_ADRERR, si_addr=0x3efffe000000} ---
> 
> Looks like we happen to got the signal when we try to fault third page,
> at least if the si_addr is correct it points in the middle of the
> mapping. So I guess that there is not enough continuous blocks to back
> the mapping.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
