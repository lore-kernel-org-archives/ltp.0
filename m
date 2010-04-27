Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O6h1K-0007Rr-73
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 09:23:58 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6h1J-0007TZ-8L
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 09:23:58 +0000
Date: Tue, 27 Apr 2010 05:23:50 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <1982387996.1043141272360230694.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1948733593.1043121272360223401.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37579_1727994511.1272360230693"
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

------=_Part_37579_1727994511.1272360230693
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

attached the patch. (fix the `need a tty to run sudo ' problem)

Thanks,
Caspar

----- "Caspar ZHANG" <czhang@redhat.com> wrote:

> ----- "Caspar ZHANG" <czhang@redhat.com> wrote:
> 
> > ----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:
> > 
> > > Hi,
> > > 
> > > Anybody seeing it on their system(s):
> > 
> > +1 :-|
> > 
> > I believe some automated testing systems don't have a tty when
> > running tests, so this test can't pass.
> > 
> > There's one line in /etc/sudoers
> > 
> >  Defaults    requiretty
> > 
> > Comment this (need logout?) and it may work. But I have tried yet.
> 
> Update: comment or delete this line and the test can work. no need to
> logout.
> 
> But I met the following failure(it seems to be another problem):
> 
> <<<test_output>>>
> ============================================================
> 
> Testing read-only file, owned by self
> 
> ***** Testing times==NULL case *****
> Pathname test
> Owner=nobody; perms=-r--------.; EFAs=Extents
> ./utimensat01 -q
> /mnt/testarea/ltp-W0ugFUAL14/utimensat_tests/utimensat.test_file 
> EXPECTED: SUCCESS y  y
> RESULT:   SUCCESS 1272358497 1272358497
> PASSED test 1
> 
> Readable file descriptor (futimens(3)) test
> Owner=nobody; perms=-r--------.; EFAs=Extents
> ./utimensat01 -q -d
> /mnt/testarea/ltp-W0ugFUAL14/utimensat_tests/utimensat.test_file NULL
> 
> EXPECTED: SUCCESS y  y
> RESULT:   SUCCESS 1272358497 1272358497
> PASSED test 2
> 
> Writable file descriptor (futimens(3)) test
> Owner=nobody; perms=-r--------.; EFAs=Extents
> ./utimensat01 -q -w -d
> /mnt/testarea/ltp-W0ugFUAL14/utimensat_tests/utimensat.test_file NULL
> 
> open: Permission denied
> FAILED (bad test setup)
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=5 cstime=10
> <<<test_end>>>
> 
> Thanks,
> Caspar
> 
> -- 
> Kernel Associate Quality Engineer
> Red Hat Inc. (Beijing R&D Branch)
> 
> Red Hat China R&D Branch Unit 907, North Tower C, 
>   Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
>   Haidian District, Beijing 100190
> 
> TEL: +86-10-62608150
> Web: http://www.redhat.com/
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_37579_1727994511.1272360230693
Content-Type: text/x-patch;
	name=syscalls-utimensat01-run-sudo-without-tty.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-utimensat01-run-sudo-without-tty.patch

Hi,
	Most automated testing systems have no tty when running tests,
	so the utimensat01 test may fail with the following error msg:

	sudo: sorry, you must have a tty to run sudo

	to avoid this, deleting `Defaults    requiretty' line in
	/etc/sudoers can make this testcase work.

	Signed-off-by: Caspar ZHANG <czhang@redhat.com>
---
diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index cc136f9..c161476 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -31,6 +31,11 @@ if tst_kvercmp 2 6 22 ; then
        exit 0
 fi
 
+# Since some automated testing systems have no tty while testing,
+# delete this line in /etc/sudoers to avoid the error message:
+# `sudo: sorry, you must have a tty to run sudo'
+sed -i "/^Defaults.*requiretty$/d" /etc/sudoers
+
 RESULT_FILE=$TMPDIR/utimensat.result
 
 TEST_DIR=$TMPDIR/utimensat_tests

------=_Part_37579_1727994511.1272360230693
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------=_Part_37579_1727994511.1272360230693
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37579_1727994511.1272360230693--

