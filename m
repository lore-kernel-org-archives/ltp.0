Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1N3vRr-0005fg-A9
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 17:39:39 +0000
Received: from mtagate2.de.ibm.com ([195.212.17.162])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N3vRi-0001Z8-Ng
	for ltp-list@lists.sourceforge.net; Fri, 30 Oct 2009 17:39:39 +0000
Message-ID: <4AEAF762.3050205@linux.vnet.ibm.com>
Date: Fri, 30 Oct 2009 15:25:38 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <1256909081.13702.14.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1256909081.13702.14.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] LTP fails to build for Application Code Coverage
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
Cc: ltp-list <ltp-list@lists.sf.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>

Hi Subrata,

Subrata Modak wrote:
> # make CFLAGS=\ -fprofile-arcs\ -ftest-coverage\ -Wall
[...]
> gcc   ltp-pan.o zoolib.o splitstr.o -lm  -o ltp-pan
> ltp-pan.o: In function `run_child':
> ltp-pan.c:(.text+0x6d54): undefined reference to `__gcov_fork'

we already solved this issue via ST but I'll still post the result here 
for reference: to prevent this particular error, you'll need to also 
provide the additional linker option -coverage.

As not all ltp Makefile work well when specifying CFLAGS and LDFLAGS on 
the make command line, you'll need to specify those during the configure 
step, i.e.

./configure CFLAGS="-fprofile-arcs -ftest-coverage" LDFLAGS="-coverage"
make


Regards,
   Peter


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
