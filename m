Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O6gqe-0006eP-TH
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 09:12:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6gqd-000847-MT
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 09:12:56 +0000
Date: Tue, 27 Apr 2010 05:12:49 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <328988291.1042731272359569134.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1650479488.1039351272354225723.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>


----- "Caspar ZHANG" <czhang@redhat.com> wrote:

> ----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:
> 
> > Hi,
> > 
> > Anybody seeing it on their system(s):
> 
> +1 :-|
> 
> I believe some automated testing systems don't have a tty when
> running tests, so this test can't pass.
> 
> There's one line in /etc/sudoers
> 
>  Defaults    requiretty
> 
> Comment this (need logout?) and it may work. But I have tried yet.

Update: comment or delete this line and the test can work. no need to logout.

But I met the following failure(it seems to be another problem):

<<<test_output>>>
============================================================

Testing read-only file, owned by self

***** Testing times==NULL case *****
Pathname test
Owner=nobody; perms=-r--------.; EFAs=Extents
./utimensat01 -q /mnt/testarea/ltp-W0ugFUAL14/utimensat_tests/utimensat.test_file 
EXPECTED: SUCCESS y  y
RESULT:   SUCCESS 1272358497 1272358497
PASSED test 1

Readable file descriptor (futimens(3)) test
Owner=nobody; perms=-r--------.; EFAs=Extents
./utimensat01 -q -d /mnt/testarea/ltp-W0ugFUAL14/utimensat_tests/utimensat.test_file NULL 
EXPECTED: SUCCESS y  y
RESULT:   SUCCESS 1272358497 1272358497
PASSED test 2

Writable file descriptor (futimens(3)) test
Owner=nobody; perms=-r--------.; EFAs=Extents
./utimensat01 -q -w -d /mnt/testarea/ltp-W0ugFUAL14/utimensat_tests/utimensat.test_file NULL 
open: Permission denied
FAILED (bad test setup)
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=10
<<<test_end>>>

Thanks,
Caspar

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
