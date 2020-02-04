From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 Feb 2020 16:24:26 +0100
Subject: [LTP] [RFC PATCH v2 0/4] TI-RPC: enhancements (pkg-config, travis)
Message-ID: <20200204152430.10935-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Changes v1->v2:
* do not include libntirpc support (would require a bit more work)
* fix glibc enablement
* split glibc enablement into separate commit

Here are some improvements to LTP RPC and TI-RPC tests (these which are in
net.tirpc_tests and net.rpc_tests). These are mostly build fixes + enablement
of glibc tests.

I'm not sure whether instead of merging this we should just remove RPC tests
from LTP. IMHO these tests (or probably new ones, as it might be faster to
write them from scratch) should be in libtirpc an ntirpc. LTP would
benefit more to test sunrpc kernel modules (which these tests does not address,
it might be adressed by LTP nfs tests). Maybe we'd just keep basic RPC testing
(builded rpc_server in as part of net.rpc, which contains other RPC userspace
tests: rpcinfo and very old rup + rusers).

Other argument for removing these tests is that LTP priority is to catch up
changes in recent kernel (over 30 new systemcalls in kernel v5.x).

Kind regards,
Petr

Petr Vorel (4):
  rpc-tirpc: Detect libtirpc with pkg-config
  rpc: Fix build under glibc only TI-RPC implementation
  travis: Merge debian.cross-compile.*.sh
  rpc-tirpc: Remove unused tests

 .travis.yml                                   |   6 +-
 include/lapi/rpc.h                            |  27 ---
 include/mk/config.mk.in                       |   3 +-
 m4/ltp-tirpc.m4                               |  31 ++-
 testcases/network/Makefile                    |  24 +-
 .../rpc/basic_tests/rpc01/lib/librpc01.c      |   2 +-
 .../rpc/basic_tests/rpc01/lib/librpc01.h      |   2 +-
 .../rpc/basic_tests/rpc01/rpc_server.c        |   2 +-
 testcases/network/rpc/rpc-tirpc/.gitignore    |   4 -
 .../network/rpc/rpc-tirpc/tests_pack/Makefile |  26 +--
 .../rpc/rpc-tirpc/tests_pack/Makefile.inc     |  21 +-
 .../rpc/rpc-tirpc/tests_pack/include/rpc.h    |  22 ++
 .../rpc/rpc-tirpc/tests_pack/rpc_cleaner.c    |   2 +-
 .../rpc-tirpc/tests_pack/rpc_suite/Makefile   |  23 +-
 .../tests_pack/rpc_suite/rpc/Makefile         |  25 +--
 .../rpc_pmap_getport.c                        |   2 +-
 .../rpc_pmap_rmtcall.c                        |   2 +-
 .../rpc_pmap_rmtcall_performance.c            |   2 +-
 .../rpc_pmap_rmtcall_stress.c                 |   2 +-
 .../rpc_addrmanagmt_pmap_set/rpc_pmap_set.c   |   2 +-
 .../rpc_pmap_unset.c                          |   2 +-
 .../rpc_auth_auth_destroy/rpc_auth_destroy.c  |  63 ------
 .../rpc_clnt_broadcast.c                      |   2 +-
 .../rpc_clnt_broadcast_complex.c              |   3 +-
 .../rpc_clnt_broadcast_dataint.c              |   2 +-
 .../rpc_clnt_broadcast_performance.c          |   2 +-
 .../rpc_clnt_broadcast_scalability.c          |   2 +-
 .../rpc_clnt_broadcast_stress.c               |   2 +-
 .../rpc_clntraw_create.c                      |  65 ------
 .../rpc_registerrpc.c                         |   2 +-
 .../rpc_svc_register.c                        |   2 +-
 .../rpc_svc_unregister.c                      |   2 +-
 .../rpc_clnt_call_complex.c                   |   2 +-
 .../rpc_svc_freeargs_svc.c                    |   2 +-
 .../rpc_stdcall_svc_getargs/rpc_svc_getargs.c |   2 +-
 .../rpc_svc_sendreply.c                       |   2 +-
 .../tirpc_rpcb_getaddr.c                      |   2 +-
 .../tirpc_rpcb_getaddr_limits.c               |   2 +-
 .../tirpc_rpcb_getmaps.c                      |   2 +-
 .../tirpc_authnone_create.c                   |   2 +-
 .../tirpc_authsys_create.c                    |   2 +-
 .../tirpc_authsys_create_default.c            |   2 +-
 .../tirpc_bottomlevel_clnt_call.c             |   2 +-
 .../tirpc_bottomlevel_clnt_call_complex.c     |   2 +-
 .../tirpc_bottomlevel_clnt_call_dataint.c     |   2 +-
 .../tirpc_bottomlevel_clnt_call_mt.c          |   2 +-
 .../tirpc_bottomlevel_clnt_call_performance.c |   2 +-
 .../tirpc_bottomlevel_clnt_call_scalability.c |   2 +-
 .../tirpc_bottomlevel_clnt_call_stress.c      |   2 +-
 .../tirpc_clnt_dg_create.c                    |   2 +-
 .../tirpc_clnt_dg_create_limits.c             |   2 +-
 .../tirpc_clnt_vc_create.c                    |   2 +-
 .../tirpc_clnt_vc_create_limits.c             |   2 +-
 .../tirpc_svc_dg_create.c                     |   2 +-
 .../tirpc_svc_dg_create_limits.c              |   2 +-
 .../tirpc_svc_vc_create.c                     |   2 +-
 .../tirpc_svc_vc_create_limits.c              |   2 +-
 .../tirpc_clnt_pcreateerror.c                 |   2 +-
 .../tirpc_err_clnt_perrno/tirpc_clnt_perrno.c |   2 +-
 .../tirpc_clnt_perrno_complex.c               |   2 +-
 .../tirpc_err_clnt_perror/tirpc_clnt_perror.c |   2 +-
 .../tirpc_clnt_perror_complex.c               |   2 +-
 .../tirpc_svcerr_noproc.c                     |   2 +-
 .../tirpc_svcerr_noprog.c                     |   2 +-
 .../tirpc_svcerr_progvers.c                   |   2 +-
 .../tirpc_svcerr_systemerr.c                  |   2 +-
 .../tirpc_svcerr_weakauth.c                   |   2 +-
 .../tirpc_expertlevel_clnt_call.c             |   2 +-
 .../tirpc_expertlevel_clnt_call_complex.c     |   2 +-
 .../tirpc_expertlevel_clnt_call_dataint.c     |   2 +-
 .../tirpc_expertlevel_clnt_call_mt.c          |   2 +-
 .../tirpc_expertlevel_clnt_call_performance.c |   2 +-
 .../tirpc_expertlevel_clnt_call_scalability.c |   2 +-
 .../tirpc_expertlevel_clnt_call_stress.c      |   2 +-
 .../tirpc_clnt_tli_create.c                   |   2 +-
 .../tirpc_clnt_tli_create_limits.c            |   2 +-
 .../tirpc_rpcb_rmtcall.c                      |   2 +-
 .../tirpc_rpcb_rmtcall_complex.c              |   2 +-
 .../tirpc_rpcb_rmtcall_dataint.c              |   2 +-
 .../tirpc_rpcb_rmtcall_mt.c                   |   2 +-
 .../tirpc_rpcb_rmtcall_performance.c          |   2 +-
 .../tirpc_rpcb_rmtcall_scalability.c          |   2 +-
 .../tirpc_rpcb_rmtcall_stress.c               |   2 +-
 .../tirpc_rpcb_set.c                          |   2 +-
 .../tirpc_rpcb_unset.c                        |   2 +-
 .../tirpc_expertlevel_svc_reg/tirpc_svc_reg.c |   2 +-
 .../tirpc_svc_reg_mt.c                        |   2 +-
 .../tirpc_svc_reg_stress.c                    |   2 +-
 .../tirpc_svc_tli_create.c                    |   2 +-
 .../tirpc_svc_tli_create_limits.c             |   2 +-
 .../tirpc_svc_unreg.c                         |   2 +-
 .../tirpc_svc_unreg_mt.c                      |   2 +-
 .../tirpc_svc_unreg_stress.c                  |   2 +-
 .../tirpc_interlevel_clnt_call.c              |   2 +-
 .../tirpc_interlevel_clnt_call_complex.c      |   2 +-
 .../tirpc_interlevel_clnt_call_dataint.c      |   2 +-
 .../tirpc_interlevel_clnt_call_mt.c           |   2 +-
 .../tirpc_interlevel_clnt_call_performance.c  |   2 +-
 .../tirpc_interlevel_clnt_call_scalability.c  |   2 +-
 .../tirpc_interlevel_clnt_call_stress.c       |   2 +-
 .../tirpc_clnt_control.c                      |   2 +-
 .../tirpc_clnt_control_limits.c               |   2 +-
 .../tirpc_clnt_tp_create.c                    |   2 +-
 .../tirpc_clnt_tp_create_timed.c              |   2 +-
 .../tirpc_clnt_tp_create_timed_limits.c       |   2 +-
 .../tirpc_svc_tp_create.c                     |   2 +-
 .../tirpc_rpc_broadcast.c                     |   2 +-
 .../tirpc_rpc_broadcast_complex.c             |   2 +-
 .../tirpc_rpc_broadcast_dataint.c             |   2 +-
 .../tirpc_rpc_broadcast_mt.c                  |   2 +-
 .../tirpc_rpc_broadcast_performance.c         |   2 +-
 .../tirpc_rpc_broadcast_scalability.c         |   2 +-
 .../tirpc_rpc_broadcast_stress.c              |   2 +-
 .../tirpc_rpc_broadcast_exp.c                 |   2 +-
 .../tirpc_rpc_broadcast_exp_complex.c         |   2 +-
 .../tirpc_rpc_broadcast_exp_dataint.c         |   2 +-
 .../tirpc_rpc_broadcast_exp_limits.c          |   2 +-
 .../tirpc_rpc_broadcast_exp_mt.c              |   2 +-
 .../tirpc_rpc_broadcast_exp_performance.c     |   2 +-
 .../tirpc_rpc_broadcast_exp_scalability.c     |   2 +-
 .../tirpc_rpc_broadcast_exp_stress.c          |   2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call.c    |   2 +-
 .../tirpc_rpc_call_complex.c                  |   2 +-
 .../tirpc_rpc_call_dataint.c                  |   2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call_mt.c |   2 +-
 .../tirpc_rpc_call_performance.c              |   2 +-
 .../tirpc_rpc_call_scalability.c              |   2 +-
 .../tirpc_rpc_call_stress.c                   |   2 +-
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg.c      |   2 +-
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c   |   2 +-
 .../tirpc_rpc_reg_stress.c                    |   2 +-
 .../tirpc_toplevel_clnt_call.c                |   2 +-
 .../tirpc_toplevel_clnt_call_complex.c        |   2 +-
 .../tirpc_toplevel_clnt_call_dataint.c        |   2 +-
 .../tirpc_toplevel_clnt_call_mt.c             |   2 +-
 .../tirpc_toplevel_clnt_call_performance.c    |   2 +-
 .../tirpc_toplevel_clnt_call_scalability.c    |   2 +-
 .../tirpc_toplevel_clnt_call_stress.c         |   2 +-
 .../tirpc_clnt_create.c                       |   2 +-
 .../tirpc_clnt_create_timed.c                 |   2 +-
 .../tirpc_clnt_create_timed_limits.c          |   2 +-
 .../tirpc_clnt_destroy.c                      |   2 +-
 .../tirpc_svc_create.c                        |   2 +-
 .../tirpc_svc_destroy.c                       |   2 +-
 .../tests_pack/rpc_svc_1/rpc_svc_1.c          |   2 +-
 .../tests_pack/rpc_svc_2/rpc_svc_2.c          |   2 +-
 .../rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c  |   2 +-
 .../tests_pack/tirpc_svc_1/tirpc_svc_1.c      |   2 +-
 .../tests_pack/tirpc_svc_11/tirpc_svc_11.c    |   2 +-
 .../tests_pack/tirpc_svc_2/tirpc_svc_2.c      |   2 +-
 .../tests_pack/tirpc_svc_3/tirpc_svc_3.c      |   2 +-
 .../tests_pack/tirpc_svc_4/tirpc_svc_4.c      |   2 +-
 .../tests_pack/tirpc_svc_5/tirpc_svc_5.c      |   2 +-
 .../rpc-tirpc/tests_pack/tirpc_svc_6/Makefile |  23 --
 .../tests_pack/tirpc_svc_6/tirpc_svc_6.c      | 181 ---------------
 .../rpc-tirpc/tests_pack/tirpc_svc_7/Makefile |  23 --
 .../tests_pack/tirpc_svc_7/tirpc_svc_7.c      | 212 ------------------
 .../rpc-tirpc/tests_pack/tirpc_svc_8/Makefile |  23 --
 .../tests_pack/tirpc_svc_8/tirpc_svc_8.c      | 183 ---------------
 .../rpc-tirpc/tests_pack/tirpc_svc_9/Makefile |  23 --
 .../tests_pack/tirpc_svc_9/tirpc_svc_9.c      | 192 ----------------
 travis/debian.cross-compile.aarch64.sh        |   7 -
 travis/debian.cross-compile.ppc64le.sh        |   7 -
 travis/debian.cross-compile.sh                |  22 ++
 travis/debian.i386.sh                         |   5 +-
 travis/debian.sh                              |   5 +-
 travis/fedora.sh                              |   5 +-
 travis/tumbleweed.sh                          |   5 +-
 168 files changed, 254 insertions(+), 1283 deletions(-)
 delete mode 100644 include/lapi/rpc.h
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy.c
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/rpc_clntraw_create.c
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/tirpc_svc_6.c
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/tirpc_svc_7.c
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/tirpc_svc_8.c
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile
 delete mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/tirpc_svc_9.c
 delete mode 100755 travis/debian.cross-compile.aarch64.sh
 delete mode 100755 travis/debian.cross-compile.ppc64le.sh
 create mode 100755 travis/debian.cross-compile.sh

-- 
2.24.1

