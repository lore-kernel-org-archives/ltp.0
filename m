Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri2S0-00026d-KT
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:22:40 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri2Rv-0005wK-5k
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:22:40 +0000
Message-ID: <4F02E4F4.9090707@imgtec.com>
Date: Tue, 3 Jan 2012 11:22:28 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030604070503060809050800"
Subject: [LTP] [PATCH 13/21] Build system: Always append CFLAGS at the end
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
To: ltp-list@lists.sourceforge.net

--------------030604070503060809050800
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------030604070503060809050800
Content-Type: text/plain;
	name="0013-Build-system-Always-append-CFLAGS-at-the-end.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0013-Build-system-Always-append-CFLAGS-at-the-end.patch"

From 5800c95986bb1d63ef0af9dda4eb87c771bcccf3 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 17:22:48 +0000
Subject: [PATCH 13/21] Build system: Always append CFLAGS at the end

The build system sets -g -O2 -fno-strict-aliasing -pipe by default. We
append the enviromental CFLAGS at the end to allow the user to override
the default CFLAGS

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 include/mk/config.mk.in |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index b835c86..6148b2c 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -72,8 +72,11 @@ WCFLAGS			?= -Wall
 WCXXFLAGS		?= $(WCFLAGS)
 
 LDFLAGS			+= $(WLDFLAGS)
-CFLAGS			+= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS)
-CXXFLAGS		+= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS)
+AMCFLAGS		= $(DEBUG_CFLAGS) $(OPT_CFLAGS) $(WCFLAGS) $(CFLAGS)
+AMCXXFLAGS		= $(DEBUG_CXXFLAGS) $(OPT_CXXFLAGS) $(WCXXFLAGS) $(CXXFLAGS)
+
+CFLAGS			:= $(AMCFLAGS)
+CXXFLAGS		:= $(AMCXXFLAGS)
 
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
-- 
1.7.1


--------------030604070503060809050800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------030604070503060809050800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030604070503060809050800--


