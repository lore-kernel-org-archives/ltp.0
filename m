From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 28 Mar 2019 17:36:46 +0800
Subject: [LTP] [PATCH 1/2] m4: Use common LTP_CHECK_LIBC_FUNCS to check libc
	implementations
Message-ID: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use LTP_CHECK_LIBC_FUNCS if only libc implementations need to be checked.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 configure.ac              | 23 +----------------------
 m4/ltp-epoll_pwait.m4     | 25 -------------------------
 m4/ltp-execveat.m4        | 25 -------------------------
 m4/ltp-fallocate.m4       | 25 -------------------------
 m4/ltp-fchownat.m4        | 25 -------------------------
 m4/ltp-fstatat.m4         | 26 --------------------------
 m4/ltp-kcmp.m4            | 23 -----------------------
 m4/ltp-libc-funcs.m4      | 14 ++++++++++++++
 m4/ltp-mkdirat.m4         | 25 -------------------------
 m4/ltp-mknodat.m4         | 25 -------------------------
 m4/ltp-openat.m4          | 25 -------------------------
 m4/ltp-preadv.m4          | 23 -----------------------
 m4/ltp-preadv2.m4         |  9 ---------
 m4/ltp-pwritev.m4         | 23 -----------------------
 m4/ltp-pwritev2.m4        |  9 ---------
 m4/ltp-readlinkat.m4      | 25 -------------------------
 m4/ltp-renameat.m4        | 25 -------------------------
 m4/ltp-renameat2.m4       | 27 ---------------------------
 m4/ltp-splice.m4          | 25 -------------------------
 m4/ltp-sync_file_range.m4 | 10 ----------
 m4/ltp-syncfs.m4          | 10 ----------
 m4/ltp-tee.m4             | 25 -------------------------
 m4/ltp-unshare.m4         | 25 -------------------------
 m4/ltp-vmsplice.m4        | 25 -------------------------
 24 files changed, 15 insertions(+), 507 deletions(-)
 delete mode 100644 m4/ltp-epoll_pwait.m4
 delete mode 100644 m4/ltp-execveat.m4
 delete mode 100644 m4/ltp-fallocate.m4
 delete mode 100644 m4/ltp-fchownat.m4
 delete mode 100644 m4/ltp-fstatat.m4
 delete mode 100644 m4/ltp-kcmp.m4
 create mode 100644 m4/ltp-libc-funcs.m4
 delete mode 100644 m4/ltp-mkdirat.m4
 delete mode 100644 m4/ltp-mknodat.m4
 delete mode 100644 m4/ltp-openat.m4
 delete mode 100644 m4/ltp-preadv.m4
 delete mode 100644 m4/ltp-preadv2.m4
 delete mode 100644 m4/ltp-pwritev.m4
 delete mode 100644 m4/ltp-pwritev2.m4
 delete mode 100644 m4/ltp-readlinkat.m4
 delete mode 100644 m4/ltp-renameat.m4
 delete mode 100644 m4/ltp-renameat2.m4
 delete mode 100644 m4/ltp-splice.m4
 delete mode 100644 m4/ltp-sync_file_range.m4
 delete mode 100644 m4/ltp-syncfs.m4
 delete mode 100644 m4/ltp-tee.m4
 delete mode 100644 m4/ltp-unshare.m4
 delete mode 100644 m4/ltp-vmsplice.m4

diff --git a/configure.ac b/configure.ac
index d71d832..c231e33 100644
--- a/configure.ac
+++ b/configure.ac
@@ -182,7 +182,6 @@ LTP_CHECK_SYSCALL_EVENTFD
 LTP_CHECK_SYSCALL_MODIFY_LDT
 LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
-LTP_CHECK_SYSCALL_UNSHARE
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
 LTP_CHECK_TIME
@@ -193,36 +192,17 @@ LTP_CHECK_MREMAP_FIXED
 LTP_CHECK_KERNEL_DEVEL
 LTP_CHECK_XFS_QUOTACTL
 LTP_CHECK_CLONE_SUPPORTS_7_ARGS
-LTP_CHECK_MKDIRAT
-LTP_CHECK_FCHOWNAT
-LTP_CHECK_FSTATAT
-LTP_CHECK_MKNODAT
-LTP_CHECK_READLINKAT
-LTP_CHECK_OPENAT
-LTP_CHECK_EXECVEAT
-LTP_CHECK_RENAMEAT
-LTP_CHECK_RENAMEAT2
 LTP_CHECK_STATX
-LTP_CHECK_FALLOCATE
 LTP_CHECK_SYSCALL_FCNTL
 LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 if test "x$with_tirpc" = xyes; then
 LTP_CHECK_TIRPC
 fi
-LTP_CHECK_TEE
-LTP_CHECK_SPLICE
-LTP_CHECK_VMSPLICE
 LTP_CHECK_TIMERFD
 LTP_CHECK_IOVEC
 LTP_CHECK_LINUXRANDOM
 LTP_CHECK_IF_LINK
-LTP_CHECK_KCMP
 LTP_CHECK_KCMP_TYPE
-LTP_CHECK_PREADV
-LTP_CHECK_PWRITEV
-LTP_CHECK_PREADV2
-LTP_CHECK_PWRITEV2
-LTP_CHECK_EPOLL_PWAIT
 LTP_CHECK_KEYUTILS_SUPPORT
 LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_BUILTIN_CLEAR_CACHE
@@ -234,10 +214,9 @@ LTP_CHECK_TPACKET_V3
 LTP_CHECK_RLIMIT64
 LTP_DETECT_HOST_CPU
 LTP_CHECK_PERF_EVENT
-LTP_CHECK_SYNCFS
-LTP_CHECK_SYNC_FILE_RANGE
 LTP_CHECK_FTS_H
 LTP_CHECK_FIDEDUPE
+LTP_CHECK_LIBC_FUNCS
 
 if test "x$with_numa" = xyes; then
 	LTP_CHECK_SYSCALL_NUMA
diff --git a/m4/ltp-epoll_pwait.m4 b/m4/ltp-epoll_pwait.m4
deleted file mode 100644
index e918110..0000000
--- a/m4/ltp-epoll_pwait.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) 2016 Fujitsu Ltd.
-dnl Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-dnl
-dnl This program is free software; you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program.
-dnl
-
-dnl
-dnl LTP_CHECK_EPOLL_PWAIT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_EPOLL_PWAIT],[
-AC_CHECK_FUNCS(epoll_pwait,,)
-])
diff --git a/m4/ltp-execveat.m4 b/m4/ltp-execveat.m4
deleted file mode 100644
index 8cb6147..0000000
--- a/m4/ltp-execveat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_EXECVEAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_EXECVEAT],[
-AC_CHECK_FUNCS(execveat,,)
-])
diff --git a/m4/ltp-fallocate.m4 b/m4/ltp-fallocate.m4
deleted file mode 100644
index c7d509e..0000000
--- a/m4/ltp-fallocate.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_FALLOCATE
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_FALLOCATE],[
-AC_CHECK_FUNCS(fallocate,,)
-])
diff --git a/m4/ltp-fchownat.m4 b/m4/ltp-fchownat.m4
deleted file mode 100644
index a46a397..0000000
--- a/m4/ltp-fchownat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_FCHOWNAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_FCHOWNAT],[
-AC_CHECK_FUNCS(fchownat,,)
-])
diff --git a/m4/ltp-fstatat.m4 b/m4/ltp-fstatat.m4
deleted file mode 100644
index 8814ade..0000000
--- a/m4/ltp-fstatat.m4
+++ /dev/null
@@ -1,26 +0,0 @@
-dnl
-dnl Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
-dnl
-dnl Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-dnl
-
-dnl
-dnl LTP_CHECK_FSTATAT
-dnl -----------------
-dnl
-AC_DEFUN([LTP_CHECK_FSTATAT],[
-AC_CHECK_FUNCS(fstatat,,)
-])
diff --git a/m4/ltp-kcmp.m4 b/m4/ltp-kcmp.m4
deleted file mode 100644
index 70bf375..0000000
--- a/m4/ltp-kcmp.m4
+++ /dev/null
@@ -1,23 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2015
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software Foundation,
-dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-dnl Author: Cedric Hnyda <chnyda@suse.com>
-dnl
-
-AC_DEFUN([LTP_CHECK_KCMP],[
-AC_CHECK_FUNCS(kcmp,,)
-])
diff --git a/m4/ltp-libc-funcs.m4 b/m4/ltp-libc-funcs.m4
new file mode 100644
index 0000000..ebbe2c9
--- /dev/null
+++ b/m4/ltp-libc-funcs.m4
@@ -0,0 +1,14 @@
+dnl SPDX-License-Identifier: GPL-2.0-or-later
+dnl Copyright (c) 2019 Fujitsu Ltd.
+dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+
+dnl
+dnl LTP_CHECK_LIBC_FUNCS
+dnl ----------------------------
+dnl
+
+AC_DEFUN([LTP_CHECK_LIBC_FUNCS],[
+AC_CHECK_FUNCS(epoll_pwait execveat fallocate fchownat fstatat kcmp mkdirat \
+mknodat openat preadv preadv2 pwritev pwritev2 readlinkat renameat renameat2 \
+splice syncfs sync_file_range tee unshare vmsplice,,)
+])
diff --git a/m4/ltp-mkdirat.m4 b/m4/ltp-mkdirat.m4
deleted file mode 100644
index 40786c3..0000000
--- a/m4/ltp-mkdirat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_MKDIRAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_MKDIRAT],[
-AC_CHECK_FUNCS(mkdirat,,)
-])
diff --git a/m4/ltp-mknodat.m4 b/m4/ltp-mknodat.m4
deleted file mode 100644
index 1ec22c7..0000000
--- a/m4/ltp-mknodat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_MKNODAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_MKNODAT],[
-AC_CHECK_FUNCS(mknodat,,)
-])
diff --git a/m4/ltp-openat.m4 b/m4/ltp-openat.m4
deleted file mode 100644
index aa3b0a3..0000000
--- a/m4/ltp-openat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_OPENAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_OPENAT],[
-AC_CHECK_FUNCS(openat,,)
-])
diff --git a/m4/ltp-preadv.m4 b/m4/ltp-preadv.m4
deleted file mode 100644
index 2046902..0000000
--- a/m4/ltp-preadv.m4
+++ /dev/null
@@ -1,23 +0,0 @@
-dnl
-dnl Copyright (c) 2015 Fujitsu Ltd.
-dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-dnl
-dnl This program is free software; you can redistribute it and/or modify it
-dnl under the terms of version 2 of the GNU General Public License as
-dnl published by the Free Software Foundation.
-dnl
-dnl This program is distributed in the hope that it would be useful, but
-dnl WITHOUT ANY WARRANTY; without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl alone with this program.
-dnl
-
-dnl
-dnl LTP_CHECK_PREADV
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_PREADV],[
-AC_CHECK_FUNCS(preadv,,)
-])
diff --git a/m4/ltp-preadv2.m4 b/m4/ltp-preadv2.m4
deleted file mode 100644
index a1e5327..0000000
--- a/m4/ltp-preadv2.m4
+++ /dev/null
@@ -1,9 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
-dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-
-dnl LTP_CHECK_PREADV2
-dnl ----------------------------
-AC_DEFUN([LTP_CHECK_PREADV2],[
-AC_CHECK_FUNCS(preadv2,,)
-])
diff --git a/m4/ltp-pwritev.m4 b/m4/ltp-pwritev.m4
deleted file mode 100644
index 6565332..0000000
--- a/m4/ltp-pwritev.m4
+++ /dev/null
@@ -1,23 +0,0 @@
-dnl
-dnl Copyright (c) 2015 Fujitsu Ltd.
-dnl Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-dnl
-dnl This program is free software; you can redistribute it and/or modify it
-dnl under the terms of version 2 of the GNU General Public License as
-dnl published by the Free Software Foundation.
-dnl
-dnl This program is distributed in the hope that it would be useful, but
-dnl WITHOUT ANY WARRANTY; without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl alone with this program.
-dnl
-
-dnl
-dnl LTP_CHECK_PWRITEV
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_PWRITEV],[
-AC_CHECK_FUNCS(pwritev,,)
-])
diff --git a/m4/ltp-pwritev2.m4 b/m4/ltp-pwritev2.m4
deleted file mode 100644
index 38148ac..0000000
--- a/m4/ltp-pwritev2.m4
+++ /dev/null
@@ -1,9 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
-dnl Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
-
-dnl LTP_CHECK_PWRITEV2
-dnl ----------------------------
-AC_DEFUN([LTP_CHECK_PWRITEV2],[
-AC_CHECK_FUNCS(pwritev2,,)
-])
diff --git a/m4/ltp-readlinkat.m4 b/m4/ltp-readlinkat.m4
deleted file mode 100644
index 6866f3b..0000000
--- a/m4/ltp-readlinkat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_READLINKAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_READLINKAT],[
-AC_CHECK_FUNCS(readlinkat,,)
-])
diff --git a/m4/ltp-renameat.m4 b/m4/ltp-renameat.m4
deleted file mode 100644
index f40c58e..0000000
--- a/m4/ltp-renameat.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software Foundation,
-dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_RENAMEAT
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_RENAMEAT],[
-AC_CHECK_FUNCS(renameat,,)
-])
diff --git a/m4/ltp-renameat2.m4 b/m4/ltp-renameat2.m4
deleted file mode 100644
index 2bc7313..0000000
--- a/m4/ltp-renameat2.m4
+++ /dev/null
@@ -1,27 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2015
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software Foundation,
-dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-dnl Author: Cedric Hnyda <chnyda@suse.com>
-dnl
-
-dnl
-dnl LTP_CHECK_RENAMEAT2
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_RENAMEAT2],[
-AC_CHECK_FUNCS(renameat2,,)
-])
diff --git a/m4/ltp-splice.m4 b/m4/ltp-splice.m4
deleted file mode 100644
index 0ddaae0..0000000
--- a/m4/ltp-splice.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_SPLICE
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_SPLICE],[
-AC_CHECK_FUNCS(splice,,)
-])
diff --git a/m4/ltp-sync_file_range.m4 b/m4/ltp-sync_file_range.m4
deleted file mode 100644
index b47a091..0000000
--- a/m4/ltp-sync_file_range.m4
+++ /dev/null
@@ -1,10 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2019 Linaro Limited. All rights reserved.
-
-dnl
-dnl LTP_CHECK_SYNC_FILE_RANGE
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_SYNC_FILE_RANGE],[
-AC_CHECK_FUNCS(sync_file_range,,)
-])
diff --git a/m4/ltp-syncfs.m4 b/m4/ltp-syncfs.m4
deleted file mode 100644
index 836a055..0000000
--- a/m4/ltp-syncfs.m4
+++ /dev/null
@@ -1,10 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2019 Linaro Limited. All rights reserved.
-
-dnl
-dnl LTP_CHECK_SYNCFS
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_SYNCFS],[
-AC_CHECK_FUNCS(syncfs,,)
-])
diff --git a/m4/ltp-tee.m4 b/m4/ltp-tee.m4
deleted file mode 100644
index eb4a6b2..0000000
--- a/m4/ltp-tee.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software Foundation,
-dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_TEE
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_TEE],[
-AC_CHECK_FUNCS(tee,,)
-])
diff --git a/m4/ltp-unshare.m4 b/m4/ltp-unshare.m4
deleted file mode 100644
index de8da73..0000000
--- a/m4/ltp-unshare.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Cisco Systems Inc., 2009
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
-dnl
-
-dnl
-dnl LTP_CHECK_SYSCALL_UNSHARE
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_SYSCALL_UNSHARE],[AC_CHECK_FUNCS_ONCE(unshare)])
diff --git a/m4/ltp-vmsplice.m4 b/m4/ltp-vmsplice.m4
deleted file mode 100644
index 6129cfe..0000000
--- a/m4/ltp-vmsplice.m4
+++ /dev/null
@@ -1,25 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_SPLICE
-dnl ----------------------------
-dnl
-AC_DEFUN([LTP_CHECK_VMSPLICE],[
-AC_CHECK_FUNCS(vmsplice,,)
-])
-- 
1.8.3.1



