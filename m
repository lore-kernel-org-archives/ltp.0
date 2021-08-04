From: Leo Liang <ycliang@andestech.com>
Date: Wed, 4 Aug 2021 09:51:07 +0800
Subject: [LTP] [PATCH v6,
 0/4] cgroup/cgroup_regression_test: Fix umount failure
Message-ID: <20210804015053.GA21545@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test sequence
	mount -t cgroup -o <controllers> <path>
	mkdir <path>/<dir>
	rmdir <path>/<dir>
	umount <path>
	mount -t cgroup -o <controllers> <path>
would easily fail at the last mount with -EBUSY on certain platform.

Adding a little delay between "rmdir" and "umount" could fix the problem,
so use tst_umount API instead of umount in "rmdir, umount" sequence.

tst_umount API is ambiguous when checking for whether a device is mounted.
Modify it to check an actual mount point instead of device
and reject anything that does not start with '/' as an argument.

Changes since v1
- Use "tst_umount" instead of "sync" as suggested
- Make "tst_umount" work with argument that has terminating slash

Changes since v2
- Filter out the trailing slash instead of using mountpoint command

Changes since v3
- Filter out the trailing slash only in grep command
- Add comment in the test script

Changes since v4
- Remove unnecessary stderr redirection

Changes since v5
- Make tst_umount to only accept absolute mount point as an argument
- Modify tests that use tst_umount to pass mount point in instead of device

Leo Yu-Chi Liang (4):
  lib: tst_umount: umount a mount point instead of device
  doc: change the default behavior of tst_umount
  cgroup/cgroup_regression_test: Fix umount failure
  Make argument to tst_umount an absolute path

 doc/shell-test-api.txt                         |  8 ++++----
 .../cgroup/cgroup_regression_test.sh           | 10 +++++-----
 .../fs/quota_remount/quota_remount_test01.sh   |  2 +-
 .../integrity/ima/tests/evm_overlay.sh         |  2 +-
 .../tracing/dynamic_debug/dynamic_debug01.sh   |  2 +-
 testcases/lib/tst_test.sh                      | 18 +++++++++++-------
 6 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.17.0
