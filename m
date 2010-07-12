Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OYGGf-0002ab-CO
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 10:29:45 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OYGGe-0007XW-AR
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 10:29:45 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTinyob2ONZI7W9rnBdZI87D1twZuskEZQaHTK4UA@mail.gmail.com>
References: <1278930128.18204.14.camel@subratamodak.linux.ibm.com>
	<AANLkTinyob2ONZI7W9rnBdZI87D1twZuskEZQaHTK4UA@mail.gmail.com>
Date: Mon, 12 Jul 2010 15:59:25 +0530
Message-Id: <1278930566.18204.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Latest GIT creates install error
Reply-To: subrata@linux.vnet.ibm.com
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, 2010-07-12 at 03:23 -0700, Garrett Cooper wrote:
> On Mon, Jul 12, 2010 at 3:22 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > Hi Garret,
> >
> > Latest LTP git creates install error:
> >
> > make -C open_posix_testsuite
> > top_srcdir=/root/ltp-dev/testcases/open_posix_testsuite install
> > make[2]: Entering directory
> > `/root/ltp-dev/testcases/open_posix_testsuite'
> > mkdir -p //opt/openposix_testsuite/bin/.
> > make[2]: *** No rule to make target `run.sh', needed by `install'.
> > Stop.
> > make[2]: Leaving directory
> > `/root/ltp-dev/testcases/open_posix_testsuite'
> > make[1]: *** [open_posix_testsuite-install] Error 2
> > make[1]: Leaving directory `/root/ltp-dev/testcases'
> > make: *** [testcases-install] Error 2
> 
> Could you try:
> 
> make -C open_posix_testsuite all
> 
> then
> 
> make -C open_posix_testsuite install
> 
> ?

[root@mjs22lp4 ltp-dev]# make -C open_posix_testsuite all
make: *** open_posix_testsuite: No such file or directory.  Stop.
[root@mjs22lp4 ltp-dev]# ls -l testcases/open_posix_testsuite/
total 132
-rw-r--r--. 1 1000 1000   366 May 31 11:22 AUTHORS
drwxr-xr-x. 2 1000 1000  4096 Jul 12 15:41 bin
-rw-r--r--. 1 1000 1000  5288 Jul 12 15:24 BUILD
-rw-r--r--. 1 1000 1000    55 Jul 12 15:24 CFLAGS
-rw-r--r--. 1 1000 1000  6815 Jul 12 15:24 ChangeLog
drwxr-xr-x. 5 1000 1000  4096 Jul 12 15:24 conformance
-rw-r--r--. 1 1000 1000 19748 Jul 12 15:24 COPYING
drwxr-xr-x. 2 1000 1000  4096 Jul 12 15:24 Documentation
drwxr-xr-x. 6 1000 1000  4096 Jul 12 15:24 functional
drwxr-xr-x. 2 1000 1000  4096 Jul 12 15:24 include
-rw-r--r--. 1 1000 1000   229 May 31 11:22 INSTALL
-rw-r--r--. 1 1000 1000     0 Jul 12 15:24 LDFLAGS
-rw-r--r--. 1 1000 1000     0 Jul 12 15:24 LDLIBS
-rw-r--r--. 1 root root 16257 Jul 12 15:41 logfile.conformance-all
-rw-r--r--. 1 root root 10425 Jul 12 15:42 logfile.functional-all
-rw-r--r--. 1 1000 1000  1142 Jul 12 15:41 Makefile
-rw-r--r--. 1 1000 1000  3219 May 31 11:22 NEWS
-rw-r--r--. 1 1000 1000  2240 Jul 12 15:24 QUICK-START
-rw-r--r--. 1 1000 1000  4475 May 31 11:22 README
-rwxr-xr-x. 1 1000 1000  1673 May 31 11:22 run_tests
drwxr-xr-x. 2 1000 1000  4096 Jul 12 15:24 scripts
drwxr-xr-x. 7 1000 1000  4096 Jul 12 15:24 stress
drwxr-xr-x. 2 1000 1000  4096 Jul 12 15:24 tools
[root@mjs22lp4 ltp-dev]# make -C open_posix_testsuite install
make: *** open_posix_testsuite: No such file or directory.  Stop.

Regards--
Subrata

> 
> Thanks,
> -Garrett


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
