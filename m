From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:53 +0100
Subject: [LTP] [PATCH 00/19] Fix a bunch of warnings (mainly
	old-style-definition)
Message-ID: <20180124130312.7665-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I was able to find the time to fix a bunch of the warnings when building
LTP. With a fex exceptions, this was fixig function definitions, like 
changing int foo() to int foo(void) or changing old K&R-style to what you
would expect. None of the changes was bigger than that. I did one patch per 
file, and each of them was individually build-tested.

Michael


Michael Moese (19):
  fix warning on old style function definition
  fix default int in function definition
  fix old style definition in nfs_lock.c
  fix old style definition in mc_gethost.c
  remove duplicate const in mremap05.c
  fix old style definition in pidns06.c
  fix old style function definition in memcg_process_stress.c
  fix two old style function definitions in mem_process.c
  fix old-style-definition in vfork.c
  fix old style function definitions in libcpuset.c
  fix old style definition in cpuctl_test04.c
  fix old style definition in cpuctl_test01.c
  fix old style definition and unuses argc/argv in main()  in
    cpuctl_test02.c
  fix unused parameter in tpci.c
  fix old style definitions in memctl_test01.c
  fix old style definitions in cpuctl_def_task04.c
  fix old style definitions in fsx-linux.c
  fix old style definition in inode02.c
  fix old style definition in inode01.c

 testcases/kernel/containers/pidns/pidns06.c        |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_def_task04.c  |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test01.c      |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test02.c      |  6 +-
 .../kernel/controllers/cpuctl/cpuctl_test04.c      |  2 +-
 .../controllers/cpuset/cpuset_lib/libcpuset.c      | 34 +++++------
 testcases/kernel/controllers/freezer/vfork.c       |  4 +-
 .../kernel/controllers/memcg/control/mem_process.c |  4 +-
 .../memcg/stress/memcg_process_stress.c            |  2 +-
 .../kernel/controllers/memctl/memctl_test01.c      |  8 ++-
 .../kernel/device-drivers/pci/tpci_user/tpci.c     |  6 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c          | 10 +---
 testcases/kernel/fs/inode/inode01.c                | 58 +++++++++----------
 testcases/kernel/fs/inode/inode02.c                | 67 ++++++++++------------
 testcases/kernel/syscalls/mremap/mremap05.c        |  2 +-
 testcases/misc/f00f/f00f.c                         |  4 +-
 .../network/multicast/mc_gethost/mc_gethost.c      |  4 +-
 testcases/network/nfs/nfslock01/nfs_flock.c        |  4 +-
 testcases/network/stress/ns-tools/ns-udpserver.c   |  2 +-
 19 files changed, 103 insertions(+), 120 deletions(-)

-- 
2.13.6

