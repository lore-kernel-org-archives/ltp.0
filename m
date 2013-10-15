Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VW39K-0001nz-JS
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 11:50:54 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VW39I-0007Ml-Rj
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 11:50:54 +0000
Date: Tue, 15 Oct 2013 07:50:41 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1096964421.7014139.1381837841727.JavaMail.root@redhat.com>
In-Reply-To: <000901cec66b$5bd10b70$13732250$@cn.fujitsu.com>
References: <00ae01cec57d$6b50bbc0$41f23340$@cn.fujitsu.com>
	<552630664.4346396.1381389438416.JavaMail.root@redhat.com>
	<000901cec66b$5bd10b70$13732250$@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] getrusage/getrusage04.c: Fix factor_nr = 1
	->	factor_nr = 5
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>, Drew Jones <drjones@redhat.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 11 October, 2013 12:19:19 PM
> Subject: RE: [LTP] [PATCH] getrusage/getrusage04.c: Fix factor_nr = 1 ->	factor_nr = 5
> > >
> > > Note, that there is already a parameter -m to set factor_nr.
> > >
> > > Can you share more details why this should be the default?
> > > On which system/architecture do you see it failing?
> > 
> > Yes. We have some problems in RHEL5.10GA.
> > It could not work as we expected. And I will be more careful.
> > Thanks.
> > 
> 
> When kernel is vmlinuz-2.6.18-371.el5xen, the case will fail.
> But with vmlinuz-2.6.18-371.el5, it works well.

I'm seeing the same as you also with previous minor RHEL5 releases on dom0:
5.3 2.6.18-128.el5xen
5.6 2.6.18-238.el5xen
5.9 2.6.18-348.el5xen
5.10 2.6.18-371.el5xen

> Maybe the case is not suit for xen kernel.

It's possible, it doesn't look like regression to me so far.
The systems are definitely not "slow" ones, and test can pass on bare-metal kernel. 

Regards,
Jan

> 
> Regards,
> Zeng
> 
> > >
> > > Regards,
> > > Jan
> > >


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
