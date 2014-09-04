Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XPTQW-0006cz-Uw
	for ltp-list@lists.sourceforge.net; Thu, 04 Sep 2014 09:34:01 +0000
Date: Thu, 4 Sep 2014 11:33:48 +0200
From: chrubis@suse.cz
Message-ID: <20140904093348.GA15717@rei.suse.cz>
References: <20140901183433.GT30210@waldemar-brodkorb.de>
	<20140902082745.GA6002@rei.suse.cz>
	<20140903212151.GC19440@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20140903212151.GC19440@waldemar-brodkorb.de>
Subject: Re: [LTP] issue #13
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
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: ltp-list@lists.sourceforge.net


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> > Does the trick suggested by Mike (vapier) works for you?
> > 
> > I.e. changing the input of the exp10() function to (float)argc so that
> > the compiler cannot assume that the vhole expression is a constant?
> 
> I would try it, but I have issues using autoreconf -vif in the top
> level sourcedir to recreate configure and co. after I made the
> change in the exp10 m4 file. I see no bootstrap script either.
> What is the correct command to regenerate configure in LTP?

Argh, you are right, using autoreconf the macros from m4 directory are
not used for the realtime testsuite. I will have a look at that later.

For now try doing 'make distclean' and 'make autotools' which seems to
work fine for me.


Also I've found that changing the exp10() parameter not to be constant
breaks the check on systems that does have it, we have to add -lm to
LIBS too. Can you try attached patch to see if it works correctly for
you?

-- 
Cyril Hrubis
chrubis@suse.cz

--SLDf9lqlvOQaIe6s
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-realtime-Fix-exp10-check.patch"

From 03bf456cb5b65ff7cfabfab3758ca8f3c6816556 Mon Sep 17 00:00:00 2001
From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Sep 2014 11:28:55 +0200
Subject: [PATCH] realtime: Fix exp10 check.

The parameter to exp10() function was constant and because of that it
was substituted by a constant at the compile time.

This patch passes volatile float as the parameter and also adds -lm to
the LIBS which is needed to link the test.

Reported-by: Waldemar Brodkorb <wbx@openadk.org>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/realtime/m4/ltp-exp10.m4 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/m4/ltp-exp10.m4 b/testcases/realtime/m4/ltp-exp10.m4
index 4fe7091..84a3d9b 100644
--- a/testcases/realtime/m4/ltp-exp10.m4
+++ b/testcases/realtime/m4/ltp-exp10.m4
@@ -24,10 +24,14 @@ AC_DEFUN([LTP_CHECK_EXP10],[
 AH_TEMPLATE(HAVE_EXP10,
 [Define to 1 if you have 'exp10' function.])
 AC_MSG_CHECKING([for exp10])
+backup_ldlibs="$LIBS"
+LIBS+=" -lm"
 AC_TRY_LINK([#define _GNU_SOURCE
              #include <math.h>],
             [
-             exp10(0.00);
+	     volatile float val;
+             exp10(val);
             ],
              AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
+LIBS="$backup_ldlibs"
 ])
-- 
1.8.5.5


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--SLDf9lqlvOQaIe6s--

