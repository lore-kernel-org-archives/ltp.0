Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJmV2-0002o5-P3
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:48:12 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJmUw-0007H3-6H
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:48:07 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <78aaeffc0906250339q1051eceak19a244c968b4ba0c@mail.gmail.com>
References: <78aaeffc0906250000i150418e8k3637acb41976c1a0@mail.gmail.com>
	<1245921062.5542.51.camel@subratamodak.linux.ibm.com>
	<78aaeffc0906250339q1051eceak19a244c968b4ba0c@mail.gmail.com>
Date: Thu, 25 Jun 2009 16:17:13 +0530
Message-Id: <1245926833.8178.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Can not run Test
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
To: Mimi Zohar <zohar@us.ibm.com>
Cc: waqar afridi <afridi.waqar@gmail.com>, ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@linux.vnet.ibm.com>

On Thu, 2009-06-25 at 16:39 +0600, waqar afridi wrote:
> 
> 
> On Thu, Jun 25, 2009 at 3:11 PM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>         On Thu, 2009-06-25 at 13:00 +0600, waqar afridi wrote:
>         > Hi All
>         >
>         > I have downloaded ltp-full-20090531.tgz and installed it
>         using the
>         > commands make autotools, ./configure, make all, make
>         install. but when
>         > I try to run a test like
>         >
>         > # ./ima_tpm.sh
>         > ./ima_tpm.sh: 163: source: not found
>         > ./ima_tpm.sh: 164: setup: not found
>         >
>         > I get the error above. What could be the problem,
>         Desperately need
>         > help.
>         
>         
>         Look through:
>         http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/integrity/ima/README,
>         on instructions to setup before executing those tests.
> 
> I already have done these steps. but I think  the problem will be with
> mounting partition with iversion support(I have done this too, added
> iversion to fstab). I am not clear about whats iversion, so thats why
> I am going to clear my Idea about iversion. but if some body can help
> with both the problem and iversion, I will be very thankful.

Mimi,

Can you please help Afridi ?

Regards--
Subrata

> 
>         
>         
>         Regards--
>         Subrata
>         
>         >
>         > --
>         > Waqar Afridi
>         > Research Associate
>         > Member: Security Engineering Research Group (SERG)
>         > IM | Sciences Peshawar
>         
>         >
>         ------------------------------------------------------------------------------
>         > _______________________________________________
>         > Ltp-list mailing list
>         > Ltp-list@lists.sourceforge.net
>         > https://lists.sourceforge.net/lists/listinfo/ltp-list
>         
> 
> 
> 
> -- 
> Waqar Afridi
> Research Associate
> Member: Security Engineering Research Group (SERG)
> IM | Sciences Peshawar


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
