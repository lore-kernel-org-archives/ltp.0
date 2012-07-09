Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SoAjS-0003f7-J8
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 09:58:18 +0000
Received: from mail-gh0-f175.google.com ([209.85.160.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SoAjN-0007TH-5w
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 09:58:18 +0000
Received: by ghbz2 with SMTP id z2so10048011ghb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jul 2012 02:58:07 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon,  9 Jul 2012 17:51:53 +0800
Message-Id: <1341827513-21908-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
References: <1341827513-21908-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH 2/2] mm/lib: increase sleep time in ksm scanning
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


for some systems under pressure, we've observed that sleeping 5 seconds
is not sufficient for completing ksm scanning, to fix this, we should
give ksmd more time to scan the mergable pages by increasing sleeping
time to 10s.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/lib/mem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0002-mm-lib-increase-sleep-time-in-ksm-scanning.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-mm-lib-increase-sleep-time-in-ksm-scanning.patch"

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 6283f25..bb56e36 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -154,7 +154,7 @@ static void _wait_ksmd_done(void)
 	int changing = 1, count = 0;
 
 	while (changing) {
-		sleep(5);
+		sleep(10);
 		count++;
 
 		read_file(PATH_KSM "pages_shared", buf);

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



