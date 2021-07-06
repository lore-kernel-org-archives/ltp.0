From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue,  6 Jul 2021 14:04:33 +0200
Subject: [LTP] [PATCH v2 3/4] fs_bind: Convert cloneNS tests
In-Reply-To: <20210706120434.867426-1-lkml@jv-coder.de>
References: <20210706120434.867426-1-lkml@jv-coder.de>
Message-ID: <20210706120434.867426-4-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The cloneNS tests are now also executed and working. The test code
is now fully contained in the fs_bind_cloneNS*.sh files, instead
of three files for test, parent and child and some wonky synchronization.
The three files contained code, that was executed before creating the
new mount namespace, in the parent process and in the child process.
The code in parent and child process had some synchronization points before.
Using ns_create and ns_exec no snychronization is required anymore,
because code can be executed arbitrarily in the parent or child namespace.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 runtest/fs_bind                               |   9 ++
 .../fs/fs_bind/cloneNS/00_Descriptions.txt    |  70 ---------
 testcases/kernel/fs/fs_bind/cloneNS/child01   |  34 -----
 testcases/kernel/fs/fs_bind/cloneNS/child02   |  42 ------
 testcases/kernel/fs/fs_bind/cloneNS/child03   |  32 ----
 testcases/kernel/fs/fs_bind/cloneNS/child04   |  33 -----
 testcases/kernel/fs/fs_bind/cloneNS/child05   |  41 ------
 testcases/kernel/fs/fs_bind/cloneNS/child06   |  49 ------
 testcases/kernel/fs/fs_bind/cloneNS/child07   |  42 ------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh   |  99 ++++---------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh   | 104 +++++--------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh   |  86 +++--------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh   |  87 +++--------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh   | 139 +++++++-----------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh   | 137 ++++++++---------
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh   | 106 +++++--------
 testcases/kernel/fs/fs_bind/cloneNS/parent01  |  44 ------
 testcases/kernel/fs/fs_bind/cloneNS/parent02  |  45 ------
 testcases/kernel/fs/fs_bind/cloneNS/parent03  |  34 -----
 testcases/kernel/fs/fs_bind/cloneNS/parent04  |  37 -----
 testcases/kernel/fs/fs_bind/cloneNS/parent05  |  45 ------
 testcases/kernel/fs/fs_bind/cloneNS/parent06  |  51 -------
 testcases/kernel/fs/fs_bind/cloneNS/parent07  |  48 ------
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh    |  41 +++++-
 24 files changed, 292 insertions(+), 1163 deletions(-)
 delete mode 100644 testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child01
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child02
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child03
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child04
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child05
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child06
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child07
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent01
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent02
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent03
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent04
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent05
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent06
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent07

diff --git a/runtest/fs_bind b/runtest/fs_bind
index 7d8400336..61b3e7628 100644
--- a/runtest/fs_bind
+++ b/runtest/fs_bind
@@ -94,3 +94,12 @@ fs_bind_rbind39_sh fs_bind_rbind39.sh
 
 
 fs_bind_regression_sh fs_bind_regression.sh
+
+
+fs_bind_cloneNS01_sh fs_bind_cloneNS01.sh
+fs_bind_cloneNS02_sh fs_bind_cloneNS02.sh
+fs_bind_cloneNS03_sh fs_bind_cloneNS03.sh
+fs_bind_cloneNS04_sh fs_bind_cloneNS04.sh
+fs_bind_cloneNS05_sh fs_bind_cloneNS05.sh
+fs_bind_cloneNS06_sh fs_bind_cloneNS06.sh
+fs_bind_cloneNS07_sh fs_bind_cloneNS07.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt b/testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt
deleted file mode 100644
index 8c616cca6..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-OO_DESCRIPTION.txt
-==================
-
-The contents of the cloneNS directory:
-test01 - namespace with shared dirs
-test02 - namespaces with parent-slave
-test03 - namespace with unclonable mount
-test04 - namespace with private mount.
-test05 - namespace with multi-level
-test06 - namespace with shared point bind mounted
-test07 - slave child to slave parent.
-
-
-test01:
-=======
-namespace with shared dirs
-
-
-test02:
-=======
-namespaces with parent-slave
-
-
-test03:
-=======
-namespace with unclonable mount
-
-
-test04:
-=======
-namespace with private mount.
-
-
-test05:
-=======
-namespace with multi-level
-chain of slaves
-
-
-test06:
-=======
-namespace with shared point bind mounted
-within the same directory
-
-
-test07:
-=======
-slave child to slave parent.
-
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child01 b/testcases/kernel/fs/fs_bind/cloneNS/child01
deleted file mode 100755
index 4e667941f..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child01
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-check "$disk2" dir1/a dir2/a
-mount --bind "$disk3" dir1/b
-check dir1/b dir2/b
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child02 b/testcases/kernel/fs/fs_bind/cloneNS/child02
deleted file mode 100755
index b46e8d1d2..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child02
+++ /dev/null
@@ -1,42 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check "$disk2" dir1/a dir2/a
-check -n "$disk3" d2/b
-check -n "$disk3" d1/b
-
-mount --bind "$disk4" dir1/c
-check dir1/c dir2/c
-
-umount dir2/a
-check -n dir1/a dir2/a
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child03 b/testcases/kernel/fs/fs_bind/cloneNS/child03
deleted file mode 100755
index 2b78bc3bc..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child03
+++ /dev/null
@@ -1,32 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-check "$disk1" dir1
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child04 b/testcases/kernel/fs/fs_bind/cloneNS/child04
deleted file mode 100755
index b6ba67c62..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child04
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-check -n "$disk2" dir1/a
-mount --bind "$disk3" dir1/b
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child05 b/testcases/kernel/fs/fs_bind/cloneNS/child05
deleted file mode 100755
index a82cbb2b5..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child05
+++ /dev/null
@@ -1,41 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check "$disk2" parent/child1/a parent/child2/child1/a
-check "$disk3" parent/child1/b parent/child2/child1/b
-
-mount --bind "$disk4" parent/child2/child1/c
-check parent/child2/child1/c parent/child1/c
-
-umount parent/child1/b
-check parent/child2/child1/b parent/child1/b
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child06 b/testcases/kernel/fs/fs_bind/cloneNS/child06
deleted file mode 100755
index 5abbf97ec..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child06
+++ /dev/null
@@ -1,49 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check dir1/x dir2/x dir3/x dir4/x
-
-echo ls dir1/x/a
-ls dir1/x/a
-check -n dir1/x/a dir2/x/a
-check "$disk2" dir2/x/a dir3/x/a dir4/x/a
-
-mount --rbind "$disk3" dir3/x/b
-check -n dir1/x/b dir3/x/b
-check -n dir2/x/b dir3/x/b
-check dir3/x/b dir4/x/b
-
-mount --rbind "$disk4" dir4/x/c
-check -n dir1/x/c dir4/x/c
-check -n dir2/x/c dir4/x/c
-check -n dir3/x/c dir4/x/c
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child07 b/testcases/kernel/fs/fs_bind/cloneNS/child07
deleted file mode 100755
index 50c4965c0..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child07
+++ /dev/null
@@ -1,42 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check parent2 parent2/a parent2/a/a
-check parent2/b parent2/a/b parent2/a/a/b
-
-mount --bind "$disk3" parent1/a/c
-check parent2/c parent2/a/c parent2/a/a/c
-
-goahead
-iamgoingahead
-check parent2/c parent2/a/c parent2/a/a/c
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
index a4fda7dc4..930e98547 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
@@ -1,85 +1,38 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test01} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST01***************"
-tst_resm TINFO "cloneNS: namespace with shared dirs"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test01 failed" && tst_exit)
-export result=0
-
 
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
+FS_BIND_TESTFUNC=test
 
-while /bin/true ; do
-	# This loop is for error recovery purposes only
+. fs_bind_lib.sh
 
-	cp "${FS_BIND_ROOT}/cloneNS/parent01" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child01" .
-
-	chmod 755 parent01 child01
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-	"${FS_BIND_ROOT}/bin/makedir" share dir2
+test()
+{
+	tst_res TINFO "cloneNS: namespace with shared dirs"
 
+	fs_bind_makedir rshared dir1
+	fs_bind_makedir rshared dir2
 
-	mount --bind "$disk1" dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+	EXPECT_PASS mount --bind dir1 dir2
 
-	mount --bind dir1 dir2
+	fs_bind_create_ns
 
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent01 ./child01 || result=$?
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir2/a
+	fs_bind_check dir1/a dir2/a
 
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test01: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test01: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir2/b
-	umount dir1
-	umount dir1
-	umount dir1
-	umount dir2
+	fs_bind_check -s "$FS_BIND_DISK2" dir1/a dir2/a
+	fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK3" $PWD/dir1/b
+	fs_bind_check -s dir1/b dir2/b
 
-	rm -rf dir* parent* child*
+	EXPECT_PASS umount dir1/b
+	EXPECT_PASS umount dir2/a
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir1
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir1
+}
 
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test01: FAILED: cloneNS: namespace with shared dirs"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test01: PASSED"
-	exit 0
-fi
-tst_exit
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
index 62045130f..b1ce9b2bd 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
@@ -1,85 +1,53 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
 
+FS_BIND_TESTFUNC=test
 
-SETS_DEFAULTS="${TCID=test02} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
+. fs_bind_lib.sh
 
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "cloneNS: namespaces with parent-slave"
-tst_resm TINFO "************************************"
+test()
+{
+	tst_res TINFO "cloneNS: namespaces with parent-slave"
 
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test02 failed" && tst_exit)
-export result=0
+	fs_bind_makedir rshared dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
 
+	mkdir dir2
+	EXPECT_PASS mount --bind dir1 dir2
+	EXPECT_PASS mount --make-slave dir2
 
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
+	fs_bind_create_ns
 
-while /bin/true ; do
-	# This loop is for error recovery purposes only
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir1/a
+	fs_bind_check dir1/a dir2/a
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" dir2/b
+	fs_bind_check -n dir1/b dir2/b
 
-	cp "${FS_BIND_ROOT}/cloneNS/parent02" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child02" .
 
-	chmod 755 parent02 child02
+	fs_bind_check -s "$FS_BIND_DISK2" dir1/a dir2/a
+	fs_bind_check -s -n "$FS_BIND_DISK3" dir2/b
+	fs_bind_check -s -n "$FS_BIND_DISK3" dir1/b
+	fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK4" $PWD/dir1/c
+	fs_bind_check -s dir1/c dir2/c
 
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-	mount --bind "$disk1" dir1
+	fs_bind_exec_ns umount $PWD/dir2/a
+	fs_bind_check -s -n dir1/a dir2/a
 
-	mkdir dir2
-	mount --bind dir1 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir2
 
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent02 ./child02 || result=$?
+	fs_bind_check "$FS_BIND_DISK2" dir1/a dir2/a
+	fs_bind_check "$FS_BIND_DISK4" dir1/c dir2/c
 
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test02: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test02: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir2/b
-	umount dir1/c
-	umount dir2
-	umount dir1
-	umount dir1
+	fs_bind_destroy_ns
 
-	rm -rf dir* parent* child*
+	EXPECT_PASS umount dir1/c
+	EXPECT_PASS umount dir1/a
+	EXPECT_PASS umount dir2/b
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir1
+	EXPECT_PASS umount dir1
+}
 
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test02: FAILED: cloneNS: namespaces with parent-slave"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test02: PASSED"
-	exit 0
-fi
-tst_exit
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
index 8db2c78fc..777b976b7 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
@@ -1,77 +1,27 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test03} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST03***************"
-tst_resm TINFO "cloneNS: namespace with unclonable mount "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test03 failed" && tst_exit)
-export result=0
-
 
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
+FS_BIND_TESTFUNC=test
 
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent03" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child03" .
-
-	chmod 755 parent03 child03
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone dir1
-	mount --bind "$disk1" dir1
+. fs_bind_lib.sh
 
+test()
+{
+	tst_res TINFO "cloneNS: namespace with unclonable mount"
 
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent03 ./child03 || result=$?
+	fs_bind_makedir runbindable dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+	fs_bind_check "$FS_BIND_DISK1" dir1
 
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test03: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test03: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1
-	umount dir1
+	fs_bind_create_ns
 
-	rm -rf dir* parent* child*
+	fs_bind_check -s "$FS_BIND_DISK1" dir1
+	
+	EXPECT_PASS umount dir1
+	EXPECT_PASS umount dir1
+}
 
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test03: FAILED: cloneNS: namespace with unclonable mount "
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test03: PASSED"
-	exit 0
-fi
-tst_exit
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
index 2605fbedf..58080cc94 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
@@ -1,78 +1,31 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test04} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST04***************"
-tst_resm TINFO "cloneNS: namespace with private mount."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test04 failed" && tst_exit)
-export result=0
 
+FS_BIND_TESTFUNC=test
 
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
+. fs_bind_lib.sh
 
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent04" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child04" .
-
-	chmod 755 parent04 child04
+test()
+{
+	tst_res TINFO "cloneNS: namespace with private mount"
 
-	"${FS_BIND_ROOT}/bin/makedir" priv dir1
-	mount --bind "$disk1" dir1
+	fs_bind_makedir private dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+	fs_bind_create_ns
 
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir1/a
 
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent04 ./child04 || result=$?
+	fs_bind_check -s -n "$FS_BIND_DISK2" dir1/a
+	fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK3" "$PWD/dir1/b"
 
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test04: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test04: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir1
-	umount dir1
+	fs_bind_check -n "$FS_BIND_DISK3" dir1/b   
 
-	rm -rf dir* parent* child*
+	EXPECT_PASS umount dir1/a
+	EXPECT_PASS umount dir1
+	EXPECT_PASS umount dir1
+}
 
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test04: FAILED: cloneNS: namespace with private mount."
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test04: PASSED"
-	exit 0
-fi
-tst_exit
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
index d03ac2937..dbcb5ba17 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
@@ -1,90 +1,55 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test05} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST05***************"
-tst_resm TINFO "cloneNS: namespace with multi-level "
-tst_resm TINFO "chain of slaves"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test05 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent05" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child05" .
-
-	chmod 755 parent05 child05
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child2
-
-	mount --rbind "$disk1" parent/child1
-
-	mount --rbind parent parent/child2/
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent05 ./child05 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test05: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test05: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
 {
-	umount parent/child2/child2
-	umount parent/child2/child1/a
-	umount parent/child2/child1/c
-	umount parent/child2/child1
-	umount parent/child2/child1
-	umount parent/child2
-	umount parent/child2
-	umount parent
-
-	rm -rf parent* child*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test05: FAILED: cloneNS: namespace with multi-level
-chain of slaves"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test05: PASSED"
-	exit 0
-fi
-tst_exit
+	tst_res TINFO "cloneNS: namespace with multi-level chain of slaves"
+
+	fs_bind_makedir rshared parent
+	fs_bind_makedir rshared parent/child1
+	fs_bind_makedir rshared parent/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent/child1
+	EXPECT_PASS mount --rbind parent parent/child2
+
+	fs_bind_create_ns
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent/child1/a
+	fs_bind_check parent/child1/a parent/child2/child1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent/child2/child1/b
+	fs_bind_check parent/child1/b parent/child2/child1/b
+
+
+	fs_bind_check -s "$FS_BIND_DISK2" parent/child1/a parent/child2/child1/a
+	fs_bind_check -s "$FS_BIND_DISK3" parent/child1/b parent/child2/child1/b
+
+	fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK4" "$PWD/parent/child2/child1/c"
+	fs_bind_check -scheck parent/child2/child1/c parent/child1/c
+
+	fs_bind_exec_ns umount "$PWD/parent/child1/b"
+	fs_bind_check -s parent/child2/child1/b parent/child1/b
+
+
+	fs_bind_check "$FS_BIND_DISK4" parent/child2/child1/c parent/child1/c
+	fs_bind_check -n "$FS_BIND_DISK3" parent/child1/b
+	fs_bind_check parent/child1/b parent/child2/child1/b
+
+
+	EXPECT_PASS umount parent/child2/child1/c
+	EXPECT_PASS umount parent/child2/child1/a
+	EXPECT_PASS umount parent/child2/child1
+	EXPECT_PASS umount parent/child2/child1
+	EXPECT_PASS umount parent/child2/child2
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
index b7af489a2..0e87cc464 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
@@ -1,96 +1,77 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
 
-SETS_DEFAULTS="${TCID=test06} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
 
-tst_resm TINFO "***************TEST06***************"
-tst_resm TINFO "cloneNS: namespace with shared point bind mounted "
-tst_resm TINFO "within the same directory"
-tst_resm TINFO "************************************"
+test()
+{
+	tst_res TINFO "cloneNS: namespace with shared point bind mounted within the same directory"
 
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test06 failed" && tst_exit)
-export result=0
+	fs_bind_makedir rshared dir1
 
+	mkdir dir1/x dir2 dir3 dir4
 
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
+	EXPECT_PASS mount --rbind dir1 dir2
+	EXPECT_PASS mount --make-rslave dir2
+	EXPECT_PASS mount --make-rshared dir2
 
-while /bin/true ; do
-	# This loop is for error recovery purposes only
+	EXPECT_PASS mount --rbind dir2 dir3
+	EXPECT_PASS mount --make-rslave dir3
+	EXPECT_PASS mount --make-rshared dir3
 
-	cp "${FS_BIND_ROOT}/cloneNS/parent06" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child06" .
+	EXPECT_PASS mount --rbind dir3 dir4
+	EXPECT_PASS mount --make-rslave dir4
 
-	chmod 755 parent06 child06
+	fs_bind_create_ns
 
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" dir1/x
 
-	mkdir dir1/x dir2 dir3 dir4
+	fs_bind_check dir1/x dir2/x dir3/x dir4/x
 
-	mount --rbind dir1 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir2
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" dir2/x/a
+	fs_bind_check -n dir1/x/a dir2/x/a
+	fs_bind_check dir2/x/a dir3/x/a dir4/x/a
 
-	mount --rbind dir2 dir3
-	"${FS_BIND_ROOT}/bin/makedir" slave dir3
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir3
 
-	mount --rbind dir3 dir4
-	"${FS_BIND_ROOT}/bin/makedir" slave dir4
+	fs_bind_check -s dir1/x dir2/x dir3/x dir4/x
 
+	fs_bind_check -s -n dir1/x/a dir2/x/a
+	fs_bind_check -s "$FS_BIND_DISK2" dir2/x/a dir3/x/a dir4/x/a
 
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent06 ./child06 || result=$?
+	fs_bind_exec_ns mount --rbind "$PWD/$FS_BIND_DISK3" "$PWD/dir3/x/b"
+	fs_bind_check -s -n dir1/x/b dir3/x/b
+	fs_bind_check -s -n dir2/x/b dir3/x/b
+	fs_bind_check -s dir3/x/b dir4/x/b
 
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test06: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test06: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir3/x/b
-	umount dir2/x/a
-	umount dir1/x
-	umount dir4
-	umount dir3
-	umount dir2
-	umount dir1
-
-	rm -rf parent* child* dir*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test06: FAILED: cloneNS: namespace with shared point bind mounted
-within the same directory"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test06: PASSED"
-	exit 0
-fi
-tst_exit
+	fs_bind_exec_ns mount --rbind "$PWD/$FS_BIND_DISK4" "$PWD/dir4/x/c"
+	fs_bind_check -s -n dir1/x/c dir4/x/c
+	fs_bind_check -s -n dir2/x/c dir4/x/c
+	fs_bind_check -s -n dir3/x/c dir4/x/c
+
+
+	fs_bind_check -n dir1/x/b dir3/x/b
+	fs_bind_check -n dir2/x/b dir3/x/b
+	fs_bind_check dir3/x/b dir4/x/b
+	fs_bind_check "$FS_BIND_DISK3" dir3/x/b
+
+	fs_bind_check -n "$FS_BIND_DISK4" dir4/x/c
+	fs_bind_check dir1/x/c dir2/x/c dir3/x/c dir4/x/c
+
+
+	EXPECT_PASS umount dir3/x/b
+	EXPECT_PASS umount dir3/x/a
+	EXPECT_PASS umount dir2/x/a
+	EXPECT_PASS umount dir2/x
+	EXPECT_PASS umount dir1/x
+	EXPECT_PASS umount dir4
+	EXPECT_PASS umount dir3
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
index bf94912c6..0780734a9 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
@@ -1,91 +1,55 @@
-#!/bin/bash
-
-#
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 # Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test07} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
 
-tst_resm TINFO "***************TEST 07***************"
-tst_resm TINFO "cloneNS: slave child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test07 failed" && tst_exit)
-export result=0
+FS_BIND_TESTFUNC=test
 
+. fs_bind_lib.sh
 
+test()
+{
+	tst_res TINFO "cloneNS: slave child to slave parent"
 
+	mkdir parent1 parent2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1
+	EXPECT_PASS mount --make-rshared parent1
+	EXPECT_PASS mount --bind parent1 parent2
 
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
+	fs_bind_check parent1 parent2
 
-while /bin/true ; do
-	# This loop is for error recovery purposes only
+	EXPECT_PASS mount --move parent1 parent2/a
 
-	cp "${FS_BIND_ROOT}/cloneNS/parent07" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child07" .
-	chmod 755 parent07 child07
+	fs_bind_check parent2 parent2/a parent2/a/a
 
-	mkdir parent1 parent2
-	mount --bind "$disk1" parent1
-	mount --make-rshared parent1 > /dev/null 2>&1 || "${FS_BIND_ROOT}/bin/smount" parent1 rshared
-	mount --bind parent1 parent2
+	fs_bind_create_ns
 
-	check parent1 parent2
+	fs_bind_check parent2 parent2/a parent2/a/a
 
-	mount --move parent1 parent2/a
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/b
+	fs_bind_check parent2/b parent2/a/b parent2/a/a/b
 
-	check parent2 parent2/a parent2/a/a
 
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent07 ./child07 || result=$?
+	fs_bind_check -s parent2 parent2/a parent2/a/a
+	fs_bind_check -s parent2/b parent2/a/b parent2/a/a/b
 
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test07: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test07: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/b
-	umount parent2/a/a
-	umount parent2/a
-	umount parent2
-	umount parent1
+	fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK3" "$PWD/parent2/a/c"
+	fs_bind_check -s parent2/c parent2/a/c parent2/a/a/c
 
 
+	fs_bind_check parent2 parent2/a parent2/a/a
+	fs_bind_check parent2/c parent2/a/c parent2/a/a/c
 
-	rm -rf parent* child*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "cloneNS/test07: FAILED: cloneNS: slave child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "cloneNS/test07: PASSED"
-        exit 0
-fi
+	EXPECT_PASS umount parent2/a/a/c
+	fs_bind_check parent2/c parent2/a/c parent2/a/a/c
+	
+	
+	fs_bind_check -s parent2/c parent2/a/c parent2/a/a/c
 
+	EXPECT_PASS umount parent2/a/b
+	EXPECT_PASS umount parent2/a/a
+	EXPECT_PASS umount parent2
+}
 
-tst_exit
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent01 b/testcases/kernel/fs/fs_bind/cloneNS/parent01
deleted file mode 100755
index afeb5bf1b..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent01
+++ /dev/null
@@ -1,44 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-ls
-ls dir*
-mount --bind "$disk2" dir2/a
-check dir1/a dir2/a
-echo dir1/a
-ls dir1/a
-
-goahead
-iamgoingahead
-check "$disk3" dir1/b dir2/b
-echo dir2/b
-ls dir2/b
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent02 b/testcases/kernel/fs/fs_bind/cloneNS/parent02
deleted file mode 100755
index 56b3c9072..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent02
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-ls
-ls dir*
-mount --bind "$disk2" dir1/a
-check dir1/a dir2/a
-
-mount --bind "$disk3" dir2/b
-check -n dir1/b dir2/b
-
-goahead
-iamgoingahead
-
-check "$disk2" dir1/a dir2/a
-check "$disk4" dir1/c dir2/c
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent03 b/testcases/kernel/fs/fs_bind/cloneNS/parent03
deleted file mode 100755
index e9c3b77c5..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent03
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-check "$disk1" dir1
-goahead
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent04 b/testcases/kernel/fs/fs_bind/cloneNS/parent04
deleted file mode 100755
index 58ac7306d..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent04
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-mount --bind "$disk2" dir1/a
-goahead
-iamgoingahead
-check -n "$disk3" dir1/b
-
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent05 b/testcases/kernel/fs/fs_bind/cloneNS/parent05
deleted file mode 100755
index 3aa69dfe4..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent05
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-mount --bind "$disk2" parent/child1/a
-check parent/child1/a parent/child2/child1/a
-
-mount --bind "$disk3" parent/child2/child1/b
-check parent/child1/b parent/child2/child1/b
-
-goahead
-iamgoingahead
-
-check "$disk4" parent/child2/child1/c parent/child1/c
-check -n "$disk3" parent/child1/b
-check parent/child1/b parent/child2/child1/b
-
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent06 b/testcases/kernel/fs/fs_bind/cloneNS/parent06
deleted file mode 100755
index 0f3e87f89..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent06
+++ /dev/null
@@ -1,51 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-mount --rbind "$disk1" dir1/x
-
-check dir1/x dir2/x dir3/x dir4/x
-
-mount --rbind "$disk2" dir2/x/a
-check -n dir1/x/a dir2/x/a
-check dir2/x/a dir3/x/a dir4/x/a
-
-
-goahead
-iamgoingahead
-
-check -n dir1/x/b dir3/x/b
-check -n dir2/x/b dir3/x/b
-check dir3/x/b dir4/x/b
-check "$disk3" dir3/x/b
-
-check -n "$disk4" dir4/x/c
-check dir1/x/c dir2/x/c dir3/x/c dir4/x/c
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent07 b/testcases/kernel/fs/fs_bind/cloneNS/parent07
deleted file mode 100755
index 6a5109f7c..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent07
+++ /dev/null
@@ -1,48 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-check parent2 parent2/a parent2/a/a
-
-mount --bind "$disk2" parent2/b
-check parent2/b parent2/a/b parent2/a/a/b
-
-
-goahead
-iamgoingahead
-
-
-check parent2 parent2/a parent2/a/a
-check parent2/c parent2/a/c parent2/a/a/c
-
-umount parent2/a/a/c
-check parent2/c parent2/a/c parent2/a/a/c
-goahead
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
index b644ef512..94e94024c 100644
--- a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
+++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
@@ -28,6 +28,8 @@ FS_BIND_DISK2="disk2"
 FS_BIND_DISK3="disk3"
 FS_BIND_DISK4="disk4"
 
+FS_BIND_MNTNS_PID=
+
 # Creates a directory and bind-mounts it to itself.
 # usage: fs_bind_makedir share_mode directory
 # where
@@ -68,16 +70,23 @@ fs_bind_makedir()
 #              If -n is given, only two directories are allowed.
 fs_bind_check()
 {
-	local expect_diff args msg dir1 dir2 fail output
+	local expect_diff use_ns args msg dir1 dir2 fail output
 	expect_diff=0
-	while getopts "n" args; do
+	use_ns=0
+	while getopts "ns" args; do
 		case "$args" in
 		n) expect_diff=1; shift; ;;
+		s) use_ns=1; shift; ;;
 		esac
 	done
 	msg="Check"
 	[ $expect_diff -eq 1 ] && msg="$msg no"
-	msg="$msg propagation $*"
+	msg="$msg propagation"
+	if [ $use_ns -eq 1 ]; then
+		[ -z "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace does not exist"
+		msg="$msg in mnt namespace"
+	fi
+	msg="$msg $*"
 
 	if [ $# -lt 2 ] || ( [ $expect_diff -eq 1 ] && [ $# -ne 2 ] ); then
 		tst_brk TBROK "Insufficient arguments"
@@ -102,7 +111,11 @@ fs_bind_check()
 	        fi
 	    fi
 
-		output="$(diff -r "$dir1" "$dir2" 2> /dev/null)"
+		if [ $use_ns -eq 1 ]; then
+			output="$(ns_exec ${FS_BIND_MNTNS_PID} mnt diff -r "$PWD/$dir1" "$PWD/$dir2" 2> /dev/null)"
+		else
+			output="$(diff -r "$dir1" "$dir2" 2> /dev/null)"
+		fi
 
 		if [ $? -ne 0 ]; then
 			if [ $expect_diff -eq 1 ]; then
@@ -184,10 +197,30 @@ _fs_bind_setup_test()
 	done
 }
 
+fs_bind_create_ns()
+{
+	[ -n "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace exist already"
+	FS_BIND_MNTNS_PID=$(ns_create mnt)
+}
+
+fs_bind_exec_ns()
+{
+	[ -z "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace does not exist"
+	EXPECT_PASS ns_exec $FS_BIND_MNTNS_PID mnt "$@"
+}
+
+fs_bind_destroy_ns()
+{
+	[ -n "$FS_BIND_MNTNS_PID" ] && kill $FS_BIND_MNTNS_PID 2>/dev/null
+	FS_BIND_MNTNS_PID=
+}
+
 _fs_bind_cleanup_test()
 {
 	local mounts
 
+	fs_bind_destroy_ns
+
 	mounts=$( awk -v tmp="$TST_TMPDIR/$FS_BIND_SANDBOX/" '
 		index($2, tmp) {
 			print substr($2, length(tmp) + 1)
-- 
2.25.1

