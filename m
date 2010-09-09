Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1OtaX7-0003BB-2K
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 06:22:53 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OtaX3-00084w-Ls
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 06:22:53 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o896MhKQ019038
	for <ltp-list@lists.sourceforge.net>;
	Wed, 8 Sep 2010 23:22:43 -0700 (PDT)
Message-ID: <4C887D32.60608@windriver.com>
Date: Thu, 09 Sep 2010 14:22:42 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010804000607000505080700"
Subject: [LTP] [PATCH]mktemp command in runltp version issue
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010804000607000505080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In runltp:

if [ -n "$DEVICE" ]; then
       mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`

--tmpdir is a invalid option for mktemp version 1.5, which is used
 widely. The valid option to specify a directory for version 1.5 is
 -p directory.

Regards,

Lina Zhao


--------------010804000607000505080700
Content-Type: text/x-diff;
 name="0001-mktemp-version-issue-in-runltp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-mktemp-version-issue-in-runltp.patch"

From 5e5ff93aa2a9d7ae7325b2813092efdb7d19a043 Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Thu, 9 Sep 2010 14:12:14 +0800
Subject: [PATCH] mktemp version issue in runltp

--tmpdir is a invalid option for mktemp version 1.5, which is used
widely. The valid option to specify a directory for version 1.5 is
 -p directory.

Signed-off-by: Lina Zhao < lina.zhao@windriver.com >
---
 runltp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runltp b/runltp
index b385984..ddfd666 100755
--- a/runltp
+++ b/runltp
@@ -716,7 +716,7 @@ main()
     fi
 
     if [ -n "$DEVICE" ]; then
-        mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`
+        mnt_pnt=`mktemp -d -p ${TMP} mnt_pnt.XXXXXX`
         if [ -n "$DEVICE_FS_TYPE" ]; then
             mount -t $DEVICE_FS_TYPE $DEVICE $mnt_pnt
         else
-- 
1.6.3.1


--------------010804000607000505080700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--------------010804000607000505080700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010804000607000505080700--

