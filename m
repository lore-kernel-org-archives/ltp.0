From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Jun 2019 08:56:50 +0200
Subject: [LTP] [PATCH 3/3] sh: Replace GPL verbose text by SPDX license
	identifier
In-Reply-To: <20190614065650.8612-1-pvorel@suse.cz>
References: <20190614065650.8612-1-pvorel@suse.cz>
Message-ID: <20190614065650.8612-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in tests which use new shell API.
+ other minor cleanup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/ar/ar01                    | 24 ++-------
 testcases/commands/cp/cp_tests.sh             | 27 ++--------
 testcases/commands/cpio/cpio_tests.sh         | 24 +--------
 testcases/commands/df/df01.sh                 | 13 +----
 testcases/commands/du/du01.sh                 | 17 +-----
 testcases/commands/eject/eject-tests.sh       | 26 ++-------
 testcases/commands/file/file01.sh             | 25 ++-------
 testcases/commands/gdb/gdb01.sh               | 23 ++------
 testcases/commands/gzip/gzip_tests.sh         | 34 +++---------
 testcases/commands/insmod/insmod01.sh         | 15 +-----
 testcases/commands/keyctl/keyctl01.sh         | 16 +-----
 testcases/commands/ld/ld01                    | 24 ++-------
 testcases/commands/ldd/ldd01                  | 30 ++---------
 testcases/commands/ln/ln_tests.sh             | 27 ++--------
 testcases/commands/lsmod/lsmod01.sh           | 16 ++----
 testcases/commands/mkdir/mkdir_tests.sh       | 25 ++-------
 testcases/commands/mkfs/mkfs01.sh             | 13 +----
 testcases/commands/mkswap/mkswap01.sh         | 13 +----
 testcases/commands/mv/mv_tests.sh             | 34 +++---------
 testcases/commands/nm/nm01                    | 24 ++-------
 testcases/commands/sysctl/sysctl01.sh         | 16 +-----
 testcases/commands/tar/tar_tests.sh           | 26 ++-------
 testcases/commands/unshare/unshare01.sh       | 13 +----
 testcases/commands/unzip/unzip01.sh           | 26 ++-------
 testcases/commands/wc/wc01.sh                 | 13 +----
 testcases/commands/which/which01.sh           | 13 +----
 .../kernel/controllers/cpuacct/cpuacct.sh     | 35 +++---------
 testcases/kernel/controllers/pids/pids.sh     | 29 ++--------
 testcases/kernel/mem/vma/vma05.sh             | 44 +++++----------
 testcases/kernel/numa/numa01.sh               | 53 ++++++-------------
 .../security/integrity/ima/tests/ima_setup.sh | 15 +-----
 .../tracing/dynamic_debug/dynamic_debug01.sh  | 31 +++--------
 testcases/lib/tst_test.sh                     | 22 ++------
 33 files changed, 131 insertions(+), 655 deletions(-)

diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
index 0252c6d56..48b54c376 100644
--- a/testcases/commands/ar/ar01
+++ b/testcases/commands/ar/ar01
@@ -1,27 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2000
-#  06/01 Robbie Williamson (robbiew@us.ibm.com)
+# Copyright (c) International Business Machines Corp., 2000
 # Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#-----------------------------------------------------------------------
+# Author: Robbie Williamson <robbiew@us.ibm.com>
 #
 # This is a basic ar command test.
-#
+
 AR="${AR:=ar}"
 TST_CNT=17
 TST_SETUP=setup
diff --git a/testcases/commands/cp/cp_tests.sh b/testcases/commands/cp/cp_tests.sh
index 30bb183a7..952f3138c 100755
--- a/testcases/commands/cp/cp_tests.sh
+++ b/testcases/commands/cp/cp_tests.sh
@@ -1,28 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:       Manoj Iyer, manjo@mail.utexas.edu                           ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
 # Tests basic cp functionality
-#
+
 TST_CNT=5
 TST_TESTFUNC=do_test
 TST_SETUP=setup
diff --git a/testcases/commands/cpio/cpio_tests.sh b/testcases/commands/cpio/cpio_tests.sh
index 9ebfb10ad..b110a550a 100755
--- a/testcases/commands/cpio/cpio_tests.sh
+++ b/testcases/commands/cpio/cpio_tests.sh
@@ -1,28 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author: Manoj Iyer, manjo@mail.utexas.edu                                 ##
-## Copyright (c) Cyril Hrubis <chrubis@suse.cz>                               ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
 #
 # Test basic functionality of cpio command
-#
+
 TST_TESTFUNC=cpio_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="cpio"
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 9b0be76fe..3b977801f 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
 # Test df command with some basic options.
-#
 
 TST_CNT=12
 TST_SETUP=setup
diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index c75068255..041fef16d 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -1,24 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
 #
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
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
 # Test du command with some basic options.
-#
 
 TST_CNT=23
 TST_SETUP=setup
diff --git a/testcases/commands/eject/eject-tests.sh b/testcases/commands/eject/eject-tests.sh
index c1dcd584f..af71d1b13 100755
--- a/testcases/commands/eject/eject-tests.sh
+++ b/testcases/commands/eject/eject-tests.sh
@@ -1,28 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author: Manoj Iyer, manjo@mail.utexas.edu                                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
 # Tests basic functionality of eject command.
-#
 
 TST_CNT=4
 TST_SETUP=setup
diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
index 55c043348..8df59dcbb 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -1,29 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
 #
 # This program tests the file command. The tests are aimed at
 # testing if the file command can recognize some of the commonly
 # used file formats like, tar, tar.gz, rpm, C, ASCII, ELF etc.
-#
+
 TST_CNT=20
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/gdb/gdb01.sh b/testcases/commands/gdb/gdb01.sh
index e3a5b5193..d52993982 100755
--- a/testcases/commands/gdb/gdb01.sh
+++ b/testcases/commands/gdb/gdb01.sh
@@ -1,26 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-
 # Copyright (C) 2017 Red Hat, Inc.
 #
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-
-# Test description: See if gdb can successfully attach to a process and
-#                   this process exits normally.
-
-# Usage
-# ./gdb01.sh
+# Test if gdb can successfully attach to a process and
+# this process exits normally.
 
 TST_TESTFUNC=simple_test
 TST_NEEDS_CMDS="gdb /bin/cat"
diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index 05ecb6fcd..d276de473 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -1,32 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Author:       Manoj Iyer, manjo@mail.utexas.edu                            ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
-# Description:  Test basic functionality of gzip and gunzip command
-#		- Test #1:  Test that gzip -r will travel directories and
-#			    compress all the files available.
-#
-#		- Test #2:  Test that gunzip -r will travel directories and
-#			    uncompress all the files available.
+# Test basic functionality of gzip and gunzip command
+# Test #1: Test that gzip -r will travel directories and
+#  compress all the files available.
 #
+# Test #2: Test that gunzip -r will travel directories and
+# uncompress all the files available.
 
 TST_CNT=2
 TST_TESTFUNC=test
diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
index a7835f9b9..f96cce791 100755
--- a/testcases/commands/insmod/insmod01.sh
+++ b/testcases/commands/insmod/insmod01.sh
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2016 Fujitsu Ltd.
 # Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test the basic functionality of insmod command.
-#
+# Test basic functionality of insmod command.
 
 TST_CLEANUP=cleanup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 3fda3893b..3dea06714 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -1,21 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2017 Fujitsu Ltd.
 # Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program, if not, see <http://www.gnu.org/licenses/>.
-#
 # This is a regression test about potential uninitialized variable,
 # the test can crash the buggy kernel, and the bug has been fixed in:
 #
@@ -24,7 +11,6 @@
 #   Date:   Thu Jun 16 15:48:57 2016 +0100
 #
 #   KEYS: potential uninitialized variable
-#
 
 TST_SETUP=setup
 TST_CLEANUP=cleanup
diff --git a/testcases/commands/ld/ld01 b/testcases/commands/ld/ld01
index 986ad1e60..3aee8022c 100755
--- a/testcases/commands/ld/ld01
+++ b/testcases/commands/ld/ld01
@@ -1,26 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2000
-#  06/01 Robbie Williamson (robbiew@us.ibm.com)
+# Copyright (c) International Business Machines Corp., 2000
 # Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Robbie Williamson <robbiew@us.ibm.com>
 #
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#---------------------------------------------------------------------------
-#
-# Test the basic functionality of the `ld` command.
-#
+# Test basic functionality of the `ld` command.
 
 CC=${CC:=gcc}
 LD=${LD:=ld}
diff --git a/testcases/commands/ldd/ldd01 b/testcases/commands/ldd/ldd01
index cf2aac3c1..2936034f3 100755
--- a/testcases/commands/ldd/ldd01
+++ b/testcases/commands/ldd/ldd01
@@ -1,31 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
+# Copyright (c) International Business Machines Corp., 2000
+# Author: Robbie Williamson <robbiew@us.ibm.com>
 #
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#
-#
-#  FILE   : ldd01
-#
-#  PURPOSE: To test the basic functionality of the `ldd` command.
-#
-#  HISTORY:
-#    06/01 Robbie Williamson (robbiew@us.ibm.com)
-#     -Ported
-#---------------------------------------------------------------------------
+# test basic functionality of the `ldd` command.
 
 TST_CNT=2
 TST_SETUP=setup
diff --git a/testcases/commands/ln/ln_tests.sh b/testcases/commands/ln/ln_tests.sh
index bc48bedb3..2a579eddf 100755
--- a/testcases/commands/ln/ln_tests.sh
+++ b/testcases/commands/ln/ln_tests.sh
@@ -1,28 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:       Manoj Iyer, manjo@mail.utexas.edu                           ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
 # Basic test for ln
-#
+
 TST_CNT=6
 TST_TESTFUNC=do_test
 TST_SETUP=setup
diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 132a446c9..84e105b06 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -1,20 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
-# Test the basic functionality of lsmod command.
-#
+# Test basic functionality of lsmod command.
+
 TST_TESTFUNC=lsmod_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="lsmod"
diff --git a/testcases/commands/mkdir/mkdir_tests.sh b/testcases/commands/mkdir/mkdir_tests.sh
index 990162bdb..a92c36d0d 100755
--- a/testcases/commands/mkdir/mkdir_tests.sh
+++ b/testcases/commands/mkdir/mkdir_tests.sh
@@ -1,27 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:       Manoj Iyer, manjo@mail.utexas.edu                           ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
 # Basic mkdir tests
-#
+
 TST_CNT=3
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 88f7f0baa..b1d58afb7 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
 # Test mkfs command with some basic options.
-#
 
 TST_CNT=5
 TST_SETUP=setup
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index 0c59f0ec4..a5815737b 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-# GNU General Public License for more details.
-#
 # Test mkswap command with some basic options.
-#
 
 TST_CNT=10
 TST_SETUP=setup
diff --git a/testcases/commands/mv/mv_tests.sh b/testcases/commands/mv/mv_tests.sh
index ed5506616..d8db1b6e7 100755
--- a/testcases/commands/mv/mv_tests.sh
+++ b/testcases/commands/mv/mv_tests.sh
@@ -1,31 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Author:       Manoj Iyer, manjo@mail.utexas.edu                            ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Description:  Test basic functionality of mv command
-#		- Test #1:  mv <dir1> <dir2>
-#		  move dir1 to dir2 and all its contents.
-#		- Test #2:  mv -b <file1> <file2>
-#		  move file1 to file2 and backup the file2.
+# Copyright (c) International Business Machines Corp., 2001
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
+# Test basic functionality of mv command
+# Test #1:  mv <dir1> <dir2>
+# move dir1 to dir2 and all its contents.
+# Test #2:  mv -b <file1> <file2>
+# move file1 to file2 and backup the file2.
 
 TST_CNT=2
 TST_SETUP=setup
diff --git a/testcases/commands/nm/nm01 b/testcases/commands/nm/nm01
index 39d5c9a21..8e6c9defe 100755
--- a/testcases/commands/nm/nm01
+++ b/testcases/commands/nm/nm01
@@ -1,27 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
-# Copyright (c) International Business Machines  Corp., 2000
-#  06/01 Robbie Williamson (robbiew@us.ibm.com)
+# Copyright (c) International Business Machines Corp., 2000
 # Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
-#
-# This program is free software;  you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY;  without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-# the GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program;  if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#---------------------------------------------------------------------------
+# Author: Robbie Williamson <robbiew@us.ibm.com>
 #
 # Tests the basic functionality of the `nm` command.
-#
+
 NM=${NM:=nm}
 
 TST_CNT=7
diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
index 7522da53d..b30b69c2d 100755
--- a/testcases/commands/sysctl/sysctl01.sh
+++ b/testcases/commands/sysctl/sysctl01.sh
@@ -1,22 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-
 # Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
 # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 #
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-# Description:
 # This is a regression test for invalid value of sysctl_sched_time_avg.
 # System will hang if user set sysctl_sched_time_avg to 0 on buggy kernel.
 #
diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
index 946e9c7b1..c60c928dd 100755
--- a/testcases/commands/tar/tar_tests.sh
+++ b/testcases/commands/tar/tar_tests.sh
@@ -1,28 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author: Manoj Iyer, manjo@mail.utexas.edu                                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
 # Creates, lists and extracts an plain, gzip and bzip tar archive.
-#
 
 TST_CNT=6
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/unshare/unshare01.sh b/testcases/commands/unshare/unshare01.sh
index 075511fd7..ea607368f 100755
--- a/testcases/commands/unshare/unshare01.sh
+++ b/testcases/commands/unshare/unshare01.sh
@@ -1,18 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2017 FUJITSU LIMITED. All rights reserved.
 # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
 # Test unshare command with some basic options.
 # 1) If we run unshare with "--user", UID in the newly created user namespace
 #    is set to 65534.
@@ -35,7 +25,6 @@
 #    Please see the following URL for detailed information:
 #    http://man7.org/linux/man-pages/man7/user_namespaces.7.html
 #    http://man7.org/linux/man-pages/man7/mount_namespaces.7.html
-#
 
 TST_CNT=8
 TST_SETUP=setup
diff --git a/testcases/commands/unzip/unzip01.sh b/testcases/commands/unzip/unzip01.sh
index 532afc0ce..b34d8da83 100755
--- a/testcases/commands/unzip/unzip01.sh
+++ b/testcases/commands/unzip/unzip01.sh
@@ -1,28 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:        Manoj Iyer, manjo@mail.utexas.edu                          ##
-## Copyright (c) Cyril Hrubis <chrubis@suse.cz>                               ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
+# Copyright (c) International Business Machines Corp., 2001
+# Copyright (c) Cyril Hrubis <chrubis@suse.cz>
+# Author: Manoj Iyer <manjo@mail.utexas.edu>
 #
 # Tests basic functionality of unzip command.
-#
 
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
index 74d69e254..3688ed8b6 100755
--- a/testcases/commands/wc/wc01.sh
+++ b/testcases/commands/wc/wc01.sh
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2016 Fujitsu Ltd.
 # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
 # Test wc command with some basic options.
-#
 
 TST_CNT=12
 TST_SETUP=setup
diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
index 0bd698ed9..af2d3e065 100755
--- a/testcases/commands/which/which01.sh
+++ b/testcases/commands/which/which01.sh
@@ -1,20 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
 #
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-# the GNU General Public License for more details.
-#
 # Test which command with some basic options.
-#
 
 TST_CNT=10
 TST_SETUP=setup
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 5e90b05ad..b0f75a419 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -1,39 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2015 SUSE                                                    ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301   ##
-## USA                                                                        ##
-##                                                                            ##
-## Author: Cedric Hnyda <chnyda@suse.com>                                     ##
-##                                                                            ##
-################################################################################
-
+# Copyright (c) 2015 SUSE
+# Author: Cedric Hnyda <chnyda@suse.com>
+#
 # Usage
 # ./cpuacct.sh nbsubgroup nbprocess
-#
-# 1) nbsubgroup : number of subgroup to create
-# 2) nbprocess : number of process to attach to each subgroup
+# nbsubgroup: number of subgroup to create
+# nbprocess: number of process to attach to each subgroup
 #
 # Description
-#
 # 1) Find if cpuacct is mounted, if not mounted, cpuacct will be mounted
 # 2) Check that sum ltp_test/subgroup*/cpuacct.usage = ltp_test/cpuacct.usage
-#
 
 TST_SETUP=setup
 TST_CLEANUP=cleanup
diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index fab33c415..7c8b717dc 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -1,31 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) 2015 SUSE                                                    ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301   ##
-## USA                                                                        ##
-##                                                                            ##
-## Author: Cedric Hnyda <chnyda@suse.com>                                     ##
-##                                                                            ##
-################################################################################
-
+# Copyright (c) 2015 SUSE
+# Author: Cedric Hnyda <chnyda@suse.com>
 # Usage
 # ./pids.sh caseno max
-#
+
 TST_CLEANUP=cleanup
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index d96d3911c..e49337678 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -1,38 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-
 # Copyright (C) 2017 Red Hat, Inc.
+# Regression test if the vsyscall and vdso VMA regions are reported correctly.
 #
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-
-# Test description: [regression] Check if the vsyscall and vdso VMA regions are
-#                   reported correctly.
-#
-#       While [vsyscall] is mostly deprecated with newer systems, there is
-#       still plenty of kernels compiled with CONFIG_LEGACY_VSYSCALL_NATIVE and
-#       CONFIG_LEGACY_VSYSCALL_EMULATE (see linux/arch/x86/Kconfig for option
-#       descriptions). First part of the test will check eligible kernels for
-#       regression for a bug fixed by commit 103efcd9aac1 (fix perms/range of
-#       vsyscall vma in /proc/*/maps).
+# While [vsyscall] is mostly deprecated with newer systems, there is
+# still plenty of kernels compiled with CONFIG_LEGACY_VSYSCALL_NATIVE and
+# CONFIG_LEGACY_VSYSCALL_EMULATE (see linux/arch/x86/Kconfig for option
+# descriptions). First part of the test will check eligible kernels for
+# regression for a bug fixed by commit 103efcd9aac1 (fix perms/range of
+# vsyscall vma in /proc/*/maps).
 #
-#       Second part of test checks [vdso] VMA permissions (fixed with commits
-#       b6558c4a2378 (fix [vdso] page permissions) and e5b97dde514f (Add
-#       VM_ALWAYSDUMP)). As a consequence of this bug, VMAs were not included
-#       in core dumps which resulted in eg. incomplete backtraces and invalid
-#       core dump files created by gdb.
-
-# Usage
-# ./vma05.sh
+# Second part of test checks [vdso] VMA permissions (fixed with commits
+# b6558c4a2378 (fix [vdso] page permissions) and e5b97dde514f (Add
+# VM_ALWAYSDUMP)). As a consequence of this bug, VMAs were not included
+# in core dumps which resulted in eg. incomplete backtraces and invalid
+# core dump files created by gdb.
 
 TST_SETUP=setup
 TST_CLEANUP=cleanup
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 33393ac8d..864503553 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -1,38 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-##############################################################################
-#                                                                            #
-# Copyright (c) International Business Machines  Corp., 2007                 #
-#               Sivakumar Chinnaiah, Sivakumar.C@in.ibm.com                  #
-# Copyright (c) Linux Test Project, 2016                                     #
-#                                                                            #
-# This program is free software: you can redistribute it and/or modify       #
-# it under the terms of the GNU General Public License as published by       #
-# the Free Software Foundation, either version 3 of the License, or          #
-# (at your option) any later version.                                        #
-#                                                                            #
-# This program is distributed in the hope that it will be useful,            #
-# but WITHOUT ANY WARRANTY; without even the implied warranty of             #
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
-# GNU General Public License for more details.                               #
-#                                                                            #
-# You should have received a copy of the GNU General Public License          #
-# along with this program. If not, see <http://www.gnu.org/licenses/>.       #
-#                                                                            #
-##############################################################################
-#                                                                            #
-# Description:  Test Basic functionality of numactl command.                 #
-#               Test #1: Verifies cpunodebind and membind                    #
-#               Test #2: Verifies preferred node bind for memory allocation  #
-#               Test #3: Verifies memory interleave on all nodes             #
-#               Test #4: Verifies physcpubind                                #
-#               Test #5: Verifies localalloc                                 #
-#               Test #6: Verifies memhog                                     #
-#               Test #7: Verifies numa_node_size api                         #
-#               Test #8:Verifies Migratepages                                #
-#               Test #9:Verifies hugepage alloacted on specified node        #
-#               Test #10:Verifies THP memory allocated on preferred node     #
-#                                                                            #
-##############################################################################
+# Copyright (c) International Business Machines Corp., 2007
+# Copyright (c) Linux Test Project, 2016
+# Author: Sivakumar Chinnaiah <Sivakumar.C@in.ibm.com>
+#
+# Test Basic functionality of numactl command.
+# Test #1: Verifies cpunodebind and membind
+# Test #2: Verifies preferred node bind for memory allocation
+# Test #3: Verifies memory interleave on all nodes
+# Test #4: Verifies physcpubind
+# Test #5: Verifies localalloc
+# Test #6: Verifies memhog
+# Test #7: Verifies numa_node_size api
+# Test #8:Verifies Migratepages
+# Test #9:Verifies hugepage alloacted on specified node
+# Test #10:Verifies THP memory allocated on preferred node
 
 TST_CNT=10
 TST_SETUP=setup
@@ -43,12 +25,9 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
 
 . tst_test.sh
 
-#
 # Extracts the value of given numa node from the `numastat -p` output.
-#
 # $1 - Pid number.
 # $2 - Node number.
-#
 extract_numastat_p()
 {
 	local pid=$1
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 52551190a..f7fb4d63c 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,20 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
 # Copyright (c) 2009 IBM Corporation
 # Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
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
-#
 # Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
 
 TST_TESTFUNC="test"
diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index 4cd43baf2..bd0cffebb 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -1,31 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-
 # Copyright (C) 2017 Red Hat, Inc.
 #
-# This program is free software;  you can redistribute it and#or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-# for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-#
-# Test description: Test functionality of dynamic debug feature by enabling
-#                   and disabling traces with available flags. Check that these
-#                   settings don't cause issues by searching dmesg.
-#
-#                   This test handles changes of dynamic debug interface from
-#                   commits 5ca7d2a6 (dynamic_debug: describe_flags with
-#                   '=[pmflt_]*') and 8ba6ebf5 (Dynamic debug: Add more flags)
+# Test functionality of dynamic debug feature by enabling
+# and disabling traces with available flags. Check that these
+# settings don't cause issues by searching dmesg.
 #
-# Usage
-# ./dynamic_debug01.sh
+# This test handles changes of dynamic debug interface from
+# commits 5ca7d2a6 (dynamic_debug: describe_flags with
+# '=[pmflt_]*') and 8ba6ebf5 (Dynamic debug: Add more flags)
 
 TST_TESTFUNC=ddebug_test
 TST_NEEDS_CMDS="awk /bin/echo"
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 512732315..932a6dd63 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,25 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #!/bin/sh
-#
 # Copyright (c) Linux Test Project, 2014-2018
+# Author: Cyril Hrubis <chrubis@suse.cz>
 #
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
-#
-# Written by Cyril Hrubis <chrubis@suse.cz>
-#
-# This is a LTP test library for shell.
-#
+# LTP test library for shell.
 
 [ -n "$TST_LIB_LOADED" ] && return 0
 
-- 
2.21.0

