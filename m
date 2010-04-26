Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1O6HwI-0007z5-Ih
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 06:37:06 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O6HwF-0006F7-Hy
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 06:37:06 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3Q5eQuC018332
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 11:10:26 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3Q6aqeK3411986
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 12:06:52 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3Q6aqE2029571
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 12:06:52 +0530
Message-ID: <4BD53483.9080603@in.ibm.com>
Date: Mon, 26 Apr 2010 12:06:51 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040208060403040800030709"
Subject: [LTP] PATCH : test_fs_bind testscript for busybox machines
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
To: risrajak@in.ibm.com, ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040208060403040800030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The test_fs_bind testscript hangs indefinitely when run on a machine 
where busybox applets are used.

The test hangs while trying to restore the mounts after a test run.


This happens because the "xargs" applet from busybox doesn't understand 
the --max-args=1 option. Thus, the mounts from the test are not removed 
and this goes on in a loop, indefinitely.

This could be avoided by using "-n" option which is supported by both 
the implementations of xargs.


Attached the patch here.

Thanks

Suzuki

--------------040208060403040800030709
Content-Type: text/plain;
 name="fix_fs_bind_tests_for_busybox_machines.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix_fs_bind_tests_for_busybox_machines.diff"


Signed-off-by: Suzuki K P <suzuki@in.ibm.com>

Index: ltp/testscripts/test_fs_bind.sh
===================================================================
--- ltp.orig/testscripts/test_fs_bind.sh	2009-12-22 03:28:25.000000000 +0000
+++ ltp/testscripts/test_fs_bind.sh	2010-04-26 05:50:41.000000000 +0000
@@ -238,7 +238,7 @@
 	# new mounts around and will never remove mounts outside the test
 	# directory
 	( while grep_proc_mounts ; do
-		grep_proc_mounts | awk '{print $2}' | xargs -r --max-args=1 umount -l
+		grep_proc_mounts | awk '{print $2}' | xargs -r -n 1 umount -l
 	done ) >& /dev/null
 	
 	# mount list and exit with 0

--------------040208060403040800030709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--------------040208060403040800030709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040208060403040800030709--

