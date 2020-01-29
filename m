From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 29 Jan 2020 15:49:10 +0100
Subject: [LTP] [PATCH 0/3] LVM support scripts for OpenQA
Message-ID: <20200129144913.9889-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The old support script for LVM tests (testscripts/ltpfslvm.sh) doesn't work
very well with external testing tools so LVM tests currently cannot be run
in OpenQA. Create new LVM support scripts that focus exclusively on setup
and cleanup. One of the scripts also generates a new LVM runfile that'll test
only file systems supported by the test machine.

Martin Doucha (3):
  Fix releasing loop devices in shell API
  Allow acquiring multiple loop devices
  Add LVM support scripts

 include/old/old_device.h                 |  19 +++++
 lib/tst_device.c                         |  36 +++++---
 testcases/lib/tst_device.c               |  20 +++--
 testcases/misc/lvm/Makefile              |  29 +++++++
 testcases/misc/lvm/cleanup_lvm.sh        |  34 ++++++++
 testcases/misc/lvm/datafiles/Makefile    |  19 +++++
 testcases/misc/lvm/datafiles/runfile.tpl |  36 ++++++++
 testcases/misc/lvm/generate_runfile.sh   |  27 ++++++
 testcases/misc/lvm/prepare_lvm.sh        | 102 +++++++++++++++++++++++
 9 files changed, 304 insertions(+), 18 deletions(-)
 create mode 100644 testcases/misc/lvm/Makefile
 create mode 100755 testcases/misc/lvm/cleanup_lvm.sh
 create mode 100644 testcases/misc/lvm/datafiles/Makefile
 create mode 100644 testcases/misc/lvm/datafiles/runfile.tpl
 create mode 100755 testcases/misc/lvm/generate_runfile.sh
 create mode 100755 testcases/misc/lvm/prepare_lvm.sh

-- 
2.24.1

