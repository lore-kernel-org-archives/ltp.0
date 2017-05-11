From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 May 2017 10:10:06 +0200
Subject: [LTP] Use of -pthread
In-Reply-To: <BN6PR11MB205152E1D9CD5D131EA5A752CDEC0@BN6PR11MB2051.namprd11.prod.outlook.com>
References: <BN6PR11MB205152E1D9CD5D131EA5A752CDEC0@BN6PR11MB2051.namprd11.prod.outlook.com>
Message-ID: <20170511081006.GA306@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> sge@oststbldvm09 ltp $ find . -name Makefile|xargs grep -- -pthread
> ./lib/newlib_tests/Makefile:test08: CFLAGS+=-pthread
> ./lib/newlib_tests/Makefile:test09: CFLAGS+=-pthread
> ./lib/tests/Makefile:tst_cleanup_once: CFLAGS += -pthread
> ./testcases/kernel/mem/hugetlb/hugemmap/Makefile:hugemmap06: CFLAGS+=-pthread
> ./testcases/kernel/security/dirtyc0w/Makefile:dirtyc0w_child: CFLAGS+=-pthread
> ./testcases/kernel/syscalls/futex/Makefile:futex_wait03: CFLAGS+=-pthread
> ./testcases/kernel/syscalls/futex/Makefile:futex_wake02: CFLAGS+=-pthread
> ./testcases/kernel/syscalls/futex/Makefile:futex_wake04: CFLAGS+=-pthread
> ./testcases/kernel/syscalls/sched_getattr/Makefile:CFLAGS                       += -pthread
> ./testcases/kernel/syscalls/sched_setattr/Makefile:CFLAGS                       += -pthread
> ./testcases/kernel/syscalls/signal/Makefile:signal06: CFLAGS+=-pthread
> 
> 
> Other tests (50+) use:
> 
> LDLIBS += -lpthread
> 
> Instead. 
> 
> Any reason for the difference?

Likely only historical. The only correct way how to link against
libpthread is -pthread in CFLAGS (as it's written in any pthread_*
manual page). Adding -lpthread into LDLIBS may work most of the time but
will fail rarely.

The uses of -lpthread should be replaced with -pthread.

-- 
Cyril Hrubis
chrubis@suse.cz
