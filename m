From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 13 May 2021 14:23:40 +0800
Subject: [LTP] [PATCH 1/2 v2] Makefile: Use SPDX in Makefile
In-Reply-To: <20210513062341.83852-1-xieziyao@huawei.com>
References: <20210513062341.83852-1-xieziyao@huawei.com>
Message-ID: <20210513062341.83852-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the testsuite that has used SPDX, also modify its Makefile to use SPDX.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 doc/Makefile                                  | 22 ++-------------
 include/Makefile                              | 22 ++-------------
 lib/Makefile                                  | 22 ++-------------
 lib/newlib_tests/Makefile                     |  1 +
 testcases/Makefile                            | 27 +++----------------
 testcases/commands/Makefile                   | 24 +++--------------
 testcases/commands/ar/Makefile                | 22 ++-------------
 testcases/commands/cp/Makefile                | 22 ++-------------
 testcases/commands/cpio/Makefile              | 22 ++-------------
 testcases/commands/df/Makefile                | 23 +++-------------
 testcases/commands/du/Makefile                | 18 +------------
 testcases/commands/eject/Makefile             | 22 ++-------------
 testcases/commands/file/Makefile              | 22 ++-------------
 testcases/commands/gdb/Makefile               | 20 ++------------
 testcases/commands/gzip/Makefile              | 22 ++-------------
 testcases/commands/insmod/Makefile            | 17 +++---------
 testcases/commands/keyctl/Makefile            | 19 +++----------
 testcases/commands/ld/Makefile                | 22 ++-------------
 testcases/commands/ldd/Makefile               | 18 ++-----------
 testcases/commands/ln/Makefile                | 22 ++-------------
 testcases/commands/lsmod/Makefile             | 17 +++---------
 testcases/commands/mkdir/Makefile             | 22 ++-------------
 testcases/commands/mkfs/Makefile              | 19 +++----------
 testcases/commands/mkswap/Makefile            | 17 +++---------
 testcases/commands/mv/Makefile                | 22 ++-------------
 testcases/commands/nm/Makefile                | 22 ++-------------
 testcases/commands/sysctl/Makefile            | 16 +----------
 testcases/commands/tar/Makefile               | 22 ++-------------
 testcases/commands/unshare/Makefile           | 13 +--------
 testcases/commands/unzip/Makefile             | 22 ++-------------
 testcases/commands/wc/Makefile                | 17 +++---------
 testcases/commands/which/Makefile             | 17 +++---------
 testcases/cve/Makefile                        | 14 +---------
 testcases/kernel/Makefile                     | 24 +++--------------
 testcases/kernel/connectors/Makefile          | 22 ++-------------
 testcases/kernel/connectors/pec/Makefile      | 22 ++-------------
 testcases/kernel/containers/Makefile          | 17 +-----------
 testcases/kernel/containers/netns/Makefile    | 18 ++-----------
 testcases/kernel/containers/pidns/Makefile    | 21 ++-------------
 testcases/kernel/controllers/Makefile         | 22 ++-------------
 testcases/kernel/controllers/cpuacct/Makefile | 22 ++-------------
 testcases/kernel/controllers/memcg/Makefile   | 22 ++-------------
 .../controllers/memcg/functional/Makefile     | 22 ++-------------
 .../controllers/memcg/regression/Makefile     | 22 ++-------------
 testcases/kernel/controllers/pids/Makefile    | 20 ++------------
 testcases/kernel/crypto/Makefile              | 14 +---------
 testcases/kernel/device-drivers/Makefile      | 15 +----------
 .../kernel/device-drivers/block/Makefile      | 15 +----------
 .../block/block_dev_kernel/Makefile           | 15 +----------
 testcases/kernel/device-drivers/rcu/Makefile  | 15 +----------
 testcases/kernel/device-drivers/rtc/Makefile  | 15 +----------
 testcases/kernel/fs/Makefile                  | 22 ++-------------
 testcases/kernel/fs/fs_fill/Makefile          | 14 +---------
 testcases/kernel/fs/iso9660/Makefile          | 19 ++-----------
 testcases/kernel/fs/lftest/Makefile           | 22 ++-------------
 testcases/kernel/fs/linktest/Makefile         | 22 ++-------------
 testcases/kernel/fs/quota_remount/Makefile    | 19 ++-----------
 testcases/kernel/fs/read_all/Makefile         | 14 +---------
 testcases/kernel/io/Makefile                  | 22 ++-------------
 testcases/kernel/lib/Makefile                 | 21 ++-------------
 testcases/kernel/logging/Makefile             | 19 ++-----------
 testcases/kernel/logging/kmsg/Makefile        | 19 ++-----------
 testcases/kernel/mem/Makefile                 | 22 ++-------------
 testcases/kernel/mem/hugetlb/Makefile         | 19 ++-----------
 .../kernel/mem/hugetlb/hugemmap/Makefile      | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmat/Makefile     | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmctl/Makefile    | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmdt/Makefile     | 22 ++-------------
 .../kernel/mem/hugetlb/hugeshmget/Makefile    | 19 ++-----------
 testcases/kernel/mem/hugetlb/lib/Makefile     | 19 ++-----------
 testcases/kernel/mem/ksm/Makefile             | 19 ++-----------
 testcases/kernel/mem/mmapstress/Makefile      | 19 ++-----------
 testcases/kernel/mem/mtest01/Makefile         | 22 ++-------------
 testcases/kernel/mem/mtest06/Makefile         | 22 ++-------------
 testcases/kernel/mem/mtest07/Makefile         | 22 ++-------------
 testcases/kernel/mem/thp/Makefile             | 20 ++------------
 testcases/kernel/mem/tunable/Makefile         | 20 ++------------
 testcases/kernel/mem/vma/Makefile             | 20 ++------------
 testcases/kernel/numa/Makefile                | 19 ++-----------
 testcases/kernel/pty/Makefile                 | 22 ++-------------
 testcases/kernel/sched/Makefile               | 22 ++-------------
 testcases/kernel/sched/autogroup/Makefile     | 20 +++-----------
 testcases/kernel/security/Makefile            | 22 ++-------------
 testcases/kernel/security/dirtyc0w/Makefile   | 15 +----------
 testcases/kernel/security/integrity/Makefile  | 19 ++-----------
 .../kernel/security/integrity/ima/Makefile    | 22 ++-------------
 .../security/integrity/ima/datafiles/Makefile | 26 +++---------------
 .../security/integrity/ima/src/Makefile       | 22 ++-------------
 .../security/integrity/ima/tests/Makefile     | 22 ++-------------
 testcases/kernel/syscalls/pwritev/Makefile    | 21 +++------------
 .../kernel/syscalls/set_mempolicy/Makefile    |  1 +
 testcases/kernel/tracing/Makefile             |  1 +
 .../kernel/tracing/dynamic_debug/Makefile     | 20 ++------------
 testcases/lib/Makefile                        | 22 ++-------------
 testcases/misc/Makefile                       | 24 +++--------------
 testcases/network/Makefile                    |  1 +
 testcases/network/can/Makefile                | 21 ++-------------
 testcases/network/can/filter-tests/Makefile   | 18 ++-----------
 testcases/network/dhcp/Makefile               | 15 +----------
 testcases/network/iproute/Makefile            | 22 ++-------------
 testcases/network/lib6/Makefile               | 24 ++---------------
 testcases/network/netstress/Makefile          | 14 +---------
 testcases/network/rpc/Makefile                | 22 ++-------------
 testcases/network/rpc/rpc-tirpc/Makefile      | 19 ++-----------
 .../network/rpc/rpc-tirpc/tests_pack/Makefile |  1 +
 testcases/network/sctp/Makefile               | 14 +---------
 testcases/network/sockets/Makefile            | 22 ++-------------
 testcases/network/stress/Makefile             | 22 ++-------------
 testcases/network/stress/dccp/Makefile        | 14 +---------
 testcases/network/stress/icmp/Makefile        | 22 ++-------------
 testcases/network/stress/interface/Makefile   | 22 ++-------------
 testcases/network/stress/ipsec/Makefile       | 19 +------------
 testcases/network/stress/multicast/Makefile   | 22 ++-------------
 .../stress/multicast/grp-operation/Makefile   | 22 ++-------------
 .../stress/multicast/packet-flood/Makefile    | 22 ++-------------
 .../stress/multicast/query-flood/Makefile     | 22 ++-------------
 testcases/network/stress/sctp/Makefile        | 14 +---------
 testcases/network/stress/tcp/Makefile         | 22 ++-------------
 testcases/network/stress/udp/Makefile         | 22 ++-------------
 testcases/network/tcp_cc/Makefile             | 14 +---------
 testcases/network/tcp_cmds/Makefile           | 24 +++--------------
 testcases/network/tcp_cmds/host/Makefile      | 22 ++-------------
 testcases/network/tcp_cmds/ipneigh/Makefile   | 22 ++-------------
 testcases/network/tcp_cmds/netstat/Makefile   | 22 ++-------------
 testcases/network/tcp_cmds/sendfile/Makefile  | 22 ++-------------
 testcases/network/tcp_cmds/tracepath/Makefile | 14 +---------
 testcases/network/tcp_fastopen/Makefile       | 15 +----------
 testcases/network/traceroute/Makefile         | 22 ++-------------
 testcases/network/virt/Makefile               | 15 +----------
 testcases/network/xinetd/Makefile             | 22 ++-------------
 testcases/open_posix_testsuite/Makefile       |  5 +---
 .../open_posix_testsuite/conformance/Makefile |  5 +---
 .../conformance/interfaces/Makefile           |  5 +---
 testscripts/Makefile                          | 22 ++-------------
 utils/Makefile                                | 21 ++-------------
 utils/sctp/Makefile                           | 22 ++-------------
 utils/sctp/func_tests/Makefile                | 23 ++--------------
 137 files changed, 260 insertions(+), 2351 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
index e28df6853..f7e4dd021 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -1,24 +1,6 @@
-#
-#    Doc Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir			?= ..

diff --git a/include/Makefile b/include/Makefile
index 7588e6600..25e96df9b 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,24 +1,6 @@
-#
-#    include Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ..

diff --git a/lib/Makefile b/lib/Makefile
index f019432e8..9b9906f25 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -1,24 +1,6 @@
-#
-#    lib Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ..

diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 7acdd1ff7..30ca6810c 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 top_srcdir		?= ../..

 include $(top_srcdir)/include/mk/env_pre.mk
diff --git a/testcases/Makefile b/testcases/Makefile
index b04e6309f..662d4b1ed 100644
--- a/testcases/Makefile
+++ b/testcases/Makefile
@@ -1,33 +1,14 @@
-#
-#    testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ..

 include $(top_srcdir)/include/mk/env_pre.mk

 # XXX (garrcoop):
-# 1. kdump shouldn't be compiled by default, because it's runtime based and
-#    WILL crash the build host (the tests need to be fixed to just build, not
-#    run).
+# kdump shouldn't be compiled by default, because it's runtime based and will
+# crash the build host (the tests need to be fixed to just build, not run).
 FILTER_OUT_DIRS		:= kdump

 ifneq ($(WITH_OPEN_POSIX_TESTSUITE),yes)
diff --git a/testcases/commands/Makefile b/testcases/commands/Makefile
index fba3a521b..3ef7db4e4 100644
--- a/testcases/commands/Makefile
+++ b/testcases/commands/Makefile
@@ -1,25 +1,7 @@
-#
-#    commands test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (C) 2010, Linux Test Project.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../..

diff --git a/testcases/commands/ar/Makefile b/testcases/commands/ar/Makefile
index 05a908097..52b43ccba 100644
--- a/testcases/commands/ar/Makefile
+++ b/testcases/commands/ar/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/ade/ar testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/cp/Makefile b/testcases/commands/cp/Makefile
index f71e9f3e8..22a950a8b 100644
--- a/testcases/commands/cp/Makefile
+++ b/testcases/commands/cp/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/fileutils/cp testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/cpio/Makefile b/testcases/commands/cpio/Makefile
index 55a8912cb..09da3a06a 100644
--- a/testcases/commands/cpio/Makefile
+++ b/testcases/commands/cpio/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/cpio testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/df/Makefile b/testcases/commands/df/Makefile
index e1a38c891..2787bb43a 100644
--- a/testcases/commands/df/Makefile
+++ b/testcases/commands/df/Makefile
@@ -1,23 +1,6 @@
-#
-#    commands/df testcases Makefile.
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Zhang Jin <jy_zhangjin@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author:Zhang Jin <jy_zhangjin@cn.fujitsu.com>

 top_srcdir		?= ../../..

diff --git a/testcases/commands/du/Makefile b/testcases/commands/du/Makefile
index c1664460d..04ac74274 100644
--- a/testcases/commands/du/Makefile
+++ b/testcases/commands/du/Makefile
@@ -1,22 +1,6 @@
-#
-# commands/du testcases Makefile.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

 top_srcdir		?= ../../..

diff --git a/testcases/commands/eject/Makefile b/testcases/commands/eject/Makefile
index d805ac555..f33b5117f 100644
--- a/testcases/commands/eject/Makefile
+++ b/testcases/commands/eject/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/eject testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/file/Makefile b/testcases/commands/file/Makefile
index 776db3226..906730493 100644
--- a/testcases/commands/file/Makefile
+++ b/testcases/commands/file/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/ade/file testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/gdb/Makefile b/testcases/commands/gdb/Makefile
index 1ebbf653d..80967e848 100644
--- a/testcases/commands/gdb/Makefile
+++ b/testcases/commands/gdb/Makefile
@@ -1,21 +1,5 @@
-#
-#    misc/gdb test suite Makefile.
-#
-#    Copyright (C) 2017 Red Hat, Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-#    General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, see <http://www.gnu.org/licenses/>.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2017 Red Hat, Inc.

 top_srcdir		?= ../../..

diff --git a/testcases/commands/gzip/Makefile b/testcases/commands/gzip/Makefile
index 502781b57..cb6f21991 100644
--- a/testcases/commands/gzip/Makefile
+++ b/testcases/commands/gzip/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/gzip testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/insmod/Makefile b/testcases/commands/insmod/Makefile
index e5e68b695..ad30b1509 100644
--- a/testcases/commands/insmod/Makefile
+++ b/testcases/commands/insmod/Makefile
@@ -1,17 +1,6 @@
-#
-#    Copyright (c) 2016 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016 Fujitsu Ltd.
+# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 ifneq ($(KERNELRELEASE),)

diff --git a/testcases/commands/keyctl/Makefile b/testcases/commands/keyctl/Makefile
index 144beed7c..a4c740e34 100644
--- a/testcases/commands/keyctl/Makefile
+++ b/testcases/commands/keyctl/Makefile
@@ -1,19 +1,6 @@
-#
-#    commands/keyctl testcases Makefile.
-#
-#    Copyright (c) 2017 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2017 Fujitsu Ltd.
+# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 top_srcdir		?= ../../..

diff --git a/testcases/commands/ld/Makefile b/testcases/commands/ld/Makefile
index a4117c8ea..b1bab5fac 100644
--- a/testcases/commands/ld/Makefile
+++ b/testcases/commands/ld/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/ade/ld testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/ldd/Makefile b/testcases/commands/ldd/Makefile
index 1afd3da4b..fca29bb2b 100644
--- a/testcases/commands/ldd/Makefile
+++ b/testcases/commands/ldd/Makefile
@@ -1,20 +1,6 @@
-#
-#    commands/ade/ldd testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/ln/Makefile b/testcases/commands/ln/Makefile
index c32fe5c54..f9e93a56a 100644
--- a/testcases/commands/ln/Makefile
+++ b/testcases/commands/ln/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/fileutils/ln testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/lsmod/Makefile b/testcases/commands/lsmod/Makefile
index 8fc3b1436..4df27add4 100644
--- a/testcases/commands/lsmod/Makefile
+++ b/testcases/commands/lsmod/Makefile
@@ -1,17 +1,6 @@
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 ifneq ($(KERNELRELEASE),)

diff --git a/testcases/commands/mkdir/Makefile b/testcases/commands/mkdir/Makefile
index 285a3a288..9eae51afd 100644
--- a/testcases/commands/mkdir/Makefile
+++ b/testcases/commands/mkdir/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/fileutils/mkdir testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/mkfs/Makefile b/testcases/commands/mkfs/Makefile
index 609901770..e399d7244 100644
--- a/testcases/commands/mkfs/Makefile
+++ b/testcases/commands/mkfs/Makefile
@@ -1,19 +1,6 @@
-#
-#    commands/mkfs testcases Makefile.
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 top_srcdir		?= ../../..

diff --git a/testcases/commands/mkswap/Makefile b/testcases/commands/mkswap/Makefile
index 5c8bd9bba..888053215 100644
--- a/testcases/commands/mkswap/Makefile
+++ b/testcases/commands/mkswap/Makefile
@@ -1,17 +1,6 @@
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 top_srcdir		?= ../../..

diff --git a/testcases/commands/mv/Makefile b/testcases/commands/mv/Makefile
index ca594a50a..62342e6b5 100644
--- a/testcases/commands/mv/Makefile
+++ b/testcases/commands/mv/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/fileutils/mv testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/nm/Makefile b/testcases/commands/nm/Makefile
index 4efb4b500..4d1e76af2 100644
--- a/testcases/commands/nm/Makefile
+++ b/testcases/commands/nm/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/ade/nm testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/sysctl/Makefile b/testcases/commands/sysctl/Makefile
index 61ff70518..a47e17e3e 100644
--- a/testcases/commands/sysctl/Makefile
+++ b/testcases/commands/sysctl/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
 # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, see <http://www.gnu.org/licenses/>.
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/tar/Makefile b/testcases/commands/tar/Makefile
index 7406b1f11..ff06c2715 100644
--- a/testcases/commands/tar/Makefile
+++ b/testcases/commands/tar/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/tar testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/unshare/Makefile b/testcases/commands/unshare/Makefile
index a17529145..fac183db5 100644
--- a/testcases/commands/unshare/Makefile
+++ b/testcases/commands/unshare/Makefile
@@ -1,17 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
 # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/unzip/Makefile b/testcases/commands/unzip/Makefile
index 72ac803c1..03e126d7e 100644
--- a/testcases/commands/unzip/Makefile
+++ b/testcases/commands/unzip/Makefile
@@ -1,24 +1,6 @@
-#
-#    commands/unzip testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/commands/wc/Makefile b/testcases/commands/wc/Makefile
index 6571074a9..33aeb85ad 100644
--- a/testcases/commands/wc/Makefile
+++ b/testcases/commands/wc/Makefile
@@ -1,17 +1,6 @@
-#
-#    Copyright (c) 2016 Fujitsu Ltd.
-#    Author:Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016 Fujitsu Ltd.
+# Author:Xiao Yang <yangx.jy@cn.fujitsu.com>

 top_srcdir		?= ../../..

diff --git a/testcases/commands/which/Makefile b/testcases/commands/which/Makefile
index d9b4d1299..1be02f7d7 100644
--- a/testcases/commands/which/Makefile
+++ b/testcases/commands/which/Makefile
@@ -1,17 +1,6 @@
-#
-#    Copyright (c) 2015 Fujitsu Ltd.
-#    Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author:Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 top_srcdir		?= ../../..

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 63b1d7525..301e19461 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Linux Test Project
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../..

diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 3319b3163..f3a608f38 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -1,25 +1,7 @@
-#
-#    kernel test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (C) 2010, Linux Test Project.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../..

diff --git a/testcases/kernel/connectors/Makefile b/testcases/kernel/connectors/Makefile
index 5f668f419..336f98f7b 100644
--- a/testcases/kernel/connectors/Makefile
+++ b/testcases/kernel/connectors/Makefile
@@ -1,24 +1,6 @@
-#
-#    testcases/kernel/connectors test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems, Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems, Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/connectors/pec/Makefile b/testcases/kernel/connectors/pec/Makefile
index d9a7f104e..00b549ad6 100644
--- a/testcases/kernel/connectors/pec/Makefile
+++ b/testcases/kernel/connectors/pec/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/connectors/pec testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/containers/Makefile b/testcases/kernel/containers/Makefile
index 6620ed984..4285546e7 100644
--- a/testcases/kernel/containers/Makefile
+++ b/testcases/kernel/containers/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2007
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/containers/netns/Makefile b/testcases/kernel/containers/netns/Makefile
index 3756a55ef..3cc2b4ae7 100644
--- a/testcases/kernel/containers/netns/Makefile
+++ b/testcases/kernel/containers/netns/Makefile
@@ -1,21 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2008
+# Author: Veerendra <veeren@linux.vnet.ibm.com>
 # Copyright (c) 2015 Red Hat, Inc.
-#
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
-# Author:      Veerendra <veeren@linux.vnet.ibm.com>
-################################################################################

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/containers/pidns/Makefile b/testcases/kernel/containers/pidns/Makefile
index 886e39753..5f8383c3c 100644
--- a/testcases/kernel/containers/pidns/Makefile
+++ b/testcases/kernel/containers/pidns/Makefile
@@ -1,22 +1,5 @@
-###############################################################################
-#                                                                            ##
-# Copyright (c) International Business Machines  Corp., 2007                 ##
-#                                                                            ##
-# This program is free software;  you can redistribute it and#or modify      ##
-# it under the terms of the GNU General Public License as published by       ##
-# the Free Software Foundation; either version 2 of the License, or          ##
-# (at your option) any later version.                                        ##
-#                                                                            ##
-# This program is distributed in the hope that it will be useful, but        ##
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-# for more details.                                                          ##
-#                                                                            ##
-# You should have received a copy of the GNU General Public License          ##
-# along with this program;  if not, write to the Free Software               ##
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-#                                                                            ##
-###############################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2007

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/controllers/Makefile b/testcases/kernel/controllers/Makefile
index 548692cb8..874fd5831 100644
--- a/testcases/kernel/controllers/Makefile
+++ b/testcases/kernel/controllers/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/controllers test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/controllers/cpuacct/Makefile b/testcases/kernel/controllers/cpuacct/Makefile
index 34ec049ae..dc0cf27cd 100644
--- a/testcases/kernel/controllers/cpuacct/Makefile
+++ b/testcases/kernel/controllers/cpuacct/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/controllers/cpuacct test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/controllers/memcg/Makefile b/testcases/kernel/controllers/memcg/Makefile
index 74a67b251..e45c37b9d 100644
--- a/testcases/kernel/controllers/memcg/Makefile
+++ b/testcases/kernel/controllers/memcg/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/controllers/memcg testcase suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/controllers/memcg/functional/Makefile b/testcases/kernel/controllers/memcg/functional/Makefile
index c4ae9f4e0..76ca9ddcb 100644
--- a/testcases/kernel/controllers/memcg/functional/Makefile
+++ b/testcases/kernel/controllers/memcg/functional/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/controllers/memcg/functional testcase suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, September 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/controllers/memcg/regression/Makefile b/testcases/kernel/controllers/memcg/regression/Makefile
index 36d0f5d57..9ccd5c484 100644
--- a/testcases/kernel/controllers/memcg/regression/Makefile
+++ b/testcases/kernel/controllers/memcg/regression/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/controllers/memcg/regression testcase suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, September 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/controllers/pids/Makefile b/testcases/kernel/controllers/pids/Makefile
index 650036339..21060b694 100644
--- a/testcases/kernel/controllers/pids/Makefile
+++ b/testcases/kernel/controllers/pids/Makefile
@@ -1,22 +1,6 @@
-#
-#    Copyright (C) 2015, SUSE
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2015, SUSE
 # Author: Cedric Hnyda <chnyda@suse.com>
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/crypto/Makefile b/testcases/kernel/crypto/Makefile
index 8175a346a..40e6fab9b 100644
--- a/testcases/kernel/crypto/Makefile
+++ b/testcases/kernel/crypto/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Linux Test Project
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 55e0d25a0..229a50683 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir	?= ../../..

diff --git a/testcases/kernel/device-drivers/block/Makefile b/testcases/kernel/device-drivers/block/Makefile
index b3bb5aa85..7c35f1cbe 100644
--- a/testcases/kernel/device-drivers/block/Makefile
+++ b/testcases/kernel/device-drivers/block/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir	?= ../../../..

diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
index 101330520..7a1ce9467 100644
--- a/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
+++ b/testcases/kernel/device-drivers/block/block_dev_kernel/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 ifneq ($(KERNELRELEASE),)

diff --git a/testcases/kernel/device-drivers/rcu/Makefile b/testcases/kernel/device-drivers/rcu/Makefile
index 96c6b5bd7..2a097c37d 100644
--- a/testcases/kernel/device-drivers/rcu/Makefile
+++ b/testcases/kernel/device-drivers/rcu/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir	?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/device-drivers/rtc/Makefile b/testcases/kernel/device-drivers/rtc/Makefile
index effd5dae5..e2e2b74d0 100644
--- a/testcases/kernel/device-drivers/rtc/Makefile
+++ b/testcases/kernel/device-drivers/rtc/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/fs/Makefile b/testcases/kernel/fs/Makefile
index caa2c2df3..6e9a47186 100644
--- a/testcases/kernel/fs/Makefile
+++ b/testcases/kernel/fs/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/fs testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/fs/fs_fill/Makefile b/testcases/kernel/fs/fs_fill/Makefile
index f0e092b13..62eb1fa84 100644
--- a/testcases/kernel/fs/fs_fill/Makefile
+++ b/testcases/kernel/fs/fs_fill/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Linux Test Project
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/fs/iso9660/Makefile b/testcases/kernel/fs/iso9660/Makefile
index 459b3a4f9..2291f1861 100644
--- a/testcases/kernel/fs/iso9660/Makefile
+++ b/testcases/kernel/fs/iso9660/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) 2005-2014 Linux Test Project
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2005-2014 Linux Test Project

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/fs/lftest/Makefile b/testcases/kernel/fs/lftest/Makefile
index 7102ee5c3..98b228949 100644
--- a/testcases/kernel/fs/lftest/Makefile
+++ b/testcases/kernel/fs/lftest/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/fs/lftest testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir			?= ../../../..

diff --git a/testcases/kernel/fs/linktest/Makefile b/testcases/kernel/fs/linktest/Makefile
index b3a2c1f5d..e01b4314d 100644
--- a/testcases/kernel/fs/linktest/Makefile
+++ b/testcases/kernel/fs/linktest/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/fs/linktest testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir			?= ../../../..

diff --git a/testcases/kernel/fs/quota_remount/Makefile b/testcases/kernel/fs/quota_remount/Makefile
index 350bdc17b..5c383b9d0 100644
--- a/testcases/kernel/fs/quota_remount/Makefile
+++ b/testcases/kernel/fs/quota_remount/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/fs/read_all/Makefile b/testcases/kernel/fs/read_all/Makefile
index 5416b23ed..0e6dec2d3 100644
--- a/testcases/kernel/fs/read_all/Makefile
+++ b/testcases/kernel/fs/read_all/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Linux Test Project
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/io/Makefile b/testcases/kernel/io/Makefile
index 7db02882a..d34638823 100644
--- a/testcases/kernel/io/Makefile
+++ b/testcases/kernel/io/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/io test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/lib/Makefile b/testcases/kernel/lib/Makefile
index fabf2f06e..b0cf2964e 100644
--- a/testcases/kernel/lib/Makefile
+++ b/testcases/kernel/lib/Makefile
@@ -1,22 +1,5 @@
-#
-#    kernel/lib Makefile.
-#
-#    Copyright (C) 2012, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2012, Linux Test Project.

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/logging/Makefile b/testcases/kernel/logging/Makefile
index bd32f704f..1b8c9a231 100644
--- a/testcases/kernel/logging/Makefile
+++ b/testcases/kernel/logging/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (C) 2013 Linux Test Project
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2013 Linux Test Project

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/logging/kmsg/Makefile b/testcases/kernel/logging/kmsg/Makefile
index 67b29d6f6..27345991f 100644
--- a/testcases/kernel/logging/kmsg/Makefile
+++ b/testcases/kernel/logging/kmsg/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (C) 2013 Linux Test Project
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2013 Linux Test Project

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/mem/Makefile b/testcases/kernel/mem/Makefile
index eb8f3a44b..6e9a47186 100644
--- a/testcases/kernel/mem/Makefile
+++ b/testcases/kernel/mem/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/mem/hugetlb/Makefile b/testcases/kernel/mem/hugetlb/Makefile
index ea7867f6c..82ae5330e 100644
--- a/testcases/kernel/mem/hugetlb/Makefile
+++ b/testcases/kernel/mem/hugetlb/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index bfe1976f5..2d651b4aa 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/hugetlb/hugemmap testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
index e12fc791e..8a795ac49 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/hugetlb/hugemmap testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
index 44dc6a013..8a795ac49 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/hugetlb/hugeshmctl testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
index 7f6ffadb7..8a795ac49 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/hugetlb/hugeshmdt testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
index 4f77fdd42..261c5dec1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/mem/hugetlb/lib/Makefile b/testcases/kernel/mem/hugetlb/lib/Makefile
index 2e893429d..ceccd2615 100644
--- a/testcases/kernel/mem/hugetlb/lib/Makefile
+++ b/testcases/kernel/mem/hugetlb/lib/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index dd55fb8dc..e8ea801bc 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (C) 2010  Red Hat, Inc.
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2010  Red Hat, Inc.

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/mem/mmapstress/Makefile b/testcases/kernel/mem/mmapstress/Makefile
index 5691f7d5d..744f099d8 100644
--- a/testcases/kernel/mem/mmapstress/Makefile
+++ b/testcases/kernel/mem/mmapstress/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/mem/mtest01/Makefile b/testcases/kernel/mem/mtest01/Makefile
index dbf538779..370f0d0d2 100644
--- a/testcases/kernel/mem/mtest01/Makefile
+++ b/testcases/kernel/mem/mtest01/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/mtest01 testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/mem/mtest06/Makefile b/testcases/kernel/mem/mtest06/Makefile
index 88e46329c..acb8f7cf9 100644
--- a/testcases/kernel/mem/mtest06/Makefile
+++ b/testcases/kernel/mem/mtest06/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/mtest06 testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/mem/mtest07/Makefile b/testcases/kernel/mem/mtest07/Makefile
index 65302960e..4068a0dea 100644
--- a/testcases/kernel/mem/mtest07/Makefile
+++ b/testcases/kernel/mem/mtest07/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/mem/mtest07 testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp/Makefile
index 89abdc7cd..e95712eaf 100644
--- a/testcases/kernel/mem/thp/Makefile
+++ b/testcases/kernel/mem/thp/Makefile
@@ -1,21 +1,5 @@
-#
-#  Copyright (C) 2011  Red Hat, Inc.
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or (at
-#  your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful, but
-#  WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#  General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-#  02110-1301, USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2011  Red Hat, Inc.

 top_srcdir		?= ../../../..
 thp04:			LDLIBS += -lrt
diff --git a/testcases/kernel/mem/tunable/Makefile b/testcases/kernel/mem/tunable/Makefile
index 867dcf089..80d64bb4a 100644
--- a/testcases/kernel/mem/tunable/Makefile
+++ b/testcases/kernel/mem/tunable/Makefile
@@ -1,21 +1,5 @@
-#
-#  Copyright (C) 2011  Red Hat, Inc.
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or (at
-#  your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful, but
-#  WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#  General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-#  02110-1301, USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2011  Red Hat, Inc.

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/mem/vma/Makefile b/testcases/kernel/mem/vma/Makefile
index 3a4e2b4dc..057091e16 100644
--- a/testcases/kernel/mem/vma/Makefile
+++ b/testcases/kernel/mem/vma/Makefile
@@ -1,21 +1,5 @@
-#
-#  Copyright (C) 2011  Red Hat, Inc.
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or (at
-#  your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful, but
-#  WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#  General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-#  02110-1301, USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2011  Red Hat, Inc.

 top_srcdir              ?= ../../../..

diff --git a/testcases/kernel/numa/Makefile b/testcases/kernel/numa/Makefile
index 00ba27360..fc136afef 100644
--- a/testcases/kernel/numa/Makefile
+++ b/testcases/kernel/numa/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2007
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2007

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/pty/Makefile b/testcases/kernel/pty/Makefile
index 87d70ac1d..d4c6c87f0 100644
--- a/testcases/kernel/pty/Makefile
+++ b/testcases/kernel/pty/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/pty testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/sched/Makefile b/testcases/kernel/sched/Makefile
index 6a57d79ee..d34638823 100644
--- a/testcases/kernel/sched/Makefile
+++ b/testcases/kernel/sched/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/sched test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/sched/autogroup/Makefile b/testcases/kernel/sched/autogroup/Makefile
index 6cc7782c1..c01c9e66f 100644
--- a/testcases/kernel/sched/autogroup/Makefile
+++ b/testcases/kernel/sched/autogroup/Makefile
@@ -1,20 +1,6 @@
-#
-#  Copyright (c) 2017 Fujitsu Ltd.
-#  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2017 Fujitsu Ltd.
+# Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
index eea794aa9..648ee8409 100644
--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/security test suite Makefile
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/kernel/security/dirtyc0w/Makefile b/testcases/kernel/security/dirtyc0w/Makefile
index aef8a9a34..bf26d9eb6 100644
--- a/testcases/kernel/security/dirtyc0w/Makefile
+++ b/testcases/kernel/security/dirtyc0w/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Linux Test Project
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/security/integrity/Makefile b/testcases/kernel/security/integrity/Makefile
index 14a97a86d..edb145146 100644
--- a/testcases/kernel/security/integrity/Makefile
+++ b/testcases/kernel/security/integrity/Makefile
@@ -1,20 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/security/integrity/ima/Makefile b/testcases/kernel/security/integrity/ima/Makefile
index 19b10ff64..c2bda849e 100644
--- a/testcases/kernel/security/integrity/ima/Makefile
+++ b/testcases/kernel/security/integrity/ima/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/security/integrity/ima testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 280175b17..200fd3f4d 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -1,26 +1,8 @@
-#
-#    testcases/kernel/security/integrity/ima/policy testcases Makefile.
-#
-#    Copyright (c) Linux Test Project, 2019-2020
-#    Copyright (c) 2020 Microsoft Corporation
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2019-2020
+# Copyright (c) 2020 Microsoft Corporation
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir	?= ../../../../../..

diff --git a/testcases/kernel/security/integrity/ima/src/Makefile b/testcases/kernel/security/integrity/ima/src/Makefile
index f7a818578..a772ab23c 100644
--- a/testcases/kernel/security/integrity/ima/src/Makefile
+++ b/testcases/kernel/security/integrity/ima/src/Makefile
@@ -1,24 +1,6 @@
-#
-#    kernel/security/integrity/ima/src testcase Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../../..

diff --git a/testcases/kernel/security/integrity/ima/tests/Makefile b/testcases/kernel/security/integrity/ima/tests/Makefile
index b2ccdb60d..36b726c1e 100644
--- a/testcases/kernel/security/integrity/ima/tests/Makefile
+++ b/testcases/kernel/security/integrity/ima/tests/Makefile
@@ -1,24 +1,6 @@
-#
-#    testcases/kernel/security/integrity/ima/tests testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../../../..

diff --git a/testcases/kernel/syscalls/pwritev/Makefile b/testcases/kernel/syscalls/pwritev/Makefile
index 764c956a8..ae71ae09e 100644
--- a/testcases/kernel/syscalls/pwritev/Makefile
+++ b/testcases/kernel/syscalls/pwritev/Makefile
@@ -1,21 +1,6 @@
-#
-#  Copyright (c) 2015 Fujitsu Ltd.
-#  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program.
-#
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015 Fujitsu Ltd.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>

 top_srcdir		?= ../../../..

diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
index 55ac0026f..e6e699808 100644
--- a/testcases/kernel/syscalls/set_mempolicy/Makefile
+++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 top_srcdir		?= ../../../..

 LTPLIBS = ltpnuma
diff --git a/testcases/kernel/tracing/Makefile b/testcases/kernel/tracing/Makefile
index e9f96c37a..8ca6a71dc 100644
--- a/testcases/kernel/tracing/Makefile
+++ b/testcases/kernel/tracing/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 top_srcdir		?= ../../..

 include $(top_srcdir)/include/mk/env_pre.mk
diff --git a/testcases/kernel/tracing/dynamic_debug/Makefile b/testcases/kernel/tracing/dynamic_debug/Makefile
index d38138ed6..9913ee1dc 100644
--- a/testcases/kernel/tracing/dynamic_debug/Makefile
+++ b/testcases/kernel/tracing/dynamic_debug/Makefile
@@ -1,21 +1,5 @@
-#
-#    tracing/dynamic_debug test suite Makefile.
-#
-#    Copyright (C) 2017 Red Hat, Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-#    General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, see <http://www.gnu.org/licenses/>.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2017 Red Hat, Inc.

 top_srcdir		?= ../../../..

diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index f77da0d56..98d9e4613 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -1,24 +1,6 @@
-#
-#    testcases library Makefile (differs from lib/).
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, August 2009
-#

 top_srcdir		?= ../..

diff --git a/testcases/misc/Makefile b/testcases/misc/Makefile
index fee8decad..4569728c8 100644
--- a/testcases/misc/Makefile
+++ b/testcases/misc/Makefile
@@ -1,25 +1,7 @@
-#
-#    misc test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (C) 2010, Linux Test Project.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../..

diff --git a/testcases/network/Makefile b/testcases/network/Makefile
index 7b42614ba..ccc908396 100644
--- a/testcases/network/Makefile
+++ b/testcases/network/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2009, Cisco Systems Inc.
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 # Ngie Cooper, July 2009
diff --git a/testcases/network/can/Makefile b/testcases/network/can/Makefile
index a69f6be87..00277e09f 100644
--- a/testcases/network/can/Makefile
+++ b/testcases/network/can/Makefile
@@ -1,22 +1,5 @@
-#
-#    network/can test suite Makefile.
-#
-#    Copyright (c) 2014 Fujitsu Ltd.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2014 Fujitsu Ltd.

 top_srcdir		?= ../../..

diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
index bd57c7fff..6a3302446 100644
--- a/testcases/network/can/filter-tests/Makefile
+++ b/testcases/network/can/filter-tests/Makefile
@@ -1,19 +1,5 @@
-#
-#    Copyright (c) 2014 Fujitsu Ltd.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2014 Fujitsu Ltd.

 top_srcdir		?= ../../../..

diff --git a/testcases/network/dhcp/Makefile b/testcases/network/dhcp/Makefile
index 9176e7b34..3750e698b 100644
--- a/testcases/network/dhcp/Makefile
+++ b/testcases/network/dhcp/Makefile
@@ -1,19 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (C) 2009, Cisco Systems Inc.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir		?= ../../..

diff --git a/testcases/network/iproute/Makefile b/testcases/network/iproute/Makefile
index 0774380fb..a18c7099e 100644
--- a/testcases/network/iproute/Makefile
+++ b/testcases/network/iproute/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/iproute testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/network/lib6/Makefile b/testcases/network/lib6/Makefile
index e9fde3b98..0092fa962 100644
--- a/testcases/network/lib6/Makefile
+++ b/testcases/network/lib6/Makefile
@@ -1,25 +1,5 @@
-#
-#  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-###########################################################################
-# name of file	: Makefile						  #
-# description	: make(1) description file for lib6 tests.	  	  #
-###########################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2001

 top_srcdir			?= ../../..

diff --git a/testcases/network/netstress/Makefile b/testcases/network/netstress/Makefile
index 0ada52651..49516d197 100644
--- a/testcases/network/netstress/Makefile
+++ b/testcases/network/netstress/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../..

diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
index 4ef4a45ca..6ecb1a665 100644
--- a/testcases/network/rpc/Makefile
+++ b/testcases/network/rpc/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/rpc test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/network/rpc/rpc-tirpc/Makefile b/testcases/network/rpc/rpc-tirpc/Makefile
index 2006616da..4fb080965 100644
--- a/testcases/network/rpc/rpc-tirpc/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/Makefile
@@ -1,20 +1,5 @@
-#
-#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.

 top_srcdir		?= ../../../..

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
index 49ec2a522..26d916694 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>

diff --git a/testcases/network/sctp/Makefile b/testcases/network/sctp/Makefile
index 0fa912555..7a7586739 100644
--- a/testcases/network/sctp/Makefile
+++ b/testcases/network/sctp/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../..

diff --git a/testcases/network/sockets/Makefile b/testcases/network/sockets/Makefile
index a7c263a8f..7d4c289d0 100644
--- a/testcases/network/sockets/Makefile
+++ b/testcases/network/sockets/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/sockets testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/network/stress/Makefile b/testcases/network/stress/Makefile
index 2b26ac4d6..d3a7088d1 100644
--- a/testcases/network/stress/Makefile
+++ b/testcases/network/stress/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/network/stress/dccp/Makefile b/testcases/network/stress/dccp/Makefile
index 00ca0a218..76ad463e8 100644
--- a/testcases/network/stress/dccp/Makefile
+++ b/testcases/network/stress/dccp/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/icmp/Makefile b/testcases/network/stress/icmp/Makefile
index 61a142a5a..716f84dd6 100644
--- a/testcases/network/stress/icmp/Makefile
+++ b/testcases/network/stress/icmp/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/icmp test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/interface/Makefile b/testcases/network/stress/interface/Makefile
index 31072d536..4ae3e7b6d 100644
--- a/testcases/network/stress/interface/Makefile
+++ b/testcases/network/stress/interface/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/interface test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/ipsec/Makefile b/testcases/network/stress/ipsec/Makefile
index 43352cc0a..14d858eaf 100644
--- a/testcases/network/stress/ipsec/Makefile
+++ b/testcases/network/stress/ipsec/Makefile
@@ -1,23 +1,6 @@
-#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Hangbin Liu <haliu@redhat.com>
-#
-#######################################################################
-

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/multicast/Makefile b/testcases/network/stress/multicast/Makefile
index 474e066c1..f1594466a 100644
--- a/testcases/network/stress/multicast/Makefile
+++ b/testcases/network/stress/multicast/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/multicast test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/multicast/grp-operation/Makefile b/testcases/network/stress/multicast/grp-operation/Makefile
index af11867ee..a31290115 100644
--- a/testcases/network/stress/multicast/grp-operation/Makefile
+++ b/testcases/network/stress/multicast/grp-operation/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/grp-operation testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/network/stress/multicast/packet-flood/Makefile b/testcases/network/stress/multicast/packet-flood/Makefile
index 8e144ec40..e99a8efce 100644
--- a/testcases/network/stress/multicast/packet-flood/Makefile
+++ b/testcases/network/stress/multicast/packet-flood/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/packet-flood testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/network/stress/multicast/query-flood/Makefile b/testcases/network/stress/multicast/query-flood/Makefile
index 5146a22a1..e99a8efce 100644
--- a/testcases/network/stress/multicast/query-flood/Makefile
+++ b/testcases/network/stress/multicast/query-flood/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/stress/query-flood testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../../..

diff --git a/testcases/network/stress/sctp/Makefile b/testcases/network/stress/sctp/Makefile
index 2be2b439c..ca001bed6 100644
--- a/testcases/network/stress/sctp/Makefile
+++ b/testcases/network/stress/sctp/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/tcp/Makefile b/testcases/network/stress/tcp/Makefile
index a2511fc9b..46d335352 100644
--- a/testcases/network/stress/tcp/Makefile
+++ b/testcases/network/stress/tcp/Makefile
@@ -1,24 +1,6 @@
-#
-#    testcases/network/stress/tcp Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/stress/udp/Makefile b/testcases/network/stress/udp/Makefile
index 5aa62fa84..cdd4fb466 100644
--- a/testcases/network/stress/udp/Makefile
+++ b/testcases/network/stress/udp/Makefile
@@ -1,24 +1,6 @@
-#
-#    testcases/network/stress/udp Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, October 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/tcp_cc/Makefile b/testcases/network/tcp_cc/Makefile
index a564eb438..54d3ee109 100644
--- a/testcases/network/tcp_cc/Makefile
+++ b/testcases/network/tcp_cc/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../..

diff --git a/testcases/network/tcp_cmds/Makefile b/testcases/network/tcp_cmds/Makefile
index 5719b1fe3..8c1e4f6f3 100644
--- a/testcases/network/tcp_cmds/Makefile
+++ b/testcases/network/tcp_cmds/Makefile
@@ -1,25 +1,7 @@
-#
-#    network/tcp_cmds test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#    Copyright (C) 2010, Linux Test Project.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (C) 2010, Linux Test Project.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/network/tcp_cmds/host/Makefile b/testcases/network/tcp_cmds/host/Makefile
index 1f3a51337..53eed9861 100644
--- a/testcases/network/tcp_cmds/host/Makefile
+++ b/testcases/network/tcp_cmds/host/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/tcp_cmds/host testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/tcp_cmds/ipneigh/Makefile b/testcases/network/tcp_cmds/ipneigh/Makefile
index 8dc4c5699..64cc87b92 100644
--- a/testcases/network/tcp_cmds/ipneigh/Makefile
+++ b/testcases/network/tcp_cmds/ipneigh/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/tcp_cmds/arp testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/tcp_cmds/netstat/Makefile b/testcases/network/tcp_cmds/netstat/Makefile
index 83444dbb2..9b46ebb18 100644
--- a/testcases/network/tcp_cmds/netstat/Makefile
+++ b/testcases/network/tcp_cmds/netstat/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/tcp_cmds/netstat testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
index e3cc045af..735a6ffef 100644
--- a/testcases/network/tcp_cmds/sendfile/Makefile
+++ b/testcases/network/tcp_cmds/sendfile/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/tcp_cmds/sendfile testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, September 2009
-#

 top_srcdir		?= ../../../..

diff --git a/testcases/network/tcp_cmds/tracepath/Makefile b/testcases/network/tcp_cmds/tracepath/Makefile
index 820aa5d5c..d6a758d24 100644
--- a/testcases/network/tcp_cmds/tracepath/Makefile
+++ b/testcases/network/tcp_cmds/tracepath/Makefile
@@ -1,17 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.

 top_srcdir		?= ../../../..

diff --git a/testcases/network/tcp_fastopen/Makefile b/testcases/network/tcp_fastopen/Makefile
index 68c8c44e6..ce20e4e3c 100644
--- a/testcases/network/tcp_fastopen/Makefile
+++ b/testcases/network/tcp_fastopen/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir		?= ../../..

diff --git a/testcases/network/traceroute/Makefile b/testcases/network/traceroute/Makefile
index 54ed24c49..d74c5c805 100644
--- a/testcases/network/traceroute/Makefile
+++ b/testcases/network/traceroute/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/traceroute testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 619d769ff..b5c35a9b0 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -1,18 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

 top_srcdir		?= ../../..

diff --git a/testcases/network/xinetd/Makefile b/testcases/network/xinetd/Makefile
index cdaadb19b..f0ddf1446 100644
--- a/testcases/network/xinetd/Makefile
+++ b/testcases/network/xinetd/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/xinetd testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../../..

diff --git a/testcases/open_posix_testsuite/Makefile b/testcases/open_posix_testsuite/Makefile
index 0601fa648..d655ebbd4 100644
--- a/testcases/open_posix_testsuite/Makefile
+++ b/testcases/open_posix_testsuite/Makefile
@@ -1,8 +1,5 @@
-#
-# Read COPYING for licensing details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Ngie Cooper, June 2010
-#

 # Makefiles that are considered critical to execution; if they don't exist
 # all of the Makefiles will be rebuilt by default.
diff --git a/testcases/open_posix_testsuite/conformance/Makefile b/testcases/open_posix_testsuite/conformance/Makefile
index c101b7ff6..11e8a840f 100644
--- a/testcases/open_posix_testsuite/conformance/Makefile
+++ b/testcases/open_posix_testsuite/conformance/Makefile
@@ -1,8 +1,5 @@
-#
-# Read COPYING for licensing details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Ngie Cooper, June 2010
-#

 all clean distclean-makefiles install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/Makefile b/testcases/open_posix_testsuite/conformance/interfaces/Makefile
index b09527fd3..2eb2bd40b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/Makefile
+++ b/testcases/open_posix_testsuite/conformance/interfaces/Makefile
@@ -1,8 +1,5 @@
-#
-# Read COPYING for licensing details.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Ngie Cooper, June 2010
-#

 all clean install test:
 	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
diff --git a/testscripts/Makefile b/testscripts/Makefile
index 9bae48950..f90948792 100644
--- a/testscripts/Makefile
+++ b/testscripts/Makefile
@@ -1,24 +1,6 @@
-#
-#    testscripts Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, December 2009
-#

 top_srcdir		?= ..

diff --git a/utils/Makefile b/utils/Makefile
index 9f79f5b12..342979149 100644
--- a/utils/Makefile
+++ b/utils/Makefile
@@ -1,22 +1,5 @@
-################################################################################
-#
-# Copyright (c) International Business Machines  Corp., 2008 ##
-#
-# This program is free software;  you can redistribute it and#or modify ##
-# it under the terms of the GNU General Public License as published by ##
-# the Free Software Foundation; either version 2 of the License, or ##
-# (at your option) any later version. ##
-#
-# This program is distributed in the hope that it will be useful, but ##
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-# for more details. ##
-#
-# You should have received a copy of the GNU General Public License ##
-# along with this program;  if not, write to the Free Software ##
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA ##
-#
-################################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2008

 top_srcdir		?= ..

diff --git a/utils/sctp/Makefile b/utils/sctp/Makefile
index 93551b3ac..63296d5c2 100644
--- a/utils/sctp/Makefile
+++ b/utils/sctp/Makefile
@@ -1,24 +1,6 @@
-#
-#    network/sctp test suite Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#

 top_srcdir		?= ../..

diff --git a/utils/sctp/func_tests/Makefile b/utils/sctp/func_tests/Makefile
index a17107853..f1c7996ad 100644
--- a/utils/sctp/func_tests/Makefile
+++ b/utils/sctp/func_tests/Makefile
@@ -1,24 +1,5 @@
-#
-#  (C) Copyright IBM Corp. 2001, 2003
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-###########################################################################
-# name of file	: Makefile						  #
-###########################################################################
+# SPDX-License-Identifier: GPL-2.0-or-later
+# (C) Copyright IBM Corp. 2001, 2003

 top_srcdir	?= ../../..

--
2.17.1

