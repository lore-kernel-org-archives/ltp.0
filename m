From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 26 Nov 2019 13:02:38 +0100
Subject: [LTP] [PATCH 0/3] Improve test_1_to_1_initmsg_connect SCTP test
Message-ID: <20191126120241.5460-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

One of the SCTP tests often fails on older kernels on some platforms
due to memory allocation issues. This patchset ports the test to the new LTP
library and fixes the failures by splitting the test into two test cases:
1. Functional test with reduced number of connection streams
2. Stress test with original (maximum) number of connection streams

The stress test accepts ENOMEM error in connect() as success.

This patchset also adds SAFE_ACCEPT() function to the LTP library to simplify
network tests.

Martin Doucha (3):
  Add SAFE_ACCEPT() to LTP safe net library
  Port test_1_to_1_initmsg_connect (SCTP) to new API
  Split SCTP initmsg test into two test cases

 include/safe_net_fn.h                         |   3 +
 include/tst_safe_net.h                        |   3 +
 lib/safe_net.c                                |  16 ++
 .../func_tests/test_1_to_1_initmsg_connect.c  | 161 +++++++++---------
 4 files changed, 98 insertions(+), 85 deletions(-)

-- 
2.24.0

