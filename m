From: Steve East <sge@cray.com>
Date: Wed, 10 May 2017 18:51:09 +0000
Subject: [LTP] Use of -pthread
Message-ID: <BN6PR11MB205152E1D9CD5D131EA5A752CDEC0@BN6PR11MB2051.namprd11.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I see a few tests adding -pthread to CFLAGS in the Makefile:

sge@oststbldvm09 ltp $ find . -name Makefile|xargs grep -- -pthread
./lib/newlib_tests/Makefile:test08: CFLAGS+=-pthread
./lib/newlib_tests/Makefile:test09: CFLAGS+=-pthread
./lib/tests/Makefile:tst_cleanup_once: CFLAGS += -pthread
./testcases/kernel/mem/hugetlb/hugemmap/Makefile:hugemmap06: CFLAGS+=-pthread
./testcases/kernel/security/dirtyc0w/Makefile:dirtyc0w_child: CFLAGS+=-pthread
./testcases/kernel/syscalls/futex/Makefile:futex_wait03: CFLAGS+=-pthread
./testcases/kernel/syscalls/futex/Makefile:futex_wake02: CFLAGS+=-pthread
./testcases/kernel/syscalls/futex/Makefile:futex_wake04: CFLAGS+=-pthread
./testcases/kernel/syscalls/sched_getattr/Makefile:CFLAGS                       += -pthread
./testcases/kernel/syscalls/sched_setattr/Makefile:CFLAGS                       += -pthread
./testcases/kernel/syscalls/signal/Makefile:signal06: CFLAGS+=-pthread


Other tests (50+) use:

LDLIBS += -lpthread

Instead. 

Any reason for the difference?

Steve.

