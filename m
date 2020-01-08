From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  8 Jan 2020 11:34:09 +0100
Subject: [LTP] [PATCH 0/4] TI-RPC: enhancements (pkg-config, libntirpc,
 travis)
Message-ID: <20200108103413.29096-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

This started as pkg-config detection for libtirpc (IMHO better than
#628 [1]). I also added option to use libntirpc in LTP and changed some
tests in travis to use it (not all distros package it).

BTW Steve was asking in [2] whether these tests should be merged into
libtirpc. I was thinking about it as well [3], but I think it's better
to be in LTP. These tests are IMHO for libtirpc, libntirpc and glibc
(although glibc deprecated them and since 2.26 they're installed only
when configured with --enable-obsolete-rpc). But even glibc
implementation fade out (i.e. all supported enterprise distros will ship
without it), there will be still 2 projects using it. But if you
lib{n,}tirpc developers agree on single git repository which would take
these tests, it could be moved out of LTP (taking needed subset of LTP API).

Other TODO (regardless whether it stays in LTP)
* cleanup
* support for alternative header and shared library path (for testing
lib{n,}tirpc git tree).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/pull/628
[2] https://sourceforge.net/p/libtirpc/mailman/message/36876891/
[3] https://lists.linux.it/pipermail/ltp/2019-December/014757.html

Petr Vorel (4):
  rpc-tirpc: Detect libtirpc with pkg-config
  rpc-tirpc: Add libntirpc support
  travis: Merge debian.cross-compile.*.sh
  travis: Test also libntirpc

 .travis.yml                                   | 24 ++++++++---------
 include/lapi/rpc.h                            | 27 -------------------
 include/mk/config.mk.in                       |  4 +--
 m4/ltp-tirpc.m4                               | 21 ++++++++-------
 testcases/network/Makefile                    |  2 +-
 .../rpc/rpc-tirpc/tests_pack/Makefile.inc     |  4 +--
 .../rpc/rpc-tirpc/tests_pack/include/rpc.h    | 17 ++++++++++++
 .../rpc_clnt_call_complex.c                   |  2 +-
 .../tirpc_rpcb_getaddr.c                      |  2 +-
 .../tirpc_rpcb_getaddr_limits.c               |  2 +-
 .../tirpc_rpcb_getmaps.c                      |  2 +-
 .../tirpc_authdes_create.c                    |  2 +-
 .../tirpc_authdes_seccreate.c                 |  2 +-
 .../tirpc_authnone_create.c                   |  2 +-
 .../tirpc_authsys_create.c                    |  2 +-
 .../tirpc_authsys_create_default.c            |  2 +-
 .../tirpc_bottomlevel_clnt_call.c             |  2 +-
 .../tirpc_bottomlevel_clnt_call_complex.c     |  2 +-
 .../tirpc_bottomlevel_clnt_call_dataint.c     |  2 +-
 .../tirpc_bottomlevel_clnt_call_mt.c          |  2 +-
 .../tirpc_bottomlevel_clnt_call_performance.c |  2 +-
 .../tirpc_bottomlevel_clnt_call_scalability.c |  2 +-
 .../tirpc_bottomlevel_clnt_call_stress.c      |  2 +-
 .../tirpc_clnt_dg_create.c                    |  2 +-
 .../tirpc_clnt_dg_create_limits.c             |  2 +-
 .../tirpc_clnt_vc_create.c                    |  2 +-
 .../tirpc_clnt_vc_create_limits.c             |  2 +-
 .../tirpc_svc_dg_create.c                     |  2 +-
 .../tirpc_svc_dg_create_limits.c              |  2 +-
 .../tirpc_svc_vc_create.c                     |  2 +-
 .../tirpc_svc_vc_create_limits.c              |  2 +-
 .../tirpc_clnt_pcreateerror.c                 |  2 +-
 .../tirpc_err_clnt_perrno/tirpc_clnt_perrno.c |  2 +-
 .../tirpc_clnt_perrno_complex.c               |  2 +-
 .../tirpc_err_clnt_perror/tirpc_clnt_perror.c |  2 +-
 .../tirpc_clnt_perror_complex.c               |  2 +-
 .../tirpc_svcerr_noproc.c                     |  2 +-
 .../tirpc_svcerr_noprog.c                     |  2 +-
 .../tirpc_svcerr_progvers.c                   |  2 +-
 .../tirpc_svcerr_systemerr.c                  |  2 +-
 .../tirpc_svcerr_weakauth.c                   |  2 +-
 .../tirpc_expertlevel_clnt_call.c             |  2 +-
 .../tirpc_expertlevel_clnt_call_complex.c     |  2 +-
 .../tirpc_expertlevel_clnt_call_dataint.c     |  2 +-
 .../tirpc_expertlevel_clnt_call_mt.c          |  2 +-
 .../tirpc_expertlevel_clnt_call_performance.c |  2 +-
 .../tirpc_expertlevel_clnt_call_scalability.c |  2 +-
 .../tirpc_expertlevel_clnt_call_stress.c      |  2 +-
 .../tirpc_clnt_tli_create.c                   |  2 +-
 .../tirpc_clnt_tli_create_limits.c            |  2 +-
 .../tirpc_rpcb_rmtcall.c                      |  2 +-
 .../tirpc_rpcb_rmtcall_complex.c              |  2 +-
 .../tirpc_rpcb_rmtcall_dataint.c              |  2 +-
 .../tirpc_rpcb_rmtcall_mt.c                   |  2 +-
 .../tirpc_rpcb_rmtcall_performance.c          |  2 +-
 .../tirpc_rpcb_rmtcall_scalability.c          |  2 +-
 .../tirpc_rpcb_rmtcall_stress.c               |  2 +-
 .../tirpc_rpcb_set.c                          |  2 +-
 .../tirpc_rpcb_unset.c                        |  2 +-
 .../tirpc_expertlevel_svc_reg/tirpc_svc_reg.c |  2 +-
 .../tirpc_svc_reg_mt.c                        |  2 +-
 .../tirpc_svc_reg_stress.c                    |  2 +-
 .../tirpc_svc_tli_create.c                    |  2 +-
 .../tirpc_svc_tli_create_limits.c             |  2 +-
 .../tirpc_svc_unreg.c                         |  2 +-
 .../tirpc_svc_unreg_mt.c                      |  2 +-
 .../tirpc_svc_unreg_stress.c                  |  2 +-
 .../tirpc_interlevel_clnt_call.c              |  2 +-
 .../tirpc_interlevel_clnt_call_complex.c      |  2 +-
 .../tirpc_interlevel_clnt_call_dataint.c      |  2 +-
 .../tirpc_interlevel_clnt_call_mt.c           |  2 +-
 .../tirpc_interlevel_clnt_call_performance.c  |  2 +-
 .../tirpc_interlevel_clnt_call_scalability.c  |  2 +-
 .../tirpc_interlevel_clnt_call_stress.c       |  2 +-
 .../tirpc_clnt_control.c                      |  2 +-
 .../tirpc_clnt_control_limits.c               |  2 +-
 .../tirpc_clnt_tp_create.c                    |  2 +-
 .../tirpc_clnt_tp_create_timed.c              |  2 +-
 .../tirpc_clnt_tp_create_timed_limits.c       |  2 +-
 .../tirpc_svc_tp_create.c                     |  2 +-
 .../tirpc_rpc_broadcast.c                     |  2 +-
 .../tirpc_rpc_broadcast_complex.c             |  2 +-
 .../tirpc_rpc_broadcast_dataint.c             |  2 +-
 .../tirpc_rpc_broadcast_mt.c                  |  2 +-
 .../tirpc_rpc_broadcast_performance.c         |  2 +-
 .../tirpc_rpc_broadcast_scalability.c         |  2 +-
 .../tirpc_rpc_broadcast_stress.c              |  2 +-
 .../tirpc_rpc_broadcast_exp.c                 |  2 +-
 .../tirpc_rpc_broadcast_exp_complex.c         |  2 +-
 .../tirpc_rpc_broadcast_exp_dataint.c         |  2 +-
 .../tirpc_rpc_broadcast_exp_limits.c          |  2 +-
 .../tirpc_rpc_broadcast_exp_mt.c              |  2 +-
 .../tirpc_rpc_broadcast_exp_performance.c     |  2 +-
 .../tirpc_rpc_broadcast_exp_scalability.c     |  2 +-
 .../tirpc_rpc_broadcast_exp_stress.c          |  2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call.c    |  2 +-
 .../tirpc_rpc_call_complex.c                  |  2 +-
 .../tirpc_rpc_call_dataint.c                  |  2 +-
 .../tirpc_simple_rpc_call/tirpc_rpc_call_mt.c |  2 +-
 .../tirpc_rpc_call_performance.c              |  2 +-
 .../tirpc_rpc_call_scalability.c              |  2 +-
 .../tirpc_rpc_call_stress.c                   |  2 +-
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg.c      |  2 +-
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c   |  2 +-
 .../tirpc_rpc_reg_stress.c                    |  2 +-
 .../tirpc_toplevel_clnt_call.c                |  2 +-
 .../tirpc_toplevel_clnt_call_complex.c        |  2 +-
 .../tirpc_toplevel_clnt_call_dataint.c        |  2 +-
 .../tirpc_toplevel_clnt_call_mt.c             |  2 +-
 .../tirpc_toplevel_clnt_call_performance.c    |  2 +-
 .../tirpc_toplevel_clnt_call_scalability.c    |  2 +-
 .../tirpc_toplevel_clnt_call_stress.c         |  2 +-
 .../tirpc_clnt_create.c                       |  2 +-
 .../tirpc_clnt_create_timed.c                 |  2 +-
 .../tirpc_clnt_create_timed_limits.c          |  2 +-
 .../tirpc_clnt_destroy.c                      |  2 +-
 .../tirpc_svc_create.c                        |  2 +-
 .../tirpc_svc_destroy.c                       |  2 +-
 .../rpc/rpc-tirpc/tests_pack/tirpc_cleaner.c  |  2 +-
 .../tests_pack/tirpc_svc_1/tirpc_svc_1.c      |  2 +-
 .../tests_pack/tirpc_svc_11/tirpc_svc_11.c    |  2 +-
 .../tests_pack/tirpc_svc_2/tirpc_svc_2.c      |  2 +-
 .../tests_pack/tirpc_svc_3/tirpc_svc_3.c      |  2 +-
 .../tests_pack/tirpc_svc_4/tirpc_svc_4.c      |  2 +-
 .../tests_pack/tirpc_svc_5/tirpc_svc_5.c      |  2 +-
 .../tests_pack/tirpc_svc_6/tirpc_svc_6.c      |  2 +-
 .../tests_pack/tirpc_svc_7/tirpc_svc_7.c      |  2 +-
 .../tests_pack/tirpc_svc_8/tirpc_svc_8.c      |  2 +-
 .../tests_pack/tirpc_svc_9/tirpc_svc_9.c      |  2 +-
 travis/debian.cross-compile.aarch64.sh        |  7 -----
 travis/debian.cross-compile.ppc64le.sh        |  7 -----
 travis/debian.cross-compile.sh                | 22 +++++++++++++++
 travis/debian.i386.sh                         |  5 ++--
 travis/debian.sh                              | 13 ++++++---
 travis/fedora.sh                              | 12 +++++++--
 travis/tumbleweed.sh                          |  5 ++--
 136 files changed, 216 insertions(+), 198 deletions(-)
 delete mode 100644 include/lapi/rpc.h
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/include/rpc.h
 delete mode 100755 travis/debian.cross-compile.aarch64.sh
 delete mode 100755 travis/debian.cross-compile.ppc64le.sh
 create mode 100755 travis/debian.cross-compile.sh

-- 
2.24.1

