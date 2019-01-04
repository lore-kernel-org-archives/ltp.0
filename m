From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri,  4 Jan 2019 10:54:06 +0000
Subject: [LTP] [PATCH v3 0/1]  memcg_stress newlib porting
Message-ID: <20190104105407.48123-1-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This converts memcg stress tests and its helper to LTP newlib and
performs a general cleanup.

This patch is dependent on [1] since it factors out a common helper
to cgroup_lib.sh (introduced in [1])

Changes
-------
v2->v3:
 - cleaned up cgroup_lib.sh helper

v1->v2:
 - Restored the original usage of SIGKILL to terminate memcp_process_stress
   helpers after having a look at what said in previous commit:
	9b9a6bb10258bc975bd1707b418699264d3bdcef

Cristian Marussi (1):
	[LTP] memcg_stress_test.sh: ported to newlib

[1]: http://lists.linux.it/pipermail/ltp/2018-December/010385.html


