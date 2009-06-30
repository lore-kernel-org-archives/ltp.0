Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davidel@xmailserver.org>) id 1MLeo1-0001sc-3q
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:59:33 +0000
Received: from x35.xmailserver.org ([64.71.152.41])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLenz-0003Pe-J2
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 14:59:33 +0000
Received: from makko.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2F4B5B> for <ltp-list@lists.sourceforge.net> from
	<davidel@xmailserver.org>; Tue, 30 Jun 2009 10:42:20 -0400
Date: Tue, 30 Jun 2009 07:41:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <1246347667.4819.27.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.DEB.1.10.0906300738480.3314@makko.or.mcafeemobile.com>
References: <200906232049.n5NKne0h007108@e5.ny.us.ibm.com>
	<1245920973.5542.33.camel@subratamodak.linux.ibm.com>
	<1246347667.4819.27.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Run the eventfd test in a temporary directory,
 because it creates some files
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
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list@lists.sourceforge.net

On Tue, 30 Jun 2009, Subrata Modak wrote:

> Jiri,
> 
> On Thu, 2009-06-25 at 14:39 +0530, Subrata Modak wrote: 
> > On Mon, 2008-12-29 at 14:48 +0100, Jiri Palecek wrote: 
> > > Hello,
> > > 
> > > the eventfd test creates some files in the current directory. I think it should be creating the files in a temporary directory instead, as is already the standard with other LTP tests, because the current might be nonwriteable and the user might not want the files left there.
> > > 
> > > Regards
> > >     Jiri Palecek
> > > 
> > > Signed-off-by: Jiri Palecek <jpalecek@web.de>
> > 
> > Thanks. 
> > 
> > Recently i have seen some patches on LKML from Davide on the change for
> > eventfd() interface. Could you please verify how they will affect our
> > tests, and, make changes if necessary ?
> > http://lkml.org/lkml/2009/6/24/590,
> 
> Any thoughts for this ?

No worry. It is the internal (kernel) interface that will eventually 
change. Userspace will not be affected by it.


- Davide



------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
