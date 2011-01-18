Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pf8GH-0002sp-Qj
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:54:01 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf8GG-0000I9-O6
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:54:01 +0000
Date: Tue, 18 Jan 2011 04:53:53 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <2094710513.30367.1295344433866.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <AANLkTimQM8L342XCx7obE0yK25WxamPSLUbm0XeNtSAF@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cpuset01: fix pathname to remove underscore
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>


----- Original Message -----
> On Tue, Jan 18, 2011 at 1:18 AM, CAI Qian <caiqian@redhat.com> wrote:
> > Garrett, any comment/feedback to merge this too?
> 
> Committed. Please add a runtest entry please.
Yes, I can see it has already been added in runtest/mm

cpuset01 cpuset01 -I 3600

However, it depends on this patch to be merged upstream for -I option to work properly.
http://marc.info/?l=ltp-list&m=129067708004560&w=2

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
