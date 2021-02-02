From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  2 Feb 2021 16:34:51 +0300
Subject: [LTP] [PATCH 0/3] lib/tst_net.sh: calc median instead of mean in
 tst_netload()
Message-ID: <20210202133454.59224-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series of patches is intended to improve the reliability
of results in network tests that using tst_netload().

After TST_NETLOAD_RUN_COUNT was added, we get several results (5 by
default). The first patch allows all of them to be displayed along
with the final result. It helps to debug test performance failures.

Further patches replace the mean calculation of such data set with
the median one. It allows to exclude extreme points from the final
result.

Alexey Kodanev (3):
  lib/tst_net.sh: print all netstress results in tst_netload()
  lib: add tst_get_median helper binary for use in script tests
  lib/tst_net.sh: calc median instead of mean in tst_netload()

 testcases/lib/.gitignore       |  1 +
 testcases/lib/Makefile         |  3 ++-
 testcases/lib/tst_get_median.c | 37 ++++++++++++++++++++++++++++++++++
 testcases/lib/tst_net.sh       | 10 ++++-----
 4 files changed, 45 insertions(+), 6 deletions(-)
 create mode 100644 testcases/lib/tst_get_median.c

-- 
2.25.1
