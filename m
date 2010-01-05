Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1NSIsu-00022Z-Cf
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 23:32:20 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSIsq-0000VG-H4
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 23:32:20 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o05NQBjU029595
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 18:26:11 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o05NW0SD1171696
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 18:32:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o05NW0uZ002366
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 21:32:00 -0200
Received: from d01ml096.pok.ibm.com (d01ml096.pok.ibm.com [9.63.10.19])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o05NW04t002362
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 21:32:00 -0200
In-Reply-To: <mailman.274940.1262712842.5825.ltp-list@lists.sourceforge.net>
References: <mailman.274940.1262712842.5825.ltp-list@lists.sourceforge.net>
Message-ID: <OFBE2FC11C.E215D8EA-ON852576A2.007E66E5-852576A2.008144FB@us.ibm.com>
From: Mark Ver <markver@us.ibm.com>
Date: Tue, 5 Jan 2010 18:31:58 -0500
MIME-Version: 1.0
Subject: [LTP] install instructions
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
To: ltp-list@lists.sourceforge.net

Hi,

Can we patch the install instructions with something like:
--

--- INSTALL.orig        2010-01-05 17:40:32.000000000 -0500
+++ INSTALL     2010-01-05 17:40:43.000000000 -0500
@@ -127,12 +127,19 @@
 3> ./configure
 4> make all
 5> make install
-6> ./runalltests.sh
+6> cd /opt/ltp
+7> ./runalltests.sh

-*NOTE: The LTP assumes the existence of the nobody, bin, and daemon users
and
+*NOTE:
+- The LTP assumes the existence of the nobody, bin, and daemon users and
 their groups.  If these IDs do not exist, certain tests will fail. The
users
 and groups IDs should be the same, i.e. if user "nobody" is 99, then it's
 group should also be "99". The names of the groups are irrelevant.
+- The execution directory where binaries are "installed" is now separate
from
+the build and source directories.  The default execution directory
is /opt/ltp
+and may be modified by setting a value for prefix, ex:
+    make prefix=/tmp/ltptest all
+    make prefix=/tmp/ltptest install


 Detailed Installation
--

Thanks,
- Mark Ver

office:  Building 710 / Room 2-RF-10
phone: (845) 435-7794  [tie 8 295-7794]


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
