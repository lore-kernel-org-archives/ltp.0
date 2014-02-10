Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WCuNd-00040f-Ia
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 17:10:49 +0000
Date: Mon, 10 Feb 2014 18:10:15 +0100
From: chrubis@suse.cz
Message-ID: <20140210171014.GA4186@rei>
References: <1386729875-487-1-git-send-email-xu.simon@oracle.com>
	<52BA384B.3070308@oracle.com> <52DDD0BA.4070906@oracle.com>
	<882926271.1663183.1391079335500.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <882926271.1663183.1391079335500.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] xinetd_tests.sh: explicitly enable IPv6
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Looks good to me. According to [1] it's supported since around 1.8.9,
> which appears to be older than anything I could find in RHEL distros.
> 
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> 
> [1] http://www.tldp.org/HOWTO/Linux%2BIPv6-HOWTO/hints-daemons-xinetd.html


Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android&trade; apps run on BlackBerry&reg;10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
