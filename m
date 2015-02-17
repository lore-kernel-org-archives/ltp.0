Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YNlLZ-0006W5-7B
	for ltp-list@lists.sourceforge.net; Tue, 17 Feb 2015 16:50:05 +0000
Date: Tue, 17 Feb 2015 17:49:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150217164955.GA31330@rei>
References: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
	<1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
	<20150216051704.GB4075@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150216051704.GB4075@vapier>
Subject: Re: [LTP] [PATCH] ltp: Fix cross-compile issue
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
To: Mats Liljegren <mats.liljegren@enea.com>, ltp-list@lists.sourceforge.net

Hi!
> > --- a/m4/ltp-tirpc.m4
> > +++ b/m4/ltp-tirpc.m4
> > @@ -25,7 +25,7 @@ AC_DEFUN([LTP_CHECK_TIRPC],[
> >  	TIRPC_LIBS=""
> >  
> >  	AC_CHECK_HEADER(tirpc/netconfig.h,[
> > -		TIRPC_CPPFLAGS="-I/usr/include/tirpc"
> > +		TIRPC_CPPFLAGS="-I=/usr/include/tirpc"
> >  		AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers installed])
> >  		AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS="-ltirpc"])])
> 
> this m4 is fatally flawed and tweaking the flags won't help.  we should switch 
> to use pkg-config here.  a cursory glance suggests acl/cap should also be 
> updated.

Looking pkg-config on my system only libtirpc supported.

There seems to be nothing nothing for libacl nor for libcap (not to be
confused with libcap-ng).

I guess that we may fix the ltp-tirpc.m4 to use pkg-config, if available
but not much more than that.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
