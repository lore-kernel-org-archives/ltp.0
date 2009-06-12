Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MF6fx-0004rD-Az
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:20:09 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MF6fv-0000A7-IO
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:20:09 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A31C9FC.7040601@schaufler-ca.com>
References: <1244775248.4982.6.camel@subratamodak.linux.ibm.com>
	<4A31C9FC.7040601@schaufler-ca.com>
Date: Fri, 12 Jun 2009 18:49:59 +0530
Message-Id: <1244812799.5234.22.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [006][RFC] [TESTING linux-2.6.30] SELinux & SMACK
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
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Paul Moore <paul.moore@hp.com>, Etienne Basset <etienne.basset@numericable.fr>, "David P. Quigley" <dpquigl@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>, James Morris <jmorris@macbook.localdomain>, Stephen Smalley <sds@tycho.nsa.gov>

On Thu, 2009-06-11 at 20:22 -0700, Casey Schaufler wrote: 
> Subrata Modak wrote:
> > Hi Stephen & Casey,
> >
> > Do you think there needs to be some changes that should go in to your
> > respective SELinux and SMACK tests in LTP, in response to the
> > improvements in SELinux & SMACK in linux-2.6.30 ?
> >   
> 
> Yes. As always, LTP is on the task list. Alas, also as always,
> it's not on the top of the task list.

It should be ok whenever you submit.

Regards--
Subrata

> 
> 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=11689d47f0957121920c9ec646eb5d838755853a,
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dd34b5d75a0405814a3de83f02a44ac297e81629,
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4303154e86597885bc3cbc178a48ccbc8213875f,
> >
> > Regards--
> > Subrata
> >
> >
> >
> >   


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
