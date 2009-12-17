Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NL9Xh-0008Ia-00
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 06:08:53 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NL9XY-00062H-W2
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 06:08:52 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Dec 2009 15:08:30 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 17 Dec 2009 15:08:30 +0900
Message-ID: <002701ca7edf$5b1e2730$115a7590$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] "BindMounts" test failure
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

I ran "runltp" with "ltp-2009-12-16" cvs.
And I found the following failure in "BindMounts" testcase:

------------
sh: /opt/ltp/testscripts/test_fs_bind.sh: Permission denied
------------

When I added execution permission and tested this testcase, the 
following errors occurred.

------------
ls: /opt/ltp/testcases/kernel/fs/fs_bind/move/test*: No such file or
directory
ls: /opt/ltp/testcases/kernel/fs/fs_bind/bind/test*: No such file or
directory
ls: /opt/ltp/testcases/kernel/fs/fs_bind/rbind/test*: No such file or
directory
ls: /opt/ltp/testcases/kernel/fs/fs_bind/regression/test*: No such file or
directory
------------

This error is caused by following:
 (1) Execution files haven't permissions.
 (2) "${LTPROOT}" directory isn't the current directory in which
     "make install" executed. 
     By default, "${LTPROOT}" directory is "/opt/ltp".
 (3) ".../ltp-2009-12-16/testcases/kernel/fs/fs_bind/" directory does exist,
     but "/opt/ltp/testcases/kernel/fs/fs_bind/" directory doesn't exist.
      (I want to suggest using "/opt/ltp/testcases/bin/fs_bind/"
      instead of "/opt/ltp/testcases/kernel/fs/fs_bind/".)

Then, I think that it requires following three modifications to run
"BindMounts" test exactly:

 (1) Add the execution permissions to "${LTPROOT}/testscripts" directory
     when installation.
 (2) Deploy following four directories under the "${LTPROOT}/testcases/bin"
     directory when installation.
     "./fs_bind/move/"
     "./fs_bind/bind/"
     "./fs_bind/rbind/"
     "./fs_bind/regression/"
 (3) Apply the following patch:
============
--- test_fs_bind.sh	2008-06-29 04:30:19.000000000 +0900
+++ test_fs_bind.sh.new	2009-12-17 11:32:27.000000000 +0900
@@ -60,7 +60,7 @@
 		LTPROOT="${PWD}"
 	fi
 	
-	FS_BIND_ROOT="${LTPROOT}/testcases/kernel/fs/fs_bind"
+	FS_BIND_ROOT="${LTPROOT}/testcases/bin/fs_bind"
 
 	total=0 # total number of tests
 	for dir in "${test_dirs[@]}" ; do
============


Regards--


-Tomonori Mitani



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
