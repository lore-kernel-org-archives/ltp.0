Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XxvxP-0005D2-UQ
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 10:54:23 +0000
Date: Mon, 8 Dec 2014 11:54:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208105407.GA9223@rei.suse.de>
References: <001701d012c2$e2ae8d30$a80ba790$@samsung.com>
	<1917282961.14573534.1418030128901.JavaMail.zimbra@redhat.com>
	<20141208091810.GA6401@rei.suse.de>
	<002601d012d3$7daa5a20$78ff0e60$@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <002601d012d3$7daa5a20$78ff0e60$@samsung.com>
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

Hi!
> When we compile the complete LTP and INSTALL in our target its more than 1
> GB of the compiled output.

That is a bit strange. For me the result is less than two hundred
megabytes, your result is nearly ten times greater. This looks like a
bug in your compiler/binutils.

> We do not have enough memory to copy all the LTP INSTALLED files and
> hence we want to compile only the selected test cases which we want to
> execute. That is why when I tried to explore options I was not able to
> find any which will do that.  Hence need help on how can we do that ?

If your target has network interface you can use nfs to share the
LTP binary directory over the network.

> Suppose we have "ade  at  cpio  cron  eject  fileutils  gzip  logrotate
> mail  Makefile  sssd  su  tar  tpm-tools  unzip" commands in the
> /ltp-full-20140828/testcases/commands/ dir. We need to compile only ade ,
> gzip , tar , unzip for our purpose and not compile the complete command
> folder. Hence we need help on how to compile the selected package. 

I've allready explained how to do that by hand. There is no other way to
do that.

-- 
Cyril Hrubis
chrubis@suse.cz

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
