Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MoHt5-0003eL-2F
	for Ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 14:23:07 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MoHsw-0000LB-O6
	for Ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 14:23:05 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8HDbNOs028947
	for <Ltp-list@lists.sourceforge.net>; Thu, 17 Sep 2009 07:37:23 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8HDhI9h040496
	for <Ltp-list@lists.sourceforge.net>; Thu, 17 Sep 2009 07:43:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8HDhEBS001846
	for <Ltp-list@lists.sourceforge.net>; Thu, 17 Sep 2009 07:43:15 -0600
Date: Thu, 17 Sep 2009 08:43:11 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090917134311.GB29297@us.ibm.com>
References: <alpine.LRH.2.00.0909151730320.29846@vixen.sonytel.be>
	<20090915215307.GD10922@count0.beaverton.ibm.com>
	<1253114232.6343.30.camel@subratamodak.linux.ibm.com>
	<alpine.LRH.2.00.0909161801310.6362@vixen.sonytel.be>
	<20090916170753.GB7549@us.ibm.com>
	<alpine.LRH.2.00.0909171014440.13477@vixen.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0909171014440.13477@vixen.sonytel.be>
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
> On Wed, 16 Sep 2009, Serge E. Hallyn wrote:
> > Quoting Geert Uytterhoeven (Geert.Uytterhoeven@sonycom.com):
...
> > > +	if tst_kvercmp 2 6 24 ; then
> > > +		echo modprobe capability or recompile your kernel with
> > > +		echo CONFIG_SECURITY_CAPABILITIES=y.
> > > +	elif tst_kvercmp 2 6 27 ; then
> > > +		echo recompile your kernel with CONFIG_SECURITY_CAPABILITIES=y.
> > > +	else
> > > +		echo recompile your kernel with CONFIG_SECURITY_FILE_CAPABILITIES=y.
> > 
> > I don't think splitting these last two up is necessary - the
> > CONFIG_SECURITY_FILE_CAPABILITIES check is in the next stanza
> > in checkforfilecaps.sh.  This check is only for
> > CONFIG_SECURITY_CAPABILITIES itself.
> 
> However, this (first) check is triggered on my 2.6.31+ kernel with
> CONFIG_SECURITY_FILE_CAPABILITIES=n, where the config symbol
> CONFIG_SECURITY_CAPABILITIES no longer exists.
> 
> Or should it be plain CONFIG_SECURITY?

???  Well, taking a quick look at check_simple_capset.c, it's actually
a bit messed up.  I'm pretty sure I did in fact write it, but it isn't
right.  The second test in checkforfilecaps.sh isn't right either -
it checks for the xattr support, not actual file capabilities support.

check_simple_capset.c should just read:

	caps = cap_from_text("cap_sys_admin=ep");
	caps2 = cap_get_proc();
	if (!caps || !caps2)
		fail;
	ret = cap_compare(caps, caps);
	cap_free(caps);
	cap_free(caps2);
	return ret;

The second test should actually execute a copy of sleep with filecaps,
i.e.
	cp `which sleep` .
	setcap cap_sys_admin=ep ./sleep
	capsh --uid=`id -u ltp`  -- -c "./sleep 20" &
	p=`jobs -p`
	prm=`cat /proc/$p/status | grep CapPrm | awk '{ print $2 '}`
	inh=`cat /proc/$p/status | grep CapInh | awk '{ print $2 '}`
	eff=`cat /proc/$p/status | grep CapEff | awk '{ print $2 '}`
	if [ "$inh" != "0000000000000000" ]; then
		fail;
	fi
	if [ "$prm" != "0000000000200000" ]; then
		fail;
	fi
	if [ "$eff" != "0000000000200000" ]; then
		fail;
	fi
	pass

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
