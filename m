Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@linux.vnet.ibm.com>) id 1MJnh3-0003ui-Ag
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 12:04:41 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJnh2-0003Or-7Q
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 12:04:41 +0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
In-Reply-To: <1245926833.8178.2.camel@subratamodak.linux.ibm.com>
References: <78aaeffc0906250000i150418e8k3637acb41976c1a0@mail.gmail.com>
	<1245921062.5542.51.camel@subratamodak.linux.ibm.com>
	<78aaeffc0906250339q1051eceak19a244c968b4ba0c@mail.gmail.com>
	<1245926833.8178.2.camel@subratamodak.linux.ibm.com>
Date: Thu, 25 Jun 2009 08:04:35 -0400
Message-Id: <1245931475.11847.6.camel@dyn9002018117.watson.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Can not run Test
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
Cc: waqar afridi <afridi.waqar@gmail.com>, ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@us.ibm.com>

On Thu, 2009-06-25 at 16:17 +0530, Subrata Modak wrote:
> On Thu, 2009-06-25 at 16:39 +0600, waqar afridi wrote:
> > 
> > 
> > On Thu, Jun 25, 2009 at 3:11 PM, Subrata Modak
> > <subrata@linux.vnet.ibm.com> wrote:
> >         On Thu, 2009-06-25 at 13:00 +0600, waqar afridi wrote:
> >         > Hi All
> >         >
> >         > I have downloaded ltp-full-20090531.tgz and installed it
> >         using the
> >         > commands make autotools, ./configure, make all, make
> >         install. but when
> >         > I try to run a test like
> >         >
> >         > # ./ima_tpm.sh
> >         > ./ima_tpm.sh: 163: source: not found
> >         > ./ima_tpm.sh: 164: setup: not found
> >         >
> >         > I get the error above. What could be the problem,
> >         Desperately need
> >         > help.
> >         
> >         
> >         Look through:
> >         http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/integrity/ima/README,
> >         on instructions to setup before executing those tests.
> > 
> > I already have done these steps. but I think  the problem will be with
> > mounting partition with iversion support(I have done this too, added
> > iversion to fstab). I am not clear about whats iversion, so thats why
> > I am going to clear my Idea about iversion. but if some body can help
> > with both the problem and iversion, I will be very thankful.
> 
> Mimi,
> 
> Can you please help Afridi ?
> 
> Regards--
> Subrata

Sure.  I'm in the process of updating the web site
http://linux-ima.sourceforge.net/, but it is a good place to start.
There's also IMA mailing lists
http://sourceforge.net/projects/linux-ima.

Mimi

> > 
> >         
> >         
> >         Regards--
> >         Subrata
> >         
> >         >
> >         > --
> >         > Waqar Afridi
> >         > Research Associate
> >         > Member: Security Engineering Research Group (SERG)
> >         > IM | Sciences Peshawar
> >         
> >         >
> >         ------------------------------------------------------------------------------
> >         > _______________________________________________
> >         > Ltp-list mailing list
> >         > Ltp-list@lists.sourceforge.net
> >         > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >         
> > 
> > 
> > 
> > -- 
> > Waqar Afridi
> > Research Associate
> > Member: Security Engineering Research Group (SERG)
> > IM | Sciences Peshawar
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
