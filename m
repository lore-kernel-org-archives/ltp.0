Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MnwGB-0001DY-G1
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:31 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnwG6-0005Qa-2c
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 15:17:31 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GFFK1Q020072
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:15:20 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GFHIdI246084
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:17:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GFE8mm002099
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:14:08 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090915215307.GD10922@count0.beaverton.ibm.com>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
	<20090915215307.GD10922@count0.beaverton.ibm.com>
Date: Wed, 16 Sep 2009 20:47:12 +0530
Message-Id: <1253114232.6343.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Filecaps: Update error message for recent kernels
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Test Project <Ltp-list@lists.sourceforge.net>, Serge Hallyn <serue@linux.vnet.ibm.com>

On Tue, 2009-09-15 at 14:53 -0700, Matt Helsley wrote: 
> On Tue, Sep 15, 2009 at 05:30:55PM +0200, Geert Uytterhoeven wrote:
> >    - As of 2.6.24, `capability' can no longer be a module,
> >    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > ---
> >  .../kernel/security/filecaps/checkforfilecaps.sh   |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > index 20f97f5..3f6a4ec 100755
> > --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > @@ -23,8 +23,7 @@ check_simple_capset
> >  ret=$?
> >  if [ $ret -ne 0 ]; then
> >  	echo Posix capabilities not compiled into the kernel.  Please
> > -	echo modprobe capability or recompile your kernel with
> > -	echo CONFIG_SECURITY_CAPABILITIES=y.
> > +	echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.
> 
> Then the advice is incorrect for older kernels. If LTP should still run
> nicely for users of older kernels then perhaps something like this is better:
> 
> -	echo modprobe capability or recompile your kernel with
> -	echo CONFIG_SECURITY_CAPABILITIES=y.
> +	if tst_kvercmp 2 6 24 ; then
> +		echo modprobe capability or recompile your kernel with
> +		echo CONFIG_SECURITY_CAPABILITIES=y.
> +	elif tst_kvercmp 2 6 27 ; then
> +		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=y.
> +	else
> +		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.
> +	fi

Yes, this is better. Please shoot off a patch.

Regards--
Subrata

> 
> Cheers,
> 	-Matt Helsley


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
