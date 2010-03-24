Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NuQcg-0003zK-UI
	for ltp-list@lists.sourceforge.net; Wed, 24 Mar 2010 13:27:50 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NuQcf-0007jX-DZ
	for ltp-list@lists.sourceforge.net; Wed, 24 Mar 2010 13:27:50 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2ODL7D8032592
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 07:21:07 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o2ODRgp2250506
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 07:27:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2ODRfIv003709
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Mar 2010 07:27:41 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Wed, 24 Mar 2010 19:06:45 +0530
Message-Id: <20100324133645.23583.48891.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Fix fallocate() build issue for EXT4 Online
	Defragmentation Test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5251094633875162891=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

--===============5251094633875162891==

Earlier Subject: Re: [LTP] ext4/e4defrag.c testcases compilation error,

Hi Garret/Miao,

On PPC systems, fallocate() seems to be already defined at /usr/include/bits/fcntl.h,
so building EXT4 test cases on PPC64 machines will create build problems even if the
pre-requisite packages:

e2fsprogs*
e2fsprogs-libs*
e2fsprogs-devel*

are present. So, this patch adds an extra check. Please let me know your thoughts.

Errors bound to occur:
[
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/root/subrata/ltp/ltp-dev/testcases/kernel/include -I../../../../../include -I../../../../../include   -L../../../../../lib  e4defrag.c   -lltp -lm -o e4defrag
e4defrag.c:388: error: conflicting types for ���fallocate���
/usr/include/bits/fcntl.h:240: note: previous declaration of ���fallocate��� was here
make[1]: *** [e4defrag] Error 1
]

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- ltp-dev/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c	2010-03-15 19:32:12.000000000 +0530
+++ ltp-dev.modified/testcases/kernel/fs/ext4-new-features/ext4-online-defrag/e4defrag.c	2010-03-24 18:09:14.336793513 +0530
@@ -383,10 +383,13 @@ int sync_file_range(int fd, loff_t offse
  * @offset:		file offset.
  * @len:		file size.
  */
+
+#ifndef __NR_fallocate
 int fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
 	return syscall(__NR_fallocate, fd, mode, offset, len);
 }
+#endif
 
 /*
  * get_mount_point() -	Get device's mount point.

---
Regards--
Subrata Modak



--===============5251094633875162891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============5251094633875162891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5251094633875162891==--
