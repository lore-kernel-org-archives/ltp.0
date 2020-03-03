From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 3 Mar 2020 15:22:41 +0800
Subject: [LTP] [PATCH v1 2/2] Replace GPL with SPDX-License-Identifier by
 using spdx_convert.sh
In-Reply-To: <1583220161-23201-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583220161-23201-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1583220161-23201-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in syscalls/Makefile by using spdx_convert.sh

spdx_string="# SPDX-License-Identifier: GPL-2.0-or-later"
rm -rf new.txt
rm -rf old.txt
sed -i '/^[0-9]+*/d' unconvert.txt
sed -i 's/..//' unconvert.txt
for file in `cat unconvert.txt`
do
        str_get=`sed -n '1p' $file`
        if [ "$spdx_string" == "$str_get" ]; then
                echo "new"
                echo $file >> new.txt
        else
                echo "old"
                echo $file >> old.txt
        fi
done
replace_gpl()
{
        sed -i "1c $spdx_string" $1
        sed -i "$2,$3d" $1
}

replace_gpl ./copy_file_range/Makefile  3 13
replace_gpl ./gethostbyname_r/Makefile  3 13
replace_gpl ./epoll_wait/Makefile  4 17
replace_gpl ./inotify/Makefile  3 17
replace_gpl ./removexattr/Makefile 4 17
replace_gpl ./setns/Makefile 4 17
replace_gpl ./listxattr/Makefile 4 17
replace_gpl ./epoll2/examples/Makefile 4 8
replace_gpl ./statx/Makefile 4 18
replace_gpl ./switch/Makefile 3 17
replace_gpl ./execveat/Makefile 3 17
replace_gpl ./flistxattr/Makefile 4 17
replace_gpl ./fadvise/Makefile 7 21
replace_gpl ./fanotify/Makefile 3 17
replace_gpl ./cma/Makefile 3 17
replace_gpl ./nftw/Makefile 5 18
replace_gpl ./request_key/Makefile 3 16
replace_gpl ./readahead/Makefile 3 17
replace_gpl ./execl/Makefile 4 17
replace_gpl ./mount/Makefile 4 17
replace_gpl ./epoll_ctl/Makefile 4 18
replace_gpl ./execv/Makefile 4 17
replace_gpl ./ipc/msgget/Makefile 3 16
replace_gpl ./ipc/msgsnd/Makefile 3 16
replace_gpl ./ipc/libnewipc/Makefile 3 16
replace_gpl ./preadv/Makefile 4 18
replace_gpl ./kcmp/Makefile 3 18
replace_gpl ./getrandom/Makefile 3 17
replace_gpl ./futex/Makefile 3 17
replace_gpl ./getxattr/Makefile 3 17
replace_gpl ./umount2/Makefile 4 17
replace_gpl ./sched_setattr/Makefile 3 17
replace_gpl ./renameat2/Makefile 3 18
replace_gpl ./gettid/Makefile 7 21
replace_gpl ./accept4/Makefile 3 17
replace_gpl ./sched_setaffinity/Makefile 3 16
replace_gpl ./epoll_pwait/Makefile 4 17
replace_gpl ./sched_getattr/Makefile 3 17
replace_gpl ./llistxattr/Makefile 4 17
replace_gpl ./perf_event_open/Makefile 4 16
replace_gpl ./setxattr/Makefile 3 17
replace_gpl Makefile 5 18
replace_gpl ./ipc/Makefile2.inc 6 19
replace_gpl ./ipc/Makefile.inc 5 18

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/Makefile            | 16 +---------------
 testcases/kernel/syscalls/accept4/Makefile    | 17 +----------------
 testcases/kernel/syscalls/cma/Makefile        | 17 +----------------
 .../kernel/syscalls/copy_file_range/Makefile  | 13 +------------
 .../kernel/syscalls/epoll2/examples/Makefile  |  7 +------
 testcases/kernel/syscalls/epoll_ctl/Makefile  | 17 +----------------
 .../kernel/syscalls/epoll_pwait/Makefile      | 16 +---------------
 testcases/kernel/syscalls/epoll_wait/Makefile | 16 +---------------
 testcases/kernel/syscalls/execl/Makefile      | 16 +---------------
 testcases/kernel/syscalls/execv/Makefile      | 16 +---------------
 testcases/kernel/syscalls/execveat/Makefile   | 17 +----------------
 testcases/kernel/syscalls/fadvise/Makefile    | 17 +----------------
 testcases/kernel/syscalls/fanotify/Makefile   | 17 +----------------
 testcases/kernel/syscalls/flistxattr/Makefile | 16 +---------------
 testcases/kernel/syscalls/futex/Makefile      | 17 +----------------
 .../kernel/syscalls/gethostbyname_r/Makefile  | 13 +------------
 testcases/kernel/syscalls/getrandom/Makefile  | 17 +----------------
 testcases/kernel/syscalls/gettid/Makefile     | 17 +----------------
 testcases/kernel/syscalls/getxattr/Makefile   | 17 +----------------
 testcases/kernel/syscalls/inotify/Makefile    | 17 +----------------
 testcases/kernel/syscalls/ipc/Makefile.inc    | 16 +---------------
 testcases/kernel/syscalls/ipc/Makefile2.inc   | 16 +---------------
 .../kernel/syscalls/ipc/libnewipc/Makefile    | 16 +---------------
 testcases/kernel/syscalls/ipc/msgget/Makefile | 16 +---------------
 testcases/kernel/syscalls/ipc/msgsnd/Makefile | 16 +---------------
 testcases/kernel/syscalls/kcmp/Makefile       | 18 +-----------------
 testcases/kernel/syscalls/listxattr/Makefile  | 16 +---------------
 testcases/kernel/syscalls/llistxattr/Makefile | 16 +---------------
 testcases/kernel/syscalls/mount/Makefile      | 16 +---------------
 testcases/kernel/syscalls/nftw/Makefile       | 16 +---------------
 .../kernel/syscalls/perf_event_open/Makefile  | 15 +--------------
 testcases/kernel/syscalls/preadv/Makefile     | 17 +----------------
 testcases/kernel/syscalls/readahead/Makefile  | 17 +----------------
 .../kernel/syscalls/removexattr/Makefile      | 16 +---------------
 testcases/kernel/syscalls/renameat2/Makefile  | 18 +-----------------
 .../kernel/syscalls/request_key/Makefile      | 19 +++----------------
 .../kernel/syscalls/sched_getattr/Makefile    | 17 +----------------
 .../syscalls/sched_setaffinity/Makefile       | 16 +---------------
 .../kernel/syscalls/sched_setattr/Makefile    | 17 +----------------
 testcases/kernel/syscalls/setns/Makefile      | 16 +---------------
 testcases/kernel/syscalls/setxattr/Makefile   | 17 +----------------
 testcases/kernel/syscalls/statx/Makefile      | 17 +----------------
 testcases/kernel/syscalls/switch/Makefile     | 17 +----------------
 testcases/kernel/syscalls/umount2/Makefile    | 16 +---------------
 44 files changed, 46 insertions(+), 667 deletions(-)

diff --git a/testcases/kernel/syscalls/Makefile b/testcases/kernel/syscalls/Makefile
index 45a00cf7d..c6dc8d9e7 100644
--- a/testcases/kernel/syscalls/Makefile
+++ b/testcases/kernel/syscalls/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #    testcases/kernel/syscalls Makefile.
 #
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
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
 # Ngie Cooper, July 2009
 #
 
diff --git a/testcases/kernel/syscalls/accept4/Makefile b/testcases/kernel/syscalls/accept4/Makefile
index 504042e11..6d5002ab6 100644
--- a/testcases/kernel/syscalls/accept4/Makefile
+++ b/testcases/kernel/syscalls/accept4/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) International Business Machines  Corp., 2008
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/cma/Makefile b/testcases/kernel/syscalls/cma/Makefile
index 45a3bbc59..159d5651c 100644
--- a/testcases/kernel/syscalls/cma/Makefile
+++ b/testcases/kernel/syscalls/cma/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2012 Linux Test Project, Inc.
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/copy_file_range/Makefile b/testcases/kernel/syscalls/copy_file_range/Makefile
index 0143bdec8..a77363313 100644
--- a/testcases/kernel/syscalls/copy_file_range/Makefile
+++ b/testcases/kernel/syscalls/copy_file_range/Makefile
@@ -1,16 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Linux Test Project, 2017
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/epoll2/examples/Makefile b/testcases/kernel/syscalls/epoll2/examples/Makefile
index ade66341c..b59f65d09 100644
--- a/testcases/kernel/syscalls/epoll2/examples/Makefile
+++ b/testcases/kernel/syscalls/epoll2/examples/Makefile
@@ -1,12 +1,7 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  epoll ( Efficent event polling implementation )
 #  Copyright (C) 2001,...,2002	 Davide Libenzi
 #
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
 #  Davide Libenzi <davidel@xmailserver.org>
 #
 #
diff --git a/testcases/kernel/syscalls/epoll_ctl/Makefile b/testcases/kernel/syscalls/epoll_ctl/Makefile
index 2666822e6..c7810c9fd 100644
--- a/testcases/kernel/syscalls/epoll_ctl/Makefile
+++ b/testcases/kernel/syscalls/epoll_ctl/Makefile
@@ -1,21 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 Fujitsu Ltd.
 #  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program.
-#
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/Makefile b/testcases/kernel/syscalls/epoll_pwait/Makefile
index 289aaaf44..0253b3ab6 100644
--- a/testcases/kernel/syscalls/epoll_pwait/Makefile
+++ b/testcases/kernel/syscalls/epoll_pwait/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 Fujitsu Ltd.
 #  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program.
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/epoll_wait/Makefile b/testcases/kernel/syscalls/epoll_wait/Makefile
index f29b9a78b..068de0414 100644
--- a/testcases/kernel/syscalls/epoll_wait/Makefile
+++ b/testcases/kernel/syscalls/epoll_wait/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 Fujitsu Ltd.
 #  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program.
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/execl/Makefile b/testcases/kernel/syscalls/execl/Makefile
index a0e5f0fc4..446466b1c 100644
--- a/testcases/kernel/syscalls/execl/Makefile
+++ b/testcases/kernel/syscalls/execl/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Linux Test Project, 2018
 #  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software: you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation, either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/execv/Makefile b/testcases/kernel/syscalls/execv/Makefile
index a0e5f0fc4..446466b1c 100644
--- a/testcases/kernel/syscalls/execv/Makefile
+++ b/testcases/kernel/syscalls/execv/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Linux Test Project, 2018
 #  Copyright (c) International Business Machines  Corp., 2001
-#
-#  This program is free software: you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation, either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/execveat/Makefile b/testcases/kernel/syscalls/execveat/Makefile
index 0bab6dc83..ea1252263 100644
--- a/testcases/kernel/syscalls/execveat/Makefile
+++ b/testcases/kernel/syscalls/execveat/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fadvise/Makefile b/testcases/kernel/syscalls/fadvise/Makefile
index 13aa315d7..50117a9fa 100644
--- a/testcases/kernel/syscalls/fadvise/Makefile
+++ b/testcases/kernel/syscalls/fadvise/Makefile
@@ -1,24 +1,9 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copied from ../open/Makefile by Masatake YAMATO
 #
 ###
 #
 #  Copyright (c) International Business Machines  Corp., 2001
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index 5d01b4825..3628094ba 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Jan Kara <jack@suse.cz>, 2013
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
 
 top_srcdir		?= ../../../..
 fanotify11: CFLAGS+=-pthread
diff --git a/testcases/kernel/syscalls/flistxattr/Makefile b/testcases/kernel/syscalls/flistxattr/Makefile
index b794ec01f..c2f84b159 100644
--- a/testcases/kernel/syscalls/flistxattr/Makefile
+++ b/testcases/kernel/syscalls/flistxattr/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 #  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index 1a0c0088a..8dd239301 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2015 Cyril Hrubis <chrubis@suse.cz>
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/gethostbyname_r/Makefile b/testcases/kernel/syscalls/gethostbyname_r/Makefile
index 2a423d157..0f383f984 100644
--- a/testcases/kernel/syscalls/gethostbyname_r/Makefile
+++ b/testcases/kernel/syscalls/gethostbyname_r/Makefile
@@ -1,16 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2015 Fujitsu Ltd.
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getrandom/Makefile b/testcases/kernel/syscalls/getrandom/Makefile
index 96df4e406..53b787b78 100644
--- a/testcases/kernel/syscalls/getrandom/Makefile
+++ b/testcases/kernel/syscalls/getrandom/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2015 Cedric Hnyda ced.hnyda@gmail.com
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/gettid/Makefile b/testcases/kernel/syscalls/gettid/Makefile
index d060ca83f..4e9982f76 100644
--- a/testcases/kernel/syscalls/gettid/Makefile
+++ b/testcases/kernel/syscalls/gettid/Makefile
@@ -1,24 +1,9 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copied from ../getpid/Makefile by Masatake YAMATO
 #
 ###
 #
 #  Copyright (c) International Business Machines  Corp., 2001
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/getxattr/Makefile b/testcases/kernel/syscalls/getxattr/Makefile
index 3f78745ca..53b867f61 100644
--- a/testcases/kernel/syscalls/getxattr/Makefile
+++ b/testcases/kernel/syscalls/getxattr/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Red Hat Inc., 2011
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/inotify/Makefile b/testcases/kernel/syscalls/inotify/Makefile
index ea746618d..16d430864 100644
--- a/testcases/kernel/syscalls/inotify/Makefile
+++ b/testcases/kernel/syscalls/inotify/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) SWSoft, 2007
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/Makefile.inc b/testcases/kernel/syscalls/ipc/Makefile.inc
index 839b4e4e7..c7e82bb18 100644
--- a/testcases/kernel/syscalls/ipc/Makefile.inc
+++ b/testcases/kernel/syscalls/ipc/Makefile.inc
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #    kernel/syscalls/ipc testcase suite common definitions Makefile.
 #
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
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
 # Ngie Cooper, July 2009
 #
 
diff --git a/testcases/kernel/syscalls/ipc/Makefile2.inc b/testcases/kernel/syscalls/ipc/Makefile2.inc
index 9d612450d..17917f5f8 100644
--- a/testcases/kernel/syscalls/ipc/Makefile2.inc
+++ b/testcases/kernel/syscalls/ipc/Makefile2.inc
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #    kernel/syscalls/ipc testcase suite common definitions Makefile.
 #
 #    Copyright (C) 2016, Cyril Hrubis
 #
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
 
 LDLIBS			+= -lnewipc
 LIBDIR			:= ../libnewipc
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/Makefile b/testcases/kernel/syscalls/ipc/libnewipc/Makefile
index efd8da76f..d150fb70f 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/Makefile
+++ b/testcases/kernel/syscalls/ipc/libnewipc/Makefile
@@ -1,19 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
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
-# along with this program.
-#
 
 top_srcdir		?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/Makefile b/testcases/kernel/syscalls/ipc/msgget/Makefile
index f11974c94..5e4c695dd 100644
--- a/testcases/kernel/syscalls/ipc/msgget/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgget/Makefile
@@ -1,19 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
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
-# along with this program.
-#
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/Makefile b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
index 207fb1675..46f6f1085 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/Makefile
+++ b/testcases/kernel/syscalls/ipc/msgsnd/Makefile
@@ -1,19 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) International Business Machines  Corp., 2001
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
-# along with this program.
-#
 
 top_srcdir              ?= ../../../../..
 
diff --git a/testcases/kernel/syscalls/kcmp/Makefile b/testcases/kernel/syscalls/kcmp/Makefile
index cb8a3dea3..a86863c0d 100644
--- a/testcases/kernel/syscalls/kcmp/Makefile
+++ b/testcases/kernel/syscalls/kcmp/Makefile
@@ -1,21 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2015 Cedric Hnyda chnyda@suse.com
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
-
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
index b794ec01f..c2f84b159 100644
--- a/testcases/kernel/syscalls/listxattr/Makefile
+++ b/testcases/kernel/syscalls/listxattr/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 RT-RK Institute for Computer Based Systems
 #  Author: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/llistxattr/Makefile b/testcases/kernel/syscalls/llistxattr/Makefile
index ed05a4826..c7810c9fd 100644
--- a/testcases/kernel/syscalls/llistxattr/Makefile
+++ b/testcases/kernel/syscalls/llistxattr/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 Fujitsu Ltd.
 #  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/mount/Makefile b/testcases/kernel/syscalls/mount/Makefile
index 5caed987f..31cf89155 100644
--- a/testcases/kernel/syscalls/mount/Makefile
+++ b/testcases/kernel/syscalls/mount/Makefile
@@ -1,21 +1,7 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
 #  Copyright (C) International Business Machines  Corp., 2007
 #
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
 # HISTORY:
 #  6/8/07 krisw@us.ibm.com  Copied change made in RHEL Makefile for seg fault.
 #
diff --git a/testcases/kernel/syscalls/nftw/Makefile b/testcases/kernel/syscalls/nftw/Makefile
index 9cb5a81da..04e2c43cb 100644
--- a/testcases/kernel/syscalls/nftw/Makefile
+++ b/testcases/kernel/syscalls/nftw/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #    testcases/kernel/syscalls Makefile.
 #
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
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
 # Ngie Cooper, July 2009
 #
 
diff --git a/testcases/kernel/syscalls/perf_event_open/Makefile b/testcases/kernel/syscalls/perf_event_open/Makefile
index 3c07fe47a..0facf540c 100644
--- a/testcases/kernel/syscalls/perf_event_open/Makefile
+++ b/testcases/kernel/syscalls/perf_event_open/Makefile
@@ -1,19 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
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
 #
 # Ngie Cooper, July 2009
 #
diff --git a/testcases/kernel/syscalls/preadv/Makefile b/testcases/kernel/syscalls/preadv/Makefile
index 764c956a8..0b209fe9d 100644
--- a/testcases/kernel/syscalls/preadv/Makefile
+++ b/testcases/kernel/syscalls/preadv/Makefile
@@ -1,21 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2015 Fujitsu Ltd.
 #  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/readahead/Makefile b/testcases/kernel/syscalls/readahead/Makefile
index 45a3bbc59..159d5651c 100644
--- a/testcases/kernel/syscalls/readahead/Makefile
+++ b/testcases/kernel/syscalls/readahead/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2012 Linux Test Project, Inc.
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/removexattr/Makefile b/testcases/kernel/syscalls/removexattr/Makefile
index ed05a4826..c7810c9fd 100644
--- a/testcases/kernel/syscalls/removexattr/Makefile
+++ b/testcases/kernel/syscalls/removexattr/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2016 Fujitsu Ltd.
 #  Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/renameat2/Makefile b/testcases/kernel/syscalls/renameat2/Makefile
index 083a071b4..ddaa3112c 100644
--- a/testcases/kernel/syscalls/renameat2/Makefile
+++ b/testcases/kernel/syscalls/renameat2/Makefile
@@ -1,21 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2015 Cedric Hnyda chnyda@suse.com
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
-
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/request_key/Makefile b/testcases/kernel/syscalls/request_key/Makefile
index 9add429d4..58a99875e 100644
--- a/testcases/kernel/syscalls/request_key/Makefile
+++ b/testcases/kernel/syscalls/request_key/Makefile
@@ -1,19 +1,6 @@
-#  Copyright (c) 2016 Fujitsu Ltd.
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
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016 Fujitsu Ltd.
+# Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_getattr/Makefile b/testcases/kernel/syscalls/sched_getattr/Makefile
index 0ad382e35..ea299ff4a 100644
--- a/testcases/kernel/syscalls/sched_getattr/Makefile
+++ b/testcases/kernel/syscalls/sched_getattr/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) International Business Machines  Corp., 2008
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_setaffinity/Makefile b/testcases/kernel/syscalls/sched_setaffinity/Makefile
index 6055d11bf..cdb5c3afc 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/Makefile
+++ b/testcases/kernel/syscalls/sched_setaffinity/Makefile
@@ -1,19 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
-#  along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/sched_setattr/Makefile b/testcases/kernel/syscalls/sched_setattr/Makefile
index 30718a9ce..8fd2bd6f2 100644
--- a/testcases/kernel/syscalls/sched_setattr/Makefile
+++ b/testcases/kernel/syscalls/sched_setattr/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Huawei Technologies Co., Ltd., 2015
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setns/Makefile b/testcases/kernel/syscalls/setns/Makefile
index f1b5129c2..9b051f64f 100644
--- a/testcases/kernel/syscalls/setns/Makefile
+++ b/testcases/kernel/syscalls/setns/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (C) 2013 Linux Test Project, Inc.
 #
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/setxattr/Makefile b/testcases/kernel/syscalls/setxattr/Makefile
index 72544c13e..5f941a758 100644
--- a/testcases/kernel/syscalls/setxattr/Makefile
+++ b/testcases/kernel/syscalls/setxattr/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Red Hat Inc., 2011
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/statx/Makefile b/testcases/kernel/syscalls/statx/Makefile
index 1be0bc80b..7e4770997 100644
--- a/testcases/kernel/syscalls/statx/Makefile
+++ b/testcases/kernel/syscalls/statx/Makefile
@@ -1,21 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
 #  Email: code@zilogic.com
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/switch/Makefile b/testcases/kernel/syscalls/switch/Makefile
index 504042e11..6d5002ab6 100644
--- a/testcases/kernel/syscalls/switch/Makefile
+++ b/testcases/kernel/syscalls/switch/Makefile
@@ -1,20 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) International Business Machines  Corp., 2008
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
 
 top_srcdir		?= ../../../..
 
diff --git a/testcases/kernel/syscalls/umount2/Makefile b/testcases/kernel/syscalls/umount2/Makefile
index bbf0541f3..ff3b0bdba 100644
--- a/testcases/kernel/syscalls/umount2/Makefile
+++ b/testcases/kernel/syscalls/umount2/Makefile
@@ -1,20 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
 #  Copyright (c) 2015 Fujitsu Ltd.
 #  Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
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
 
 top_srcdir		?= ../../../..
 
-- 
2.18.0



