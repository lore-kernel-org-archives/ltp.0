Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xy2dp-0004zN-EP
	for ltp-list@lists.sourceforge.net; Mon, 08 Dec 2014 18:02:37 +0000
Date: Mon, 8 Dec 2014 19:02:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141208180221.GA18182@rei>
References: <1417713657-2556-1-git-send-email-alexey.kodanev@oracle.com>
	<1417713657-2556-2-git-send-email-alexey.kodanev@oracle.com>
	<20141208114200.GB11071@rei.suse.de> <5485D893.4030403@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5485D893.4030403@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] device-drivers/cpufreq: add intel_pstate
 driver to boost test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Will simple access() suffice here or do we have to actually open the
> > file?
> 
> We have to open it, it was changed from access to open in this commit:
> 
> commit 0a91955ab91bf518ff56a44bb2969b0cb549a979
> Date:   Wed May 7 17:03:33 2014 +0400
> 
>      device-drivers/acpi/ltp_acpi_cpufreq: fix checking for write permission
> 
>      If access(some_file, W_OK) is executed by root it will return 
> success even
>      if file has read-only permission. Use 'open' to test sysfs file for 
> write
>      permission.
> 
> Doc updated as well:
> 
> commit fb3da0a1f3a4f1b836e50033cb8acf7c6d0c5a05
> Date:   Tue May 13 15:34:32 2014 +0400
> 
>      docs: add a paragraph about access() to Common Problems section

Ah, right, deja vu.

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
