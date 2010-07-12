Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OYGAu-0002F3-0Q
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 10:23:48 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OYGAt-0003VS-4z
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 10:23:47 +0000
MIME-Version: 1.0
In-Reply-To: <1278930128.18204.14.camel@subratamodak.linux.ibm.com>
References: <1278930128.18204.14.camel@subratamodak.linux.ibm.com>
Date: Mon, 12 Jul 2010 03:23:40 -0700
Message-ID: <AANLkTinyob2ONZI7W9rnBdZI87D1twZuskEZQaHTK4UA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Latest GIT creates install error
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

On Mon, Jul 12, 2010 at 3:22 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Hi Garret,
>
> Latest LTP git creates install error:
>
> make -C open_posix_testsuite
> top_srcdir=/root/ltp-dev/testcases/open_posix_testsuite install
> make[2]: Entering directory
> `/root/ltp-dev/testcases/open_posix_testsuite'
> mkdir -p //opt/openposix_testsuite/bin/.
> make[2]: *** No rule to make target `run.sh', needed by `install'.
> Stop.
> make[2]: Leaving directory
> `/root/ltp-dev/testcases/open_posix_testsuite'
> make[1]: *** [open_posix_testsuite-install] Error 2
> make[1]: Leaving directory `/root/ltp-dev/testcases'
> make: *** [testcases-install] Error 2

Could you try:

make -C open_posix_testsuite all

then

make -C open_posix_testsuite install

?

Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
