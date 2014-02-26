Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WIaEn-0001jn-Cb
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:09 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WIaEm-0003fg-Hu
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:09 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1Q8r2SL018778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:02 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s1Q8r1he022290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:02 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8r1WW011555
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:01 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 26 Feb 2014 12:52:44 +0400
Message-Id: <1393404766-18032-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [RFC PATCH 4/6] module.mk: remove module_name.ko.unsigned
	files after build
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
Cc: vasily.isaenko@oracle.com

I suppose we don't need to keep module_name.ko.unsigned files as of now.

If we do, we can add such files to correspond .gitignore files and update
CLEAN_TARGETS.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/mk/module.mk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/mk/module.mk b/include/mk/module.mk
index b903e8f..84bd49a 100644
--- a/include/mk/module.mk
+++ b/include/mk/module.mk
@@ -43,4 +43,4 @@ endif
 # missing or module build failure).
 %.ko: %.c
 	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
-	rm -rf *.mod.c *.o modules.order .tmp* .*.ko .*.cmd Module.symvers
+	rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
-- 
1.7.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
