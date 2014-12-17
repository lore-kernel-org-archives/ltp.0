Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y1Dnz-0006ec-Pz
	for ltp-list@lists.sourceforge.net; Wed, 17 Dec 2014 12:34:15 +0000
Date: Wed, 17 Dec 2014 13:33:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141217123354.GC29078@rei>
References: <1418739938-2123-1-git-send-email-xuw@redhat.com>
	<20141216145448.GA19489@rei>
	<489454473.16387266.1418795067082.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <489454473.16387266.1418795067082.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCHv3] library: add tst_system for wrapper system(3)
 without SIGCHLD
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
To: Xu Wang <xuw@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -       if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
> here is the original author's check, use "== 0", so I'am not sure the "!tst_system" will be good for ltp's coding style.
> 
> and if I make codes like this, the next line's style will not be consistent to it:
> +       if (!tst_system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null")) {
>             tst_resm(TINFO, "Appending '-f' flag to mkfs.%s", 
>                 fs_type);

I do not get what is inconsistent here. The line for the if condition is
79 chars long that way, the next line with tst_resm would be more than
80 therefore it should continue on the next line. It's that simple.

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
