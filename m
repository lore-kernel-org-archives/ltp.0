Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xtb2g-0004in-QQ
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 11:45:54 +0000
Date: Wed, 26 Nov 2014 12:45:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141126114501.GB24778@rei>
References: <001301d0055a$fb71a930$f254fb90$@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <001301d0055a$fb71a930$f254fb90$@samsung.com>
Subject: Re: [LTP] Need help to run LTP on Android
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
Cc: ltp-list@lists.sourceforge.net, subrata@linuc.vnet.ibm.com, robbiew@us.ibm.com, manjo@mail.utexas.edu

Hi!
> root@kanas:/data/ltp # ./runltp -p -l test.log -o test.log  -d /data/ltp/tmp
> 
> ./runltp -p -l test.log -o test.log  -d /data/ltp/tmp
> 
> ./runltp[999]: basename: not found

This error tells you that basename command was not found by your shell.

Likely you are missing some package.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
