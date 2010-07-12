Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Oam9H-0002EW-SQ
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 08:56:31 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Oam9G-0007D9-HI
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 08:56:31 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTimyS1H-5pxJ25TVNaHdHt71ln6Aqxe38uMdH_HU@mail.gmail.com>
References: <1278930128.18204.14.camel@subratamodak.linux.ibm.com>
	<AANLkTinyob2ONZI7W9rnBdZI87D1twZuskEZQaHTK4UA@mail.gmail.com>
	<AANLkTimyS1H-5pxJ25TVNaHdHt71ln6Aqxe38uMdH_HU@mail.gmail.com>
Date: Mon, 12 Jul 2010 16:16:13 +0530
Message-Id: <1278931579.18204.18.camel@subratamodak.linux.ibm.com>
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

On Mon, 2010-07-12 at 03:25 -0700, Garrett Cooper wrote:
> On Mon, Jul 12, 2010 at 3:23 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > On Mon, Jul 12, 2010 at 3:22 AM, Subrata Modak
> > <subrata@linux.vnet.ibm.com> wrote:
> >> Hi Garret,
> >>
> >> Latest LTP git creates install error:
> >>
> >> make -C open_posix_testsuite
> >> top_srcdir=/root/ltp-dev/testcases/open_posix_testsuite install
> >> make[2]: Entering directory
> >> `/root/ltp-dev/testcases/open_posix_testsuite'
> >> mkdir -p //opt/openposix_testsuite/bin/.
> >> make[2]: *** No rule to make target `run.sh', needed by `install'.
> >> Stop.
> >> make[2]: Leaving directory
> >> `/root/ltp-dev/testcases/open_posix_testsuite'
> >> make[1]: *** [open_posix_testsuite-install] Error 2
> >> make[1]: Leaving directory `/root/ltp-dev/testcases'
> >> make: *** [testcases-install] Error 2
> >
> > Could you try:
> >
> > make -C open_posix_testsuite all
> >
> > then
> >
> > make -C open_posix_testsuite install
> >
> > ?
> 
> Better yet, what are the exact steps you took to arrive at that error?

make autotools
./configure
make -j 16
make install

Regards--
Subrata

> Thanks!
> -Garrett


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
