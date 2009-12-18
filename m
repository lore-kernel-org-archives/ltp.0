Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NLbWp-0000ak-W6
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 12:01:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLbWl-0002tc-4y
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 12:01:51 +0000
Date: Fri, 18 Dec 2009 07:01:37 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1187453091.565781261137697221.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2124228587.565321261136540799.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] ade: fix the bug of ar01
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net


----- "Caspar Zhang" <czhang@redhat.com> wrote:

> ----- "liubo" <liubo2009@cn.fujitsu.com> wrote: 
> 
> > Yes, this problem does occur because of the version... 
> > In binutils-2.19.51.0.2, the strange dot appears. 
> > In binutils-2.17.50.0.18, the strange dot does not appear. 
> > And these cause the dismatch. 
> > 
> > Thanks, 
> > Liu Bo 
> > 
> 
> My Fedora12 has binutils-2.19.51.0.14-34, I can't see this dot
> either.
> 
Tested in binutils-2.19.51.0.2-17.fc11, don't see this dot either 
:-(

-Caspar

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
