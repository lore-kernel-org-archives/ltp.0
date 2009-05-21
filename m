Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M77oh-0008K0-Q3
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2009 12:56:11 +0000
Date: Thu, 21 May 2009 14:25:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090521122545.GA7848@schrodinger.suse.cz>
References: <20090518135848.GA1060@schrodinger.suse.cz>
	<1242729123.5961.46.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1242729123.5961.46.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] fix missing return in several files.
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi,
> >  int main(void)
> >  {
> > -  tst_brkm(TCONF, tst_exit, "libaio missing");
> > +       tst_brkm(TCONF, tst_exit, "libaio missing");
> > +
> > +       return 0;
> 
> This is not necessary as tst_exit() will automatically return
> appropriate value depending on whether it is TCONF, TPASS, TFAIL, etc.
> And for TCONF it already returns 0.
> 
> Probably you will get a build warning saying:
> 
> Noting returns although prototype says something should return.
 
Well it breaks building suse rpm package as buildservice system treats these
kind of warning as errors and it's IMHO harmless to add these returns in the code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
