Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NRb39-00045C-HF
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 00:43:59 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRb38-0002ZK-O0
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 00:43:59 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o040epTL012423
	for <ltp-list@lists.sourceforge.net>; Sun, 3 Jan 2010 17:40:51 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o040hqpZ171002
	for <ltp-list@lists.sourceforge.net>; Sun, 3 Jan 2010 17:43:52 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o040hqvm029647
	for <ltp-list@lists.sourceforge.net>; Sun, 3 Jan 2010 17:43:52 -0700
Received: from sergelap.hallyn.com (sig-9-77-140-243.mts.ibm.com
	[9.77.140.243])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o040hqmE029640
	for <ltp-list@lists.sourceforge.net>; Sun, 3 Jan 2010 17:43:52 -0700
Date: Sun, 3 Jan 2010 18:43:55 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100104004355.GA760@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH ltp] p9auth: add missing checkp9auth.sh script
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

This was in my original patch submission but somehow didn't make its way into
the ltp tree.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/p9auth/checkp9auth.sh |   70 +++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/security/p9auth/checkp9auth.sh

diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/testcases/kernel/security/p9auth/checkp9auth.sh
new file mode 100644
index 0000000..f917ce6
--- /dev/null
+++ b/testcases/kernel/security/p9auth/checkp9auth.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+
+yesno=0
+if [ "$1" = "yesno" ]; then
+	yesno=1
+fi
+
+# check for openssl
+rm -f /tmp/ab
+echo ab > /tmp/ab
+openssl sha1 -hmac "ab" /tmp/ab > /dev/null
+ret=$?
+if [ $ret -ne 0 ]; then
+	if [ $yesno -eq 1 ]; then echo
+		"no"
+	else
+		echo "openssl not installed, skipping p9auth tests."
+	fi
+	exit 1
+fi
+
+majfile=/sys/module/p9auth/parameters/cap_major
+minfile=/sys/module/p9auth/parameters/cap_minor
+if [ ! -f "$majfile" ]; then
+	if [ $yesno -eq 1 ]; then echo
+		"no"
+	else
+		echo "p9auth not detected.  Skipping p9auth tests."
+	fi
+	exit 1
+fi
+
+if [ ! -c "/dev/caphash" ]; then
+	rm -f /dev/caphash
+	maj=`cat $majfile`
+	mknod /dev/caphash c $maj 0
+fi
+
+if [ ! -c "/dev/capuse" ]; then
+	rm -f /dev/capuse
+	min=`cat $minfile`
+	mknod /dev/capuse c $maj 1
+fi
+chmod ugo+w /dev/capuse
+
+if [ $yesno -eq 1 ]; then
+	echo "yes"
+else
+	echo "p9auth ready for testing"
+fi
+exit 0
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
