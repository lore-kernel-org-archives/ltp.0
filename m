Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S2ghy-0000yh-NN
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 10:24:30 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S2ght-0001pe-5k
	for ltp-list@lists.sourceforge.net; Wed, 29 Feb 2012 10:24:30 +0000
Received: by daln34 with SMTP id n34so7665940dal.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Feb 2012 02:24:19 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed, 29 Feb 2012 18:23:20 +0800
Message-Id: <1330511000-24198-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH] lib: fix -I option to accept larger number
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


previous discussion on this issue:

    http://marc.info/?l=ltp-list&m=129585256906986&w=2

This patch uses uint64_t to make -I option accept larger numbers to
get rid of overflow.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 lib/parse_opts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-lib-fix-I-option-to-accept-larger-number.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-lib-fix-I-option-to-accept-larger-number.patch"

diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index fd49cfa..2159d22 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -708,7 +708,7 @@ static int get_current_time()
 int usc_test_looping(int counter)
 {
     static int first_time = 1;
-    static int stop_time = 0;	/* stop time in rtc or usecs */
+    static uint64_t stop_time;	/* stop time in rtc or usecs */
     static int delay;		/* delay in clocks or usecs  */
     int hertz = 0;		/* clocks per second or usecs per second */
     int ct, end;		/* current time, end delay time */
@@ -733,7 +733,7 @@ int usc_test_looping(int counter)
 
 	if (STD_LOOP_DURATION) {
 	    ct=get_current_time();
-	    stop_time = (int)((float)hertz * STD_LOOP_DURATION) + ct;
+	    stop_time = (uint64_t)((float)hertz * STD_LOOP_DURATION) + ct;
 	}
 
 	/*

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



