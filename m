Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shanwei@cn.fujitsu.com>) id 1MkXK9-0006HU-Ds
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 06:03:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MkXK4-0002yK-3a
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 06:03:33 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 3A4BD17011A
	for <ltp-list@lists.sourceforge.net>;
	Mon,  7 Sep 2009 14:03:17 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id n8763BaM006189
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 14:03:11 +0800
Message-ID: <4AA4A299.1020105@cn.fujitsu.com>
Date: Mon, 07 Sep 2009 14:05:13 +0800
From: Shan Wei <shanwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] controller: fix the bug of missing compilation for
 controller cases
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
To: ltp-list@lists.sourceforge.net
Cc: Shan Wei <shanwei@cn.fujitsu.com>, =?UTF-8?B?57yqIOWLsA==?= <miaox@cn.fujitsu.com>

When doing "./configure && make", I found the controller cases couldn't be compiled.

Because the config.mk file included into testcases/kernel/Makefile lost the definition
of LTP_CHECK_CGROUPSTATS_HEADER, so ltp never enters the controller directory to do "make".

And config.mk file is created by config.mk.in file in fact. In config.mk.in,
LTP_CHECK_CGROUPSTATS_HEADER is lost, it leads to the wrong config.mk.
Add LTP_CHECK_CGROUPSTATS_HEADER in config.mk.in to fix the problem.


Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
Signed-off-by: Shan Wei <shanwei@cn.fujitsu.com>
---
 config.mk.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/config.mk.in b/config.mk.in
index 0fcb80a..64e3847 100644
--- a/config.mk.in
+++ b/config.mk.in
@@ -9,3 +9,5 @@ LDFLAGS = @LDFLAGS@
 AIO_LIBS = @AIO_LIBS@
 SELINUX_LIBS = @SELINUX_LIBS@
 CRYPTO_LIB = @CRYPTO_LIB@
+
+LTP_CHECK_CGROUPSTATS_HEADER = @LTP_CHECK_CGROUPSTATS_HEADER@
-- 
1.5.4.rc3







------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
