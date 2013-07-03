Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.sun@oracle.com>) id 1UuDkS-00027a-CI
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 03:28:52 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UuDkO-0003bA-Vo
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 03:28:52 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r633SgU6009488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 03:28:43 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r633Sfc0017893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 03:28:42 GMT
Received: from abhmt116.oracle.com (abhmt116.oracle.com [141.146.116.68])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r633SfDU017882
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Jul 2013 03:28:41 GMT
Message-ID: <51D39AC5.7030700@oracle.com>
Date: Wed, 03 Jul 2013 11:30:13 +0800
From: Eko <hong.sun@oracle.com>
MIME-Version: 1.0
References: <mailman.81986.1372818525.14365.ltp-list@lists.sourceforge.net>
In-Reply-To: <mailman.81986.1372818525.14365.ltp-list@lists.sourceforge.net>
Subject: Re: [LTP] [ltp-full-20130503] runltp cleanup() can't remove ${TMP}
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

--- runltp.bak  2013-07-03 10:18:28.375259716 +0800
+++ runltp      2013-07-03 10:32:22.958314831 +0800
@@ -1014,6 +1014,11 @@

  cleanup()
  {
+    for file in ${TMP}/*
+    do
+        umount $file > /dev/null 2>&1
+    done
+
      [ "$LOOP_DEV" ] && losetup -d $LOOP_DEV
      [ -e "${TEMP}/test.img" ] && rm -f ${TEMP}/test.img
      rm -rf ${TMP}


-- 
Best Regards,
Eko
--


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
