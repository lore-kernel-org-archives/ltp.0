Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MvwQT-0003xp-3g
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 17:05:13 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MvwQN-0002vF-4a
	for ltp-list@lists.sourceforge.net; Thu, 08 Oct 2009 17:05:13 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n98GsL5G024963
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Oct 2009 10:54:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n98H4dQL066730
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Oct 2009 11:04:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n98H4cE3013366
	for <ltp-list@lists.sourceforge.net>; Thu, 8 Oct 2009 11:04:39 -0600
Date: Thu, 8 Oct 2009 11:59:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20091008165929.GA27576@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/1] p9auth: fix a bug in the p9auth setup script
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
To: Subrata Modak1 <subrata.modak@in.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

If by chance /dev/caphash existed but /dev/capuse did not, then
the checkp9auth.sh script would use $maj without setting it.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/p9auth/checkp9auth.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/testcases/kernel/security/p9auth/checkp9auth.sh
index 4365427..4a5a7d4 100755
--- a/testcases/kernel/security/p9auth/checkp9auth.sh
+++ b/testcases/kernel/security/p9auth/checkp9auth.sh
@@ -47,7 +47,6 @@ if [ $? -ne 0 ]; then
 fi
 
 majfile=/sys/module/p9auth/parameters/cap_major
-minfile=/sys/module/p9auth/parameters/cap_minor
 if [ ! -f "$majfile" ]; then
 	if [ $yesno -eq 1 ]; then echo
 		echo "no"
@@ -56,16 +55,15 @@ if [ ! -f "$majfile" ]; then
 	fi
 	exit 1
 fi
+maj=`cat $majfile`
 
 if [ ! -c "/dev/caphash" ]; then
 	rm -f /dev/caphash
-	maj=`cat $majfile`
 	mknod /dev/caphash c $maj 0
 fi
 
 if [ ! -c "/dev/capuse" ]; then
 	rm -f /dev/capuse
-	min=`cat $minfile`
 	mknod /dev/capuse c $maj 1
 fi
 chmod ugo+w /dev/capuse
-- 
1.6.3.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
