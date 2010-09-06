Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OsaAO-000429-CB
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 11:47:16 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OsaAI-0003fe-R7
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 11:47:16 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <391164506.177201283767973568.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <391164506.177201283767973568.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Mon, 06 Sep 2010 17:16:57 +0530
Message-Id: <1283773618.4947.0.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, 2010-09-06 at 06:12 -0400, Caspar Zhang wrote:
> This patch seemed not included in latest release?

Thanks for pointing that out. Pushed to git so that i do not forget
again ;-)

Regards--
Subrata

> 
> Thanks,
> Caspar
> 
> ----- "Caspar Zhang" <casparant@gmail.com> wrote:
> 
> > On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com>
> > wrote:
> > > The first item is different from the other two. The first one
> > ignores the
> > > signal (SIG_IGN), whereas the latter two cases reset the handler to
> > the
> > > default one (SIG_DFL). I prefer the former format, because otherwise
> > the
> > > signal handlers become reentrable on accident.
> > 
> > I see. Thank you.
> > 
> > The final patch ;-)
> > 
> > Cheers,
> > -Caspar
> > 
> > -- 
> > Tags: Ant, Beijing, BUPT, Caspar, Kernel QA, Linux, Open Source,
> > Photography, Programmer, Red Hat Inc., Zhejianger, etc.
> > 
> > Current: Kernel Associate Quality Engineer @ Red Hat Inc.
> > 
> > Home Page: http://www.CasparZhang.com/
> 
> ------------------------------------------------------------------------------
> This SF.net Dev2Dev email is sponsored by:
> 
> Show off your parallel programming skills.
> Enter the Intel(R) Threading Challenge 2010.
> http://p.sf.net/sfu/intel-thread-sfd
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
