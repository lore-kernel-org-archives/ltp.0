Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X6asm-00012I-Ln
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 07:41:08 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X6asl-0003V4-AR
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 07:41:08 +0000
Date: Mon, 14 Jul 2014 03:40:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2014157214.9432907.1405323657292.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140708144254.GB3111@localhost.localdomain>
References: <20140704031641.GA20446@localhost.localdomain>
	<1152474476.5259307.1404735279247.JavaMail.zimbra@redhat.com>
	<20140708072308.GA3111@localhost.localdomain>
	<1472278017.5756231.1404815787899.JavaMail.zimbra@redhat.com>
	<1015853559.5800703.1404820547657.JavaMail.zimbra@redhat.com>
	<2026740901.5816308.1404822634671.JavaMail.zimbra@redhat.com>
	<20140708144254.GB3111@localhost.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [RFC PATCH] regression test for
	64bit	sendfile	capped	at	2G
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
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 8 July, 2014 4:42:54 PM
> Subject: Re: [LTP] [RFC PATCH] regression test for 64bit	sendfile	capped	at	2G
> 
> On Tue, Jul 08, 2014 at 08:30:34AM -0400, Jan Stancek wrote:
> > I think the problem addressed in commit 5d73320a96fcc was using sendfile on
> > large files,
> > and not making large (count > 2GB) sendfile() calls.
> > 
> > Taking this into account, I can see the difference with/without commit
> > 5d73320a96fcc.
> > Second case here fails on unpatched kernel with:
> > 
> > sendfile(3, 4, [3221225472], 1073741824) = -1 EOVERFLOW (Value too large
> > for defined data type)
> > 
> > 
> Great! I have combined these patches, please have a look. Many Thanks!

Pushed with small changes. Mostly comment updates to reflect that we are testing
at 0 and 3GB offsets. Also, I changed test for required space to 5GB.

Regards,
Jan

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
