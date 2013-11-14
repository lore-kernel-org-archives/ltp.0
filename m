Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VgqZ9-0001Y6-TQ
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 06:38:11 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VgqZ8-0000WS-1r
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 06:38:11 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAE6c3BD001070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 06:38:04 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAE6c3xF001166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 06:38:03 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAE6c3dJ001158
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 06:38:03 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Nov 2013 10:37:56 +0400
Message-Id: <1384411077-26013-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20131113175008.GE12406@rei.Home>
References: <20131113175008.GE12406@rei.Home>
Subject: [LTP] [PATCH V3 1/2] tst_res: added ETIME, ETIMEDOUT errno values
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_res.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index f73022b..698b12c 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -255,6 +255,8 @@ static const char *strerrnodef(int err)
 		    PAIR(ENOSYS)
 		    PAIR(ENOTEMPTY)
 		    PAIR(ELOOP)
+		    PAIR(ETIMEDOUT)
+		    PAIR(ETIME)
 	};
 	return pair_lookup(errno_pairs, err);
 }
-- 
1.7.1


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
