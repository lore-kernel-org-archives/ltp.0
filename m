From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 28 Dec 2018 18:32:11 +0000
Subject: [LTP] [PATCH 0/2]  memcg_stress newlib porting and fixes
Message-ID: <20181228183213.36339-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This series at first converts memcg stress tests to LTP newlib and
performs a general cleanup, and then fixes the maximum quantity of
memory used for allocation on a swap-less system.

This patch is dependent on [1] since it factors out a common helper
to cgroup_lib.sh (introduced in [1])

Cristian Marussi (2):
	[LTP] memcg_stress_test.sh: ported to newlib
	[LTP] memcg_stress_test.sh: fix memory usage

[1]: http://lists.linux.it/pipermail/ltp/2018-December/010385.html


