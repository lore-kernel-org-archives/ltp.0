Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WGWwj-0006Sp-Dt
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 16:58:01 +0000
Date: Thu, 20 Feb 2014 17:57:48 +0100
From: chrubis@suse.cz
Message-ID: <20140220165748.GA9496@rei>
References: <CAE1O6mgK+w6s5gnRhe7NaadGngw0k3bmNfc_LAzDvfbeEiQR_A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE1O6mgK+w6s5gnRhe7NaadGngw0k3bmNfc_LAzDvfbeEiQR_A@mail.gmail.com>
Subject: Re: [LTP] LTP cron test fails
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
To: Levi Wang <wangli5665@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> cron02      0  TINFO  :  Test #2: crontab -r removes the crontab file.
> cron02      0  TINFO  :  Test #2: installing crontab file.
> cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
> cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
> var/log/messages.
> cron02      0  TINFO  :  Test #2: uninstalling crontab file.
> cron02      0  TINFO  :  Test #1: /var/log/cron: alternate...
> cron02      2  TFAIL  :  Test #2: crontab activity not recorded in
> var/log/messages.

The testcase checks if crontab activity was logged into /varlog/messages
or /var/log/cron. Probably the system logs are stored in different place
in RHEL7.0 check where they ended up.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
