Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M63WW-0006cE-EM
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 14:09:00 +0000
Date: Mon, 18 May 2009 16:08:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090518140811.GA1428@schrodinger.suse.cz>
References: <20090514204545.GA8023@schrodinger.suse.cz>
	<20090515.194057.226785652.caiqian@cclom.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090515.194057.226785652.caiqian@cclom.cn>
Subject: Re: [LTP] [PATCH] Renaming binaries to avoid conflicts
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

> Would not be easier to install it under another directory like /opt/bin
> if you also want to co-exist with Gnome pan?

Well there are at least two reasons to rename the binaries. Number one is
package convetions, as all distributions have rules (and it's standartized by
LSB) where to put some type of files in order not to mess you / filesystem. And
even bigger problem is that you still need to call pan binary with absolute
path, just because /usr/bin/ is most likely before /opt/bin/ in $PATH so
calling plain pan could and will (if gnome-pan is installed) end up in running
wrong binary.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
