From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 15 Apr 2020 14:41:54 +0200
Subject: [LTP] [PATCH v6 0/3] LVM support scripts for OpenQA
Message-ID: <20200415124157.10484-1-mdoucha@suse.cz>
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
  Allow acquiring multiple loop devices
  Add LVM support scripts
  Skip Btrfs in LVM stress tests

 include/old/old_device.h                   | 15 +++-
 lib/tst_device.c                           | 36 ++++++----
 testcases/lib/tst_device.c                 | 14 ++--
 testcases/misc/lvm/Makefile                |  9 +++
 testcases/misc/lvm/cleanup_lvm.sh          | 34 +++++++++
 testcases/misc/lvm/datafiles/Makefile      |  8 +++
 testcases/misc/lvm/datafiles/runfile.tpl   | 36 ++++++++++
 testcases/misc/lvm/generate_lvm_runfile.sh | 30 ++++++++
 testcases/misc/lvm/prepare_lvm.sh          | 83 ++++++++++++++++++++++
 testscripts/lvmtest.sh                     | 18 +++++
 10 files changed, 264 insertions(+), 19 deletions(-)
 create mode 100644 testcases/misc/lvm/Makefile
 create mode 100755 testcases/misc/lvm/cleanup_lvm.sh
 create mode 100644 testcases/misc/lvm/datafiles/Makefile
 create mode 100644 testcases/misc/lvm/datafiles/runfile.tpl
 create mode 100755 testcases/misc/lvm/generate_lvm_runfile.sh
 create mode 100755 testcases/misc/lvm/prepare_lvm.sh
 create mode 100755 testscripts/lvmtest.sh

-- 
2.26.0

