Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NLcY4-0001pY-1V
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 13:07:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLcXz-00009Z-78
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 13:07:09 +0000
Date: Fri, 18 Dec 2009 07:44:25 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <2118844783.566751261140265463.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1044568160.566731261140245405.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
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


----- "liubo" <liubo2009@cn.fujitsu.com> wrote: 

> Are you using a 32bit box or not? 
> I tested on a few 32bit boxes(Ubuntu Fedora), and I think it is the point. 
> 
> Thanks. 
> Liu Bo 
> 
> 
I tested in x86, x86_64, ppc64, s390x and ia64, all of them has a dot in RHEL6
also tested in x86 Fedora, no dot.

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
