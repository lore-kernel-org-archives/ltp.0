From: Elif Aslan <elas@linux.vnet.ibm.com>
Date: Mon, 25 Mar 2019 10:15:34 +0100
Subject: [LTP] [PATCH 0/1] add s390 cpuplugd tests
Message-ID: <20190325091535.2232-1-elas@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a new version of cpuplugd tests which includes feedback from
Cyril Hrubis given last time.

Elif Aslan (1):
  ltp: add s390 cpuplugd tests

 runtest/s390x_tests                           |   3 +-
 testcases/commands/cpuplugd/cpuplugd.sh       | 443 ++++++++++++++++++
 .../commands/cpuplugd/datafiles/cmm.conf      |  10 +
 .../commands/cpuplugd/datafiles/cpu.conf      |   8 +
 .../commands/cpuplugd/datafiles/cpuplugd.conf |  15 +
 .../cpuplugd/datafiles/cpuplugdcmm.conf       |  10 +
 .../cpuplugd/datafiles/cpuplugdtemp.conf      |  15 +
 testcases/commands/cpuplugd/mon_fsstatd.sh    | 113 +++++
 testcases/commands/cpuplugd/s390_lib.sh       |  45 ++
 9 files changed, 661 insertions(+), 1 deletion(-)
 create mode 100644 testcases/commands/cpuplugd/cpuplugd.sh
 create mode 100644 testcases/commands/cpuplugd/datafiles/cmm.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpu.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpuplugd.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpuplugdcmm.conf
 create mode 100644 testcases/commands/cpuplugd/datafiles/cpuplugdtemp.conf
 create mode 100644 testcases/commands/cpuplugd/mon_fsstatd.sh
 create mode 100644 testcases/commands/cpuplugd/s390_lib.sh

-- 
2.17.2 (Apple Git-113)

