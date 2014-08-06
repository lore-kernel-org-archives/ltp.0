Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XEvUS-0006No-Qd
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 07:18:28 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XEvUR-0005Xy-OJ
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 07:18:28 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s767IH8C018722
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Aug 2014 15:18:17 +0800
Message-ID: <1407309452.2223.13.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 6 Aug 2014 15:17:32 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH] securebits/check_keepcaps.c: Add comments about
 cap_get_flag may return -1
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
To: ltp-list <ltp-list@lists.sourceforge.net>

In RHEL7.0(3.10.0) the value of CAP_LAST_CAP in linux/capability.h is 36, it is
greater than in the capability.h which is used to create
libcap.so(libcap-2.22-8) and that value is 34. Then cap_get_flag returns -1, and
errno is set to EINVAL. Add comments to make this clear.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/securebits/check_keepcaps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/security/securebits/check_keepcaps.c b/testcases/kernel/security/securebits/check_keepcaps.c
index 83e463e..a602fb5 100644
--- a/testcases/kernel/security/securebits/check_keepcaps.c
+++ b/testcases/kernel/security/securebits/check_keepcaps.c
@@ -38,6 +38,16 @@ static int eff_caps_empty(cap_t c)
 
 	for (i = 0; i < CAP_LAST_CAP; i++) {
 		ret = cap_get_flag(c, i, CAP_PERMITTED, &v);
+		/*
+		 * If the value of CAP_LAST_CAP in linux/capability.h is greater
+		 * than the value in the capability.h which is used to create
+		 * libcap.so. Then cap_get_flag returns -1, and errno is set to
+		 * EINVAL.
+		 */
+		if (ret == -1) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				"Not expected. Please check arguments.");
+		}
 		if (ret || v)
 			empty = 0;
 	}
-- 
1.9.3




------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
