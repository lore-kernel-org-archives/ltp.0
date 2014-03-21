Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WQzaA-0001rm-Lv
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:33:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WQza9-0005jA-0Z
	for ltp-list@lists.sourceforge.net; Fri, 21 Mar 2014 13:33:58 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2LDXgdb003874
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Mar 2014 21:33:42 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 21 Mar 2014 19:44:00 +0800
Message-Id: <1395402240-6619-3-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1395402240-6619-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1395402240-6619-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] testcases/lib/misc.sh: add tst_fs_has_free
	function
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Create misc.sh to place miscellaneous functions, which will be
useful for tests written in shell but do not have a proper place
to place.

Currenly add tst_fs_has_free(), which will check if the mounted
file system has enough free space.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/lib/misc.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 testcases/lib/misc.sh

diff --git a/testcases/lib/misc.sh b/testcases/lib/misc.sh
new file mode 100644
index 0000000..f6b97ba
--- /dev/null
+++ b/testcases/lib/misc.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Copyright (c) Linux Test Project, 2014
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# This is a LTP shell test library for miscellaneous functions.
+#
+
+. test.sh
+
+# check if the mounted file system has enough free space,
+# if it is, tst_fs_has_free() returns 1, otherwise 0.
+# NOTE: filesystem free space counts in KB
+tst_fs_has_free()
+{
+	local free_space=0
+	local abs_mntpoint=$(cd $1; pwd)
+	local required_space=$2
+
+	if [ -z "$abs_mntpoint" ]; then
+		tst_brkm TBROK "$1: not a valid path"
+	fi
+
+	free_space=$(df | grep $abs_mntpoint | awk '{print $4}')
+
+	if [ -z "$free_space" ]; then
+		tst_brkm TBROK "$1: not a valid mount point"
+	fi
+
+	if [ $free_space -ge $required_space ]; then
+		return 1;
+	else
+		return 0;
+	fi
+}
-- 
1.8.2.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
