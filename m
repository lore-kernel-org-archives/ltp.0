From: Cristian Marussi <cristian.marussi@arm.com>
Date: Thu, 20 Dec 2018 18:21:45 +0000
Subject: [LTP] [PATCH v2 0/4]  cgroup tests newlib-porting
Message-ID: <20181220182149.48326-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series converts cgroup/ regression tests to LTP newlib and performs
a general cleanup as follows:

- remove bashism from all tests' scripts
- mostly remove usage of global vars
- convert to SPDX headers
- expose a controllers' common /proc/mounts parsing function
- rename tests' helpers prefixing them with a test-specific tag to avoid
  name clashes on install: I have not renamed the tests' helpers using
  more specific meaningful name, since all of them performs really
  trivial ops needed and meaningful in the context of the regression-test
  subcase they serve; so I thought it would have been better to keep their
  names as they are now, bound to the subcase they help.

Cristian Marussi (4):
  [LTP] cgroup_regression_test.sh ported to newlib
  [LTP] cgroup_regression_test.sh cleanup
  [LTP] cgroup_regression_test.sh: added helper
  [LTP] cgroup: helpers various fixes


