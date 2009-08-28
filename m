Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mguew-0004Wj-D0
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 06:10:02 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mgueq-0001JA-2g
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 06:10:02 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7S665J2021815
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:06:05 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S69occ170260
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:09:50 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7S69oQB010472
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Aug 2009 00:09:50 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <alpine.LRH.2.00.0908271416250.22490@vixen.sonytel.be>
References: <4A8330A1.20001@canonical.com>
	<200908130304.49839.vapier@gentoo.org>
	<alpine.LRH.2.00.0908271416250.22490@vixen.sonytel.be>
Date: Fri, 28 Aug 2009 11:39:25 +0530
Message-Id: <1251439768.9081.11.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] fix mail_tests for systems without mail installed
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

On Thu, 2009-08-27 at 14:19 +0200, Geert Uytterhoeven wrote: 
> On Thu, 13 Aug 2009, Mike Frysinger wrote:
> > On Wednesday 12 August 2009 17:14:09 Paul Larson wrote:
> > > +`which mail`
> > > +if [ $? != 0 ]; then
> > 
> > this results in pretty ugly output, and the return value/output of `which` is 
> > not portable.  use the type builtin instead.
> > 
> > > +    MAIL_NOT_INSTALLED=1
> > 
> > you should make sure this is always set/unset at the top of the script so 
> > parent environment poisoning wont screw things up.
> > 
> > > +if [ -z $MAIL_NOT_INSTALLED ]; then
> > 
> > tests must always be quoted:
> > [ -z "$foo" ]
> 
> Worse, as $MAIL_NOT_INSTALLED is always "0" or "1", -z always return false...
> 
> From 8035091c4232e8d6c7b3a75d612bc82c1ad84365 Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Date: Thu, 27 Aug 2009 14:11:58 +0200
> Subject: [PATCH] Fix mail_tests for systems with mail installed
> 
> `-z' tests for a string length of zero, not for a zero value, causing the
> test always to return false.
> Initialize $MAIL_NOT_INSTALLED to an empty string instead of a numerical
> zero to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Ok. Thanks.

Regards--
Subrata

> ---
>  testcases/commands/mail/mail_tests.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
> index 0959a0c..45bac93 100755
> --- a/testcases/commands/mail/mail_tests.sh
> +++ b/testcases/commands/mail/mail_tests.sh
> @@ -59,7 +59,7 @@ RC=0
>  export TCID=SETUP
>  export TST_COUNT=1
>  
> -MAIL_NOT_INSTALLED=0
> +MAIL_NOT_INSTALLED=
>  `type mail &> /dev/null`
>  if [ $? != 0 ]; then
>      MAIL_NOT_INSTALLED=1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
