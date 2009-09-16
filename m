Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Mnxzd-00021A-FE
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 17:08:33 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MnxzX-0004XH-7L
	for Ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 17:08:33 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GH2iit028398
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:02:44 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GH7t5u257192
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:07:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GH7s5H021795
	for <Ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 11:07:54 -0600
Date: Wed, 16 Sep 2009 12:07:53 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090916170753.GB7549@us.ibm.com>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
	<20090915215307.GD10922@count0.beaverton.ibm.com>
	<1253114232.6343.30.camel@subratamodak.linux.ibm.com>
	<alpine.LRH.2.00.0909161801310.6362@vixen.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0909161801310.6362@vixen.sonytel.be>
Subject: Re: [LTP] [PATCH] Filecaps: Update error message for recent kernels
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
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>, Serge Hallyn <serue@linux.vnet.ibm.com>

Quoting Geert Uytterhoeven (Geert.Uytterhoeven@sonycom.com):
> On Wed, 16 Sep 2009, Subrata Modak wrote:
> > On Tue, 2009-09-15 at 14:53 -0700, Matt Helsley wrote: 
> > > On Tue, Sep 15, 2009 at 05:30:55PM +0200, Geert Uytterhoeven wrote:
> > > >    - As of 2.6.24, `capability' can no longer be a module,
> > > >    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> > > > 
> > > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > > ---
> > > >  .../kernel/security/filecaps/checkforfilecaps.sh   |    3 +--
> > > >  1 files changed, 1 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > > > index 20f97f5..3f6a4ec 100755
> > > > --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > > > +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> > > > @@ -23,8 +23,7 @@ check_simple_capset
> > > >  ret=$?
> > > >  if [ $ret -ne 0 ]; then
> > > >  	echo Posix capabilities not compiled into the kernel.  Please
> > > > -	echo modprobe capability or recompile your kernel with
> > > > -	echo CONFIG_SECURITY_CAPABILITIES=y.
> > > > +	echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.
> > > 
> > > Then the advice is incorrect for older kernels. If LTP should still run
> > > nicely for users of older kernels then perhaps something like this is better:
> > > 
> > > -	echo modprobe capability or recompile your kernel with
> > > -	echo CONFIG_SECURITY_CAPABILITIES=y.
> > > +	if tst_kvercmp 2 6 24 ; then
> > > +		echo modprobe capability or recompile your kernel with
> > > +		echo CONFIG_SECURITY_CAPABILITIES=y.
> > > +	elif tst_kvercmp 2 6 27 ; then
> > > +		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=y.
> > > +	else
> > > +		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.
> > > +	fi
> > 
> > Yes, this is better. Please shoot off a patch.
> 
> At your service!
> 
> ---
> >From 0e13026c931d26393671884f63446b7389318b27 Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Date: Tue, 15 Sep 2009 17:06:09 +0200
> Subject: [PATCH 9/9] Filecaps: Update error message for recent kernels
> 
>    - As of 2.6.24, `capability' can no longer be a module,
>    - As of 2.6.27, CONFIG_SECURITY_CAPABILITIES no longer exists.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> --
> v2: Make the message dependent on the kernel version, as suggested by Matt
>     Helsley
> ---
>  .../kernel/security/filecaps/checkforfilecaps.sh   |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> index 20f97f5..5ca385e 100755
> --- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
> +++ b/testcases/kernel/security/filecaps/checkforfilecaps.sh
> @@ -23,8 +23,14 @@ check_simple_capset
>  ret=$?
>  if [ $ret -ne 0 ]; then
>  	echo Posix capabilities not compiled into the kernel.  Please
> -	echo modprobe capability or recompile your kernel with
> -	echo CONFIG_SECURITY_CAPABILITIES=y.
> +	if tst_kvercmp 2 6 24 ; then
> +		echo modprobe capability or recompile your kernel with
> +		echo CONFIG_SECURITY_CAPABILITIES=y.
> +	elif tst_kvercmp 2 6 27 ; then
> +		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=y.
> +	else
> +		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.

I don't think splitting these last two up is necessary - the
CONFIG_SECURITY_FILE_CAPABILITIES check is in the next stanza
in checkforfilecaps.sh.  This check is only for
CONFIG_SECURITY_CAPABILITIES itself.

> +	fi
>  	exit 1
>  fi

-serge

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
