From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 13 May 2021 14:23:39 +0800
Subject: [LTP] [PATCH 0/2 v2] Add SPDX in Makefile and use tabs instead of
 spaces
Message-ID: <20210513062341.83852-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1->v2:
1. Fix errors in patch application;
2. Add unrelated changes in replacing spaces with tabs into a separate patch.

Xie Ziyao (2):
  Makefile: Use SPDX in Makefile
  open_posix_testsuite/Makefile: Use tabs instead of spaces

 doc/Makefile                                  | 22 ++-------------
 include/Makefile                              | 22 ++-------------
 lib/Makefile                                  | 22 ++-------------
 lib/newlib_tests/Makefile                     |  1 +
 testcases/Makefile                            | 27 +++----------------
 testcases/commands/Makefile                   | 24 +++--------------
 testcases/commands/ar/Makefile                | 22 ++-------------
 testcases/commands/cp/Makefile                | 22 ++-------------
 testcases/commands/cpio/Makefile              | 22 ++-------------
 testcases/commands/df/Makefile                | 23 +++-------------
 testcases/commands/du/Makefile                | 18 +------------
 testcases/commands/eject/Makefile             | 22 ++-------------
 testcases/commands/file/Makefile              | 22 ++-------------
 testcases/commands/gdb/Makefile               | 20 ++------------
 testcases/commands/gzip/Makefile              | 22 ++-------------
 testcases/commands/insmod/Makefile            | 17 +++---------
 testcases/commands/keyctl/Makefile            | 19 +++----------
 testcases/commands/ld/Makefile                | 22 ++-------------
 testcases/commands/ldd/Makefile               | 18 ++-----------
 testcases/commands/ln/Makefile                | 22 ++-------------
 testcases/commands/lsmod/Makefile             | 17 +++---------
 testcases/commands/mkdir/Makefile             | 22 ++-------------
 testcases/commands/mkfs/Makefile              | 19 +++----------
 testcases/commands/mkswap/Makefile            | 17 +++---------
 testcases/commands/mv/Makefile                | 22 ++-------------
 testcases/commands/nm/Makefile                | 22 ++-------------
 testcases/commands/sysctl/Makefile            | 16 +----------
 testcases/commands/tar/Makefile               | 22 ++-------------
 testcases/commands/unshare/Makefile           | 13 +--------
 testcases/commands/unzip/Makefile             | 22 ++-------------
 testcases/commands/wc/Makefile                | 17 +++---------
 testcases/commands/which/Makefile             | 17 +++---------
 testcases/cve/Makefile                        | 14 +---------
 testcases/kernel/Makefile                     | 24 +++--------------
 testcases/kernel/connectors/Makefile          | 22 ++-------------
 testcases/kernel/connectors/pec/Makefile      | 22 ++-------------
 testcases/kernel/containers/Makefile          | 17 +-----------
 testcases/kernel/containers/netns/Makefile    | 18 ++-----------
 testcases/kernel/containers/pidns/Makefile    | 21 ++-------------
 testcases/kernel/controllers/Makefile         | 22 ++-------------
 testcases/kernel/controllers/cpuacct/Makefile | 22 ++-------------
 testcases/kernel/controllers/memcg/Makefile   | 22 ++-------------
 .../controllers/memcg/functional/Makefile     | 22 ++-------------
 .../controllers/memcg/regression/Makefile     | 22 ++-------------
 testcases/kernel/controllers/pids/Makefile    | 20 ++------------
 testcases/kernel/crypto/Makefile              | 14 +---------
 testcases/kernel/device-drivers/Makefile      | 15 +----------
 .../kernel/device-drivers/block/Makefile      | 15 +----------
 .../block/block_dev_kernel/Makefile           | 15 +----------
 testcases/kernel/device-drivers/rcu/Makefile  | 15 +----------
 testcases/kernel/device-drivers/rtc/Makefile  | 15 +----------
 testcases/kernel/fs/Makefile                  | 22 ++-------------
 testcases/kernel/fs/fs_fill/Makefile          | 14 +---------
 testcases/kernel/fs/iso9660/Makefile          | 19 ++-----------
 testcases/kernel/fs/lftest/Makefile           | 22 ++-------------
 testcases/kernel/fs/linktest/Makefile         | 22 ++-------------
 testcases/kernel/fs/quota_remount/Makefile    | 19 ++-----------
 testcases/kernel/fs/read_all/Makefile         | 14 +---------
 testcases/kernel/io/Makefile                  | 22 ++-------------
 testcases/kernel/lib/Makefile                 | 21 ++-------------
 testcases/kernel/logging/Makefile             | 19 ++-----------
 testcases/kernel/logging/kmsg/Makefile        | 19 ++-----------
 testcases/kernel/mem/Makefile                 | 22 ++-------------
 testcases/kernel/mem/hugetlb/Makefile         | 19 ++-----------
 .../kernel/mem/hugetlb/hugemmap/Makefile      | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmat/Makefile     | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmctl/Makefile    | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmdt/Makefile     | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmget/Makefile    | 19 ++-----------
 testcases/kernel/mem/hugetlb/lib/Makefile     | 19 ++-----------
 testcases/kernel/mem/ksm/Makefile             | 19 ++-----------
 testcases/kernel/mem/mmapstress/Makefile      | 19 ++-----------
 testcases/kernel/mem/mtest01/Makefile         | 22 ++-------------
 testcases/kernel/mem/mtest06/Makefile         | 22 ++-------------
 testcases/kernel/mem/mtest07/Makefile         | 22 ++-------------
 testcases/kernel/mem/thp/Makefile             | 20 ++------------
 testcases/kernel/mem/tunable/Makefile         | 20 ++------------
 testcases/kernel/mem/vma/Makefile             | 20 ++------------
 testcases/kernel/numa/Makefile                | 19 ++-----------
 testcases/kernel/pty/Makefile                 | 22 ++-------------
 testcases/kernel/sched/Makefile               | 22 ++-------------
 testcases/kernel/sched/autogroup/Makefile     | 20 +++-----------
 testcases/kernel/security/Makefile            | 22 ++-------------
 testcases/kernel/security/dirtyc0w/Makefile   | 15 +----------
 testcases/kernel/security/integrity/Makefile  | 19 ++-----------
 .../kernel/security/integrity/ima/Makefile    | 22 ++-------------
 .../security/integrity/ima/datafiles/Makefile | 26 +++---------------
 .../security/integrity/ima/src/Makefile       | 22 ++-------------
 .../security/integrity/ima/tests/Makefile     | 22 ++-------------
 testcases/kernel/syscalls/pwritev/Makefile    | 21 +++------------
 .../kernel/syscalls/set_mempolicy/Makefile    |  1 +
 testcases/kernel/tracing/Makefile             |  1 +
 .../kernel/tracing/dynamic_debug/Makefile     | 20 ++------------
 testcases/lib/Makefile                        | 22 ++-------------
 testcases/misc/Makefile                       | 24 +++--------------
 testcases/network/Makefile                    |  1 +
 testcases/network/can/Makefile                | 21 ++-------------
 testcases/network/can/filter-tests/Makefile   | 18 ++-----------
 testcases/network/dhcp/Makefile               | 15 +----------
 testcases/network/iproute/Makefile            | 22 ++-------------
 testcases/network/lib6/Makefile               | 24 ++---------------
 testcases/network/netstress/Makefile          | 14 +---------
 testcases/network/rpc/Makefile                | 22 ++-------------
 testcases/network/rpc/rpc-tirpc/Makefile      | 19 ++-----------
 .../network/rpc/rpc-tirpc/tests_pack/Makefile |  1 +
 testcases/network/sctp/Makefile               | 14 +---------
 testcases/network/sockets/Makefile            | 22 ++-------------
 testcases/network/stress/Makefile             | 22 ++-------------
 testcases/network/stress/dccp/Makefile        | 14 +---------
 testcases/network/stress/icmp/Makefile        | 22 ++-------------
 testcases/network/stress/interface/Makefile   | 22 ++-------------
 testcases/network/stress/ipsec/Makefile       | 19 +------------
 testcases/network/stress/multicast/Makefile   | 22 ++-------------
 .../stress/multicast/grp-operation/Makefile   | 22 ++-------------
 .../stress/multicast/packet-flood/Makefile    | 22 ++-------------
 .../stress/multicast/query-flood/Makefile     | 22 ++-------------
 testcases/network/stress/sctp/Makefile        | 14 +---------
 testcases/network/stress/tcp/Makefile         | 22 ++-------------
 testcases/network/stress/udp/Makefile         | 22 ++-------------
 testcases/network/tcp_cc/Makefile             | 14 +---------
 testcases/network/tcp_cmds/Makefile           | 24 +++--------------
 testcases/network/tcp_cmds/host/Makefile      | 22 ++-------------
 testcases/network/tcp_cmds/ipneigh/Makefile   | 22 ++-------------
 testcases/network/tcp_cmds/netstat/Makefile   | 22 ++-------------
 testcases/network/tcp_cmds/sendfile/Makefile  | 22 ++-------------
 testcases/network/tcp_cmds/tracepath/Makefile | 14 +---------
 testcases/network/tcp_fastopen/Makefile       | 15 +----------
 testcases/network/traceroute/Makefile         | 22 ++-------------
 testcases/network/virt/Makefile               | 15 +----------
 testcases/network/xinetd/Makefile             | 22 ++-------------
 testcases/open_posix_testsuite/Makefile       | 17 +++++-------
 .../open_posix_testsuite/conformance/Makefile |  5 +---
 .../conformance/interfaces/Makefile           |  5 +---
 testscripts/Makefile                          | 22 ++-------------
 utils/Makefile                                | 21 ++-------------
 utils/sctp/Makefile                           | 22 ++-------------
 utils/sctp/func_tests/Makefile                | 23 ++--------------
 137 files changed, 266 insertions(+), 2357 deletions(-)

--
2.17.1

