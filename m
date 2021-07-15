From: Leo Liang <ycliang@andestech.com>
Date: Thu, 15 Jul 2021 22:20:41 +0800
Subject: [LTP] [PATCH v2,
 0/2] cgroup/cgroup_regression_test: Fix umount failure
Message-ID: <20210715142037.GA30536@atcfdc88>
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

Changes since v1
- Use "tst_umount" instead of "sync" as suggested
- Make "tst_umount" work with argument that has terminating slash

Leo Yu-Chi Liang (2):
  lib/tst_test.sh: Make tst_umount work with argument that has
    terminating slash
  cgroup/cgroup_regression_test: Fix umount failure

 .../controllers/cgroup/cgroup_regression_test.sh       | 10 +++++-----
 testcases/lib/tst_test.sh                              |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.0
