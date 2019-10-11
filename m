From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 11 Oct 2019 11:07:35 +0200
Subject: [LTP] Rename tst_test_* to tst_require_*
Message-ID: <20191011090737.17997-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

these patches rename tst_test_* to tst_require_*, to better describe
their use. There is also tst_require_root, that has the same
behavior: It also calls tst_brk in case of a failing requirement.

You can also get this patch from the following repo:
https://github.com/MofX/ltp/commits/rename_tst_test-tst_require

J?rg

doc/test-writing-guidelines.txt                                                      |  2 +-
testcases/commands/mkfs/mkfs01.sh                                                    |  2 +-
testcases/kernel/containers/netns/netns_breakns.sh                                   |  2 +-
testcases/kernel/containers/netns/netns_helper.sh                                    |  4 ++--
testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh                           |  2 +-
testcases/kernel/controllers/memcg/functional/memcg_lib.sh                           |  4 ++--
testcases/kernel/device-drivers/zram/zram01.sh                                       |  2 +-
testcases/kernel/device-drivers/zram/zram_lib.sh                                     |  6 +++---
testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh       |  2 +-
testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh |  2 +-
testcases/kernel/fs/ext4-new-features/ext4-online-defrag/ext4_online_defrag_test.sh  |  4 ++--
testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh  |  2 +-
testcases/kernel/fs/iso9660/isofs.sh                                                 |  2 +-
testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh                      |  2 +-
testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh                      |  2 +-
testcases/kernel/io/stress_floppy/stress_floppy                                      |  2 +-
testcases/kernel/power_management/runpwtests05.sh                                    |  2 +-
testcases/kernel/power_management/runpwtests_exclusive01.sh                          |  2 +-
testcases/kernel/power_management/runpwtests_exclusive02.sh                          |  2 +-
testcases/kernel/power_management/runpwtests_exclusive03.sh                          |  2 +-
testcases/kernel/power_management/runpwtests_exclusive04.sh                          |  2 +-
testcases/kernel/power_management/runpwtests_exclusive05.sh                          |  2 +-
testcases/lib/test.sh                                                                |  2 +-
testcases/lib/tst_net.sh                                                             | 10 +++++-----
testcases/lib/tst_test.sh                                                            | 12 ++++++------
testcases/network/multicast/mc_commo/mc_commo.sh                                     |  2 +-
testcases/network/multicast/mc_member/mc_member.sh                                   |  2 +-
testcases/network/stress/dns/dns-stress.sh                                           |  2 +-
testcases/network/stress/ftp/ftp-download-stress.sh                                  |  2 +-
testcases/network/stress/ftp/ftp-download-stress01-rmt.sh                            |  2 +-
testcases/network/stress/ftp/ftp-download-stress02-rmt.sh                            |  2 +-
testcases/network/stress/ftp/ftp-upload-stress.sh                                    |  4 ++--
testcases/network/stress/ftp/ftp-upload-stress01-rmt.sh                              |  2 +-
testcases/network/stress/ftp/ftp-upload-stress02-rmt.sh                              |  2 +-
testcases/network/stress/http/http-stress01-rmt.sh                                   |  2 +-
testcases/network/stress/http/http-stress02-rmt.sh                                   |  2 +-
testcases/network/stress/interface/if-lib.sh                                         |  2 +-
testcases/network/stress/ns-tools/tst_net_stress.sh                                  |  2 +-
testcases/network/stress/ssh/ssh-stress.sh                                           |  2 +-
testcases/network/tcp_cmds/ipneigh/ipneigh01.sh                                      |  2 +-
testcases/network/tcp_cmds/ping/ping01.sh                                            |  2 +-
testcases/network/tcp_cmds/ping/ping02.sh                                            |  2 +-
testcases/network/tcp_cmds/rlogin/rlogin01.sh                                        |  2 +-
testcases/network/tcp_cmds/sendfile/sendfile01.sh                                    |  2 +-
testcases/network/tcp_cmds/tcpdump/tcpdump01.sh                                      |  2 +-
testcases/network/tcp_cmds/telnet/telnet01.sh                                        |  2 +-
testcases/network/tcp_cmds/tracepath/tracepath01.sh                                  |  2 +-
testcases/network/virt/virt_lib.sh                                                   |  4 ++--
testcases/network/xinetd/xinetd_tests.sh                                             |  2 +-
49 files changed, 65 insertions(+), 65 deletions(-)



