Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1Z2XSZ-000390-Tl
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 04:17:51 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2XSW-0008C9-Vc
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 04:17:51 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPP02MSRNXHFY70@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 13:17:41 +0900 (KST)
Date: Wed, 10 Jun 2015 04:17:41 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1573270359.793671433909861229.JavaMail.weblogic@epmlwas05c>
Subject: [LTP] Fwd:  [PATCH]: Correct printf format string
Reply-To: manjeet.p@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Please ignore the below patch as this is already incorporated into LTP.

Thanks

------- Original Message -------
Sender : Manjeet Pawar<manjeet.p@samsung.com> Senior Software Engineer (2)/SRI-Delhi-Platform S/W 1 Team/Samsung Electronics
Date : Jun 10, 2015 12:48 (GMT+09:00)
Title : [LTP] [PATCH]: Correct printf format string

From: Manjeet Pawar 
Date: Tue, 9 Jun 2015 19:15:52 +0530
Subject: [PATCH] testcases/kernel/fs/doio/growfiles.c: Correct printf format string

This patch correct the printf format string.

Signed-off-by: Akhilesh Kumar 
Signed-off-by: Manjeet Pawar 
---
testcases/kernel/fs/doio/growfiles.c |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index a656978..e3ab4b2 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -677,7 +677,7 @@ int main(int argc, char **argv)
exit(1);
}
Upanic_on_error++;
- printf("%s: Will call upanic after writes\n");
+ printf("%s%s: Will call upanic after writes\n", Progname, TagName);
#else
printf
    ("%s%s: --P is illegal option on non-cray system\n",
-- 
1.7.1
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
