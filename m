Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1OZJbw-0002Td-LK
	for ltp-list@lists.sourceforge.net; Thu, 15 Jul 2010 08:16:04 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZJbr-0000By-SN
	for ltp-list@lists.sourceforge.net; Thu, 15 Jul 2010 08:16:04 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx01.colomx.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
	o6F8FsNI025137
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Jul 2010 04:15:54 -0400
Date: Thu, 15 Jul 2010 04:15:54 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1258968798.329701279181754171.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <113519118.329641279181694037.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14362_1125756524.1279181754170"
Subject: [LTP] [PATCH] fix false alarm in pselect01
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

------=_Part_14362_1125756524.1279181754170
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi all,
   
   In my recent tests, not all desired time is equal to exact execution time, 
   sometimes it is +/-1s, and in a few times it becomes +/-2s. In most cases,
   +/-2s is still a valid value between exact execute time and desired time.
   
   Signed-off-by: Caspar Zhang <czhang@redhat.com>

--- a/testcases/kernel/syscalls/pselect/pselect01.c     2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c     2010-07-15 16:03:40.969426078 +0800
@@ -109,7 +109,8 @@
                            NULL);
                end = time(&t);
 
-               if (((end - start) == total_sec) || ((end - start) == total_sec + 1))
+               /* Is it still valid in range -2~2s? */
+               if ((end - start - total_sec <= 2) && (end - start - total_sec >= -2))
                        tst_resm(TPASS, "Sleep time was correct");
                else
                        tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_14362_1125756524.1279181754170
Content-Type: text/x-patch; name=syscalls-pselect01-fix-false-alarm.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-pselect01-fix-false-alarm.patch

Hi all,
   
   In my recent tests, not all desired time is equal to exact execution time, 
   sometimes it is +/-1s, and in a few times it becomes +/-2s. In most cases,
   +/-2s is still a valid value between exact execute time and desired time.
   
   Signed-off-by: Caspar Zhang <czhang@redhat.com>

--- a/testcases/kernel/syscalls/pselect/pselect01.c	2010-04-01 14:23:10.000000000 +0800
+++ b/testcases/kernel/syscalls/pselect/pselect01.c	2010-07-15 16:03:40.969426078 +0800
@@ -109,7 +109,8 @@
 			    NULL);
 		end = time(&t);
 
-		if (((end - start) == total_sec) || ((end - start) == total_sec + 1))
+		/* Is it still valid in range -2~2s? */
+		if ((end - start - total_sec <= 2) && (end - start - total_sec >= -2))
 			tst_resm(TPASS, "Sleep time was correct");
 		else
 			tst_resm(TFAIL, "Sleep time was incorrect:%d != %d",

------=_Part_14362_1125756524.1279181754170
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_14362_1125756524.1279181754170
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_14362_1125756524.1279181754170--

