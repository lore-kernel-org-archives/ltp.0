Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1Z7wmU-0001r5-W2
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 02:20:46 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z7wmT-0000t6-Mf
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 02:20:46 +0000
Date: Wed, 24 Jun 2015 22:20:38 -0400 (EDT)
From: Li Wang <liwang@redhat.com>
Message-ID: <2049722126.19212219.1435198838695.JavaMail.zimbra@redhat.com>
In-Reply-To: <CANuOEEhmmS_E-O9umbGEHerBONT+bGAOFHH5O055ajH_V+Rgaw@mail.gmail.com>
References: <CANuOEEhmmS_E-O9umbGEHerBONT+bGAOFHH5O055ajH_V+Rgaw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] How to specify testcases by running runltp
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
To: Shuo Yang <yshuo@umich.edu>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> Hi guys,
> 
> I just started using ltp, so this question is kind of dumb. I want to use it
> to run some file system tests but I don't know what the command should be.

Hi,

Assuming you have installed the ltp test suit in '/mnt/testarea/ltp' path, then just
cd to the place:

# pwd
/mnt/testarea/ltp/runtest

# ../runltp -f fs

after that, it running all the filesystem case.

BTW, you also could modify the content of 'fs' to customize the testcase you want to use.

Best,
Li Wang

> Currently I can run runtlp command but I don't know how to control the
> testcases. Assuming the file system I want to test is under /tmp/foo/. Could
> someone tell me how can I run the testcases specifically for testing file
> system.
> 
> Thanks,
> Shuo
> 
> 
> ------------------------------------------------------------------------------
> Monitor 25 network devices or servers for free with OpManager!
> OpManager is web-based network management software that monitors
> network devices and physical & virtual servers, alerts via email & sms
> for fault. Monitor 25 devices for free with no restriction. Download now
> http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
