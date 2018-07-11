From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 11 Jul 2018 13:29:21 +0100
Subject: [LTP] [PATCH 0/4] Add dependency checking
Message-ID: <20180711122925.24278-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

While investigating failures from nightly runs, I came across some
tests that don't explicitly check for dependencies.

Add appropriate check for dependencies so the tests are reported as an
issue with the configuration rather than a test failure. These set of
patches transitions ~50-60 tests from reporting failures to a
configuration issue.

Thanks,
Punit

Punit Agrawal (4):
  controllers/cgroup_fj_common.sh: Check for dependencies during setup
  quota_remount_test01: Add explicit check for dependencies
  memcg_lib.sh: Check for killall
  controllers/pids.sh: Check for killall

 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 1 +
 testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 3 +++
 testcases/kernel/controllers/pids/pids.sh                  | 1 +
 testcases/kernel/fs/quota_remount/quota_remount_test01.sh  | 4 ++++
 4 files changed, 9 insertions(+)

-- 
2.17.1

