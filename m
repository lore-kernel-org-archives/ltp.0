Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTK-0007eR-2S
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:22 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTI-0006eU-PC
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:22 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <ab64ec20906160538i392e4cb8oa3006186c202d1bd@mail.gmail.com>
References: <20090616095220.GA218461@medusa.sis.pasteur.fr>
	<ab64ec20906160538i392e4cb8oa3006186c202d1bd@mail.gmail.com>
Date: Thu, 18 Jun 2009 23:01:49 +0530
Message-Id: <1245346310.5041.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Small typo in sgetmask01.c
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
To: naveen penumala <naveenspen@gmail.com>, Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sf.net>

On Tue, 2009-06-16 at 18:08 +0530, naveen penumala wrote:
> Hi, 
> I have applied above patch and tested. In my testing i got below error
> statements.
> I have tested on suse linux and kernel version is 2.6.16.21
> 
> cc -I../../../../include -Wall    sgetmask01.c  -L../../../../lib
> -lltp -o sgetmask01
> In file included from sgetmask01.c:60:
> ../../../../include/linux_syscall_numbers.h:184:1: error: unterminated
> #ifdef
> ../../../../include/linux_syscall_numbers.h:13:1: error: unterminated
> #ifndef
> 
> 

Well, that is not introduced by this patch. The only issue is it not
having a Signed-off-by: Nicolas Joly <njoly@pasteur.fr>, which i have
now added in the Log message. Please do so in future.

Regards--
Subrata

> Thanks & Regards,
> -NVN
> On Tue, Jun 16, 2009 at 3:22 PM, Nicolas Joly <njoly@pasteur.fr>
> wrote:
>         
>         Hi,
>         
>         Here follow a small patch that fix a typo in sgetmask01.c
>         testcase,
>         where __NR_ssetmask is badly used instead of __NR_sgetmask.
>         
>         Regards.
>         
>         --
>         Nicolas Joly
>         
>         Biological Software and Databanks.
>         Institut Pasteur, Paris.
>         
>         ------------------------------------------------------------------------------
>         Crystal Reports - New Free Runtime and 30 Day Trial
>         Check out the new simplified licensing option that enables
>         unlimited
>         royalty-free distribution of the report engine for externally
>         facing
>         server and web deployment.
>         http://p.sf.net/sfu/businessobjects
>         _______________________________________________
>         Ltp-list mailing list
>         Ltp-list@lists.sourceforge.net
>         https://lists.sourceforge.net/lists/listinfo/ltp-list
>         
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
