Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VdGL1-0001sF-2q
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 09:20:48 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VdGKz-0005c4-RY
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 09:20:46 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA49Kcn0028916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:20:39 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA49Kc43018475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:20:38 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA49Kcl7008621
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Nov 2013 09:20:38 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Mon,  4 Nov 2013 17:20:29 +0800
Message-Id: <1383556829-1464-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP] [PATCH] networktests.sh: add ${LTPROOT}/bin into $PATH
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

Some tests need `gethost' (e.g. sendfile01), which lives in ${LTPROOT}/bin,
which is not in $PATH of networktests.sh.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testscripts/networktests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testscripts/networktests.sh b/testscripts/networktests.sh
index b136749..9465356 100755
--- a/testscripts/networktests.sh
+++ b/testscripts/networktests.sh
@@ -110,7 +110,7 @@ fi
 
 cd $TMPDIR
 
-export PATH="${PATH}:${LTPROOT}/testcases/bin"
+export PATH="${PATH}:${LTPROOT}/bin:${LTPROOT}/testcases/bin"
 
 if [ ${VERBOSE} = "yes" ]; then
     echo "Network parameters:"
-- 
1.8.4.2


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
