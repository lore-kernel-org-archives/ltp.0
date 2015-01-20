Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1YDVgt-0005js-Ut
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 10:05:43 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YDVgo-0001RX-5Z
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 10:05:43 +0000
Date: Tue, 20 Jan 2015 05:05:31 -0500 (EST)
From: Li Wang <liwang@redhat.com>
Message-ID: <1856182276.9193294.1421748331851.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150120092925.GA15756@quack.suse.cz>
References: <671699407.9161653.1421743558663.JavaMail.zimbra@redhat.com>
	<1679086070.9165707.1421744249957.JavaMail.zimbra@redhat.com>
	<20150120092925.GA15756@quack.suse.cz>
MIME-Version: 1.0
Subject: Re: [LTP] fanotify06 always failed on RHEL7
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> On Tue 20-01-15 03:57:29, Li Wang wrote:
> > Hi Jack & all,
> > 
> > fanotify06 always failed on RHEL7-GA as below. When I make some change of
> > the codes flow, Test Pass All.
> > Could you take a look at my unsure patch?
> > 
> > <<<test_start>>>
> > tag=fanotify06 stime=1421726003
> > cmdline="fanotify06"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > fanotify06    1  TPASS  :  group 0 get event: mask 2 pid=14922 fd=15
> > fanotify06    2  TPASS  :  group 1 get event: mask 2 pid=14922 fd=15
> > fanotify06    3  TPASS  :  group 2 get event: mask 2 pid=14922 fd=15
> > fanotify06    4  TFAIL  :  fanotify06.c:217: group 3 got event
> > fanotify06    5  TFAIL  :  fanotify06.c:217: group 4 got event
> > fanotify06    6  TFAIL  :  fanotify06.c:217: group 5 got event
> > fanotify06    7  TPASS  :  group 6 got no event
> > fanotify06    8  TPASS  :  group 7 got no event
> > fanotify06    9  TPASS  :  group 8 got no event
>   Well, likely the reason is that you don't have commit
> 8edc6e1688fc8f02c8c1f53a2ec4928cb1055f4d in your kernel. The test is
> correct as is.

Great! Thank you for your response promptly.

Li Wang

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
