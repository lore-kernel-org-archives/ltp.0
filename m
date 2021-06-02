From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Jun 2021 15:00:32 +0200
Subject: [LTP] [RFC] Reduce LICENCE/COPYING files
Message-ID: <YLeA8KOphpVg3IDP@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

We have various files which states GPL v2. I guess the reason is that LTP merged
various other smaller testsuites in the past.

$ git grep -l "GNU GENERAL PUBLIC LICENSE"  | xargs sha1sum  | sort -u

acd633a2cfa753e6be4e5fc68db32fb3c4672fa5  testcases/kernel/hotplug/cpu_hotplug/COPYING
acd633a2cfa753e6be4e5fc68db32fb3c4672fa5  testcases/kernel/hotplug/memory_hotplug/COPYING
a7a897a4bde987e597c04f16a9c28f6d3f57916d  testcases/realtime/COPYING
b47456e2c1f38c40346ff00db976a2badf36b5e3  testcases/kernel/security/mmc_security/LICENSE
b47456e2c1f38c40346ff00db976a2badf36b5e3  utils/benchmark/ebizzy-0.3/LICENSE
c9661f3c6fdc868720828a34d74f1e22718c8388  testcases/open_posix_testsuite/COPYING
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/fork/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_cancel/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_cond_init/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_create/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_exit/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_getschedparam/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_kill/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_mutex_init/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_mutex_lock/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_mutex_trylock/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_once/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/pthread_self/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/sem_getvalue/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/sem_init/LICENCE
dfac199a7539a404407098a2541b9482279f690d  testcases/open_posix_testsuite/stress/threads/sem_open/LICENCE
dfac199a7539a404407098a2541b9482279f690d  utils/benchmark/kernbench-0.42/COPYING
0b184ad51ba2a79e85d2288d5fcf8a1ea0481ea4  testcases/kernel/io/writetest/gpl.txt
4cc77b90af91e615a64ae04893fdffa7939db84c  COPYING
74a8a6531a42e124df07ab5599aad63870fa0bd4  testcases/kernel/controllers/freezer/COPYING

The diff is mostly different FSF address.
COPYING has been updated in 945f9c69a, others are older; not sure if it's
lastest GPL v2 version.

testcases/kernel/hotplug/{cpu_hotplug,memory_hotplug}/COPYING mention:
"These tests are OSDL/LF and imported into LTP under GPLv2."

testcases/open_posix_testsuite/COPYING has extra BSD 2-clause license + other
test at the top:

All sourcecode generated from scratch by Ngie Cooper is BSD 2-clause
licensed. All legacy openposix test suite code is GPLv2+ licensed.

You must honor the respective license when copying code.

BSD 2-clause license:
...

I suppose it's safe to keep only single licence in testcases/open_posix_testsuite/,
but could we keep only COPYING in the root directory and delete the rest?
Or keep COPYING and testcases/open_posix_testsuite/COPYING only?

Kind regards,
Petr
