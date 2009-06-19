Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHWfL-0002PE-9m
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 05:29:31 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHWfH-0008Ux-H1
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 05:29:31 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5J5OQEt003116
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 01:24:26 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5J5TQAb255064
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 01:29:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5J5TQ36024966
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Jun 2009 01:29:26 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <49b7c2350906182211s34c84011qce55fab5845274f1@mail.gmail.com>
References: <49b7c2350906120147p1a68cde1ua00b2875052ea99c@mail.gmail.com>
	<1245346296.5041.34.camel@subratamodak.linux.ibm.com>
	<49b7c2350906182211s34c84011qce55fab5845274f1@mail.gmail.com>
Date: Fri, 19 Jun 2009 10:59:20 +0530
Message-Id: <1245389361.5041.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] I met "You can specify it with option -b" error message
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
To: GeunSik Lim <leemgs1@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Andrew Vagin <avagin@parallels.com>

On Fri, 2009-06-19 at 14:11 +0900, GeunSik Lim wrote:
> On Fri, Jun 19, 2009 at 2:31 AM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
> >> remove test cases which require the block device.
> >> You can specify it with option -b
> >
> > This is not an error message at all. See this:
> > http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/runltp?r1=1.40&r2=1.41
> 
> I checked above site that you said. Thank you for sharing.
> I summarized result of benchmark  using ltp-full-20090531.
> ----------------------------------------------------------------------------------------------------
>  Linux RootFS        Linux Kernel             LTP        Result(Log)
>          Result(HTML)
> ----------------------------------------------------------------------------------------------------
> CentOS 5.3                2.6.24              20090531      Success
>               Success
> Fedora   11                2.6.29              20090531
> Success(with+ctrl C)   Failed
> 
> #> cd ltp-full-20090531
> #> ./configure
> #> make
> #> make install
> #> time ./runalltests.sh  OR
>      time ./runltp -v -l alltest.log  -o alltest.out -g alltest.html
> -x 4

Because, when you use the option -o, ltp-pan will redirect all your test
output to ltp/output/alltest.out. Do tail -f ltp/output/alltest.out, you
will see output scrolling out. Given the size of default ltp run, you
can expect somewhere from 1.5 to 2.5 hours before your command prompt
returns from:

time ./runltp -v -l alltest.log  -o alltest.out -g alltest.html

Regards--
Subrata

> 
>         ....    No response  ......
> 
> I still can't view "#>" prompt in my Fedora 11 distribution after 24hours.
> I don't know what is reason of this problem  in Fedora 11.
> 
> 
> >
> > Andrew would also explain you a bit.
> >
> > Regards--
> > Subrata
> >
> 


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
