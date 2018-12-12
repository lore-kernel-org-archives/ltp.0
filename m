From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Dec 2018 10:41:42 -0500 (EST)
Subject: [LTP] [bug?] poor migrate_pages() performance on arm64
In-Reply-To: <769820788.85756226.1544627443438.JavaMail.zimbra@redhat.com>
Message-ID: <1125108393.85764095.1544629302243.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

I'm observing migrate_pages() taking quite long time on arm64
system (Huawei TaiShan 2280, 4 nodes, 64 CPUs). I'm using 4.20.0-rc6,
but it's reproducible with older kernels (4.14) as well.

The test (see [1] below), is a trivial C application, that migrates
current process from one node to another. More complicated example
is also LTP's migrate_pages03, where this has been originally reported.

It takes 2+ seconds to migrate process from one node to another:
  # strace -f -t -T ./a.out
  ...
  [pid 13754] 10:17:13 migrate_pages(0, 8, [0x0000000000000002], [0x0000000000000001]) = 1 <0.058115>
  [pid 13754] 10:17:13 migrate_pages(0, 8, [0x0000000000000001], [0x0000000000000002]) = 12 <2.348186>
  [pid 13754] 10:17:16 migrate_pages(0, 8, [0x0000000000000002], [0x0000000000000001]) = 1 <0.057889>
  [pid 13754] 10:17:16 migrate_pages(0, 8, [0x0000000000000001], [0x0000000000000002]) = 10 <2.194890>
  ...

This scales with number of children. For example with MAXCHILD 1000,
it takes ~33 seconds:
  # strace -f -t -T ./a.out
  ...
  [pid 13773] 10:17:55 migrate_pages(0, 8, [0x0000000000000001], [0x0000000000000002]) = 11 <33.615550>
  [pid 13773] 10:18:29 migrate_pages(0, 8, [0x0000000000000002], [0x0000000000000001]) = 2 <5.460270>
  ...

It appears to be related to migration of shared pages, presumably
executable code of glibc.

If I run [1] without CAP_SYS_NICE, it completes very quickly:
  # sudo -u nobody strace -f -t -T ./a.out
  ...
  [pid 14847] 10:24:57 migrate_pages(0, 8, [0x0000000000000001], [0x0000000000000002]) = 0 <0.000172>
  [pid 14847] 10:24:57 migrate_pages(0, 8, [0x0000000000000002], [0x0000000000000001]) = 0 <0.000091>
  [pid 14847] 10:24:57 migrate_pages(0, 8, [0x0000000000000001], [0x0000000000000002]) = 0 <0.000074>
  [pid 14847] 10:24:57 migrate_pages(0, 8, [0x0000000000000002], [0x0000000000000001]) = 0 <0.000069>
  ...


Looking at perf, most of time is spent invalidating icache.

-  100.00%     0.00%  a.out    [kernel.kallsyms]  [k] __sys_trace_return
   - __sys_trace_return
      - 100.00% __se_sys_migrate_pages
           do_migrate_pages.part.9
         - migrate_pages
            - 99.92% rmap_walk
               - 99.92% rmap_walk_file
                  - 99.90% remove_migration_pte
                     - 99.85% __sync_icache_dcache
                          __flush_cache_user_range

Percent│      nop
       │      ubfx   x3, x3, #16, #4
       │      mov    x2, #0x4                        // #4
       │      lsl    x2, x2, x3
       │      sub    x3, x2, #0x1
       │      bic    x4, x0, x3
  1.82 │      dc     cvau, x4
       │      add    x4, x4, x2
       │      cmp    x4, x1
       │    → b.cc   0xffff00000809efc8  // b.lo, b.ul, fffff7f61067
       │      dsb    ish
       │      nop
  0.07 │      nop
       │      mrs    x3, ctr_el0
       │      nop
       │      and    x3, x3, #0xf
       │      mov    x2, #0x4                        // #4
       │      lsl    x2, x2, x3
       │      sub    x3, x2, #0x1
       │      bic    x3, x0, x3
 96.17 │      ic     ivau, x3
       │      add    x3, x3, x2
       │      cmp    x3, x1
       │    → b.cc   0xffff00000809f000  // b.lo, b.ul, fffff7f61067
  0.10 │      dsb    ish
       │      isb
  1.85 │      mov    x0, #0x0                        // #0
       │78: ← ret
       │      mov    x0, #0xfffffffffffffff2         // #-14
       │    ↑ b      78

Regards,
Jan

[1]
----- 8< -----
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/syscall.h>

#define MAXCHILD 10

int main(void)
{
	long node1 = 1, node2 = 2;
	int i, child;
	int pids[MAXCHILD];

	for (i = 0; i < MAXCHILD; i++) {
		child = fork();
		if (child == 0) {
			sleep(600);
			exit(0);
		}
		pids[i] = child;
	}

	for (i = 0; i < 5; i++) {
		syscall(__NR_migrate_pages, 0, 8, &node1, &node2);
		syscall(__NR_migrate_pages, 0, 8, &node2, &node1);
	}

	for (i = 0; i < MAXCHILD; i++) {
		kill(pids[i], SIGKILL);
	}

	return 0;
}
----- >8 -----
