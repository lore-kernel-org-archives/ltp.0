From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 10 Dec 2019 21:13:18 +0100
Subject: [LTP] [PATCH 0/3] musl: travis build and include fixes
Message-ID: <20191210201321.1430984-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

although LTP not yet fully support musl, I'd like
to add travis build via Alpine linux distro.
Remaining broken tests are deleted before building,
I volunteer to solve musl problems for new code.

I also added 2 simple RPC fixes.
RPC tests deserve some rewrite, but I'd postpone it.
https://github.com/linux-test-project/ltp/issues/621

Kind regards,
Petr

Petr Vorel (3):
  travis: Add musl build (with Alpine Linux)
  rpc: Add missing <string.h>
  rpc: Remove <sys/socketvar.h>

 .travis.yml                                   |  7 +++
 .../rpc/basic_tests/rpc01/rpc_server.c        |  1 +
 .../rpc_clnt_broadcast_dataint.c              |  1 +
 .../rpc_svcraw_create.c                       |  1 -
 .../rpc_svctcp_create.c                       |  1 -
 .../rpc_svctcp_create_stress.c                |  1 -
 .../rpc_svcudp_bufcreate.c                    |  1 -
 .../rpc_svcudp_create.c                       |  1 -
 .../rpc_svcudp_create_stress.c                |  1 -
 .../rpc_registerrpc.c                         |  1 -
 .../rpc_svc_register.c                        |  1 -
 .../rpc_svc_unregister.c                      |  1 -
 .../rpc_xprt_register.c                       |  1 -
 .../rpc_xprt_unregister.c                     |  1 -
 .../rpc_stdcall_callrpc/rpc_callrpc_dataint.c |  1 +
 .../rpc_clnt_call_dataint.c                   |  1 +
 .../rpc_svc_freeargs_svc.c                    |  1 +
 .../rpc_stdcall_svc_getargs/rpc_svc_getargs.c |  1 +
 .../rpc_svc_sendreply.c                       |  1 +
 .../tirpc_bottomlevel_clnt_call_dataint.c     |  1 +
 .../tirpc_bottomlevel_clnt_call_mt.c          |  1 +
 .../tirpc_bottomlevel_clnt_call_scalability.c |  1 +
 .../tirpc_expertlevel_clnt_call_complex.c     |  1 +
 .../tirpc_expertlevel_clnt_call_dataint.c     |  1 +
 .../tirpc_expertlevel_clnt_call_mt.c          |  1 +
 .../tirpc_expertlevel_clnt_call_scalability.c |  1 +
 .../tirpc_rpcb_rmtcall_complex.c              |  1 +
 .../tirpc_rpcb_rmtcall_dataint.c              |  1 +
 .../tirpc_rpcb_rmtcall_mt.c                   |  1 +
 .../tirpc_rpcb_rmtcall_scalability.c          |  1 +
 .../tirpc_svc_reg_mt.c                        |  1 +
 .../tirpc_svc_unreg_mt.c                      |  1 +
 .../tirpc_interlevel_clnt_call_complex.c      |  1 +
 .../tirpc_interlevel_clnt_call_dataint.c      |  1 +
 .../tirpc_interlevel_clnt_call_mt.c           |  1 +
 .../tirpc_interlevel_clnt_call_scalability.c  |  1 +
 .../tirpc_rpc_broadcast_dataint.c             |  1 +
 .../tirpc_rpc_broadcast_mt.c                  |  1 +
 .../tirpc_rpc_broadcast_scalability.c         |  1 +
 .../tirpc_rpc_broadcast_exp_dataint.c         |  1 +
 .../tirpc_rpc_broadcast_exp_mt.c              |  1 +
 .../tirpc_rpc_broadcast_exp_scalability.c     |  1 +
 .../tirpc_rpc_call_complex.c                  |  1 +
 .../tirpc_rpc_call_dataint.c                  |  1 +
 .../tirpc_simple_rpc_call/tirpc_rpc_call_mt.c |  1 +
 .../tirpc_rpc_call_scalability.c              |  1 +
 .../tirpc_simple_rpc_reg/tirpc_rpc_reg_mt.c   |  1 +
 .../tirpc_toplevel_clnt_call_complex.c        |  1 +
 .../tirpc_toplevel_clnt_call_dataint.c        |  1 +
 .../tirpc_toplevel_clnt_call_mt.c             |  1 +
 .../tirpc_toplevel_clnt_call_scalability.c    |  1 +
 .../tests_pack/rpc_svc_1/rpc_svc_1.c          |  1 +
 travis/alpine.sh                              | 51 +++++++++++++++++++
 53 files changed, 98 insertions(+), 11 deletions(-)
 create mode 100755 travis/alpine.sh

-- 
2.24.0

