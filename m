Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NaUsF-0003G1-5W
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 13:57:31 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NaUsC-00049c-IE
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 13:57:31 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41001272156p5f12bc94p4eba45d9df61fbc0@mail.gmail.com>
References: <1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<20100111210006.GA26554@us.ibm.com>
	<364299f41001120029x15b2e7adwe30d925717a1dc89@mail.gmail.com>
	<20100112153827.GB7975@us.ibm.com>
	<364299f41001150948u4df35c36g3d4b07b16af49f90@mail.gmail.com>
	<364299f41001260031h2529b9b0j1bbbacd9d3d85eae@mail.gmail.com>
	<1264516245.19890.22.camel@moss-pluto.epoch.ncsc.mil>
	<23804BFE-0FC7-45F8-939D-3729E39DB431@gmail.com>
	<1264619548.17372.27.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001271437k3f9bde57t64845d8d0054ba22@mail.gmail.com>
	<364299f41001272156p5f12bc94p4eba45d9df61fbc0@mail.gmail.com>
Date: Thu, 28 Jan 2010 09:02:27 -0500
Message-Id: <1264687347.6232.48.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Wed, 2010-01-27 at 21:56 -0800, Garrett Cooper wrote:
> On Wed, Jan 27, 2010 at 2:37 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > Ok. Send me a patch that does a readlink -f of the LTPPATH and set
> > your PATH to include $LTPROOT/testcases/bin, and you'll be good to go
> 
>     Nevermind. I just committed the change... please retest and
> hopefully all goes well for you this time around.

Looks good.  Patch below fixes two bugs in the selinux tests, noticed by
examining the selinux.outfile carefully for errors (No such file or
directory, Segmentation fault).  

Index: testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh,v
retrieving revision 1.10
diff -u -r1.10 selinux_file.sh
--- testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh	26 Jan 2010 07:05:02 -0000	1.10
+++ testcases/kernel/security/selinux-testsuite/tests/file/selinux_file.sh	28 Jan 2010 13:50:31 -0000
@@ -47,7 +47,8 @@
 	# 
 	# Change the context of the test executable
 	#
-	chcon -t fileop_exec_t selinux_wait_io 2>&1 > /dev/null
+	LTPBIN=${LTPBIN:-$LTPROOT/testcases/bin}
+	chcon -t fileop_exec_t $LTPBIN/selinux_wait_io 2>&1 > /dev/null
 
 	#
 	# Get the SID of the good file.
Index: testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shmat.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shmat.c,v
retrieving revision 1.4
diff -u -r1.4 selinux_shmat.c
--- testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shmat.c	13 Jan 2010 08:16:57 -0000	1.4
+++ testcases/kernel/security/selinux-testsuite/tests/shm/selinux_shmat.c	28 Jan 2010 13:50:31 -0000
@@ -40,7 +40,7 @@
 		return 1;
 
 	buf = shmat(id, 0, 0);
-	error = (*buf == -1) ? -1 : 0;
+	error = (buf == (void*)-1) ? -1 : 0;
 	printf("shmat: buf=%p, returned %d\n", buf, error);
 	return error;
 }

-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
