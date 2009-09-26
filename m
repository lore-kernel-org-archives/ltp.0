Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1Mrg28-0005Xe-Qs
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:28 +0000
Received: from fg-out-1718.google.com ([72.14.220.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mrg20-0000xM-CE
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:28 +0000
Received: by fg-out-1718.google.com with SMTP id e21so474931fga.10
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 15:46:14 -0700 (PDT)
From: Andrew Vagin <avagin@gmail.com>
Date: Sun, 27 Sep 2009 02:46:02 +0400
Message-Id: <1254005162-27353-5-git-send-email-avagin@gmail.com>
In-Reply-To: <1254005162-27353-4-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
	<1254005162-27353-2-git-send-email-avagin@gmail.com>
	<1254005162-27353-3-git-send-email-avagin@gmail.com>
	<1254005162-27353-4-git-send-email-avagin@gmail.com>
Subject: [LTP] [PATCH 5/5] fsstress: renew flist if clean up test directory
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

flist contain all files created by fsstress. If test clean up direcory
on each interations that it should reinitilize flist.

Signed-off-by: Andrew Vagin <avagin@gmail.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index cf7ba76..736bd53 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -491,6 +491,12 @@ int main(int argc, char **argv)
 		{
 			sprintf(cmd,"rm -rf %s/*",dirname);
 			system(cmd);
+			for (i = 0; i < FT_nft; i++) {
+				flist[i].nslots = 0;
+				flist[i].nfiles = 0;
+				free(flist[i].fents);
+				flist[i].fents = NULL;
+			}
 		}
 		loopcntr++;
 	}
-- 
1.6.2.5


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
