Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XvoVd-0004tY-87
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 14:32:57 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 772EFABCA
	for <ltp-list@lists.sourceforge.net>;
	Tue,  2 Dec 2014 14:32:49 +0000 (UTC)
Date: Tue, 2 Dec 2014 15:32:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202143245.GB18709@rei.suse.de>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
	<20141103221828.GD9814@tarantula.localdomain>
	<20141103225247.GJ5402@vapier.wh0rd.info>
	<20141104210118.GE12659@tarantula.localdomain>
	<20141105021415.GM5402@vapier.wh0rd.info>
	<20141105183706.GA4361@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141105183706.GA4361@tarantula.localdomain>
Subject: Re: [LTP] [PATCH] file_test: fix testcase for ppc64le
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
To: ltp-list@lists.sourceforge.net

Hi!
> +# check for CPU endianness
> +READELF=$(which readelf 2>/dev/null)
> +case $(${READELF} -h ${READELF}) in

I've simplified these two lines to:

case $(readelf -h /bin/sh) in

And pushed, thanks.

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
