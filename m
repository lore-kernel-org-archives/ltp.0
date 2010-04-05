Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NymEA-0001wE-9o
	for ltp-list@lists.sourceforge.net; Mon, 05 Apr 2010 13:20:30 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NymE8-0001iQ-2J
	for ltp-list@lists.sourceforge.net; Mon, 05 Apr 2010 13:20:30 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o35DAwBH025109
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Apr 2010 07:10:58 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o35DK6kY073752
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Apr 2010 07:20:08 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o35DK5IC005662
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Apr 2010 07:20:06 -0600
Date: Mon, 5 Apr 2010 08:20:04 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100405132004.GA32049@us.ibm.com>
References: <000001cad173$3c32b200$b4981600$@co.jp>
	<20100401083510.GD13796@linux.vnet.ibm.com>
	<000101cad17c$ee4946d0$cadbd470$@co.jp>
	<20100401093511.GA25290@linux.vnet.ibm.com>
	<000001cad18d$ea091c60$be1b5520$@co.jp>
	<20100401152647.GH22648@us.ibm.com>
	<000301cad20b$2269c230$673d4690$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000301cad20b$2269c230$673d4690$@co.jp>
Subject: Re: [LTP] cap_bounds_r.c build failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, Andrew Morgan <morgan@kernel.org>

Quoting Mitani (mitani@ryobi.co.jp):
> Hi,
> 
> 
> I tired to upgrade "libcap" from "libcap-1.0-20" to "libcap-2.11".
> My system is RHEL4.8 (x86) and kernel version is 2.6.9-89.ELsmp.

Oh, I'm sorry, I misunderstood from the first.  I thought you wanted
to test a modern kernel on an older distro.  So the real problem in
your original email wasn't that cap_bounds_r.c wouldn't compile, but
that it tried to compile.

Maybe the attached ltp patch will do a better job of not trying
to compile.  Though I'm not sure what is the best way to detect
both 64-bit caps in kernel and libcap2 userspace.

-serge

Date: Mon, 5 Apr 2010 08:17:46 -0500
Subject: [PATCH ltp] don't compile cap_bounds on older systems

Only define HAVE_LIBCAP for libcap2 and 64-bit caps.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 m4/ltp-cap.m4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index caa436f..6248ff3 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -27,7 +27,7 @@ AH_TEMPLATE(HAVE_LIBCAP,
 [Define to 1 if you have libcap-2 installed.])
 AC_CHECK_HEADERS(sys/capability.h,[
 	LTP_CAPABILITY_SUPPORT=yes
-	AC_CHECK_LIB(cap,cap_compare,[AC_DEFINE(HAVE_LIBCAP) CAP_LIBS="-lcap"], [CAP_LIBS=""])
+	AC_CHECK_DECL(VFS_CAP_REVISION_2,[AC_DEFINE(HAVE_LIBCAP) CAP_LIBS="-lcap"],[CAP_LIBS=""],[#include "linux/capability.h"])
 	AC_CHECK_PROG(HAVE_SETCAP,setcap,setcap,false)
 ])]
 AC_SUBST(CAP_LIBS)
-- 
1.6.3.3


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
