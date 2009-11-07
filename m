Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1N6Y7X-000838-1G
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:21:31 +0000
Received: from xenotime.net ([72.52.64.118])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N6Y7W-00064K-00
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:21:30 +0000
Message-ID: <4AF4B952.4090508@xenotime.net>
Date: Fri, 06 Nov 2009 16:03:30 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>	<87iqdn76jg.fsf@basil.nowhere.org>
	<364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
In-Reply-To: <364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
Subject: [LTP] [patch 1/2] small makefile corrections
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Andi Kleen <andi@firstfloor.org>


Correct filename and spello/typo.

---
 Makefile        |    2 +-
 README.mk-devel |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- ltp-full-20091031.orig/Makefile
+++ ltp-full-20091031/Makefile
@@ -32,7 +32,7 @@ include $(top_srcdir)/include/mk/automak
 
 # This variable is automatically changed from help to all once someone has
 # run configure, or the equivalent steps manually, as described in
-# README.mk-user.
+# README.mk-devel.
 ifeq ($(wildcard $(top_builddir)/include/config.h),)
 .DEFAULT_GOAL		:= help
 else
--- ltp-full-20091031.orig/README.mk-devel
+++ ltp-full-20091031/README.mk-devel
@@ -70,7 +70,7 @@ include $(top_srcdir)/include/mk/generic
 Make Rules and Make Variables
 ==============================
 
-When using make rules, avoid writing adhoc rules like:
+When using make rules, avoid writing ad hoc rules like:
 
 [prog]: [dependencies]
 	cc -I../../include $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS) \

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
