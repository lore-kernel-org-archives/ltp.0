From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 18:18:18 +0200
Subject: [LTP] [RFC PATCH v2 0/2] Shell: Add TST_TEST_DATA and
	TST_TEST_DATA_IFS
Message-ID: <20180516161820.3077-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2:
* renamed variables to TST_TEST_DATA and TST_TEST_DATA_IFS (Cyril)
* replace split with IFS by split with while & cut (Cyril)
* TST_TESTFUNC_DATA can be used with TST_CNT
* iteration/sequence number is in $1, data are in $2
* For consistency the test number is now passed also to functions as the
'$1' in tests using $TST_CNT in separate functions (so that
TST_TEST_DATA is always passed as the '$2'). This is also updated in doc.
* improved doc

Petr Vorel (2):
  tst_test.sh: Add TST_TEST_DATA and TST_TEST_DATA_IFS
  net/{stress,virt}: Use TST_TEST_DATA and TST_TEST_DATA_IFS

 doc/test-writing-guidelines.txt                 | 74 ++++++++++++++++++++++---
 lib/newlib_tests/Makefile                       | 19 -------
 testcases/lib/tst_test.sh                       | 22 ++++++--
 testcases/network/stress/dccp/dccp_ipsec.sh     |  5 +-
 testcases/network/stress/dccp/dccp_ipsec_vti.sh |  5 +-
 testcases/network/stress/ipsec/ipsec_lib.sh     |  3 +-
 testcases/network/stress/sctp/sctp_ipsec.sh     |  6 +-
 testcases/network/stress/sctp/sctp_ipsec_vti.sh |  7 +--
 testcases/network/stress/tcp/tcp_ipsec.sh       |  6 +-
 testcases/network/stress/tcp/tcp_ipsec_vti.sh   |  5 +-
 testcases/network/stress/udp/udp_ipsec.sh       |  7 +--
 testcases/network/stress/udp/udp_ipsec_vti.sh   |  7 +--
 12 files changed, 100 insertions(+), 66 deletions(-)
 delete mode 100644 lib/newlib_tests/Makefile

-- 
2.16.3

