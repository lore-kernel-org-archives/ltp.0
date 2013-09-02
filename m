Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VGV6d-0003su-PT
	for ltp-list@lists.sourceforge.net; Mon, 02 Sep 2013 14:27:51 +0000
Date: Mon, 2 Sep 2013 16:27:54 +0200
From: chrubis@suse.cz
Message-ID: <20130902142754.GA26252@rei>
References: <20130711110014.GB6142@rei.suse.cz> <20130828115601.GA4804@rei>
	<201308281234.41447.vapier@gentoo.org>
	<201308281237.03104.vapier@gentoo.org> <20130902122315.GC3269@rei>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20130902122315.GC3269@rei>
Subject: Re: [LTP] RFC add _FORTIFY_SOURCE to default LTP CFLAGS
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > you could probably turn that AH_VERBATIM into a compile test and then add it 
> > to CPPFLAGS based on the result.  that would probably work in most cases.
> 
> So back to the beginning...

What about this patch?
(it's tested and works)

-- 
Cyril Hrubis
chrubis@suse.cz

--LZvS9be/3tNcYl/X
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline;
	filename="0001-configure-Add-_FORTIFY_SOURCE-2.patch"

From 9d69dc34b6f08e742d79a30b4253371836de7367 Mon Sep 17 00:00:00 2001
From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Sep 2013 16:13:16 +0200
Subject: [PATCH] configure: Add _FORTIFY_SOURCE=2

Add -D_FORTIFY_SOURCE=2 into CPPFLAGS if:

o it's not allready set in system headers
o optimalization is enabled

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac             |  2 +-
 m4/ltp-fortify_source.m4 | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 m4/ltp-fortify_source.m4

diff --git a/configure.ac b/configure.ac
index f0fc6b0..81f92ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,7 +144,7 @@ else
 fi
 
 # END testsuites knobs
-
+LTP_CHECK_FORTIFY_SOURCE
 LTP_CHECK_MKDTEMP
 LTP_CHECK_CAPABILITY_SUPPORT
 LTP_CHECK_CRYPTO
diff --git a/m4/ltp-fortify_source.m4 b/m4/ltp-fortify_source.m4
new file mode 100644
index 0000000..ffb22b4
--- /dev/null
+++ b/m4/ltp-fortify_source.m4
@@ -0,0 +1,39 @@
+dnl
+dnl Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software
+dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_FORTIFY_SOURCE
+dnl ------------------------
+dnl
+AC_DEFUN([LTP_CHECK_FORTIFY_SOURCE],[dnl
+	AC_MSG_CHECKING(whether to define _FORTIFY_SOURCE=2)
+	AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+#include <stdio.h>
+
+int main(void)
+{
+#if !defined _FORTIFY_SOURCE && defined __OPTIMIZE__ && __OPTIMIZE__
+	return 0;
+#else
+# error Compiling without optimalizations
+#endif
+}
+])],[CPPFLAGS="$CPPFLAGS -D_FORTIFY_SOURCE=2"
+AC_MSG_RESULT(yes)],
+[AC_MSG_RESULT(no)])
+])
-- 
1.8.1.5


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--LZvS9be/3tNcYl/X--

