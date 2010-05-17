Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OE6aB-0003o9-Ns
	for ltp-list@lists.sourceforge.net; Mon, 17 May 2010 20:06:35 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OE6a9-0007wq-HO
	for ltp-list@lists.sourceforge.net; Mon, 17 May 2010 20:06:35 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100512131426.GA190127@medusa.sis.pasteur.fr>
References: <20100512131426.GA190127@medusa.sis.pasteur.fr>
Date: Tue, 18 May 2010 01:36:11 +0530
Message-Id: <1274126771.5106.18.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ftruncate04.c: cleanup mandatory locking check
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sf.net>

On Wed, 2010-05-12 at 15:14 +0200, Nicolas Joly wrote: 
> Hi,
> 
> The attached patch tries to cleanup the `mandatory locking' check in
> the ftruncate04.c testcase.
> 
> The currently test is made with system(2) and involve calling some
> external tools ... to determine if the underlying filesystem has
> `mand' option set. The same result can be easily retrieved with a
> simple statvfs(2) call and examining the mount flags value.
> 
> This has been successfully tested on a RHEL5 x86_64 machine.
> 
> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

Thanks.

Regards--
Subrata

> 
> Regards.
> 
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
