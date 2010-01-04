Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NRqXx-0006R8-Eq
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 17:16:49 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRqXv-0004y4-2p
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 17:16:49 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o04HDgSZ027105
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 12:13:42 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o04HGepQ105880
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 12:16:40 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o04HGeWc004701
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 15:16:40 -0200
Received: from sergelap.hallyn.com (sig-9-77-138-139.mts.ibm.com
	[9.77.138.139])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o04HGdgb004687
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 15:16:39 -0200
Date: Mon, 4 Jan 2010 11:16:43 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100104171643.GA545@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/1] say FAIL not PASS when we failed
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
To: LTP list <ltp-list@lists.sourceforge.net>

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/p9auth/p9priv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/kernel/security/p9auth/p9priv.sh
index ad2eead..c1a14d0 100755
--- a/testcases/kernel/security/p9auth/p9priv.sh
+++ b/testcases/kernel/security/p9auth/p9priv.sh
@@ -101,7 +101,7 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
 touch $LTPTMP/childgo
 while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
 if [ -f $LTPTMP/d/childpass ]; then
-	echo "PASS: child could setuid from wrong source uid"
+	echo "FAIL: child could setuid from wrong source uid"
 	exit 1
 fi
 echo "PASS: child couldn't setuid from wrong source uid"
-- 
1.6.1.1


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
