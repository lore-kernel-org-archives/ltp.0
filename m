Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UZPYg-0002D5-CS
	for ltp-list@lists.sourceforge.net; Mon, 06 May 2013 17:50:42 +0000
Date: Mon, 6 May 2013 19:51:42 +0200
From: chrubis@suse.cz
Message-ID: <20130506175142.GB15141@rei.suse.cz>
References: <CA+icZUVOgWZ+B41Hyb2_J-YCXu_c8ucad43H5ts5xsP4uisi7w@mail.gmail.com>
	<20130116140742.GB6699@rei>
	<CA+icZUUneR2cuZeYGq64=Ffh0UsFzd3KmbO9FmC97zWj6zTpxQ@mail.gmail.com>
	<20130506092822.GC4388@rei> <5187E6FB.1070603@linux.vnet.ibm.com>
	<20130506172626.GA15198@rei.suse.cz>
	<5187E99F.9030600@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5187E99F.9030600@linux.vnet.ibm.com>
Subject: Re: [LTP] Tarballs in Files section @ sf.net
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
To: shubham <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>>> First, I was really happy when I wanted today to stress my Linux-Next
> >>>> (next-20130503) kernels.
> >>>>
> >>>> 4 hours ago LTP-full 2013-05-03 was released.
> >>>> Cool, I said.
> >>>>
> >>>> Looking at ltp-full-20130503.bz2 ...
> >>>>
> >>>> ...is still a TAR-archive when unpacked.
> >>>>
> >>>> An XZ-Tar-archive as demanded by me and promised by you was NOT prepared.
> >>>>
> >>>> That makes me a bit of Grrr...
> >>>> Hereby my reminder, again!
> >>> I mailed Shubham from IBM (who does the releases) to include the xz and
> >>> rename the bz2 just a few minutes ago (even before I've read this mail).
> >>> Hopefully he will fix this during the day.
> >>>
> >> I replaced the sf.net download file to "ltp-full-20130503.tar.xz". Hope
> >> this helps...
> > Thanks.
> >
> > Could you please also rename the ltp-full-20130503.bz2 to
> > ltp-full-20130503.tar.bz2 to reflect its content?
> >
> 
> I already did that. The download file name is "ltp-full-20130503.tar.xz" 
> now. I think this is better than "ltp-full-20130503.tar.bz2".

Sure, but we decided to serve both files the .bz2 and .xz for
compatibility with older distros. But the bz2 had historically wrong
suffix (missing the .tar). I would like to have that one fixed too, and
from what I can say the sourceforge serves me still the
ltp-full-20130503.bz2. Or is this intentional to stay backwards
compatible?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
