Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3t-00026g-T0
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:21 +0000
Received: from mail-lb0-f174.google.com ([209.85.217.174])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3s-0007y0-UN
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:21 +0000
Received: by mail-lb0-f174.google.com with SMTP id w20so2387421lbh.19
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:14 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:57 +0200
Message-Id: <1375729379-16469-5-git-send-email-anders.roxell@linaro.org>
In-Reply-To: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
References: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH 4/6] realtime tests: created Makefiles for
	profiles/scripts
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
Cc: patches@linaro.org

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/realtime/profiles/Makefile |   26 ++++++++++++++++++++++++++
 testcases/realtime/scripts/Makefile  |   26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 testcases/realtime/profiles/Makefile
 create mode 100644 testcases/realtime/scripts/Makefile

diff --git a/testcases/realtime/profiles/Makefile b/testcases/realtime/profiles/Makefile
new file mode 100644
index 0000000..c231f31
--- /dev/null
+++ b/testcases/realtime/profiles/Makefile
@@ -0,0 +1,26 @@
+#
+#    realtime/profiles test suite Makefile.
+#
+#    Copyright 2013 Linaro Limited
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../config.mk
+INSTALL_TARGETS		:= default
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/realtime/scripts/Makefile b/testcases/realtime/scripts/Makefile
new file mode 100644
index 0000000..28bf88e
--- /dev/null
+++ b/testcases/realtime/scripts/Makefile
@@ -0,0 +1,26 @@
+#
+#    realtime/scripts test suite Makefile.
+#
+#    Copyright 2013 Linaro Limited
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../config.mk
+INSTALL_TARGETS		:= run_c_files.sh setenv.sh __init__.py parser.py
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.10.4


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
