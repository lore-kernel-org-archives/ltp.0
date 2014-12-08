Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XxuPq-0005Vp-AG
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 09:15:38 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XxuPo-0005y7-OU
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 09:15:38 +0000
Date: Mon, 8 Dec 2014 04:15:28 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1917282961.14573534.1418030128901.JavaMail.zimbra@redhat.com>
In-Reply-To: <001701d012c2$e2ae8d30$a80ba790$@samsung.com>
References: <001701d012c2$e2ae8d30$a80ba790$@samsung.com>
MIME-Version: 1.0
Subject: Re: [LTP] How to compile indiviual packages/modules in LTP
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
To: Raju <raju.biswas@samsung.com>
Cc: ltp-list@lists.sourceforge.net

----- Original Message ----- 
> From: "Raju" <raju.biswas@samsung.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 8 December, 2014 9:42:20 AM
> Subject: [LTP] How to compile indiviual packages/modules in LTP
> Hello Sir,
> There are lot of test suit modules / packages currently under LTP.
> Examples :
> /ltp-full-20140828/testcases/commands/
> ade at cpio cron eject fileutils gzip logrotate mail Makefile sssd su tar
> tpm-tools unzip
> /ltp-full-20140828/testcases/kernel
> connectors controllers firmware hotplug io lib Makefile mem numa pty security
> timers
> containers device-drivers fs include ipc logging mce-test module
> power_management sched syscalls tracing
> etc.
> Currently we have option to compile the whole LTP package. But suppose I do
> not want some modules to get compiled Ex. Ade , gzip , security , timers etc
> , but compile the rest of the LTP test suit. How can I do it ?

If none of configure options works for you, as outline by Cyril here:
  http://thread.gmane.org/gmane.linux.ltp/21992

you need to make changes yourself. If specific Makefile doesn't name
sub-directories by name, then delete the ones you don't want to compile from tree.
If Makefile does list sub-directories by name, then you need to patch that Makefile
and remove those you wish to skip.

Regards,
Jan

> I do not want to whole LTP to get compiled but compile only the selected test
> package. How can I select the packages to compile. It is just like we do not
> compile the complete kernel but compile what is required for our need.
> Similar to that how can we compile what we need and not the complete
> package.
> Request help to compile selected package in LTP.
> Regards,
> Raju Biswas
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
